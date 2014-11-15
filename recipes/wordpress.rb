#
# Cookbook Name:: wordpress
# Recipe:: wordpress
#

require 'securerandom'

sites = node[:wordpress][:sites]

sites.each do |site|

  execute "Prepare WordPress #{site[:version]}" do
    cwd "/tmp"
    command <<-EOF
      tar -xvzf wordpress-#{site[:version]}.tar.gz
      mv wordpress wordpress-#{site[:version]}
      mkdir -p #{node[:wordpress][:base_dir]}/#{site[:name]}
      cp -r wordpress-#{site[:version]}/* #{node[:wordpress][:base_dir]}/#{site[:name]}
      EOF
    action :nothing
  end

  remote_file "/tmp/wordpress-#{site[:version]}.tar.gz" do
    source "http://wordpress.org/wordpress-#{site[:version]}.tar.gz"
    backup false
    notifies :run, "execute[Prepare WordPress #{site[:version]}]", :immediately
    not_if { ::File.exists?("/tmp/wordpress-#{site[:version]}.tar.gz") }
  end

  template "#{node[:wordpress][:base_dir]}/#{site[:name]}/wp-config.php" do
    source "wp-config.php.erb"
    mode '0644'
    owner 'root'
    group 'root'
    variables({
      db_name:          site[:db][:name]    || node[:wordpress][:site_defaults][:db][:name],
      db_user:          site[:db][:user]    || node[:wordpress][:site_defaults][:db][:user],
      db_pass:          site[:db][:pass]    || node[:wordpress][:site_defaults][:db][:pass],
      db_host:          site[:db][:host]    || node[:wordpress][:site_defaults][:db][:host],
      db_charset:       site[:db][:charset] || node[:wordpress][:site_defaults][:db][:charset],
      db_collate:       site[:db][:collate] || node[:wordpress][:site_defaults][:db][:collate],
      table_prefix:     site[:table_prefix] || node[:wordpress][:site_defaults][:table_prefix],
      debug:            site[:debug]        || node[:wordpress][:site_defaults][:debug],
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

  file "#{node[:wordpress][:base_dir]}/#{site[:name]}/.htaccess" do
    owner node[:apache][:user]
    group node[:apache][:user]
    mode '0644'
    action :create
  end

  directory "#{node[:wordpress][:base_dir]}/#{site[:name]}/wp-content/uploads" do
    owner node[:apache][:user]
    group node[:apache][:user]
    mode '0755'
    action :create
  end

  directory "#{node[:wordpress][:base_dir]}/#{site[:name]}/wp-content/languages" do
    owner 'root'
    group 'root'
    mode '0755'
    action :create
  end

  if ! site[:lang].nil?

    if site[:version].nil? || site[:version] >= 4.0
      lang_version = 'dev'
    else
      lang_version = "#{site[:version]}.x"
    end

    remote_file "#{node[:wordpress][:base_dir]}/#{site[:name]}/wp-content/languages/#{site[:lang]}.mo" do
      source "https://translate.wordpress.org/projects/wp/#{lang_version}/#{site[:lang]}/default/export-translations?format=mo"
      backup false
      owner "root"
      group "root"
      mode "0644"
      action :create_if_missing
    end

    remote_file "#{node[:wordpress][:base_dir]}/#{site[:name]}/wp-content/languages/admin-#{site[:lang]}.mo" do
      source "https://translate.wordpress.org/projects/wp/#{lang_version}/admin/#{site[:lang]}/default/export-translations?format=mo"
      backup false
      owner "root"
      group "root"
      mode "0644"
      action :create_if_missing
    end

    remote_file "#{node[:wordpress][:base_dir]}/#{site[:name]}/wp-content/languages/admin-network-#{site[:lang]}.mo" do
      source "https://translate.wordpress.org/projects/wp/#{lang_version}/admin/network/#{site[:lang]}/default/export-translations?format=mo"
      backup false
      owner "root"
      group "root"
      mode "0644"
      action :create_if_missing
    end

    if site[:version] >= 3.5
      remote_file "#{node[:wordpress][:base_dir]}/#{site[:name]}/wp-content/languages/twentytwelve-#{site[:lang]}.mo" do
        source "https://translate.wordpress.org/projects/wp/#{lang_version}/twentytwelve/#{site[:lang]}/default/export-translations?format=mo"
        backup false
        owner "root"
        group "root"
        mode "0644"
        action :create_if_missing
      end
    end

    if site[:version] >= 3.6
      remote_file "#{node[:wordpress][:base_dir]}/#{site[:name]}/wp-content/languages/twentythirteen-#{site[:lang]}.mo" do
        source "https://translate.wordpress.org/projects/wp/#{lang_version}/twentythirteen/#{site[:lang]}/default/export-translations?format=mo"
        backup false
        owner "root"
        group "root"
        mode "0644"
        action :create_if_missing
      end
    end

    if site[:version] >= 3.8
      remote_file "#{node[:wordpress][:base_dir]}/#{site[:name]}/wp-content/languages/twentyfourteen-#{site[:lang]}.mo" do
        source "https://translate.wordpress.org/projects/wp/#{lang_version}/twentyfourteen/#{site[:lang]}/default/export-translations?format=mo"
        backup false
        owner "root"
        group "root"
        mode "0644"
        action :create_if_missing
      end
    end

  end

end

