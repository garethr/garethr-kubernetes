require 'puppet_x/puppetlabs/swagger/symbolize_keys'


Puppet::Type.newtype(:kubernetes_resource_quota_spec) do
  
  @doc = "ResourceQuotaSpec defines the desired hard limits to enforce for Quota."
  

  ensurable

  

  newparam(:name, namevar: true) do
    desc 'Name of the resource_quota_spec.'
  end
  
    
      newproperty(:hard) do
        desc "Hard is the set of desired hard limits for each named resource. More info: http://releases.k8s.io/HEAD/docs/design/admission_control_resource_quota.md#admissioncontrol-plugin-resourcequota"
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
