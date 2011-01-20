module Relentity module Entity

  def initialize hash
    @properties = hash
  end

  def method_missing method, *args, &block
    if method =~ /=$/
      @properties[method[0...-1].to_sym] = args.first
    else
      @properties[method]
    end
  end

end end
