#
# Cookbook Name:: redis
# Attribute::default
#

case node['platform']
when 'ubuntu','debian'
  shell = '/bin/false'
  homedir = '/var/lib/redis'
when 'centos','redhat','scientific','amazon','suse'
  shell = '/bin/sh'
  homedir = '/var/lib/redis' 
when 'fedora'
  shell = '/bin/sh'
  homedir = '/home'
else
  shell = '/bin/sh'
  homedir = '/redis'
end

#Install related attributes
default['redis']['safe_install'] = true

#Tarball and download related defaults
default['redis']['mirror'] = "http://download.redis.io/releases/"
default['redis']['base_name'] = 'redis-'
default['redis']['artifact_type'] = 'tar.gz'
default['redis']['version'] = '2.6.17'
default['redis']['base_piddir'] = '/var/run/redis'

#Custom installation directory
default['redis']['install_dir'] = nil

#Default settings for all redis instances, these can be overridden on a per server basis in the 'servers' hash
default['redis']['default_settings'] = {
  'user'                   => 'redis',
  'group'                  => 'redis',
  'homedir'                => homedir,
  'shell'                  => shell,
  'systemuser'             => true,
  'ulimit'                 => 0,
  'configdir'              => '/etc/redis',
  'name'                   => nil,
  'address'                => nil,
  'databases'              => '16',
  'backuptype'             => 'rdb',
  'datadir'                => '/var/lib/redis',
  'unixsocket'             => nil,
  'unixsocketperm'         => nil,
  'timeout'                => '0',
  'loglevel'               => 'verbose',
  'logfile'                => nil,
  'syslogenabled'          => 'yes',
  'syslogfacility'         => 'local0',
  'shutdown_save'          => false,
  'save'                   => nil, # Defaults to ['900 1','300 10','60 10000'] inside of template.  Needed due to lack of hash subtraction
  'slaveof'                => nil,
  'job_control'            => 'initd', 
  'masterauth'             => nil,
  'slaveservestaledata'    => 'yes',
  'replpingslaveperiod'    => '10',
  'repltimeout'            => '60',
  'requirepass'            => nil,
  'maxclients'             => 10000,
  'maxmemory'              => nil,
  'maxmemorypolicy'        => 'volatile-lru',
  'maxmemorysamples'       => '3',
  'appendfsync'            => 'everysec',
  'noappendfsynconrewrite' => 'no',
  'aofrewritepercentage'   => '100',
  'aofrewriteminsize'      => '64mb',
  'cluster-enabled'        => 'no',
  'cluster-config-file'    => nil, # Defaults to redis instance name inside of template if cluster is enabled.
  'cluster-node-timeout'   => 5,
  'includes'               => nil
}

# The default for this is set inside of the "install" recipe. This is due to the way deep merge handles arrays
default['redis']['servers'] = nil

