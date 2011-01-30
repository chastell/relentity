module Relentity module Persistence::YAMLStore::EntityPool

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
      entities[name].select { |id, entity| block.call entity }.values
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
      @entities = YAML::Store.new "#{@root}/#{name}.yml"
      @entities.transaction do
        @entities[name] ||= {}
      end
    end
    @entities
  end

end end
