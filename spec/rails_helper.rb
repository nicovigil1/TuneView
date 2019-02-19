require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'

OmniAuth.config.test_mode = true

SimpleCov.start 'rails' do
  add_filter "app/channels/application_cable/channel.rb"
  add_filter "app/channels/application_cable/connection.rb"
  add_filter "app/jobs/application_job.rb"
  add_filter "app/mailers/application_mailer.rb"
  add_filter "app/helpers/application_helper.rb"
end

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!

end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

def stub_login(user)
  allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
end

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.filter_sensitive_data('<SPOTIFY_CLIENT_ID>') { ENV["SPOTIFY_CLIENT_ID"] }
  c.filter_sensitive_data('<SPOTIFY_CLIENT_SECRET>') { ENV["SPOTIFY_CLIENT_SECRET"] }
  c.filter_sensitive_data('<SPOTIFY_TEST_TOKEN>') { ENV["S_TEST_TOKEN"] }
  c.filter_sensitive_data('<SPOTIFY_REQUEST_TOKEN>') { ENV["REQUEST_TOKEN"] }
end
