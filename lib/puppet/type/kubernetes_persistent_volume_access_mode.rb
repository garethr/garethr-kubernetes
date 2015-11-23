require 'puppet_x/puppetlabs/swagger/symbolize_keys'


Puppet::Type.newtype(:kubernetes_persistent_volume_access_mode) do
  

  ensurable

  

  newparam(:name, namevar: true) do
    desc 'Name of the persistent_volume_access_mode.'
  end
  
end
