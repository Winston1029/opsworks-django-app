#
# Cookbook Name:: redis
# Provider::service
#

action :start do
  Chef::Log.warn("The redis_service resource is deprecated!  Please use the redis<port> resource instead!")
  case node.platform
  when 'ubuntu','debian','centos','redhat','fedora', 'amazon'
    if ::File.exists?("/etc/init.d/redis#{new_resource.server_port}")
      execute "/etc/init.d/redis#{new_resource.server_port} start"
    else
      Chef::Log.warn("Cannot start service, init script not found")
    end
  end
end

action :stop do
  Chef::Log.warn("The redis_service resource is deprecated!  Please use the redis<port> resource instead!")
  case node.platform
  when 'ubuntu','debian','centos','redhat','fedora', 'amazon'
    if ::File.exists?("/etc/init.d/redis#{new_resource.server_port}")
      execute "/etc/init.d/redis#{new_resource.server_port} stop"
    else
      Chef::Log.warn("Cannot stop service, init script not found")
    end
  end
end

action :restart do
  Chef::Log.warn("The redis_service resource is deprecated!  Please use the redis<port> resource instead!")
  case node.platform
  when 'ubuntu','debian','centos','redhat','fedora', 'amazon'
    if ::File.exists?("/etc/init.d/redis#{new_resource.server_port}")
      execute "/etc/init.d/redis#{new_resource.server_port} stop && /etc/init.d/redis#{new_resource.server_port} start"
    else
      Chef::Log.warn("Cannot restart service, init script does not exist")
    end
  end
end

action :enable do
  Chef::Log.warn("The redis_service resource is deprecated!  Please use the redis<port> resource instead!")
  case node.platform
  when 'ubuntu','debian'
    if ::File.exists?("/etc/init.d/redis#{new_resource.server_port}")
      execute "update-rc.d redis#{new_resource.server_port} start 91 2 3 4 5 . stop 91 0 1 6 ."
    else
      Chef::Log.warn("Cannot enable service, init script does not exist")
    end
  when 'redhat','centos','fedora','scientific','amazon','suse'
    if ::File.exists?("/etc/init.d/redis#{new_resource.server_port}")
      execute "chkconfig --add redis#{new_resource.server_port} && chkconfig --level 2345 redis#{new_resource.server_port} on"
    else
      Chef::Log.warn("Cannot enable service, init script does not exist")
    end
  end
end

action :disable do
  Chef::Log.warn("The redis_service resource is deprecated!  Please use the redis<port> resource instead!")
  case node.platform
  when 'ubuntu','debian'
    if ::File.exists?("/etc/init.d/redis#{new_resource.server_port}")
      execute "update-rc.d -f redis#{new_resource.server_port} remove"
    else
      Chef::Log.warn("Cannot disable service, init script does not exist")
    end

  when 'redhat','centos','fedora','scientific','amazon','suse'
    if ::File.exists?("/etc/init.d/redis#{new_resource.server_port}")
      execute "chkconfig --level 2345 redis#{new_resource.server_port} off && chkconfig --del redis#{new_resource.server_port}"
    else
      Chef::Log.warn("Cannot disable service, init script does not exist")
    end
  end

end
