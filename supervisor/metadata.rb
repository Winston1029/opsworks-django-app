name              "supervisor"
description       "Installs supervisor and provides resources to configure services"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "1.0.0"

recipe "supervisor", "Installs and configures supervisord"

%w{ ubuntu debian }.each do |os|
  supports os
end

depends "python"
