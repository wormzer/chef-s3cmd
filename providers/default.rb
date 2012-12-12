require "find"
require "chef/mixin/command"

action :sync do
  base_command_options = [ "sync" ]

  base_command_options << "--config=#{::File.join(node["s3cmd"]["dir"], "etc", "s3cfg")}"
  base_command_options << "--recursive" if new_resource.recursive
  base_command_options << "--include=#{new_resource.includes.join(" ")}" if new_resource.includes && !new_resource.includes.empty?  
  base_command_options << "--exclude=#{new_resource.excludes.join(" ")}" if new_resource.excludes && !new_resource.excludes.empty?
  
  status = run_s3cmd("#{base_command_options.join(" ")} #{new_resource.source} #{new_resource.destination}", {
    "AWS_ACCESS_KEY_ID"     => new_resource.aws_access_key,
    "AWS_SECRET_ACCESS_KEY" => new_resource.aws_secret_access_key
  })

  new_resource.updated_by_last_action(status.exitstatus == 0)
end

private

def run_s3cmd(sub_command, env)
  Chef::Mixin::Command.run_command(
    :command      => "#{::File.join(node["s3cmd"]["dir"], "bin", "s3cmd")} #{sub_command}",
    :environment  => { "PYTHONPATH" => "#{::Find.find(node["s3cmd"]["dir"]).grep(/site-packages/).first}/" }.merge(env),
    :returns      => 0
  )
end
