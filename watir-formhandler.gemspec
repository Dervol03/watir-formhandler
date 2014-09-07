Gem::Specification.new do |spec|
  spec.name           = 'watir-formhandler'
  spec.version        = '0.0.1'
  spec.platform       = Gem::Platform::RUBY

  spec.authors        = ['Yves Komenda']
  spec.email          = ['b_d_v@web.de']
  spec.summary        = 'Adds some generic form handling to watir'
  spec.description    = 'TODO'
  spec.homepage       = 'http://rubygems.org/gems/watir-formhandler'
  spec.license        = 'MIT'

  spec.files          = Dir['lib/**/*.rb']
  spec.test_files     = Dir['spec/**/*']
  spec.require_paths  = ['lib']

  spec.add_runtime_dependency 'watir', ['=5.0.0']
  spec.add_runtime_dependency 'watir-webdriver', ['=0.6.10']
  spec.add_runtime_dependency 'selenium-webdriver', ['2.42.0']
end
