#
# Cookbook Name:: redis
# Recipe:: redis_gem
#

gem_package node['redis']['gem']['name'] do
  version node['redis']['gem']['version'] unless node['redis']['gem']['version'].nil?  
  action :install 
end 
