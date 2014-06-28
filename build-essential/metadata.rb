name              "build-essential"
description       "Installs C compiler / build tools"
long_description IO.read(File.join(File.dirname(__FILE__), "README.md"))
version           "1.0.0"

recipe            "build-essential", "Installs packages required for compiling C software from source."

%w{ ubuntu debian }.each do |os|
  supports os
end
