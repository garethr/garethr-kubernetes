require 'puppet_x/puppetlabs/swagger/prefetch_error'
require 'puppet_x/puppetlabs/swagger/symbolize_keys'
require 'puppet_x/puppetlabs/kubernetes/provider'

Puppet::Type.type(:kubernetes_capability).provide(:swagger, :parent => PuppetX::Puppetlabs::Kubernetes::Provider) do

  mk_resource_methods

  def self.instance_to_hash(instance)
    {
    ensure: :present,
    name: instance.metadata.name,
    
    object: instance,
    }
  end

  def create
    Puppet.info("Creating #{name}")
    create_instance_of('capability', name, build_params)
  end

  def flush
    if ! @property_hash.empty? and @property_hash[:ensure] != :absent
      flush_instance_of('capability', name, @property_hash[:object], build_params)
    end
  end

  def destroy
    Puppet.info("Deleting #{name}")
    destroy_instance_of('capability', name)
  end

  private
  def self.list_instances
    list_instances_of('capability')
  end

  def build_params
    params = {
    
    }
    params.delete_if { |key, value| value.nil? }
    params
  end
end
