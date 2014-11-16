#
# Cookbook Name:: wordpress
# Recipe:: apache
#

include_recipe 'apache2'
include_recipe 'apache2::mod_php5'
include_recipe "php"

package "php5-gd" do
  action :install
end

package "php5-mysql" do
  action :install
end

sites = node[:wordpress][:sites]

sites.each do |site|
  web_app site[:name] do
    server_name site[:name]
    docroot "#{node[:wordpress][:base_dir]}/#{site[:name]}"
    allow_override "AuthConfig FileInfo"
    directory_options "FollowSymLinks"
  end
end

