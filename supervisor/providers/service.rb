#
# Cookbook Name:: supervisor
# Provider:: service
#

action :enable do
  execute "supervisorctl update" do
    action :nothing
    user "root"
  end

  template "#{node['supervisor']['dir']}/#{new_resource.service_name}.conf" do
    source "program.conf.erb"
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

  file "#{node['supervisor']['dir']}/#{new_resource.service_name}.conf" do
    action :delete
    notifies :run, resources(:execute => "supervisorctl update"), :immediately
  end
end

action :start do
  execute "supervisorctl start #{cmd_line_args}" do
    user "root"
  end
end

action :stop do
  execute "supervisorctl stop #{cmd_line_args}" do
    user "root"
  end
end

action :restart  do
  execute "supervisorctl restart #{cmd_line_args}" do
    user "root"
  end
end

action :reload  do
  execute "supervisorctl restart #{cmd_line_args}" do
    user "root"
  end
end

def cmd_line_args
  name = new_resource.service_name
  if new_resource.numprocs > 1
    name += ':*'
  end
  name
end
