
# This file is automatically generated by puppet-swagger-generator and
# any manual changes are likely to be clobbered when the files
# are regenerated.

require_relative '../../puppet_x/puppetlabs/swagger/fuzzy_compare'

Puppet::Type.newtype(:kubernetes_node_config_source) do
  
  @doc = "NodeConfigSource specifies a source of node configuration. Exactly one subfield (excluding metadata) must be non-nil."
  

  ensurable

  

  newparam(:name, namevar: true) do
    desc 'Name of the node_config_source.'
  end
  
    
  
    
  
    
      
      newproperty(:config_map_ref) do
      
        
        def insync?(is)
          PuppetX::Puppetlabs::Swagger::Utils::fuzzy_compare(is, should)
        end
      end
    
  
end