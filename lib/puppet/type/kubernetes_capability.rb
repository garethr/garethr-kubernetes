require 'puppet_x/puppetlabs/swagger/symbolize_keys'


Puppet::Type.newtype(:kubernetes_capability) do
  

  ensurable

  

  newparam(:name, namevar: true) do
    desc 'Name of the capability.'
  end
  
end
