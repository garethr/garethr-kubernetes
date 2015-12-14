class Object
  def fixnumify
    if self.respond_to? :to_i and self.to_i.to_s == self
      # If we can cast it to a Fixnum without losing anything do it.
      self.to_i
    elsif self.is_a? Array
      # If it's an Array, use Enumerable#map to recursively call this method
      # on each item.
      self.map {|item| item.fixnumify }
    elsif self.is_a? Hash
      # If it's a Hash, recursively call this method on each value.
      self.merge( self ) {|k, val| val.fixnumify }
    else
      # If for some reason we run into something else, just return
      # it unmodified; alternatively you could throw an exception.
      self
    end
  end
end
