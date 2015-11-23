require 'puppet_x/puppetlabs/swagger/symbolize_keys'


Puppet::Type.newtype(:kubernetes_empty_dir_volume_source) do
  
  @doc = "EmptyDirVolumeSource is temporary directory that shares a pod's lifetime."
  

  ensurable

  

  newparam(:name, namevar: true) do
    desc 'Name of the empty_dir_volume_source.'
  end
  
    
      newproperty(:medium) do
        desc "What type of storage medium should back this directory. The default is '' which means to use the node's default medium. Must be an empty string (default) or Memory. More info: http://releases.k8s.io/HEAD/docs/user-guide/volumes.md#emptydir"
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
