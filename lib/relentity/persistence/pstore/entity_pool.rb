module Relentity module Persistence::PStore::EntityPool

  def add entity
    entities.transaction do
      entities[name][entity.id] = entity
    end
  end

  def id id
    entities.transaction true do
      entities[name][id]
    end
  end

  def root root = nil
    @root ||= root
  end

  def select &block
    entities.transaction true do
      entities[name].values.select &block
    end
  end

  def update entity
    entities.transaction do
      entities[name][entity.id] = entity
    end
  end

  private

  def entities
    unless @entities
      @entities = PStore.new "#{@root}/#{name}.pstore"
      @entities.transaction do
        @entities[name] = {}
      end
    end
    @entities
  end

end end
