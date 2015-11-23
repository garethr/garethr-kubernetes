require 'puppet_x/puppetlabs/swagger/symbolize_keys'


Puppet::Type.newtype(:kubernetes_local_object_reference) do
  
  @doc = "LocalObjectReference contains enough information to let you locate the referenced object inside the same namespace."
  

  ensurable

  

  newparam(:name, namevar: true) do
    desc 'Name of the local_object_reference.'
  end
  
    
      newproperty(:name) do
        desc "Name of the referent. More info: http://releases.k8s.io/HEAD/docs/user-guide/identifiers.md#names"
        def insync?(is)
          normalized_is = is.symbolize_keys
          normalized_should = should.symbolize_keys
          if is.all? { |k,v| v.class == String }
            diff = normalized_is.merge(normalized_should)
            diff == normalized_is
          else
            tests = normalized_should.keys.collect do |key|
              normalized_is[key].collect do |is_value|
                normalized_should[key].collect do |should_value|
                  diff = is_value.merge(should_value)
                  diff == is_value
                end
              end
            end
            tests.flatten.include? true
          end
        end
      end
    
  
end
