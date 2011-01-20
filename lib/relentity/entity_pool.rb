module Relentity module EntityPool

  def << entity
    entities[entity.id] = entity
  end

  def id id
    entities[id]
  end

  def select &block
    entities.values.select &block
  end

  private

  def entities
    @entities ||= {}
  end

end end
