#
# Cookbook Name:: wordpress
# Recipe:: wordpress
#

require 'securerandom'

# Set WP major version ex) 3.6
wp_default_major_version = node[:wordpress][:site_defaults][:version].to_s
wp_default_major_version = wp_default_major_version.gsub(/\.[0-9]+?$/, '') if wp_default_major_version.count('.') >= 2

# Setup WordPress for each site
node[:wordpress][:sites].each do |site|

  # Set defaults
  site_name         = site[:name]         || node[:wordpress][:site_defaults][:name]
  site_version      = site[:version]      || node[:wordpress][:site_defaults][:version]
  site_lang         = site[:lang]         || node[:wordpress][:site_defaults][:lang]
  site_db_name      = site[:db][:name]    || node[:wordpress][:site_defaults][:db][:name]
  site_db_user      = site[:db][:user]    || node[:wordpress][:site_defaults][:db][:user]
  site_db_pass      = site[:db][:pass]    || node[:wordpress][:site_defaults][:db][:pass]
  site_db_host      = site[:db][:host]    || node[:wordpress][:site_defaults][:db][:host]
  site_db_charset   = site[:db][:charset] || node[:wordpress][:site_defaults][:db][:charset]
  site_db_collate   = site[:db][:collate] || node[:wordpress][:site_defaults][:db][:collate]
  site_table_prefix = site[:table_prefix] || node[:wordpress][:site_defaults][:table_prefix]
  site_debug        = site[:debug]        || node[:wordpress][:site_defaults][:debug]

  execute "Extract WordPress #{site_version} tarball" do
    cwd "/tmp"
    command <<-EOF
      tar -xvzf wordpress-#{site_version}.tar.gz
      mv wordpress wordpress-#{site_version}
      EOF
    action :nothing
    not_if { ::File.exists?("/tmp/wordpress-#{site_version}") }
  end

  execute "Copy WordPress #{site_version} for #{site_name}" do
    cwd "/tmp"
    command <<-EOF
      mkdir -p #{node[:wordpress][:base_dir]}/#{site_name}
      cp -r wordpress-#{site_version}/* #{node[:wordpress][:base_dir]}/#{site_name}
      EOF
    action :nothing
    not_if { ::File.exists?("#{node[:wordpress][:base_dir]}/#{site_name}") }
  end

  remote_file "/tmp/wordpress-#{site_version}.tar.gz" do
    source "http://wordpress.org/wordpress-#{site_version}.tar.gz"
    backup false
    notifies :run, "execute[Extract WordPress #{site_version} tarball]", :immediately
    notifies :run, "execute[Copy WordPress #{site_version} for #{site_name}]", :immediately
    not_if { ::File.exists?("/tmp/wordpress-#{site_version}.tar.gz") }
  end

  template "#{node[:wordpress][:base_dir]}/#{site_name}/wp-config.php" do
    source "wp-config.php.erb"
    mode '0644'
    owner 'root'
    group 'root'
    variables({
      db_name:          site_db_name,
      db_user:          site_db_user,
      db_pass:          site_db_pass,
      db_host:          site_db_host,
      db_charset:       site_db_charset,
      db_collate:       site_db_collate,
      table_prefix:     site_table_prefix,
      debug:            site_debug,
      auth_key:         SecureRandom.hex,
      secure_auth_key:  SecureRandom.hex,
      logged_in_key:    SecureRandom.hex,
      nonce_key:        SecureRandom.hex,
      auth_salt:        SecureRandom.hex,
      secure_auth_salt: SecureRandom.hex,
      logged_in_salt:   SecureRandom.hex,
      nonce_salt:       SecureRandom.hex
    })
  end

  file "#{node[:wordpress][:base_dir]}/#{site_name}/.htaccess" do
    owner node[:apache][:user]
    group node[:apache][:user]
    mode '0644'
    action :create
  end

  directory "#{node[:wordpress][:base_dir]}/#{site_name}/wp-content/uploads" do
    owner node[:apache][:user]
    group node[:apache][:user]
    mode '0755'
    action :create
  end

  directory "#{node[:wordpress][:base_dir]}/#{site_name}/wp-content/languages" do
    owner 'root'
    group 'root'
    mode '0755'
    action :create
  end

  if ! site_lang.nil?

    wp_major_version = site_version.to_s
    wp_major_version = wp_major_version.gsub(/\.[0-9]+?$/, '') if wp_major_version.count('.') >= 2

    lang_version = "#{wp_major_version}.x"
    lang_version = 'dev' if wp_major_version.to_f >= wp_default_major_version.to_f

    remote_file "#{node[:wordpress][:base_dir]}/#{site_name}/wp-content/languages/#{site_lang}.mo" do
      source "https://translate.wordpress.org/projects/wp/#{lang_version}/#{site_lang}/default/export-translations?format=mo"
      backup false
      owner "root"
      group "root"
      mode "0644"
      action :create_if_missing
    end

    remote_file "#{node[:wordpress][:base_dir]}/#{site_name}/wp-content/languages/admin-#{site_lang}.mo" do
      source "https://translate.wordpress.org/projects/wp/#{lang_version}/admin/#{site_lang}/default/export-translations?format=mo"
      backup false
      owner "root"
      group "root"
      mode "0644"
      action :create_if_missing
    end

    remote_file "#{node[:wordpress][:base_dir]}/#{site_name}/wp-content/languages/admin-network-#{site_lang}.mo" do
      source "https://translate.wordpress.org/projects/wp/#{lang_version}/admin/network/#{site_lang}/default/export-translations?format=mo"
      backup false
      owner "root"
      group "root"
      mode "0644"
      action :create_if_missing
    end

    if wp_major_version.to_f >= 3.5
      remote_file "#{node[:wordpress][:base_dir]}/#{site_name}/wp-content/languages/twentytwelve-#{site_lang}.mo" do
        source "https://translate.wordpress.org/projects/wp/#{lang_version}/twentytwelve/#{site_lang}/default/export-translations?format=mo"
        backup false
        owner "root"
        group "root"
        mode "0644"
        action :create_if_missing
      end
    end

    if wp_major_version.to_f >= 3.6
      remote_file "#{node[:wordpress][:base_dir]}/#{site_name}/wp-content/languages/twentythirteen-#{site_lang}.mo" do
        source "https://translate.wordpress.org/projects/wp/#{lang_version}/twentythirteen/#{site_lang}/default/export-translations?format=mo"
        backup false
        owner "root"
        group "root"
        mode "0644"
        action :create_if_missing
      end
    end

    if wp_major_version.to_f >= 3.8
      remote_file "#{node[:wordpress][:base_dir]}/#{site_name}/wp-content/languages/twentyfourteen-#{site_lang}.mo" do
        source "https://translate.wordpress.org/projects/wp/#{lang_version}/twentyfourteen/#{site_lang}/default/export-translations?format=mo"
        backup false
        owner "root"
        group "root"
        mode "0644"
        action :create_if_missing
      end
    end

  end

end

