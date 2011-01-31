module Relentity describe Persistence::NoThanks::EntityPool do

  before :all do
    module NoThanksPeople
      extend Persistence::NoThanks::EntityPool
    end
    class NoThanksPerson
      include Entity
      entity_pool NoThanksPeople
    end
  end

  describe '.<<' do

    it 'adds the passed object to the pool, giving it id if missing' do
      class NoThanksAddEntity; include Entity; end
      module NoThanksAddPool; extend Persistence::NoThanks::EntityPool; end
      entity = NoThanksAddEntity.new
      entity.id.should be_nil
      NoThanksAddPool[entity.object_id].should == nil
      NoThanksAddPool << entity
      entity.id.should == entity.object_id
      NoThanksAddPool[entity.object_id].should == entity
    end

  end

  describe '.[]' do

    it 'returns the Entity with the given id' do
      NoThanksPeople << (rincewind = NoThanksPerson.new id: :rincewind)
      NoThanksPeople << (twoflower = NoThanksPerson.new id: :twoflower)
      NoThanksPeople[:rincewind].should == rincewind
      NoThanksPeople[:twoflower].should == twoflower
      NoThanksPeople[:auditor].should   == nil
    end

  end

  describe '.select' do

    it 'returns Entities fulfilling the block given' do
      sandra = NoThanksPerson.new id: :sandra, given_names: ['Sandra'], surname: 'Battye'
      NoThanksPeople.select { |p| p.id == :sandra }.should == [NoThanksPeople[:sandra]]
    end

  end

end end
