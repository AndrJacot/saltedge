# Chef InSpec test for recipe saltedge_test::default

# The Chef InSpec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec/resources/

# This test check if user exist.
describe user('aj') do
  it { should exist }
end

# This test check if port 8080 if listening by application.
describe port(8989) do
  it { should be_listening }
end
# This test check if errbit service is enabled
describe service('errbitaj') do
  it { should be_enabled }
end

# This test check if errbit service is running
describe service('errbitaj') do
  it { should be_running }
end