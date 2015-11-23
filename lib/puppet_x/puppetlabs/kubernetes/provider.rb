require 'kubeclient'
require 'recursive_open_struct'

require 'puppet_x/puppetlabs/swagger/provider'

class RecursiveOpenStruct
  def ensure_value_at_path(klass, path, value)
    path.each_with_index.inject(self) { |obj, (attr, index)|
      if index == (path.size - 1)
        obj.send("#{attr}=", value)
      else
        if a.class == Fixnum
          if obj.send(:at, attr).nil?
            obj.append(Object::const_get("Kubeclient::#{klass}").new)
          end
          obj.send(:at, attr)
        else
          obj.send(attr)
        end
      end
    }
  end
end


module PuppetX
  module Puppetlabs
    module Kubernetes
      class Provider < PuppetX::Puppetlabs::Swagger::Provider
        private
        def self.client
          config = ::PuppetX::Puppetlabs::Azure::Config.new
          ::Kubeclient::Client.new config.master # 'http://localhost:8080/api/'
        end

        def self.list_instances_of(type)
          client.send("get_#{type}s")
        end

        def make_object(type, name, params)
          klass = type.split('_').collect(&:capitalize).join
          object = Object::const_get("Kubeclient::#{klass}").new(params.symbolize_keys)
          object.metadata.name = name
          object.metadata.namespace = namespace
          object
        end

        def create_instance_of(type, name, params)
          client.send("create_#{type}", make_object(type, name, params))
        end

        def build_applicator(input)
          data = []
          input.each do |key,value|
            value.each do |inner_key,inner_value|
              if inner_value.class == String
                data << [[key,inner_key], inner_value]
              end
              if inner_value.class == Array
                inner_value.each_with_index do |item,index|
                  item.each do |k,v|
                    data << [[key, inner_key, index, k], v]
                  end
                end
              end
            end
          end
          data
        end

        def apply_applicator(type, object, changes)
          klass = type.split('_').collect(&:capitalize).join
          changes.each do |path, value|
            object.ensure_value_at_path(klass, path, value)
          end
          object
        end

        def flush_instance_of(type, name, object, params)
          applicator = build_applicator(params)
          updated = apply_applicator(type, object, applicator)
          client.send("update_#{type}", updated)
        end

        def self.method_missing(method_sym, *arguments, &block)
          client.send(method_sym, *arguments, &block)
        end

        def destroy_instance_of(type, name)
          client.send("delete_#{type}", name, namespace)
        end

        def client
          self.class.client
        end

        def namespace
          if self.metadata == :absent
            resource[:metadata]['namespace'] || 'default'
          else
            self.metadata[:namespace] || 'default'
          end
        end
      end
    end
  end
end
