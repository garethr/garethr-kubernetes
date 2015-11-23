require 'puppet_x/puppetlabs/swagger/symbolize_keys'


Puppet::Type.newtype(:kubernetes_namespace_status) do
  
  @doc = "NamespaceStatus is information about the current status of a Namespace."
  

  ensurable

  

  newparam(:name, namevar: true) do
    desc 'Name of the namespace_status.'
  end
  
    
      newproperty(:phase) do
        desc "Phase is the current lifecycle phase of the namespace. More info: http://releases.k8s.io/HEAD/docs/design/namespaces.md#phases"
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
