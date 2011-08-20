require_relative '../../../spec_helper'

module Relentity describe Persistence::YAMLStore::EntityPool do

  module YAMLStorePeople
    extend Persistence::YAMLStore::EntityPool
  end

  class YAMLStorePerson
    include Entity
    entity_pool YAMLStorePeople
  end

  before do
    @root = Dir.mktmpdir
    YAMLStorePeople.root = @root
  end

  after do
    FileUtils.rmtree @root
  end

  describe '.<<' do

    it 'saves the passed entity to the YAMLStore, creating it if necessary' do
      refute Pathname("#{@root}/Relentity::YAMLStorePeople.yml").exist?
      YAMLStorePerson.new id: :sandra, given_names: ['Sandra'], surname: 'Battye'
      assert Pathname("#{@root}/Relentity::YAMLStorePeople.yml").exist?
      File.read("#{@root}/Relentity::YAMLStorePeople.yml").must_equal File.read('spec/fixtures/persistence/yaml_store/entity_pool.sandra.yml')
    end

    it 'saves the updated entity to the YAMLStore' do
      sandra = YAMLStorePerson.new id: :sandra, given_names: ['Sandra'], surname: 'Battye'
      File.read("#{@root}/Relentity::YAMLStorePeople.yml").must_equal File.read('spec/fixtures/persistence/yaml_store/entity_pool.sandra.yml')
      sandra.occupation = 'seamstress'
      File.read("#{@root}/Relentity::YAMLStorePeople.yml").must_equal File.read('spec/fixtures/persistence/yaml_store/entity_pool.sandra+seamstress.yml')
    end

    it 'gives the entity an id if missing' do
      Dir.mktmpdir do |temp|
        class YAMLStoreAddEntity; include Entity; end
        module YAMLStoreAddPool; extend Persistence::YAMLStore::EntityPool; end
        YAMLStoreAddPool.root = temp
        entity = YAMLStoreAddEntity.new
        entity.id.must_be_nil
        YAMLStoreAddPool[entity.object_id].must_be_nil
        YAMLStoreAddPool << entity
        entity.id.must_equal entity.object_id
        YAMLStoreAddPool[entity.object_id].must_be_same_as entity
      end
    end

  end

  describe '.[]' do

    it 'returns the Entity with the given id' do
      sam   = YAMLStorePerson.new id: :sam
      sybil = YAMLStorePerson.new id: :sybil
      YAMLStorePeople[:sam].must_be_same_as sam
      YAMLStorePeople[:sybil].must_be_same_as sybil
      YAMLStorePeople[:auditor].must_be_nil
    end

  end

  describe '.root=' do

    it 'stores the root dir and repoints the pool' do
      module YAMLStoreRootPool; extend Persistence::YAMLStore::EntityPool; end
      class YAMLStoreRootEntity; include Entity; end
      2.times do
        Dir.mktmpdir do |root|
          refute Pathname("#{root}/Relentity::YAMLStoreRootPool.yml").exist?
          YAMLStoreRootPool.root = root
          YAMLStoreRootPool << YAMLStoreRootEntity.new
          assert Pathname("#{root}/Relentity::YAMLStoreRootPool.yml").exist?
        end
      end
    end

  end

  describe '.select' do

    it 'returns Entities fulfilling the given block' do
      sam   = YAMLStorePerson.new id: :sam, given_names: ['Samuel'], surname: 'Vimes'
      sybil = YAMLStorePerson.new id: :sybil, given_names: ['Sybil', 'Deirdre', 'Olgivanna'], surname: 'Vimes'
      YAMLStorePeople.select { |p| p.surname == 'Vimes' }.must_include sam
      YAMLStorePeople.select { |p| p.surname == 'Vimes' }.must_include sybil
      YAMLStorePeople.select { |p| p.given_names.include? 'Deirdre' }.must_equal [sybil]
    end

  end

end end
