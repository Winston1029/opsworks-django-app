#
# Cookbook Name:: build-essential
# Recipe:: mac_os_x
#


result = Mixlib::ShellOut.new("pkgutil --pkgs").run_command
osx_gcc_installer_installed = result.stdout.split("\n").include?("com.apple.pkg.gcc4.2Leo")
developer_tools_cli_installed = result.stdout.split("\n").include?("com.apple.pkg.DeveloperToolsCLI")
pkg_filename = ::File.basename(node['build_essential']['osx']['gcc_installer_url'])
pkg_path = "#{Chef::Config[:file_cache_path]}/#{pkg_filename}"

r = remote_file pkg_path do
  source node['build_essential']['osx']['gcc_installer_url']
  checksum node['build_essential']['osx']['gcc_installer_checksum']
  action( node['build_essential']['compiletime'] ? :nothing : :create )
  not_if { osx_gcc_installer_installed or developer_tools_cli_installed  }
end
r.run_action(:create) if node['build_essential']['compiletime']

r = execute "sudo installer -pkg \"#{pkg_path}\" -target /" do
  action( node['build_essential']['compiletime'] ? :nothing : :run )
  not_if { osx_gcc_installer_installed or developer_tools_cli_installed  }
end
r.run_action(:run) if node['build_essential']['compiletime']
