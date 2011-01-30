Relentity::EntityPool = Relentity::Persistence::NoThanks::EntityPool

module People
  extend Relentity::EntityPool
end

class Person
  include Relentity::Entity
  entity_pool People
end

sam   = Person.new id: :sam
sybil = Person.new id: :sybil
y_sam = Person.new id: :y_sam

Relentity::Rel.new id: :duchy, refs: [sam, sybil],   rels: [:spouses, :spouses]
Relentity::Rel.new id: :cow,   refs: [sam, y_sam],   rels: [:parents, :children]
Relentity::Rel.new id: :'42',  refs: [y_sam, sybil], rels: [:children, :parents]
