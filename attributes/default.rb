default["s3cmd"]["version"]             = "1.1.0-beta3"
default["s3cmd"]["dir"]                 = "/opt/s3cmd"
default["s3cmd"]["url"]                 = "https://github.com/s3tools/s3cmd/archive/v#{node["s3cmd"]["version"]}.tar.gz"
default["s3cmd"]["checksum"]            = "bd14cc7593ce0e253014fe7e9e384a539c101bde4d5c6e28f048f8ae80035a30"

default["s3cmd"]["access_key"]          = ""
default["s3cmd"]["secret_key"]          = ""
default["s3cmd"]["use_https"]           = false
default["s3cmd"]["reduced_redundancy"]  = false
