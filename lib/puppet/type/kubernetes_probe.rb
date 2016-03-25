# This file is automatically generated by puppet-swagger-generator and
# any manual changes are likely to be clobbered when the files
# are regenerated.

require_relative '../../puppet_x/puppetlabs/swagger/fuzzy_compare'


Puppet::Type.newtype(:kubernetes_probe) do
  
  @doc = "Probe describes a health check to be performed against a container to determine whether it is alive or ready to receive traffic."
  

  ensurable

  

  newparam(:name, namevar: true) do
    desc 'Name of the probe.'
  end
  
    
      newproperty(:exec) do
        desc "One and only one of the following should be specified. Exec specifies the action to take."
        def insync?(is)
          PuppetX::Puppetlabs::Swagger::Utils::fuzzy_compare(is, should)
        end
      end
    
  
    
      newproperty(:httpGet) do
        desc "HTTPGet specifies the http request to perform."
        def insync?(is)
          PuppetX::Puppetlabs::Swagger::Utils::fuzzy_compare(is, should)
        end
      end
    
  
    
      newproperty(:tcpSocket) do
        desc "TCPSocket specifies an action involving a TCP port. TCP hooks not yet supported"
        def insync?(is)
          PuppetX::Puppetlabs::Swagger::Utils::fuzzy_compare(is, should)
        end
      end
    
  
    
      newproperty(:initialDelaySeconds) do
        desc "Number of seconds after the container has started before liveness probes are initiated. More info: http://releases.k8s.io/release-1.2/docs/user-guide/pod-states.md#container-probes"
        def insync?(is)
          PuppetX::Puppetlabs::Swagger::Utils::fuzzy_compare(is, should)
        end
      end
    
  
    
      newproperty(:timeoutSeconds) do
        desc "Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1. More info: http://releases.k8s.io/release-1.2/docs/user-guide/pod-states.md#container-probes"
        def insync?(is)
          PuppetX::Puppetlabs::Swagger::Utils::fuzzy_compare(is, should)
        end
      end
    
  
    
      newproperty(:periodSeconds) do
        desc "How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1."
        def insync?(is)
          PuppetX::Puppetlabs::Swagger::Utils::fuzzy_compare(is, should)
        end
      end
    
  
    
      newproperty(:successThreshold) do
        desc "Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness. Minimum value is 1."
        def insync?(is)
          PuppetX::Puppetlabs::Swagger::Utils::fuzzy_compare(is, should)
        end
      end
    
  
    
      newproperty(:failureThreshold) do
        desc "Minimum consecutive failures for the probe to be considered failed after having succeeded. Defaults to 3. Minimum value is 1."
        def insync?(is)
          PuppetX::Puppetlabs::Swagger::Utils::fuzzy_compare(is, should)
        end
      end
    
  
end
