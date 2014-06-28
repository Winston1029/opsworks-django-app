#
# Cookbook Name:: redis
# Recipe:: default
#

case node.platform
when 'debian','ubuntu'
  %w[tar build-essential].each do |pkg|
    package pkg do
      action :install
    end
  end
when 'redhat','centos','fedora','scientific','suse','amazon'
  %w[tar make automake gcc].each do |pkg|
    package pkg do
      action :install
      end
  end
end

