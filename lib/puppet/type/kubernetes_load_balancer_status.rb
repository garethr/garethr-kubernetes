require 'puppet_x/puppetlabs/swagger/symbolize_keys'


Puppet::Type.newtype(:kubernetes_load_balancer_status) do
  
  @doc = "LoadBalancerStatus represents the status of a load-balancer."
  

  ensurable

  

  newparam(:name, namevar: true) do
    desc 'Name of the load_balancer_status.'
  end
  
    
      newproperty(:ingress) do
        desc "Ingress is a list containing ingress points for the load-balancer. Traffic intended for the service should be sent to these ingress points."
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
