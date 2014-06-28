#
# Cookbook Name:: redis
# Resource::install
#
actions :run

#Uncomment this and remove the block in initialize when ready to drop support for chef <= 0.10.8
#default_action :run

#Installation attributes
attribute :version, :kind_of => String
attribute :download_url, :kind_of => String
attribute :download_dir, :kind_of => String, :default => Chef::Config[:file_cache_path]
attribute :artifact_type, :kind_of => String, :default => 'tar.gz'
attribute :base_name, :kind_of => String, :default => 'redis-'
attribute :safe_install, :kind_of => [ TrueClass, FalseClass ], :default => true
attribute :base_piddir, :kind_of => String, :default => '/var/run/redis'

attribute :install_dir, :kind_of => String, :default => nil

#Configuration attributes
attribute :user, :kind_of => String, :default => 'redis'
attribute :group, :kind_of => String, :default => 'redis'

attribute :default_settings, :kind_of => Hash
attribute :servers, :kind_of => Array

def initialize(name, run_context=nil)
  super
  @action = :run
  @tarball = nil
end

