
# This file is automatically generated by puppet-swagger-generator and
# any manual changes are likely to be clobbered when the files
# are regenerated.

require_relative '../../../puppet_x/puppetlabs/kubernetes/provider'

Puppet::Type.type(:kubernetes_ceph_fs_volume_source).provide(:swagger, :parent => PuppetX::Puppetlabs::Kubernetes::Provider) do

  mk_resource_methods

  def self.instance_to_hash(instance)
    {
    ensure: :present,
    name: instance.metadata.name,
    
      
        
        monitors: hash_arrays(instance.monitors),
        
      
    
      
        
        path: instance.path.respond_to?(:to_hash) ? instance.path.to_hash : instance.path,
        
      
    
      
        
        user: instance.user.respond_to?(:to_hash) ? instance.user.to_hash : instance.user,
        
      
    
      
        
        secret_file: instance.secretFile.respond_to?(:to_hash) ? instance.secretFile.to_hash : instance.secretFile,
        
      
    
      
        
        secret_ref: instance.secretRef.respond_to?(:to_hash) ? instance.secretRef.to_hash : instance.secretRef,
        
      
    
      
        
        read_only: instance.readOnly.respond_to?(:to_hash) ? instance.readOnly.to_hash : instance.readOnly,
        
      
    
    object: instance,
    }
  end

  def create
    Puppet.info("Creating kubernetes_ceph_fs_volume_source #{name}")
    create_instance_of('ceph_fs_volume_source', name, build_params)
  end

  def flush
   unless @property_hash.empty?
     unless resource[:ensure] == :absent
        flush_instance_of('ceph_fs_volume_source', name, @property_hash[:object], build_params)
      end
    end
  end

  def destroy
    Puppet.info("Deleting kubernetes_ceph_fs_volume_source #{name}")
    destroy_instance_of('ceph_fs_volume_source', name)
    @property_hash[:ensure] = :absent
  end

  private
  def self.list_instances
    list_instances_of('ceph_fs_volume_source')
  end

  def build_params
    params = {
    
      
        monitors: resource[:monitors],
      
    
      
        path: resource[:path],
      
    
      
        user: resource[:user],
      
    
      
        secretFile: resource[:secret_file],
      
    
      
        secretRef: resource[:secret_ref],
      
    
      
        readOnly: resource[:read_only],
      
    
    }
    params.delete_if { |key, value| value.nil? }
    params
  end
end
