name              "s3cmd"
maintainer        "Hector Castro"
maintainer_email  "hectcastro@gmail.com"
license           "Apache 2.0"
description       "Installs and configures s3cmd."
version           "0.2.0"
recipe            "s3cmd", "Installs and configures s3cmd"

%w{ python yum yum-epel}.each do |d|
  depends d
end

%w{ amazon centos ubuntu }.each do |os|
  supports os
end
