
# This file is automatically generated by puppet-swagger-generator and
# any manual changes are likely to be clobbered when the files
# are regenerated.

require_relative '../../../puppet_x/puppetlabs/kubernetes/provider'

Puppet::Type.type(:kubernetes_fs_group_strategy_options).provide(:swagger, :parent => PuppetX::Puppetlabs::Kubernetes::Provider) do

  mk_resource_methods

  def self.instance_to_hash(instance)
    {
    ensure: :present,
    name: instance.metadata.name,
    
      
        
        rule: instance.rule.respond_to?(:to_hash) ? instance.rule.to_hash : instance.rule,
        
      
    
      
        
        ranges: hash_arrays(instance.ranges),
        
      
    
    object: instance,
    }
  end

  def create
    Puppet.info("Creating kubernetes_fs_group_strategy_options #{name}")
    create_instance_of('fs_group_strategy_options', name, build_params)
  end

  def flush
   unless @property_hash.empty?
     unless resource[:ensure] == :absent
        flush_instance_of('fs_group_strategy_options', name, @property_hash[:object], build_params)
      end
    end
  end

  def destroy
    Puppet.info("Deleting kubernetes_fs_group_strategy_options #{name}")
    destroy_instance_of('fs_group_strategy_options', name)
    @property_hash[:ensure] = :absent
  end

  private
  def self.list_instances
    list_instances_of('fs_group_strategy_options')
  end

  def build_params
    params = {
    
      
        rule: resource[:rule],
      
    
      
        ranges: resource[:ranges],
      
    
    }
    params.delete_if { |key, value| value.nil? }
    params
  end
end
