require 'puppet_x/puppetlabs/swagger/prefetch_error'
require 'puppet_x/puppetlabs/swagger/symbolize_keys'
require 'puppet_x/puppetlabs/kubernetes/provider'

Puppet::Type.type(:kubernetes_binding).provide(:swagger, :parent => PuppetX::Puppetlabs::Kubernetes::Provider) do

  mk_resource_methods

  def self.instance_to_hash(instance)
    {
    ensure: :present,
    name: instance.metadata.name,
    
      
        kind: instance.kind.respond_to?(:to_hash) ? instance.kind.to_hash : instance.kind,
      
    
      
        apiVersion: instance.apiVersion.respond_to?(:to_hash) ? instance.apiVersion.to_hash : instance.apiVersion,
      
    
      
        metadata: instance.metadata.respond_to?(:to_hash) ? instance.metadata.to_hash : instance.metadata,
      
    
      
        target: instance.target.respond_to?(:to_hash) ? instance.target.to_hash : instance.target,
      
    
    object: instance,
    }
  end

  def create
    Puppet.info("Creating #{name}")
    create_instance_of('binding', name, build_params)
  end

  def flush
    if ! @property_hash.empty? and @property_hash[:ensure] != :absent
      flush_instance_of('binding', name, @property_hash[:object], build_params)
    end
  end

  def destroy
    Puppet.info("Deleting #{name}")
    destroy_instance_of('binding', name)
  end

  private
  def self.list_instances
    list_instances_of('binding')
  end

  def build_params
    params = {
    
      
        kind: resource[:kind],
      
    
      
        apiVersion: resource[:apiVersion],
      
    
      
        metadata: resource[:metadata],
      
    
      
        target: resource[:target],
      
    
    }
    params.delete_if { |key, value| value.nil? }
    params
  end
end
