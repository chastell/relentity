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

    it 'adds the passed object to the pool' do
      object = Object.new
      def object.id; :object; end
      NoThanksPeople.id(:object).should == nil
      NoThanksPeople << object
      NoThanksPeople.id(:object).should == object
    end

  end

  describe '.id' do

    it 'returns the Entity with the given id' do
      NoThanksPeople << (rincewind = NoThanksPerson.new id: :rincewind)
      NoThanksPeople << (twoflower = NoThanksPerson.new id: :twoflower)
      NoThanksPeople.id(:rincewind).should == rincewind
      NoThanksPeople.id(:twoflower).should == twoflower
      NoThanksPeople.id(:auditor).should   == nil
    end

  end

  describe '.select' do

    it 'returns Entities fulfilling the block given' do
      sandra = NoThanksPerson.new id: :sandra, given_names: ['Sandra'], surname: 'Battye'
      NoThanksPeople.select { |p| p.id == :sandra }.should == [NoThanksPeople.id(:sandra)]
    end

  end

end end
