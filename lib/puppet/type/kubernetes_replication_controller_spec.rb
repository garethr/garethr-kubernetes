require 'puppet_x/puppetlabs/swagger/symbolize_keys'


Puppet::Type.newtype(:kubernetes_replication_controller_spec) do
  
  @doc = "ReplicationControllerSpec is the specification of a replication controller."
  

  ensurable

  

  newparam(:name, namevar: true) do
    desc 'Name of the replication_controller_spec.'
  end
  
    
      newproperty(:replicas) do
        desc "Replicas is the number of desired replicas. This is a pointer to distinguish between explicit zero and unspecified. Defaults to 1. More info: http://releases.k8s.io/HEAD/docs/user-guide/replication-controller.md#what-is-a-replication-controller"
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
    
  
    
      newproperty(:selector) do
        desc "Selector is a label query over pods that should match the Replicas count. If Selector is empty, it is defaulted to the labels present on the Pod template. Label keys and values that must match in order to be controlled by this replication controller, if empty defaulted to labels on Pod template. More info: http://releases.k8s.io/HEAD/docs/user-guide/labels.md#label-selectors"
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
    
  
    
      newproperty(:template) do
        desc "Template is the object that describes the pod that will be created if insufficient replicas are detected. This takes precedence over a TemplateRef. More info: http://releases.k8s.io/HEAD/docs/user-guide/replication-controller.md#pod-template"
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
