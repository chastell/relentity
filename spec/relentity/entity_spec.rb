module Relentity describe Entity do

  describe '.new' do

    it 'ensures that the new Entity has an id' do
      id_less = Person.new
      -> { id_less.id }.should_not raise_error
    end

    it 'adds the new Entity to its EntityPool' do
      People.should_receive(:add).with an_instance_of Person
      Person.new
    end

    it 'does not raise when the EntityPool is missing' do
      class Poolless; include Entity; end
      -> { Poolless.new }.should_not raise_error
    end

  end

  describe '.entity_pool' do

    it 'retrieves and stores the related EntityPool' do
      class AnEntity; include Entity; end
      module AnEntityPool; end
      AnEntity.entity_pool.should be_nil
      AnEntity.entity_pool AnEntityPool
      AnEntity.entity_pool.should == AnEntityPool
    end

  end

  describe '#method_missing' do

    it 'retrieves and sets arbitrary properties' do
      librarian = Person.new given_names: ['Horace'], surname: 'Worblehat'
      librarian.given_names.should == ['Horace']
      librarian.surname.should     == 'Worblehat'

      -> { librarian.species }.should raise_error NoMethodError
      librarian.species        =  'monk^W'
      librarian.species.should == 'monk^W'
      librarian.species        =  'ape'
      librarian.species.should == 'ape'
    end

    it 'notifies its EntityPool when setting properties' do
      librarian = Person.new given_names: ['Horace'], surname: 'Worblehat'
      People.should_receive(:update).with librarian
      librarian.species = 'ape'
    end

    it 'does not raise when the EntityPool is missing' do
      class Poolless; include Entity; end
      -> { Poolless.new.foo = :bar }.should_not raise_error
    end

  end

  describe '#related' do

    it 'returns the relevant EntityRels object, enabling access to related Entities' do
      class AnEvent; include Entity; end
      event  = AnEvent.new
      person = Person.new
      Rel.new refs: [event, person], rels: [:events, :participants]
      event.related.participants.should include person
      person.related.events.should      include event
    end

  end

end end
