action :create do 
  cert =
    cookbook_file "#{new_resource.name}.crt" do
      action :nothing
      owner new_resource.owner
      group new_resource.group
      mode new_resource.mode
      source "certificates/#{new_resource.cn}.crt"
      cookbook "ssl"
      backup 0
    end
  cert.run_action(:create)
  if cert.updated?
    Chef::Log.debug "certificate #{new_resource.name}.crt updated"
    new_resource.updated_by_last_action(true)
  else
    Chef::Log.debug "certificate #{new_resource.name}.crt not updated"
  end
  key =
    cookbook_file "#{new_resource.name}.key" do
      action :nothing
      owner new_resource.owner
      group new_resource.group
      mode '0400'
      source "certificates/#{new_resource.cn}.key"
      cookbook "ssl"
      backup 0
    end
  key.run_action(:create)
  if key.updated?
    Chef::Log.debug "key #{new_resource.name}.key updated"
    new_resource.updated_by_last_action(true)
  else
    Chef::Log.debug "key #{new_resource.name}.key not updated"
  end
end
