#
# Cookbook Name:: gunicorn
# Recipe:: default
#

include_recipe 'python'

unless node["gunicorn"]["virtualenv"].nil?
  python_virtualenv node["gunicorn"]["virtualenv"] do
    action :create
  end
end

python_pip "gunicorn" do
  virtualenv node["gunicorn"]["virtualenv"] unless node["gunicorn"]["virtualenv"].nil?
  action :install
end
