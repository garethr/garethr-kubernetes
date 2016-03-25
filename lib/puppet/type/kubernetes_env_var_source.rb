# This file is automatically generated by puppet-swagger-generator and
# any manual changes are likely to be clobbered when the files
# are regenerated.

require_relative '../../puppet_x/puppetlabs/swagger/fuzzy_compare'


Puppet::Type.newtype(:kubernetes_env_var_source) do
  
  @doc = "EnvVarSource represents a source for the value of an EnvVar."
  

  ensurable

  

  newparam(:name, namevar: true) do
    desc 'Name of the env_var_source.'
  end
  
    
      newproperty(:fieldRef) do
        desc "Selects a field of the pod; only name and namespace are supported."
        def insync?(is)
          PuppetX::Puppetlabs::Swagger::Utils::fuzzy_compare(is, should)
        end
      end
    
  
    
      newproperty(:configMapKeyRef) do
        desc "Selects a key of a ConfigMap."
        def insync?(is)
          PuppetX::Puppetlabs::Swagger::Utils::fuzzy_compare(is, should)
        end
      end
    
  
    
      newproperty(:secretKeyRef) do
        desc "Selects a key of a secret in the pod's namespace"
        def insync?(is)
          PuppetX::Puppetlabs::Swagger::Utils::fuzzy_compare(is, should)
        end
      end
    
  
end
