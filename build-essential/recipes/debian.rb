#
# Cookbook Name:: build-essential
# Recipe:: debian
#

# on apt-based platforms when first provisioning we need to force
# apt-get update at compiletime if we are going to try to install at compiletime
execute "apt-get-update-build-essentials" do
  command "apt-get update"
  action :nothing
  # tip: to suppress this running every time, just use the apt cookbook
  not_if do
    ::File.exists?('/var/lib/apt/periodic/update-success-stamp') &&
    ::File.mtime('/var/lib/apt/periodic/update-success-stamp') > Time.now - 86400*2
  end
end.run_action(:run) if node['build_essential']['compiletime']

%w{
  autoconf
  binutils-doc
  bison
  build-essential
  flex
}.each do |pkg|

  r = package pkg do
    action( node['build_essential']['compiletime'] ? :nothing : :install )
  end
  r.run_action(:install) if node['build_essential']['compiletime']

end
