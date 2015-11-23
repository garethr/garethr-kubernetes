require 'puppet_x/puppetlabs/swagger/symbolize_keys'


Puppet::Type.newtype(:kubernetes_pod_security_context) do
  
  @doc = "PodSecurityContext holds pod-level security attributes and common container settings."
  

  ensurable

  

  newparam(:name, namevar: true) do
    desc 'Name of the pod_security_context.'
  end
  
end
