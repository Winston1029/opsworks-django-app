#
# Cookbook Name:: gunicorn
# Resource:: config
#

actions :create, :delete

attribute :path, :kind_of => String, :name_attribute => true
attribute :template, :kind_of => String, :default => 'gunicorn.py.erb'
attribute :cookbook, :kind_of => String, :default => 'gunicorn'

attribute :listen, :kind_of => String, :default => '0.0.0.0:8000'
attribute :backlog, :kind_of => Integer, :default => 2048
attribute :preload_app, :kind_of => [TrueClass, FalseClass], :default => false

attribute :worker_processes, :kind_of => Integer, :default => 4
attribute :worker_class, :kind_of => String, :default => 'sync'
attribute :worker_timeout, :kind_of => Integer, :default => 60 
attribute :worker_keepalive, :kind_of => Integer, :default => 2
attribute :worker_max_requests, :kind_of => Integer, :default => 0

attribute :server_hooks, :kind_of => Hash, :default => {}, \
    :callbacks => { 
      "should contain a valid gunicorn server hook name" => lambda { |hooks| Chef::Resource::GunicornConfig.validate_server_hook_hash_keys(hooks)}
    }

attribute :owner, :regex => Chef::Config[:user_valid_regex]
attribute :group, :regex => Chef::Config[:group_valid_regex]
attribute :pid, :kind_of => String

VALID_SERVER_HOOK_NAMES = [:when_ready, :pre_fork, :post_fork, :pre_exec, :pre_request, :post_request, :worker_exit]

private
  def self.validate_server_hook_hash_keys(server_hooks)
    server_hooks.keys.reject{|key| VALID_SERVER_HOOK_NAMES.include?(key.to_sym)}.empty?
  end
