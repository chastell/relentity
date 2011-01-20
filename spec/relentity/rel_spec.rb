module Relentity describe Rel do

  before do
    @sam   = Person.new
    @sybil = Person.new
    @y_sam = Person.new
    @duchy = Rel.new refs: [@sam, @sybil]
  end

  describe '#other' do

    it 'returns the other Entity' do
      @duchy.other(@sam).should   == @sybil
      @duchy.other(@sybil).should == @sam
      @duchy.other(@y_sam).should == nil
    end

  end

  describe '#refs?' do

    it 'is a predicate whether the Rel refs the given Entity' do
      @duchy.should     be_refs @sam
      @duchy.should     be_refs @sybil
      @duchy.should_not be_refs @y_sam
    end

  end

end end
