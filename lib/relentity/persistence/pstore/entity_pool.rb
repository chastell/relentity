module Relentity module Persistence::PStore::EntityPool

  def add entity
    entities ||= PStore.new "#{@root}/#{name}.pstore"
    entities.transaction do
      entities[entity.id] = entity
    end
  end

  def root root = nil
    @root ||= root
  end

end end
