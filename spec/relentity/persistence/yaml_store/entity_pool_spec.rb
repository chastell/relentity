module Relentity describe Persistence::YAMLStore::EntityPool do

  before :all do
    module YAMLStorePeople
      extend Persistence::YAMLStore::EntityPool
    end
    class YAMLStorePerson
      include Entity
      entity_pool YAMLStorePeople
    end
  end

  before :each do
    @root = Dir.mktmpdir
    YAMLStorePeople.root = @root
  end

  after :each do
    FileUtils.rmtree @root
  end

  describe '.<<' do

    it 'saves the passed entity to the YAMLStore, creating it if necessary' do
      File.exists?("#{@root}/Relentity::YAMLStorePeople.yml").should be_false
      YAMLStorePerson.new id: :sandra, given_names: ['Sandra'], surname: 'Battye'
      File.exists?("#{@root}/Relentity::YAMLStorePeople.yml").should be_true
      File.read("#{@root}/Relentity::YAMLStorePeople.yml").should == File.read('spec/fixtures/persistence/yaml_store/entity_pool.sandra.yml')
    end

  end

  describe '.id' do

    it 'returns the Entity with the given id' do
      sam   = YAMLStorePerson.new id: :sam
      sybil = YAMLStorePerson.new id: :sybil
      YAMLStorePeople.id(:sam).should     == sam
      YAMLStorePeople.id(:sybil).should   == sybil
      YAMLStorePeople.id(:auditor).should == nil
    end

  end

  describe '.root=' do

    it 'stores the root dir and repoints the pool' do
      module YAMLStoreRootPool; extend Persistence::YAMLStore::EntityPool; end
      class YAMLStoreRootEntity; include Entity; end
      2.times do
        Dir.mktmpdir do |root|
          File.exists?("#{root}/Relentity::YAMLStoreRootPool.yml").should be_false
          YAMLStoreRootPool.root = root
          YAMLStoreRootPool << YAMLStoreRootEntity.new
          File.exists?("#{root}/Relentity::YAMLStoreRootPool.yml").should be_true
        end
      end
    end

  end

  describe '.select' do

    it 'returns Entities fulfilling the given block' do
      sam   = YAMLStorePerson.new id: :sam, given_names: ['Samuel'], surname: 'Vimes'
      sybil = YAMLStorePerson.new id: :sybil, given_names: ['Sybil', 'Deirdre', 'Olgivanna'], surname: 'Vimes'
      YAMLStorePeople.select { |p| p.surname == 'Vimes' }.should include sam
      YAMLStorePeople.select { |p| p.surname == 'Vimes' }.should include sybil
      YAMLStorePeople.select { |p| p.given_names.include? 'Deirdre' }.should == [sybil]
    end

  end

  describe '.update' do

    it 'saves the updated entity to the YAMLStore' do
      sandra = YAMLStorePerson.new id: :sandra, given_names: ['Sandra'], surname: 'Battye'
      File.read("#{@root}/Relentity::YAMLStorePeople.yml").should == File.read('spec/fixtures/persistence/yaml_store/entity_pool.sandra.yml')
      sandra.occupation = 'seamstress'
      File.read("#{@root}/Relentity::YAMLStorePeople.yml").should == File.read('spec/fixtures/persistence/yaml_store/entity_pool.sandra+seamstress.yml')
    end

  end

end end
