#
# Cookbook Name:: build-essential
# Recipe:: solaris2
#

%w{
  autoconf
  automake
  bison
  coreutils
  flex
  gcc4core
  gcc4g++
  gcc4objc
  gcc3core
  gcc3g++
  ggrep
  gmake
  gtar
  pkgconfig
}.each do |pkg|

  r = pkgutil_package pkg do
    action( node['build_essential']['compiletime'] ? :nothing : :install )
  end
  r.run_action(:install) if node['build_essential']['compiletime']

end
