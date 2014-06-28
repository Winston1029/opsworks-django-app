#
# Cookbook Name:: supervisor
# Resource:: group
#

actions :enable, :disable, :start, :stop, :restart, :reload

def initialize(*args)
  super
  @action = [:enable, :start]
end

attribute :group_name, :kind_of => String, :name_attribute => true
attribute :programs, :kind_of => Array, :default => []
attribute :priority, :kind_of => Integer
