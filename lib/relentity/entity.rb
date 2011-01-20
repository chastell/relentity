module Relentity module Entity

  def initialize hash = {}
    @properties = {id: object_id}.merge hash
  end

  def method_missing method, *args, &block
    if method =~ /=$/
      @properties[method[0...-1].to_sym] = args.first
    else
      @properties[method] or super
    end
  end

end end
