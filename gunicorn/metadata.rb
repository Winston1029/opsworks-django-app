name             "gunicorn"
description      "Installs/Configures Gunicorn"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.0.0"

%w{ ubuntu debian }.each do |os|
  supports os
end

depends "python"
