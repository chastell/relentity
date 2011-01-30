module Relentity module Persistence::PStore::EntityPool

  def add entity
    entities.transaction do
      entities[entity.id] = entity
    end
  end

  def id id
    entities.transaction true do
      entities[id]
    end
  end

  def root root = nil
    @root ||= root
  end

  def update entity
    entities.transaction do
      entities[entity.id] = entity
    end
  end

  private

  def entities
    @entities ||= PStore.new "#{@root}/#{name}.pstore"
  end

end end
