#
# Cookbook Name:: wordpress
# Recipe:: test-user
#
# ** WARNING **
# THIS RECIPE FOR TESTS!
# /test/integration/default/serverspec
#

group "wordpress" do
  gid 503
  action :create
end

user "wordpress" do
  supports :manage_home => true
  comment "WordPress directories and files owner in integration tests."
  uid 503
  gid "wordpress"
  home "/home/wordpress"
  shell "/bin/bash"
  password "$1$JJsvHslV$szsCjVEroftprNn4JHtDi."
end

