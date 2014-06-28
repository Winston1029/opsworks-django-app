#
# Cookbook Name:: build-essential
# Recipe:: smartos
#

%w{
  build-essential
}.each do |pkg|

  r = package pkg do
    action( node['build_essential']['compiletime'] ? :nothing : :install )
  end
  r.run_action(:install) if node['build_essential']['compiletime']

end
