#
# Cookbook Name:: wordpress
# Recipe:: mysql
#

include_recipe 'mysql::server'
include_recipe 'mysql::client'
include_recipe 'database::mysql'

sites = node[:wordpress][:sites]

sites.each do |site|

  connection_info = {
    host:     site[:db][:hostname] || 'localhost',
    username: 'root',
    password: node[:mysql][:server_root_password]
  }

  mysql_database_user site[:db][:user] do
    connection connection_info
    password   site[:db][:pass]
    action     :create
  end

  mysql_database site[:db][:name] do
    connection connection_info
    owner    site[:db][:user]
    encoding 'utf8'
    action   :create
  end

  mysql_database_user site[:db][:user] do
    connection    connection_info
    database_name site[:db][:name]
    host          '%'
    privileges    [:all]
    action        :grant
  end

end

