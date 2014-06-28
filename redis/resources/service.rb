#
# Cookbook Name:: redis
# Resource::service
#

actions :start, :stop, :restart, :enable, :disable

attribute :server_port, :name_attribute => true

def initialize(name, run_context=nil)
  super
  @action = :start
end
