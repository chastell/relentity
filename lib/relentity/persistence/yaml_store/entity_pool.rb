module Relentity module Persistence::YAMLStore::EntityPool

  def add entity
    entities.transaction do
      entities[entity.id] = entity
    end
    identity_map[entity.id] = entity
  end

  def id id
    identity_map[id]
  end

  def root= root
    @root     = root
    @entities = nil
  end

  def select &block
    ids = entities.transaction true do
      entities.roots.select { |id| block.call entities[id] }
    end
    identity_map.values_at *ids
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

  def identity_map
    @identity_map ||= Hash.new do |map, id|
      map[id] = entities.transaction true do
        entities[id]
      end
    end
  end

end end
