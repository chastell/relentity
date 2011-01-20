module Relentity module EntityPool

  def << entity
    @entities ||= []
    @entities << entity
  end

  def id id
    (@entities || []).find { |e| e.id == id }
  end

end end
