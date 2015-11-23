require 'puppet_x/puppetlabs/swagger/symbolize_keys'


Puppet::Type.newtype(:kubernetes_node_daemon_endpoints) do
  
  @doc = "NodeDaemonEndpoints lists ports opened by daemons running on the Node."
  

  ensurable

  

  newparam(:name, namevar: true) do
    desc 'Name of the node_daemon_endpoints.'
  end
  
    
      newproperty(:kubeletEndpoint) do
        desc "Endpoint on which Kubelet is listening."
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
