module Relentity describe EntityPool do

  describe '.add' do

    it 'adds the passed object to the pool' do
      object = Object.new
      def object.id; :object; end
      People.id(:object).should == nil
      People.add object
      People.id(:object).should == object
    end

  end

  describe '.id' do

    it 'returns the Entity with the given id' do
      People.add rincewind = Person.new(id: :rincewind)
      People.add twoflower = Person.new(id: :twoflower)
      People.id(:rincewind).should == rincewind
      People.id(:twoflower).should == twoflower
      People.id(:auditor).should   == nil
    end

  end

  describe '.update' do

    it 'exists and takes an argument' do
      -> { People.update Object.new }.should_not raise_error
    end

  end

  describe '.select' do

    it 'returns Entities fulfilling the block given' do
      People.select { |p| p.id == :sam }.should == [People.id(:sam)]
    end

  end

end end
