require_relative 'prefetch_error'

module PuppetX
  module Puppetlabs
    module Swagger
      class Provider < Puppet::Provider
        def self.read_only(*methods)
          methods.each do |method|
            define_method("#{method}=") do |v|
              fail "#{method} property is read-only once #{resource.type} created."
            end
          end
        end

        def self.instances
          begin
            list_instances.collect do |instance|
              begin
                hash = instance_to_hash(instance)
                Puppet.debug("Ignoring #{name} due to invalid or incomplete response") unless hash
                new(hash) if hash
              end
            end.compact
          rescue Timeout::Error, StandardError => e
            raise PuppetX::Puppetlabs::Swagger::PrefetchError.new(self.resource_type.name.to_s, e)
          end
        end

        def self.prefetch(resources)
          instances.each do |prov|
            if resource = resources[prov.name] # rubocop:disable Lint/AssignmentInCondition
              resource.provider = prov
            end
          end
        end

        def exists?
          Puppet.info("Checking if #{name} exists")
          @property_hash[:ensure] and @property_hash[:ensure] != :absent
        end

        private
        def self.list_instance_of(type)
          fail "Needs implementation in your own provider"
        end

        def create_instance_of(type, name, params)
          fail "Needs implementation in your own provider"
        end

        def destroy_instance_of(type, name)
          fail "Needs implementation in your own provider"
        end

        def flush_instance_of(type)
          fail "Needs implementation in your own provider"
        end
      end
    end
  end
end
