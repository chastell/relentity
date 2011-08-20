require_relative '../spec_helper'

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
      sam_self = Rel.new id: :sam_self, refs: [@y_sam, @y_sam]
      Rels[:sam_self].must_be_same_as sam_self
    end

    it 'references passed-in refs' do
      @duchy.instance_variable_get(:@properties)[:refs].must_equal [{ref: 'People', id: :sam}, {ref: 'People', id: :sybil}]
    end

  end

  describe '#other' do

    it 'returns the other Entity' do
      @duchy.other(@sam).must_be_same_as @sybil
      @duchy.other(@sybil).must_be_same_as @sam
      @duchy.other(@y_sam).must_be_nil
    end

  end

  describe '#refs' do

    it 'dereferences internal refs' do
      @duchy.refs.must_equal [@sam, @sybil]
    end

  end

  describe '#refs=' do

    it 'references passed-in refs' do
      chudy = @duchy.dup
      chudy.refs = [@sybil, @sam]
      chudy.instance_variable_get(:@properties)[:refs].must_equal [{ref: 'People', id: :sybil}, {ref: 'People', id: :sam}]
    end

  end

  describe '#refs?' do

    it 'is a predicate whether the Rel refs the given Entity' do
      assert @duchy.refs? @sam
      assert @duchy.refs? @sybil
      refute @duchy.refs? @y_sam
    end

  end

  describe '#rel_to_other' do

    it 'returns the relationship to the Entity other than the passed one' do
      @duchy.rel_to_other(@sam).must_equal :spouses
      @duchy.rel_to_other(@sybil).must_equal :spouses
      @duchy.rel_to_other(@y_sam).must_be_nil

      @cow.rel_to_other(@sam).must_equal :children
      @cow.rel_to_other(@y_sam).must_equal :parents
      @cow.rel_to_other(@sybil).must_be_nil
    end

  end

end end
