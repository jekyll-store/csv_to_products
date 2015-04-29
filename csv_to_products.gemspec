# coding: utf-8
version = File.read(File.expand_path('../VERSION', __FILE__)).strip

Gem::Specification.new do |s|
  s.name         = 'csv_to_products'
  s.version      = version
  s.author       = 'Max White'
  s.email        = 'mushishi78@gmail.com'
  s.homepage     = 'https://github.com/jekyll-store/csv_to_products'
  s.summary      = 'Jekyll-Store cmdline tool to translate CSV file to products.'
  s.license      = 'MIT'
  s.files        = Dir['LICENSE.txt', 'README.md', 'lib/**/*']
  s.require_path = 'lib'
  s.executables  << 'csv_to_products'

  s.add_development_dependency 'rspec', '~> 3'
end
