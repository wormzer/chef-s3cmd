include_recipe "yum-epel" if node["platform_family"] == "rhel"
include_recipe "python"

package "python-magic" do
  action :install
end

file "/etc/profile.d/s3cmd.sh" do
  mode "0644"
  content ""
  action :nothing
end

remote_file "#{Chef::Config[:file_cache_path]}/s3cmd-#{node["s3cmd"]["version"]}.tar.gz" do
  source node["s3cmd"]["url"]
  checksum node["s3cmd"]["checksum"]
  notifies :run, "bash[install-s3cmd]", :immediately
  action :create_if_missing
end

bash "install-s3cmd" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
    tar -xzf s3cmd-#{node["s3cmd"]["version"]}.tar.gz
    (cd s3cmd-#{node["s3cmd"]["version"]} &&
    python setup.py install --prefix=#{node["s3cmd"]["dir"]})
  EOH
  action :nothing
  notifies :create, "ruby_block[python-path]", :immediately
  not_if "#{node["s3cmd"]["dir"]}/bin/s3cmd --version 2>&1 | grep #{node["s3cmd"]["version"]}"
end

ruby_block "python-path" do
  block do
    require "find"

    s3cmd_profile = resources(:file => "/etc/profile.d/s3cmd.sh")
    s3cmd_profile.content "export PYTHONPATH='#{::Find.find(node["s3cmd"]["dir"]).grep(/site-packages/).first}/'"
  end
  action :nothing
  notifies :create_if_missing, "file[/etc/profile.d/s3cmd.sh]", :immediately
end

directory ::File.join(node["s3cmd"]["dir"], "etc") do
  action :create
end

template ::File.join(node["s3cmd"]["dir"], "etc", "s3cfg") do
  source "s3cfg.erb"
  mode "0644"
  variables(
    :access_key               => node["s3cmd"]["access_key"],
    :secret_key               => node["s3cmd"]["secret_key"],
    :use_https                => node["s3cmd"]["use_https"],
    :reduced_redundancy       => node["s3cmd"]["reduced_redundancy"],
    :enable_multipart         => node["s3cmd"]["enable_multipart"],
    :multipart_chunk_size_mb  => node["s3cmd"]["multipart_chunk_size_mb"],
    :proxy_host               => node["s3cmd"]["proxy_host"],
    :proxy_port               => node["s3cmd"]["proxy_port"]
  )
end
