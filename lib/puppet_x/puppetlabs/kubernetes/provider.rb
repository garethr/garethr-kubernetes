require 'puppet'
require 'kubeclient'
require 'recursive_open_struct'

require_relative '../swagger/provider'
require_relative '../swagger/fixnumify'
require_relative '../../../kubeclient/config'

class RecursiveOpenStruct
  def ensure_value_at_path(klass, path, value)
    path.each_with_index.inject(self) { |obj, (attr, index)|
      if index == (path.size - 1)
        obj.send("#{attr}=", value)
      else
        if attr.class == Fixnum
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
          Puppet.initialize_settings unless Puppet[:confdir]
          file = File.join(Puppet[:confdir], 'kubernetes.conf')
          Puppet.debug("Checking for config file at #{file}")
          config = Kubeclient::Config.read(file)
          ::Kubeclient::Client.new(
            config.context.api_endpoint,
            config.context.api_version,
            ssl_options: config.context.ssl_options,
          )
        end

        def self.list_instances_of(type)
          client.send("get_#{type}s")
        end

        def make_object(type, name, params)
          klass = type.split('_').collect(&:capitalize).join
          params[:metadata] = {} unless params.key?(:metadata)
          p = params.symbolize_keys.fixnumify
          object = Object::const_get("Kubeclient::#{klass}").new(p)
          object.metadata.name = name
          object.metadata.namespace = namespace unless namespace.nil?
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
                data << [[key,inner_key], inner_value.fixnumify]
              end
              if inner_value.class == Array
                inner_value.each_with_index do |item,index|
                  item.each do |k,v|
                    data << [[key, inner_key, index, k], v.fixnumify]
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
            # This means the resource doesn't exist already
            if resource[:metadata]
              resource[:metadata]['namespace'] || 'default'
            else
              # for resources without metadata like namespaces
              # we don't need to set a namespace
              nil
            end
          else
            # here we're reading from the API so we don't need to
            # provide any default values
            self.metadata[:namespace] || nil
          end
        end
      end
    end
  end
end
