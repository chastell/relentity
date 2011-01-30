module Relentity
  autoload :Entity,     'relentity/entity'
  autoload :EntityRels, 'relentity/entity_rels'
  autoload :Rel,        'relentity/rel'
  autoload :Rels,       'relentity/rels'
  module Persistence
    module NoThanks
      autoload :EntityPool, 'relentity/persistence/no_thanks/entity_pool'
    end
    module YAMLStore
      require 'yaml'
      YAML::ENGINE.yamler = 'psych' if defined? Psych
      require 'yaml/store'
      autoload :EntityPool, 'relentity/persistence/yaml_store/entity_pool'
    end
  end
end
