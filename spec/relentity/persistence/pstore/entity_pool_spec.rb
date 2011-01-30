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

  describe '.id' do

    it 'returns the Entity with the given id' do
      FileUtils.cp 'spec/fixtures/PStorePeople.id.pstore', "#{@root}/Relentity::PStorePeople.pstore"
      PStorePeople.id(:sam).surname.should       == 'Vimes'
      PStorePeople.id(:sybil).given_names.should include 'Deirdre'
      PStorePeople.id(:auditor).should           be_nil
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

  describe '.update' do

    it 'saves the passed entity to the PStore' do
      FileUtils.cp 'spec/fixtures/PStorePeople.add.pstore', "#{@root}/Relentity::PStorePeople.pstore"
      sandra = PStorePeople.id :sandra
      sandra.occupation = 'seamstress'
      File.binread("#{@root}/Relentity::PStorePeople.pstore").should == File.binread('spec/fixtures/PStorePeople.update.pstore')
    end

  end

end end
