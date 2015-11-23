require 'puppet_x/puppetlabs/swagger/prefetch_error'
require 'puppet_x/puppetlabs/swagger/symbolize_keys'
require 'puppet_x/puppetlabs/kubernetes/provider'

Puppet::Type.type(:kubernetes_downward_api_volume_file).provide(:swagger, :parent => PuppetX::Puppetlabs::Kubernetes::Provider) do

  mk_resource_methods

  def self.instance_to_hash(instance)
    {
    ensure: :present,
    name: instance.metadata.name,
    
      
        path: instance.path.respond_to?(:to_hash) ? instance.path.to_hash : instance.path,
      
    
      
        fieldRef: instance.fieldRef.respond_to?(:to_hash) ? instance.fieldRef.to_hash : instance.fieldRef,
      
    
    object: instance,
    }
  end

  def create
    Puppet.info("Creating #{name}")
    create_instance_of('downward_api_volume_file', name, build_params)
  end

  def flush
    if ! @property_hash.empty? and @property_hash[:ensure] != :absent
      flush_instance_of('downward_api_volume_file', name, @property_hash[:object], build_params)
    end
  end

  def destroy
    Puppet.info("Deleting #{name}")
    destroy_instance_of('downward_api_volume_file', name)
  end

  private
  def self.list_instances
    list_instances_of('downward_api_volume_file')
  end

  def build_params
    params = {
    
      
        path: resource[:path],
      
    
      
        fieldRef: resource[:fieldRef],
      
    
    }
    params.delete_if { |key, value| value.nil? }
    params
  end
end
