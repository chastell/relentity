module Relentity
  autoload :Entity,     'relentity/entity'
  autoload :EntityPool, 'relentity/entity_pool'
  autoload :EntityRels, 'relentity/entity_rels'
  autoload :Rel,        'relentity/rel'
  autoload :Rels,       'relentity/rels'
  module Persistence
    module NoThanks
      autoload :EntityPool, 'relentity/persistence/no_thanks/entity_pool'
    end
  end
end
