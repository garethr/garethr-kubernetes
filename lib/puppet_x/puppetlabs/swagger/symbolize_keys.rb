class Object
  def kube_symbolize_keys
    return self.inject({}){|memo,(k,v)| memo[k.to_sym] = v.kube_symbolize_keys; memo} if self.is_a? Hash
    return self.inject([]){|memo,v    | memo           << v.kube_symbolize_keys; memo} if self.is_a? Array
    return self
  end
end
