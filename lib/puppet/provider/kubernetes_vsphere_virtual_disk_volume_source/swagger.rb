
# This file is automatically generated by puppet-swagger-generator and
# any manual changes are likely to be clobbered when the files
# are regenerated.

require_relative '../../../puppet_x/puppetlabs/kubernetes/provider'

Puppet::Type.type(:kubernetes_vsphere_virtual_disk_volume_source).provide(:swagger, :parent => PuppetX::Puppetlabs::Kubernetes::Provider) do

  mk_resource_methods

  def self.instance_to_hash(instance)
    {
    ensure: :present,
    name: instance.metadata.name,
    
      
        volume_path: instance.volumePath.respond_to?(:to_hash) ? instance.volumePath.to_hash : instance.volumePath,
      
    
      
        fs_type: instance.fsType.respond_to?(:to_hash) ? instance.fsType.to_hash : instance.fsType,
      
    
      
        storage_policy_name: instance.storagePolicyName.respond_to?(:to_hash) ? instance.storagePolicyName.to_hash : instance.storagePolicyName,
      
    
      
        storage_policy_id: instance.storagePolicyID.respond_to?(:to_hash) ? instance.storagePolicyID.to_hash : instance.storagePolicyID,
      
    
    object: instance,
    }
  end

  def create
    Puppet.info("Creating kubernetes_vsphere_virtual_disk_volume_source #{name}")
    create_instance_of('vsphere_virtual_disk_volume_source', name, build_params)
  end

  def flush
   unless @property_hash.empty?
     unless resource[:ensure] == :absent
        flush_instance_of('vsphere_virtual_disk_volume_source', name, @property_hash[:object], build_params)
      end
    end
  end

  def destroy
    Puppet.info("Deleting kubernetes_vsphere_virtual_disk_volume_source #{name}")
    destroy_instance_of('vsphere_virtual_disk_volume_source', name)
    @property_hash[:ensure] = :absent
  end

  private
  def self.list_instances
    list_instances_of('vsphere_virtual_disk_volume_source')
  end

  def build_params
    params = {
    
      
        volumePath: resource[:volume_path],
      
    
      
        fsType: resource[:fs_type],
      
    
      
        storagePolicyName: resource[:storage_policy_name],
      
    
      
        storagePolicyID: resource[:storage_policy_id],
      
    
    }
    params.delete_if { |key, value| value.nil? }
    params
  end
end
