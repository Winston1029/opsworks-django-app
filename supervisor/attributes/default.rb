#
# Cookbook Name:: supervisor
# Attribute File:: default
#

default['supervisor']['inet_port'] = nil
default['supervisor']['inet_username'] = nil
default['supervisor']['inet_password'] = nil
default['supervisor']['dir'] = '/etc/supervisor.d'
default['supervisor']['log_dir'] = '/var/log/supervisor'
default['supervisor']['logfile_maxbytes'] = '50MB'
default['supervisor']['logfile_backups'] = 10
default['supervisor']['loglevel'] = 'info'
default['supervisor']['minfds'] = 1024
default['supervisor']['minprocs'] = 200
