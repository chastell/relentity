module Relentity class Rel

  include Entity

  entity_pool Rels

  def initialize hash = {}
    @properties = {}
    self.refs = hash.delete :refs
    super
  end

  def other entity
    case entity
    when refs.first then refs.last
    when refs.last  then refs.first
    end
  end

  def refs
    @properties[:refs].map { |ref| (eval ref[:ref])[ref[:id]] }
  end

  def refs= refs
    @properties[:refs] = refs.map { |ref| {ref: ref.class.entity_pool.name, id: ref.id} }
  end

  def refs? entity
    refs.include? entity
  end

  def rel_to_other entity
    case entity
    when refs.first then rels.last
    when refs.last  then rels.first
    end
  end

end end
