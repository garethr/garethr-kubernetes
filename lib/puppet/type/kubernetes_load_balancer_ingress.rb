require 'puppet_x/puppetlabs/swagger/symbolize_keys'


Puppet::Type.newtype(:kubernetes_load_balancer_ingress) do
  
  @doc = "LoadBalancerIngress represents the status of a load-balancer ingress point: traffic intended for the service should be sent to an ingress point."
  

  ensurable

  

  newparam(:name, namevar: true) do
    desc 'Name of the load_balancer_ingress.'
  end
  
    
      newproperty(:ip) do
        desc "IP is set for load-balancer ingress points that are IP based (typically GCE or OpenStack load-balancers)"
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
    
  
    
      newproperty(:hostname) do
        desc "Hostname is set for load-balancer ingress points that are DNS based (typically AWS load-balancers)"
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
