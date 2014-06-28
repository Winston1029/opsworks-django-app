#
# Cookbook Name:: build-essential
# Recipe:: rhel
#

pkgs = %w{
  autoconf
  bison
  flex
  gcc
  gcc-c++
  kernel-devel
  make
  m4
}

# ensure GCC 4 is available on older pre-6 EL
if node['platform_version'].to_i < 6
  pkgs.unshift %w{ gcc44 gcc44-c++ }
end

pkgs.flatten.each do |pkg|

  r = package pkg do
    action( node['build_essential']['compiletime'] ? :nothing : :install )
  end
  r.run_action(:install) if node['build_essential']['compiletime']

end
