Gem::Specification.new do |spec|
  spec.name           = 'watir-formhandler'
  spec.version        = '2.1.0'
  spec.platform       = Gem::Platform::RUBY

  spec.authors        = ['Yves Komenda']
  spec.email          = ['b_d_v@web.de']
  spec.summary        = 'Watir formhandler'
  spec.description    = 'Adds some convenience methods to fill out forms in Watir'
  spec.homepage       = 'http://rubygems.org/gems/watir-formhandler'
  spec.license        = 'MIT'

  spec.files          = Dir['lib/**/*.rb']
  spec.test_files     = Dir['spec/**/*']
  spec.require_paths  = ['lib']

  spec.add_runtime_dependency 'watir', ['=5.0.0']
  spec.add_runtime_dependency 'watir-webdriver', ['=0.6.10']
end
