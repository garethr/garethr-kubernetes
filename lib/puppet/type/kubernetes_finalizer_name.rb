require 'puppet_x/puppetlabs/swagger/symbolize_keys'


Puppet::Type.newtype(:kubernetes_finalizer_name) do
  

  ensurable

  

  newparam(:name, namevar: true) do
    desc 'Name of the finalizer_name.'
  end
  
end
