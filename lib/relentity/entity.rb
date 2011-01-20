module Relentity module Entity

  def initialize hash
    @properties = hash
  end

  def method_missing method, *args, &block
    @properties[method]
  end

end end
