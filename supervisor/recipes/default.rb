#
# Cookbook Name:: supervisor
# Recipe:: default
#

include_recipe "python"

python_pip "supervisor" do
  action :upgrade
  version node['supervisor']['version'] if node['supervisor']['version']
end

directory node['supervisor']['dir'] do
  owner "root"
  group "root"
  mode "755"
end

template "/etc/supervisord.conf" do
  source "supervisord.conf.erb"
  owner "root"
  group "root"
  mode "644"
  variables({
    :inet_port => node['supervisor']['inet_port'],
    :inet_username => node['supervisor']['inet_username'],
    :inet_password => node['supervisor']['inet_password'],
    :supervisord_minfds => node['supervisor']['minfds'],
    :supervisord_minprocs => node['supervisor']['minprocs'],
    :supervisor_version => node['supervisor']['version'],
  })
end

directory node['supervisor']['log_dir'] do
  owner "root"
  group "root"
  mode "755"
  recursive true
end

case node['platform']
when "debian", "ubuntu"
  template "/etc/init.d/supervisor" do
    source "supervisor.init.erb"
    owner "root"
    group "root"
    mode "755"
  end

  template "/etc/default/supervisor" do
    source "supervisor.default.erb"
    owner "root"
    group "root"
    mode "644"
  end

  service "supervisor" do
    action [:enable, :start]
  end
end
