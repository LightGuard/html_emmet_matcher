# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'html_emmet_matcher/version'

Gem::Specification.new do |gem|
  gem.name          = "html_emmet_matcher"
  gem.version       = HtmlEmmetMatcher::VERSION
  gem.authors       = ["LightGuard"]
  gem.email         = ["lightguard.jp@gmail.com"]
  gem.description   = %q{rspec matcher to match html with an emmet string}
  gem.summary       = %q{rspec matcher which matches html to an emmet string}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency('rspec', '>= 2.13.0')
  gem.add_dependency('nokogiri', '>= 1.5.9')
end
