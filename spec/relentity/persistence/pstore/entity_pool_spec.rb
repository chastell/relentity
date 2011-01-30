module Relentity describe Persistence::PStore::EntityPool do

  before :all do
    module PStorePeople
      extend Persistence::PStore::EntityPool
    end
    class PStorePerson
      include Entity
      entity_pool PStorePeople
    end
    @root = Dir.mktmpdir
    PStorePeople.root @root
  end

  after :all do
    FileUtils.rmtree @root
  end

  describe '.add' do

    it 'saves the passed entity to the PStore, creating it if necessary' do
      File.exists?("#{@root}/Relentity::PStorePeople.pstore").should be_false
      PStorePerson.new id: :sandra, given_names: ['Sandra'], surname: 'Battye'
      File.exists?("#{@root}/Relentity::PStorePeople.pstore").should be_true
      File.binread("#{@root}/Relentity::PStorePeople.pstore").should == File.binread('spec/fixtures/PStorePeople.add.pstore')
    end

  end

  describe '.root' do

    it 'retrieves and stores the PStore root dir' do
      module Rootless; extend Persistence::PStore::EntityPool; end
      Rootless.root.should == nil
      Rootless.root 'dir'
      Rootless.root.should == 'dir'
    end

  end

end end
