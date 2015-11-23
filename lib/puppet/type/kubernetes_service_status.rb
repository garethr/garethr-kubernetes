require 'puppet_x/puppetlabs/swagger/symbolize_keys'


Puppet::Type.newtype(:kubernetes_service_status) do
  
  @doc = "ServiceStatus represents the current status of a service."
  

  ensurable

  

  newparam(:name, namevar: true) do
    desc 'Name of the service_status.'
  end
  
    
      newproperty(:loadBalancer) do
        desc "LoadBalancer contains the current status of the load-balancer, if one is present."
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
