require "spec_helper"

RSpec.describe PostgramRaidexes do
  let(:dumped_schema_lines) { test_app_schema_lines }
  let(:users_email_trigram_index_dump) do
    %q|add_index "users", ["email"], name: "index_users_on_email_trigram", using: :gin, opclasses: {"email"=>"gin_trgm_ops"}|
  end
  let(:users_last_name_trigram_index_dump) do
    %q|add_index "users", ["last_name"], name: "index_users_on_last_name_trigram", using: :gin, opclasses: {"last_name"=>"gin_trgm_ops"}|
  end

  it "dumps trigram indexes" do
    expect(dumped_schema_lines).to include_line(users_email_trigram_index_dump)
    expect(dumped_schema_lines).to include_line(users_last_name_trigram_index_dump)
  end

  def test_app_schema_lines
    delete_old_schema_file
    setup_test_database
    migrate
    File.readlines("spec/support/test_app/db/schema.rb")
  end

  def delete_old_schema_file
    test_schema_path = "spec/support/test_app/db/schema.rb"
    File.delete(test_schema_path) if File.exist?(test_schema_path)
  end

  def setup_test_database
    `cd spec/support/test_app && bundle exec rake db:drop db:create`
  end

  def migrate
    `cd spec/support/test_app && bundle exec rake db:migrate`
  end

  RSpec::Matchers.define :include_line do |expected_line|
    match do |lines|
      lines.any? do |actual_line|
        actual_line.include?(expected_line)
      end
    end
  end
end
