module Relentity describe EntityPool do

  module People
    extend EntityPool
    def self.include? entity
      (@entities or []).include? entity
    end
  end

  describe '.<<' do

    it 'adds the passed object to the pool' do
      object = Object.new
      People.should_not include object
      People << object
      People.should include object
    end

  end

end end
