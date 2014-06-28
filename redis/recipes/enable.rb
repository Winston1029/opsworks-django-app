#
# Cookbook Name:: redis
# Recipe:: enable
#

redis = node['redis']

redis['servers'].each do |current_server|
  server_name = current_server["name"] || current_server["port"]
  resource = resources("service[redis#{server_name}]")
  resource.action Array(resource.action)
  resource.action << :start
  resource.action << :enable
end

