require 'spec_helper'

# wp1.example.com

describe file('/var/www/wp1.example.com/.htaccess') do
  it { should be_file }
  it { should be_mode 600 }
  it { should be_owned_by 'www-data' }
end 

describe file('/var/www/wp1.example.com/wp-config.php') do
  it { should be_file }
  it { should be_mode 404 }
  it { should be_owned_by 'wordpress' }
  its(:content) { should match /define\('DB_USER', 'wordpress1'\);/ }
  its(:content) { should match /define\('DB_PASSWORD', 'wordpress1'\);/ }
  its(:content) { should match /define\('DB_HOST', 'localhost'\);/ }
  its(:content) { should match /define\('DB_CHARSET', 'utf8'\);/ }
  its(:content) { should match /define\('DB_COLLATE', ''\);/ }
  its(:content) { should match /\$table_prefix  = 'wp_';/ }
  its(:content) { should match /define\('WP_DEBUG', false\);/ }
end

describe file('/var/www/wp1.example.com/wp-content/languages/ja.mo') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'wordpress' }
end 

describe file('/var/www/wp1.example.com/wp-content/languages/admin-ja.mo') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'wordpress' }
end 

describe file('/var/www/wp1.example.com/wp-content/languages/admin-network-ja.mo') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'wordpress' }
end 

describe file('/var/www/wp1.example.com/wp-content/uploads') do
  it { should be_directory }
  it { should be_mode 755 }
  it { should be_owned_by 'www-data' }
end 

# wp2.example.com

describe file('/var/www/wp2.example.com/.htaccess') do
  it { should be_file }
  it { should be_mode 600 }
  it { should be_owned_by 'www-data' }
end 

describe file('/var/www/wp2.example.com/wp-config.php') do
  it { should be_file }
  it { should be_mode 404 }
  it { should be_owned_by 'wordpress' }
  its(:content) { should match /define\('DB_USER', 'wordpress2'\);/ }
  its(:content) { should match /define\('DB_PASSWORD', 'wordpress2'\);/ }
  its(:content) { should match /define\('DB_HOST', 'localhost'\);/ }
  its(:content) { should match /define\('DB_CHARSET', 'utf8'\);/ }
  its(:content) { should match /define\('DB_COLLATE', ''\);/ }
  its(:content) { should match /\$table_prefix  = 'wp_';/ }
  its(:content) { should match /define\('WP_DEBUG', false\);/ }
end

describe file('/var/www/wp2.example.com/wp-content/languages/ja.mo') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'wordpress' }
end 

describe file('/var/www/wp2.example.com/wp-content/languages/admin-ja.mo') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'wordpress' }
end 

describe file('/var/www/wp2.example.com/wp-content/languages/admin-network-ja.mo') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'wordpress' }
end 

describe file('/var/www/wp2.example.com/wp-content/uploads') do
  it { should be_directory }
  it { should be_mode 755 }
  it { should be_owned_by 'www-data' }
end 
