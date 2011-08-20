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
      class NoThanksAddEntity; include Entity; end
      module NoThanksAddPool; extend Persistence::NoThanks::EntityPool; end
      entity = NoThanksAddEntity.new
      entity.id.must_be_nil
      NoThanksAddPool[entity.object_id].must_be_nil
      NoThanksAddPool << entity
      entity.id.must_equal entity.object_id
      NoThanksAddPool[entity.object_id].must_be_same_as entity
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
