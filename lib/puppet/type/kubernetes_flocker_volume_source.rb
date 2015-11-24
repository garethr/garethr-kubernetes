# This file is automatically generated by puppet-swagger-generator and
# any manual changes are likely to be clobbered when the files
# are regenerated.

require 'puppet_x/puppetlabs/swagger/fuzzy_compare'


Puppet::Type.newtype(:kubernetes_flocker_volume_source) do
  
  @doc = "FlockerVolumeSource represents a Flocker volume mounted by the Flocker agent."
  

  ensurable

  
  validate do
    required_properties = [
    
      datasetName,
    
    ]
    required_properties.each do |property|
      # We check for both places so as to cover the puppet resource path as well
      if self[property].nil? and self.provider.send(property) == :absent
        fail "You must provide a #{property}"
      end
    end
  end
  

  newparam(:name, namevar: true) do
    desc 'Name of the flocker_volume_source.'
  end
  
    
      newproperty(:datasetName) do
        desc "Required: the volume name. This is going to be store on metadata -> name on the payload for Flocker"
        def insync?(is)
          PuppetX::Puppetlabs::Swagger::Utils::fuzzy_compare(is, should)
        end
      end
    
  
end