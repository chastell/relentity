module Relentity describe Entity do

  describe '.new' do

    it 'adds the new Entity to its EntityPool' do
      person = Person.new id: :person
      People[:person].must_be_same_as person
    end

    it 'does not raise when the EntityPool is missing' do
      class Poolless; include Entity; end
      Poolless.new
    end

  end

  describe '.entity_pool' do

    it 'retrieves and stores the related EntityPool' do
      class AnEntity; include Entity; end
      module AnEntityPool; end
      AnEntity.entity_pool.must_be_nil
      AnEntity.entity_pool AnEntityPool
      AnEntity.entity_pool.must_be_same_as AnEntityPool
    end

  end

  describe '#id' do

    it 'returns nil if not set explicitly' do
      class Idless; include Entity; end
      Idless.new.id.must_be_nil
    end

  end

  describe '#method_missing' do

    it 'retrieves and sets arbitrary properties' do
      librarian = Person.new given_names: ['Horace'], surname: 'Worblehat'
      librarian.given_names.must_equal ['Horace']
      librarian.surname.must_equal 'Worblehat'

      -> { librarian.species }.must_raise NoMethodError
      librarian.species = 'monk^W'
      librarian.species.must_equal 'monk^W'
      librarian.species = 'ape'
      librarian.species.must_equal 'ape'
    end

    it 'notifies its EntityPool when setting properties' do
      mock_pool = MiniTest::Mock.new
      entity_class = Class.new { include Entity }
      entity = entity_class.new
      entity_class.entity_pool mock_pool

      mock_pool.expect :<<, nil, [entity]
      entity.foo = 'bar'
      mock_pool.verify
    end

    it 'does not raise when the EntityPool is missing' do
      class Poolless; include Entity; end
      Poolless.new.foo = :bar
    end

  end

  describe '#related' do

    it 'returns the relevant EntityRels object, enabling access to related Entities' do
      module Events; extend EntityPool; end
      class Event; include Entity; entity_pool Events; end
      event  = Event.new
      person = Person.new
      Rel.new refs: [event, person], rels: [:events, :participants]
      event.related.participants.must_include person
      person.related.events.must_include event
    end

  end

end end
