require 'puppet_x/puppetlabs/swagger/prefetch_error'
require 'puppet_x/puppetlabs/swagger/symbolize_keys'
require 'puppet_x/puppetlabs/kubernetes/provider'

Puppet::Type.type(:kubernetes_endpoint_address).provide(:swagger, :parent => PuppetX::Puppetlabs::Kubernetes::Provider) do

  mk_resource_methods

  def self.instance_to_hash(instance)
    {
    ensure: :present,
    name: instance.metadata.name,
    
      
        ip: instance.ip.respond_to?(:to_hash) ? instance.ip.to_hash : instance.ip,
      
    
      
        targetRef: instance.targetRef.respond_to?(:to_hash) ? instance.targetRef.to_hash : instance.targetRef,
      
    
    object: instance,
    }
  end

  def create
    Puppet.info("Creating #{name}")
    create_instance_of('endpoint_address', name, build_params)
  end

  def flush
    if ! @property_hash.empty? and @property_hash[:ensure] != :absent
      flush_instance_of('endpoint_address', name, @property_hash[:object], build_params)
    end
  end

  def destroy
    Puppet.info("Deleting #{name}")
    destroy_instance_of('endpoint_address', name)
  end

  private
  def self.list_instances
    list_instances_of('endpoint_address')
  end

  def build_params
    params = {
    
      
        ip: resource[:ip],
      
    
      
        targetRef: resource[:targetRef],
      
    
    }
    params.delete_if { |key, value| value.nil? }
    params
  end
end
