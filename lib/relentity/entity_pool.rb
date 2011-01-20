module Relentity module EntityPool

  def << entity
    @entities ||= []
    @entities << entity
  end

end end
