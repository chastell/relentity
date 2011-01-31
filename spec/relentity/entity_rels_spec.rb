module Relentity describe EntityRels do

  describe '#method_missing' do

    it 'retrieves Entities based on relationship' do
      sam   = People[:sam]
      sybil = People[:sybil]
      y_sam = People[:y_sam]

      sams   = EntityRels.new sam
      sybils = EntityRels.new sybil
      y_sams = EntityRels.new y_sam

      sams.spouses.should    include sybil
      sybils.spouses.should  include sam
      sams.children.should   include y_sam
      sybils.children.should include y_sam
      y_sams.parents.should  include sam
      y_sams.parents.should  include sybil

      -> { y_sams.toys }.should raise_error NoMethodError
    end

  end

end end
