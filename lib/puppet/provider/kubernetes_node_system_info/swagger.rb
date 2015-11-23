require 'puppet_x/puppetlabs/swagger/prefetch_error'
require 'puppet_x/puppetlabs/swagger/symbolize_keys'
require 'puppet_x/puppetlabs/kubernetes/provider'

Puppet::Type.type(:kubernetes_node_system_info).provide(:swagger, :parent => PuppetX::Puppetlabs::Kubernetes::Provider) do

  mk_resource_methods

  def self.instance_to_hash(instance)
    {
    ensure: :present,
    name: instance.metadata.name,
    
      
        machineID: instance.machineID.respond_to?(:to_hash) ? instance.machineID.to_hash : instance.machineID,
      
    
      
        systemUUID: instance.systemUUID.respond_to?(:to_hash) ? instance.systemUUID.to_hash : instance.systemUUID,
      
    
      
        bootID: instance.bootID.respond_to?(:to_hash) ? instance.bootID.to_hash : instance.bootID,
      
    
      
        kernelVersion: instance.kernelVersion.respond_to?(:to_hash) ? instance.kernelVersion.to_hash : instance.kernelVersion,
      
    
      
        osImage: instance.osImage.respond_to?(:to_hash) ? instance.osImage.to_hash : instance.osImage,
      
    
      
        containerRuntimeVersion: instance.containerRuntimeVersion.respond_to?(:to_hash) ? instance.containerRuntimeVersion.to_hash : instance.containerRuntimeVersion,
      
    
      
        kubeletVersion: instance.kubeletVersion.respond_to?(:to_hash) ? instance.kubeletVersion.to_hash : instance.kubeletVersion,
      
    
      
        kubeProxyVersion: instance.kubeProxyVersion.respond_to?(:to_hash) ? instance.kubeProxyVersion.to_hash : instance.kubeProxyVersion,
      
    
    object: instance,
    }
  end

  def create
    Puppet.info("Creating #{name}")
    create_instance_of('node_system_info', name, build_params)
  end

  def flush
    if ! @property_hash.empty? and @property_hash[:ensure] != :absent
      flush_instance_of('node_system_info', name, @property_hash[:object], build_params)
    end
  end

  def destroy
    Puppet.info("Deleting #{name}")
    destroy_instance_of('node_system_info', name)
  end

  private
  def self.list_instances
    list_instances_of('node_system_info')
  end

  def build_params
    params = {
    
      
        machineID: resource[:machineID],
      
    
      
        systemUUID: resource[:systemUUID],
      
    
      
        bootID: resource[:bootID],
      
    
      
        kernelVersion: resource[:kernelVersion],
      
    
      
        osImage: resource[:osImage],
      
    
      
        containerRuntimeVersion: resource[:containerRuntimeVersion],
      
    
      
        kubeletVersion: resource[:kubeletVersion],
      
    
      
        kubeProxyVersion: resource[:kubeProxyVersion],
      
    
    }
    params.delete_if { |key, value| value.nil? }
    params
  end
end
