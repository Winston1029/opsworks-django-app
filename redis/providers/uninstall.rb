#
# Cookbook Name:: redis
# Provider::uninstall
#

action :run do
    #remove redis binaries
    execute "rm -rf /usr/local/bin/redis*" if ::File.exists?("/usr/local/bin/redis-server")

    #remove configuration file and init script for servers provided
    unless new_resource.servers.nil?
      new_resource.servers.each do |server|
        server_name = server['name'] || server['port'] 
        execute "rm -rf /etc/redis/#{server_name}.conf" if ::File.exists?("/etc/redis/#{server_name}.conf")
        execute "rm -rf /etc/init.d/redis#{server_name}" if ::File.exists?("/etc/init.d/redis#{server_name}")
        execute "rm -rf /etc/init/redis#{server_name}.conf" if ::File.exists?("/etc/init/redis#{server_name}.conf")
      end
    end
end
