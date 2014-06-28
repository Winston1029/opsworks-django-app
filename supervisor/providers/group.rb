#
# Cookbook Name:: supervisor
# Provider:: group
#

action :enable do
  execute "supervisorctl update" do
    action :nothing
    user "root"
  end

  template "#{node['supervisor']['dir']}/#{new_resource.group_name}.conf" do
    source "group.conf.erb"
    cookbook "supervisor"
    owner "root"
    group "root"
    mode "644"
    variables :prog => new_resource
    notifies :run, resources(:execute => "supervisorctl update"), :immediately
  end
end

action :disable do
  execute "supervisorctl update" do
    action :nothing
    user "root"
  end

  file "#{node['supervisor']['dir']}/#{new_resource.group_name}.conf" do
    action :delete
    notifies :run, resources(:execute => "supervisorctl update"), :immediately
  end
end

action :start do
  execute "supervisorctl start #{new_resource.group_name}" do
    user "root"
  end
end

action :stop do
  execute "supervisorctl stop #{new_resource.group_name}" do
    user "root"
  end
end

action :restart  do
  execute "supervisorctl restart #{new_resource.group_name}" do
    user "root"
  end
end

action :reload  do
  execute "supervisorctl restart #{new_resource.group_name}" do
    user "root"
  end
end
