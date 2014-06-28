#
# Cookbook Name:: build-essential
# Recipe:: default
#

begin
  include_recipe "build-essential::#{node['platform_family']}"
rescue Chef::Exceptions::RecipeNotFound
  Chef::Log.warn "A build-essential recipe does not exist for the platform_family: #{node['platform_family']}"
end
