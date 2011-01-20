module Relentity describe EntityPool do

  describe '.<<' do

    it 'adds the passed object to the pool' do
      object = Object.new
      def object.id; :object; end
      People.id(:object).should == nil
      People << object
      People.id(:object).should == object
    end

  end

  describe '.id' do

    it 'returns the Entity with the given id' do
      People << (rincewind = Person.new id: :rincewind)
      People << (twoflower = Person.new id: :twoflower)
      People.id(:rincewind).should == rincewind
      People.id(:twoflower).should == twoflower
      People.id(:auditor).should   == nil
    end

  end

end end
