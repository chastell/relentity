module Relentity class EntityRels

  def initialize entity
    @rels = Rels.select { |rel| rel.refs? entity }
                .group_by { |rel| rel.rel_to_other entity }
                .each_value { |rels| rels.map! { |rel| rel.other entity } }
  end

  def method_missing method, *args, &block
    @rels[method]
  end

end end
