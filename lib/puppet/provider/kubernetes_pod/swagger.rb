require 'puppet_x/puppetlabs/swagger/prefetch_error'
require 'puppet_x/puppetlabs/swagger/symbolize_keys'
require 'puppet_x/puppetlabs/kubernetes/provider'

Puppet::Type.type(:kubernetes_pod).provide(:swagger, :parent => PuppetX::Puppetlabs::Kubernetes::Provider) do

  mk_resource_methods

  def self.instance_to_hash(instance)
    {
    ensure: :present,
    name: instance.metadata.name,
    
      
    
      
    
      
        metadata: instance.metadata.respond_to?(:to_hash) ? instance.metadata.to_hash : instance.metadata,
      
    
      
        spec: instance.spec.respond_to?(:to_hash) ? instance.spec.to_hash : instance.spec,
      
    
      
        status: instance.status.respond_to?(:to_hash) ? instance.status.to_hash : instance.status,
      
    
    object: instance,
    }
  end

  def create
    Puppet.info("Creating #{name}")
    create_instance_of('pod', name, build_params)
  end

  def flush
    if ! @property_hash.empty? and @property_hash[:ensure] != :absent
      flush_instance_of('pod', name, @property_hash[:object], build_params)
    end
  end

  def destroy
    Puppet.info("Deleting #{name}")
    destroy_instance_of('pod', name)
  end

  private
  def self.list_instances
    list_instances_of('pod')
  end

  def build_params
    params = {
    
      
    
      
    
      
        metadata: resource[:metadata],
      
    
      
        spec: resource[:spec],
      
    
      
        status: resource[:status],
      
    
    }
    params.delete_if { |key, value| value.nil? }
    params
  end
end
