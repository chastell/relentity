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
    YAMLStorePeople.root = Dir.mktmpdir
  end

  after do
    FileUtils.rmtree YAMLStorePeople.root
  end

  describe '.<<' do

    it 'saves the passed entity to the YAMLStore, creating it if necessary' do
      refute Pathname("#{YAMLStorePeople.root}/Relentity::YAMLStorePeople.yml").exist?
      YAMLStorePerson.new id: :sandra, given_names: ['Sandra'], surname: 'Battye'
      assert Pathname("#{YAMLStorePeople.root}/Relentity::YAMLStorePeople.yml").exist?
      File.read("#{YAMLStorePeople.root}/Relentity::YAMLStorePeople.yml").must_equal File.read('spec/fixtures/persistence/yaml_store/entity_pool.sandra.yml')
    end

    it 'saves the updated entity to the YAMLStore' do
      sandra = YAMLStorePerson.new id: :sandra, given_names: ['Sandra'], surname: 'Battye'
      File.read("#{YAMLStorePeople.root}/Relentity::YAMLStorePeople.yml").must_equal File.read('spec/fixtures/persistence/yaml_store/entity_pool.sandra.yml')
      sandra.occupation = 'seamstress'
      File.read("#{YAMLStorePeople.root}/Relentity::YAMLStorePeople.yml").must_equal File.read('spec/fixtures/persistence/yaml_store/entity_pool.sandra+seamstress.yml')
    end

    it 'gives the entity an id if missing' do
      Dir.mktmpdir do |tempdir|
        entity_class = Class.new { include Entity }
        pool = Module.new { extend Persistence::YAMLStore::EntityPool }
        pool.root = tempdir
        entity = entity_class.new
        entity.id.must_be_nil
        pool[entity.object_id].must_be_nil
        pool << entity
        entity.id.must_equal entity.object_id
        pool[entity.object_id].must_be_same_as entity
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

  describe '.root' do

    it 'returns the root of the store' do
      pool = Module.new { extend Persistence::YAMLStore::EntityPool }
      pool.root.must_be_nil
      2.times do
        Dir.mktmpdir do |tempdir|
          pool.root = tempdir
          pool.root.must_equal tempdir
        end
      end
    end

  end

  describe '.root=' do

    it 'stores the root dir and repoints the pool' do
      entity_class = Class.new { include Entity }
      pool = Module.new { extend Persistence::YAMLStore::EntityPool }
      2.times do
        Dir.mktmpdir do |tempdir|
          refute Pathname("#{tempdir}/.yml").exist?
          pool.root = tempdir
          pool << entity_class.new
          assert Pathname("#{tempdir}/.yml").exist?
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
