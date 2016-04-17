source 'https://rubygems.org'

puppetversion = ENV.key?('PUPPET_VERSION') ? "= #{ENV['PUPPET_VERSION']}" : ['>= 3.3']
gem 'puppet', puppetversion
gem 'puppet-lint', '>= 0.3.2'
gem 'facter', '>= 1.7.0'

group :test do
  gem 'rspec-core',              :require => false
  gem 'puppetlabs_spec_helper',  :require => false
  gem 'simplecov',               :require => false
  gem 'puppet_facts',            :require => false
  gem 'metadata-json-lint',      :require => false
end

group :development do
  gem 'travis',          :require => false
  gem 'travis-lint',     :require => false
  gem 'guard-rake',      :require => false
  gem 'puppet-strings',  :require => false, :git => 'https://github.com/puppetlabs/puppetlabs-strings.git'
  gem 'redcarpet',       :require => false
end
