module Relentity describe Rel do

  before do
    @sam   = People[:sam]
    @sybil = People[:sybil]
    @y_sam = People[:y_sam]
    @duchy = Rels[:duchy]
    @cow   = Rels[:cow]
  end

  describe '.new' do

    it 'adds the new Rel to Rels' do
      Rels.should_receive(:<<).with an_instance_of Rel
      Rel.new
    end

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
      @duchy.refs?(@sam).should    be_true
      @duchy.refs?(@sybil).should  be_true
      @duchy.refs?(@y_sams).should be_false
    end

  end

  describe '#rel_to_other' do

    it 'returns the relationship to the Entity other than the passed one' do
      @duchy.rel_to_other(@sam).should   == :spouses
      @duchy.rel_to_other(@sybil).should == :spouses
      @duchy.rel_to_other(@y_sam).should == nil

      @cow.rel_to_other(@sam).should   == :children
      @cow.rel_to_other(@y_sam).should == :parents
      @cow.rel_to_other(@sybil).should == nil
    end

  end

end end
