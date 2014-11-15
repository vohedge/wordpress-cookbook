#
# Cookbook Name:: wordpress
# Recipe:: default
#

include_recipe "wordpress::apache"
include_recipe "wordpress::mysql"
include_recipe "wordpress::wordpress"

