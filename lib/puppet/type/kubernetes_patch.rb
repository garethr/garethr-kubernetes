require 'puppet_x/puppetlabs/swagger/symbolize_keys'


Puppet::Type.newtype(:kubernetes_patch) do
  

  ensurable

  

  newparam(:name, namevar: true) do
    desc 'Name of the patch.'
  end
  
end
