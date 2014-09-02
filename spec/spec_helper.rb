require 'watir'
require 'watir-webdriver'
require 'selenium-webdriver'
require 'rspec'
require 'watir_formhandler'
require 'pry'

HTML_DIR = File.join(File.dirname(File.expand_path(__FILE__)), 'html')
FORM_PAGE = 'form.html'

def local_url(page)
  File.join('file://', HTML_DIR, page)
end

