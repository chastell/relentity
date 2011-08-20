require_relative '../spec_helper'

module Relentity describe EntityRels do

  describe '#method_missing' do

    it 'retrieves Entities based on relationship' do
      sam   = People[:sam]
      sybil = People[:sybil]
      y_sam = People[:y_sam]

      sams   = EntityRels.new sam
      sybils = EntityRels.new sybil
      y_sams = EntityRels.new y_sam

      sams.spouses.must_include    sybil
      sybils.spouses.must_include  sam
      sams.children.must_include   y_sam
      sybils.children.must_include y_sam
      y_sams.parents.must_include  sam
      y_sams.parents.must_include  sybil

      -> { y_sams.toys }.must_raise NoMethodError
    end

  end

end end
