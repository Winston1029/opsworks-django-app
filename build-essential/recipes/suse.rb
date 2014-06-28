#
# Cookbook Name:: build-essential
# Recipe:: suse
#

%w{
  autoconf
  bison
  flex
  gcc
  gcc-c++
  kernel-default-devel
  make
  m4
}.each do |pkg|

  r = package pkg do
    action( node['build_essential']['compiletime'] ? :nothing : :install )
  end
  r.run_action(:install) if node['build_essential']['compiletime']

end
