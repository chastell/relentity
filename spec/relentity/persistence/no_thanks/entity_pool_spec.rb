require_relative '../../../spec_helper'

module Relentity describe Persistence::NoThanks::EntityPool do

  module NoThanksPeople
    extend Persistence::NoThanks::EntityPool
  end

  class NoThanksPerson
    include Entity
    entity_pool NoThanksPeople
  end

  describe '.<<' do

    it 'adds the passed object to the pool, giving it id if missing' do
      entity_class = Class.new { include Entity }
      pool = Module.new { extend Persistence::NoThanks::EntityPool }
      entity = entity_class.new
      entity.id.must_be_nil
      pool[entity.object_id].must_be_nil
      pool << entity
      entity.id.must_equal entity.object_id
      pool[entity.object_id].must_be_same_as entity
    end

  end

  describe '.[]' do

    it 'returns the Entity with the given id' do
      NoThanksPeople << (rincewind = NoThanksPerson.new id: :rincewind)
      NoThanksPeople << (twoflower = NoThanksPerson.new id: :twoflower)
      NoThanksPeople[:rincewind].must_be_same_as rincewind
      NoThanksPeople[:twoflower].must_be_same_as twoflower
      NoThanksPeople[:auditor].must_be_nil
    end

  end

  describe '.select' do

    it 'returns Entities fulfilling the block given' do
      sandra = NoThanksPerson.new id: :sandra, given_names: ['Sandra'], surname: 'Battye'
      NoThanksPeople.select { |p| p.id == :sandra }.must_equal [NoThanksPeople[:sandra]]
    end

  end

end end
