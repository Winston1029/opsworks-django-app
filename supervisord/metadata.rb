name             "supervisord"
description      "Installs/Configures supervisord"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.0.0"

%w{ ubuntu debian }.each do |os|
  supports os
end
