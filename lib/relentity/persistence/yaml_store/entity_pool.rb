module Relentity module Persistence::YAMLStore::EntityPool

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

  def root= root
    @root     = root
    @entities = nil
  end

  def select &block
    entities.transaction true do
      entities.roots.select { |id| block.call entities[id] }.map { |id| entities[id] }
    end
  end

  def update entity
    entities.transaction do
      entities[entity.id] = entity
    end
  end

  private

  def entities
    @entities ||= YAML::Store.new "#{@root}/#{name}.yml"
  end

end end
