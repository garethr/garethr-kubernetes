require 'puppet_x/puppetlabs/swagger/prefetch_error'
require 'puppet_x/puppetlabs/swagger/symbolize_keys'
require 'puppet_x/puppetlabs/kubernetes/provider'

Puppet::Type.type(:kubernetes_container).provide(:swagger, :parent => PuppetX::Puppetlabs::Kubernetes::Provider) do

  mk_resource_methods

  def self.instance_to_hash(instance)
    {
    ensure: :present,
    name: instance.metadata.name,
    
      
        name: instance.name.respond_to?(:to_hash) ? instance.name.to_hash : instance.name,
      
    
      
        image: instance.image.respond_to?(:to_hash) ? instance.image.to_hash : instance.image,
      
    
      
        command: instance.command.respond_to?(:to_hash) ? instance.command.to_hash : instance.command,
      
    
      
        args: instance.args.respond_to?(:to_hash) ? instance.args.to_hash : instance.args,
      
    
      
        workingDir: instance.workingDir.respond_to?(:to_hash) ? instance.workingDir.to_hash : instance.workingDir,
      
    
      
        ports: instance.ports.respond_to?(:to_hash) ? instance.ports.to_hash : instance.ports,
      
    
      
        env: instance.env.respond_to?(:to_hash) ? instance.env.to_hash : instance.env,
      
    
      
        resources: instance.resources.respond_to?(:to_hash) ? instance.resources.to_hash : instance.resources,
      
    
      
        volumeMounts: instance.volumeMounts.respond_to?(:to_hash) ? instance.volumeMounts.to_hash : instance.volumeMounts,
      
    
      
        livenessProbe: instance.livenessProbe.respond_to?(:to_hash) ? instance.livenessProbe.to_hash : instance.livenessProbe,
      
    
      
        readinessProbe: instance.readinessProbe.respond_to?(:to_hash) ? instance.readinessProbe.to_hash : instance.readinessProbe,
      
    
      
        lifecycle: instance.lifecycle.respond_to?(:to_hash) ? instance.lifecycle.to_hash : instance.lifecycle,
      
    
      
        terminationMessagePath: instance.terminationMessagePath.respond_to?(:to_hash) ? instance.terminationMessagePath.to_hash : instance.terminationMessagePath,
      
    
      
        imagePullPolicy: instance.imagePullPolicy.respond_to?(:to_hash) ? instance.imagePullPolicy.to_hash : instance.imagePullPolicy,
      
    
      
        securityContext: instance.securityContext.respond_to?(:to_hash) ? instance.securityContext.to_hash : instance.securityContext,
      
    
      
        stdin: instance.stdin.respond_to?(:to_hash) ? instance.stdin.to_hash : instance.stdin,
      
    
      
        tty: instance.tty.respond_to?(:to_hash) ? instance.tty.to_hash : instance.tty,
      
    
    object: instance,
    }
  end

  def create
    Puppet.info("Creating #{name}")
    create_instance_of('container', name, build_params)
  end

  def flush
    if ! @property_hash.empty? and @property_hash[:ensure] != :absent
      flush_instance_of('container', name, @property_hash[:object], build_params)
    end
  end

  def destroy
    Puppet.info("Deleting #{name}")
    destroy_instance_of('container', name)
  end

  private
  def self.list_instances
    list_instances_of('container')
  end

  def build_params
    params = {
    
      
        name: resource[:name],
      
    
      
        image: resource[:image],
      
    
      
        command: resource[:command],
      
    
      
        args: resource[:args],
      
    
      
        workingDir: resource[:workingDir],
      
    
      
        ports: resource[:ports],
      
    
      
        env: resource[:env],
      
    
      
        resources: resource[:resources],
      
    
      
        volumeMounts: resource[:volumeMounts],
      
    
      
        livenessProbe: resource[:livenessProbe],
      
    
      
        readinessProbe: resource[:readinessProbe],
      
    
      
        lifecycle: resource[:lifecycle],
      
    
      
        terminationMessagePath: resource[:terminationMessagePath],
      
    
      
        imagePullPolicy: resource[:imagePullPolicy],
      
    
      
        securityContext: resource[:securityContext],
      
    
      
        stdin: resource[:stdin],
      
    
      
        tty: resource[:tty],
      
    
    }
    params.delete_if { |key, value| value.nil? }
    params
  end
end
