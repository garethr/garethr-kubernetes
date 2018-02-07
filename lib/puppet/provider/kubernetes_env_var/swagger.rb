
# This file is automatically generated by puppet-swagger-generator and
# any manual changes are likely to be clobbered when the files
# are regenerated.

require_relative '../../../puppet_x/puppetlabs/kubernetes/provider'

Puppet::Type.type(:kubernetes_env_var).provide(:swagger, :parent => PuppetX::Puppetlabs::Kubernetes::Provider) do

  mk_resource_methods

  def self.instance_to_hash(instance)
    {
    ensure: :present,
    name: instance.metadata.name,
    
      
        
        name: instance.name.respond_to?(:to_hash) ? instance.name.to_hash : instance.name,
        
      
    
      
        
        value: instance.value.respond_to?(:to_hash) ? instance.value.to_hash : instance.value,
        
      
    
      
        
        value_from: instance.valueFrom.respond_to?(:to_hash) ? instance.valueFrom.to_hash : instance.valueFrom,
        
      
    
    object: instance,
    }
  end

  def create
    Puppet.info("Creating kubernetes_env_var #{name}")
    create_instance_of('env_var', name, build_params)
  end

  def flush
   unless @property_hash.empty?
     unless resource[:ensure] == :absent
        flush_instance_of('env_var', name, @property_hash[:object], build_params)
      end
    end
  end

  def destroy
    Puppet.info("Deleting kubernetes_env_var #{name}")
    destroy_instance_of('env_var', name)
    @property_hash[:ensure] = :absent
  end

  private
  def self.list_instances
    list_instances_of('env_var')
  end

  def build_params
    params = {
    
      
        name: resource[:name],
      
    
      
        value: resource[:value],
      
    
      
        valueFrom: resource[:value_from],
      
    
    }
    params.delete_if { |key, value| value.nil? }
    params
  end
end
