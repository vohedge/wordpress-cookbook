require 'spec_helper'

describe process('mysqld') do
  it { should be_running }
end

# Check database user can login
describe command("mysql -u wordpress1 -pwordpress1 -e 'show databases;'") do
  its(:exit_status) { should eq 0 }
end

# Check redmine database exists
describe command("mysql -u wordpress1 -pwordpress1 -e \"show databases like 'wordpress1';\"") do
  its(:exit_status) { should eq 0 }
end

# Check database user can login
describe command("mysql -u wordpress2 -pwordpress2 -e 'show databases;'") do
  its(:exit_status) { should eq 0 }
end

# Check redmine database exists
describe command("mysql -u wordpress2 -pwordpress2 -e \"show databases like 'wordpress2';\"") do
  its(:exit_status) { should eq 0 }
end

