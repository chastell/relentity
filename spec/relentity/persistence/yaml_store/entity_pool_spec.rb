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
      Pathname("#{@root}/Relentity::YAMLStorePeople.yml").should_not exist
      YAMLStorePerson.new id: :sandra, given_names: ['Sandra'], surname: 'Battye'
      Pathname("#{@root}/Relentity::YAMLStorePeople.yml").should exist
      File.read("#{@root}/Relentity::YAMLStorePeople.yml").should == File.read('spec/fixtures/persistence/yaml_store/entity_pool.sandra.yml')
    end

    it 'saves the updated entity to the YAMLStore' do
      sandra = YAMLStorePerson.new id: :sandra, given_names: ['Sandra'], surname: 'Battye'
      File.read("#{@root}/Relentity::YAMLStorePeople.yml").should == File.read('spec/fixtures/persistence/yaml_store/entity_pool.sandra.yml')
      sandra.occupation = 'seamstress'
      File.read("#{@root}/Relentity::YAMLStorePeople.yml").should == File.read('spec/fixtures/persistence/yaml_store/entity_pool.sandra+seamstress.yml')
    end

    it 'gives the entity an id if missing' do
      Dir.mktmpdir do |temp|
        class YAMLStoreAddEntity; include Entity; end
        module YAMLStoreAddPool; extend Persistence::YAMLStore::EntityPool; end
        YAMLStoreAddPool.root = temp
        entity = YAMLStoreAddEntity.new
        entity.id.should be nil
        YAMLStoreAddPool[entity.object_id].should be nil
        YAMLStoreAddPool << entity
        entity.id.should == entity.object_id
        YAMLStoreAddPool[entity.object_id].should be entity
      end
    end

  end

  describe '.[]' do

    it 'returns the Entity with the given id' do
      sam   = YAMLStorePerson.new id: :sam
      sybil = YAMLStorePerson.new id: :sybil
      YAMLStorePeople[:sam].should     be sam
      YAMLStorePeople[:sybil].should   be sybil
      YAMLStorePeople[:auditor].should be nil
    end

  end

  describe '.root=' do

    it 'stores the root dir and repoints the pool' do
      module YAMLStoreRootPool; extend Persistence::YAMLStore::EntityPool; end
      class YAMLStoreRootEntity; include Entity; end
      2.times do
        Dir.mktmpdir do |root|
          Pathname("#{root}/Relentity::YAMLStoreRootPool.yml").should_not exist
          YAMLStoreRootPool.root = root
          YAMLStoreRootPool << YAMLStoreRootEntity.new
          Pathname("#{root}/Relentity::YAMLStoreRootPool.yml").should exist
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

end end
