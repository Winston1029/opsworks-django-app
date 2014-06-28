#
# Cookbook Name:: redis
# Recipe:: uninstall
#

redis = node['redis']

redis_uninstall "redis-servers" do
  servers redis['servers']
  action :run
end
