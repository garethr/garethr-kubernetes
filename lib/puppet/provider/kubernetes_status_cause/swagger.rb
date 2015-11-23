require 'puppet_x/puppetlabs/swagger/prefetch_error'
require 'puppet_x/puppetlabs/swagger/symbolize_keys'
require 'puppet_x/puppetlabs/kubernetes/provider'

Puppet::Type.type(:kubernetes_status_cause).provide(:swagger, :parent => PuppetX::Puppetlabs::Kubernetes::Provider) do

  mk_resource_methods

  def self.instance_to_hash(instance)
    {
    ensure: :present,
    name: instance.metadata.name,
    
      
        reason: instance.reason.respond_to?(:to_hash) ? instance.reason.to_hash : instance.reason,
      
    
      
        message: instance.message.respond_to?(:to_hash) ? instance.message.to_hash : instance.message,
      
    
      
        field: instance.field.respond_to?(:to_hash) ? instance.field.to_hash : instance.field,
      
    
    object: instance,
    }
  end

  def create
    Puppet.info("Creating #{name}")
    create_instance_of('status_cause', name, build_params)
  end

  def flush
    if ! @property_hash.empty? and @property_hash[:ensure] != :absent
      flush_instance_of('status_cause', name, @property_hash[:object], build_params)
    end
  end

  def destroy
    Puppet.info("Deleting #{name}")
    destroy_instance_of('status_cause', name)
  end

  private
  def self.list_instances
    list_instances_of('status_cause')
  end

  def build_params
    params = {
    
      
        reason: resource[:reason],
      
    
      
        message: resource[:message],
      
    
      
        field: resource[:field],
      
    
    }
    params.delete_if { |key, value| value.nil? }
    params
  end
end
