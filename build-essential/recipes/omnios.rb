#
# Cookbook Name:: build-essential
# Recipe:: omnios
#

%w{
  developer/gcc47
  developer/object-file
  developer/linker
  developer/library/lint
  developer/build/gnu-make
  system/header
  system/library/math/header-math
}.each do |pkg|

  r = package pkg do
    action( node['build_essential']['compiletime'] ? :nothing : :install )
  end
  r.run_action(:install) if node['build_essential']['compiletime']

  # Per OmniOS documentation, the gcc bin dir isn't in the default
  # $PATH, so add it to the running process environment
  # http://omnios.omniti.com/wiki.php/DevEnv
  ENV['PATH'] = "#{ENV['PATH']}:/opt/gcc-4.7.2/bin"
end
