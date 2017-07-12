source "https://rubygems.org"

gem "kubeclient"

group :test do
  gem "rake", "~> 10.0"
  gem "puppet", ENV['PUPPET_GEM_VERSION'] || '~> 4'
  gem "puppet-lint"
  gem "puppet-lint-unquoted_string-check"
  gem "rspec-puppet"
  gem "puppet-syntax"
  gem "puppetlabs_spec_helper"
  gem "metadata-json-lint"
  gem "rspec"
  gem "CFPropertyList"
end

group :development do
  gem "travis"
  gem "travis-lint"
  gem "puppet-blacksmith"
  gem "guard-rake"
  gem "pry"
  gem "yard"
end
