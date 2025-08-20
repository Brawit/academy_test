require "simplecov"
SimpleCov.start "rails" do
  add_filter "/bin/"
  add_filter "/db/"
  add_filter "/test/"
end

ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "active_record/test_fixtures"

class ActiveSupport::TestCase
  include ActiveRecord::TestFixtures   # ✅ ต้อง include
  fixtures :all                        # ✅ โหลด fixtures ทั้งหมด

  parallelize(workers: :number_of_processors)
end
