module Relentity
  autoload :Entity,     'relentity/entity'
  autoload :EntityRels, 'relentity/entity_rels'
  autoload :Rel,        'relentity/rel'
  autoload :Rels,       'relentity/rels'
  module Persistence
    module NoThanks
      autoload :EntityPool, 'relentity/persistence/no_thanks/entity_pool'
    end
    module PStore
      require 'pstore'
      autoload :EntityPool, 'relentity/persistence/pstore/entity_pool'
    end
  end
end
