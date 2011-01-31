module Relentity module Persistence::NoThanks::EntityPool

  def << entity
    entity.id ||= entity.object_id
    entities[entity.id] = entity
  end

  def [] id
    entities[id]
  end

  def select &block
    entities.select { |id, entity| block.call entity }.values
  end

  private

  def entities
    @entities ||= {}
  end

end end
