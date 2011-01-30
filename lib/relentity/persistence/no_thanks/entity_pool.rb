module Relentity module Persistence::NoThanks::EntityPool

  def add entity
    entities[entity.id] = entity
  end

  def id id
    entities[id]
  end

  def select &block
    entities.values.select &block
  end

  def update entity
  end

  private

  def entities
    @entities ||= {}
  end

end end
