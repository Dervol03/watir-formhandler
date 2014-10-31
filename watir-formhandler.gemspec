Gem::Specification.new do |spec|
  spec.name                   = 'watir-formhandler'
  spec.version                = '2.6.1'
  spec.platform               = Gem::Platform::RUBY
  spec.required_ruby_version  = '>=2.0.0'

  spec.authors                = ['Yves Komenda']
  spec.email                  = ['b_d_v@web.de']
  spec.summary                = 'Watir formhandler'
  spec.description            = 'Adds some convenience methods to fill out forms in Watir.'
  spec.homepage               = 'http://github.com/Dervol03/watir-formhandler'
  spec.license                = 'MIT'

  spec.files                  = Dir['lib/**/*.rb']
  spec.test_files             = Dir['spec/**/*']
  spec.require_paths          = ['lib']
  spec.extra_rdoc_files       = ['README.md']

  spec.add_runtime_dependency 'watir', ['=5.0.0']
  spec.add_runtime_dependency 'watir-webdriver', ['=0.6.11']
end
