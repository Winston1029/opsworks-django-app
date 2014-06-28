#
# Cookbook Name:: redis
# Recipe:: install
#
include_recipe 'redis::default'
include_recipe 'ulimit::default'

redis = node['redis']
location = "#{redis['mirror']}/#{redis['base_name']}#{redis['version']}.#{redis['artifact_type']}"

redis_instances = redis['servers']
if redis_instances.nil?
  redis_instances = [{'port' => '6379'}]
end

redis_install "redis-servers" do
  version redis['version']
  download_url location
  default_settings redis['default_settings']
  servers redis_instances
  safe_install redis['safe_install']
  base_piddir redis['base_piddir']
  install_dir redis['install_dir']
end

# Create a service resource for each redis instance, named for the port it runs on.
redis_instances.each do |current_server|
  server_name = current_server['name'] || current_server['port']
  job_control = current_server['job_control'] || redis['default_settings']['job_control'] 

  if job_control == 'initd'
  	service "redis#{server_name}" do
      start_command "/etc/init.d/redis#{server_name} start"
      stop_command "/etc/init.d/redis#{server_name} stop"
      status_command "pgrep -lf 'redis.*#{server_name}' | grep -v 'sh'"
      restart_command "/etc/init.d/redis#{server_name} stop && /etc/init.d/redis#{server_name} start"
      supports :start => true, :stop => true, :restart => true, :status => false
  	end
  elsif job_control == 'upstart'
  	service "redis#{server_name}" do
	  provider Chef::Provider::Service::Upstart
      start_command "start redis#{server_name}"
      stop_command "stop redis#{server_name}"
      status_command "pgrep -lf 'redis.*#{server_name}' | grep -v 'sh'"
      restart_command "restart redis#{server_name}"
      supports :start => true, :stop => true, :restart => true, :status => false
  	end
  else
    Chef::Log.error("Unknown job control type, no service resource created!")
  end

end

node.set['redis']['servers'] = redis_instances 

