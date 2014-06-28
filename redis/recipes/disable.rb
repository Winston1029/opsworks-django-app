#
# Cookbook Name:: redis
# Recipe:: disable
#

redis = node['redis']

redis['servers'].each do |current_server|
  server_name = current_server["name"] || current_server["port"]
  resource = resources("service[redis#{server_name}]")
  resource.action Array(resource.action)
  resource.action << :stop
  resource.action << :disable
end

