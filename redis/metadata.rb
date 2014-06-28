name             'redis'
description      'Installs/Configures redis'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.0'

%w[ debian ubuntu ].each do |os|
  supports os
end

recipe "redis::default", "This recipe is used to install the prequisites for building and installing redis, as well as provides the LWRPs"
recipe "redis::install", "This recipe is used to install redis and create the configuration files and init scripts"
recipe "redis::uninstall", "This recipe is used to uninstall the redis binaries as well as optionally the configuration files and init scripts"
recipe "redis::enable", "This recipe is used to start the redis instances and enable them in the default run levels"
recipe "redis::disable", "this recipe is used to stop the redis instances and disable them in the default run levels"
recipe "redis::redis_gem", "this recipe will install the redis ruby gem into the system ruby"

depends "ulimit"
