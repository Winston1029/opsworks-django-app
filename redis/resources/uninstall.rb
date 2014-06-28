#
# Cookbook Name:: redis
# Resource::uninstall
#

actions :run, :nothing

attribute :servers, :kind_of => Array, :default => nil

def initialize(name, run_context=nil)
  super
  @action = :nothing
end

