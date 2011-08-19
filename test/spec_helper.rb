require 'minitest/autorun'

require_relative '../lib/relentity'

Relentity::EntityPool = Relentity::Persistence::NoThanks::EntityPool
