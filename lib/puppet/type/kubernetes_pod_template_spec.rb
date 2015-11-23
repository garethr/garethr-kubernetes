require 'puppet_x/puppetlabs/swagger/symbolize_keys'


Puppet::Type.newtype(:kubernetes_pod_template_spec) do
  
  @doc = "PodTemplateSpec describes the data a pod should have when created from a template"
  

  ensurable

  

  newparam(:name, namevar: true) do
    desc 'Name of the pod_template_spec.'
  end
  
    
      newproperty(:metadata) do
        desc "Standard object's metadata. More info: http://releases.k8s.io/HEAD/docs/devel/api-conventions.md#metadata"
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
    
  
    
      newproperty(:spec) do
        desc "Specification of the desired behavior of the pod. More info: http://releases.k8s.io/HEAD/docs/devel/api-conventions.md#spec-and-status"
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
