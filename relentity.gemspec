Gem::Specification.new do |gem|
  gem.name     = 'relentity'
  gem.version  = '0.0.0'
  gem.summary  = 'relentity: a persistence-agnostic object relationship framework'
  gem.homepage = 'http://github.com/chastell/relentity'
  gem.author   = 'Piotr Szotkowski'
  gem.email    = 'chastell@chastell.net'

  gem.files      = `git ls-files -z`.split "\0"
  gem.test_files = `git ls-files -z -- spec/*`.split "\0"

  gem.add_development_dependency 'minitest', '>= 2.3'
end
