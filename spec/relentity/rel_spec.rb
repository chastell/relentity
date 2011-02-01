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
      Rel.new refs: [@y_sam, @y_sam]
    end

    it 'references passed-in refs' do
      @duchy.instance_variable_get(:@properties)[:refs].should == [{ref: 'People', id: :sam}, {ref: 'People', id: :sybil}]
    end

  end

  describe '#other' do

    it 'returns the other Entity' do
      @duchy.other(@sam).should   be @sybil
      @duchy.other(@sybil).should be @sam
      @duchy.other(@y_sam).should be nil
    end

  end

  describe '#refs' do

    it 'dereferences internal refs' do
      @duchy.refs.should == [@sam, @sybil]
    end

  end

  describe '#refs=' do

    it 'references passed-in refs' do
      chudy = @duchy.dup
      chudy.refs = [@sybil, @sam]
      chudy.instance_variable_get(:@properties)[:refs].should == [{ref: 'People', id: :sybil}, {ref: 'People', id: :sam}]
    end

  end

  describe '#refs?' do

    it 'is a predicate whether the Rel refs the given Entity' do
      @duchy.refs?(@sam).should   be true
      @duchy.refs?(@sybil).should be true
      @duchy.refs?(@y_sam).should be false
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
