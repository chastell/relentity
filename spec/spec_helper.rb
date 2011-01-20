module People
  extend Relentity::EntityPool
end

class Person
  include Relentity::Entity
  entity_pool People
end
