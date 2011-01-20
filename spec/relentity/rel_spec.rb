module Relentity describe Rel do

  describe '#refs?' do

    it 'is a predicate whether the Rel refs the given Entity' do
      mort    = Person.new id: :mort
      ysabell = Person.new id: :ysabell
      susan   = Person.new id: :susan
      duchy   = Rel.new refs: [mort, ysabell]
      duchy.should     be_refs mort
      duchy.should     be_refs ysabell
      duchy.should_not be_refs susan
    end

  end

end end
