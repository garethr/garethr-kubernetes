# This file is automatically generated by puppet-swagger-generator and
# any manual changes are likely to be clobbered when the files
# are regenerated.

require 'puppet_x/puppetlabs/kubernetes/provider'

Puppet::Type.type(:kubernetes_http_get_action).provide(:swagger, :parent => PuppetX::Puppetlabs::Kubernetes::Provider) do

  mk_resource_methods

  def self.instance_to_hash(instance)
    {
    ensure: :present,
    name: instance.metadata.name,
    
      
        path: instance.path.respond_to?(:to_hash) ? instance.path.to_hash : instance.path,
      
    
      
        port: instance.port.respond_to?(:to_hash) ? instance.port.to_hash : instance.port,
      
    
      
        host: instance.host.respond_to?(:to_hash) ? instance.host.to_hash : instance.host,
      
    
      
        scheme: instance.scheme.respond_to?(:to_hash) ? instance.scheme.to_hash : instance.scheme,
      
    
    object: instance,
    }
  end

  def create
    Puppet.info("Creating kubernetes_http_get_action #{name}")
    create_instance_of('http_get_action', name, build_params)
  end

  def flush
    if ! @property_hash.empty? or resource[:ensure] != :absent
      flush_instance_of('http_get_action', name, @property_hash[:object], build_params)
    end
  end

  def destroy
    Puppet.info("Deleting kubernetes_http_get_action #{name}")
    destroy_instance_of('http_get_action', name)
  end

  private
  def self.list_instances
    list_instances_of('http_get_action')
  end

  def build_params
    params = {
    
      
        path: resource[:path],
      
    
      
        port: resource[:port],
      
    
      
        host: resource[:host],
      
    
      
        scheme: resource[:scheme],
      
    
    }
    params.delete_if { |key, value| value.nil? }
    params
  end
end