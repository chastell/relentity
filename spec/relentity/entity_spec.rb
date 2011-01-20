module Relentity describe Entity do

  class Person
    include Entity
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

  end

end end
