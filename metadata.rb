maintainer        "Hector Castro"
maintainer_email  "hectcastro@gmail.com"
license           "Apache 2.0"
description       "Installs and configures s3cmd."
version           "0.1.0"
recipe            "s3cmd", "Installs and configures s3cmd"

%w{ python yum }.each do |d|
  depends d
end

%w{ amazon centos ubuntu }.each do |os|
  supports os
end
