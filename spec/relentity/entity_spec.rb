module Relentity describe Entity do

  class Person
    include Entity
  end

  describe '#method_missing' do

    it 'retrieves arbitrary properties set upon initialisation' do
      librarian = Person.new given_names: ['Horace'], surname: 'Worblehat'
      librarian.given_names.should == ['Horace']
      librarian.surname.should     == 'Worblehat'
    end

  end

end end
