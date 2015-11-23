require 'puppet_x/puppetlabs/swagger/prefetch_error'
require 'puppet_x/puppetlabs/swagger/symbolize_keys'
require 'puppet_x/puppetlabs/kubernetes/provider'

Puppet::Type.type(:kubernetes_namespace_status).provide(:swagger, :parent => PuppetX::Puppetlabs::Kubernetes::Provider) do

  mk_resource_methods

  def self.instance_to_hash(instance)
    {
    ensure: :present,
    name: instance.metadata.name,
    
      
        phase: instance.phase.respond_to?(:to_hash) ? instance.phase.to_hash : instance.phase,
      
    
    object: instance,
    }
  end

  def create
    Puppet.info("Creating #{name}")
    create_instance_of('namespace_status', name, build_params)
  end

  def flush
    if ! @property_hash.empty? and @property_hash[:ensure] != :absent
      flush_instance_of('namespace_status', name, @property_hash[:object], build_params)
    end
  end

  def destroy
    Puppet.info("Deleting #{name}")
    destroy_instance_of('namespace_status', name)
  end

  private
  def self.list_instances
    list_instances_of('namespace_status')
  end

  def build_params
    params = {
    
      
        phase: resource[:phase],
      
    
    }
    params.delete_if { |key, value| value.nil? }
    params
  end
end
