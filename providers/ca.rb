action :create do

  %w(crt crl).each do |t|
    ca_file =
      cookbook_file "#{new_resource.name}.#{t}" do
        action :nothing
        owner new_resource.owner
        group new_resource.group
        mode new_resource.mode
        source "certificates/ca.#{t}"
        cookbook "ssl"
        backup 0
      end
    ca_file.run_action(:create)
    if ca_file.updated?
      Chef::Log.debug "#{new_resource.name}.#{t} updated"
      @new_resource.updated_by_last_action(true)
    else
      Chef::Log.debug "#{new_resource.name}.#{t} not updated"
    end
  end

  if new_resource.symlink
    ca_link =
      execute "#{new_resource.name}-ca-symlink" do
        action :nothing
        command "ln -s #{::File.basename(new_resource.name)}.crt #{::File.dirname(new_resource.name)}/`openssl x509 -noout -hash -in #{new_resource.name}.crt`.0"
        not_if "test -e #{::File.dirname(new_resource.name)}/`openssl x509 -noout -hash -in #{new_resource.name}.crt`.0"
      end
    ca_link.run_action(:run)
    if ca_link.updated?
      Chef::Log.debug "#{new_resource.name}-ca-symlink updated"
      @new_resource.updated_by_last_action(true)
    else
      Chef::Log.debug "#{new_resource.name}-ca-symlink not updated"
    end

    crl_link =
      execute "#{new_resource.name}-crl-symlink" do
        action :nothing
        command "ln -s #{::File.basename(new_resource.name)}.crl #{::File.dirname(new_resource.name)}/`openssl crl -noout -hash -in #{new_resource.name}.crl`.r0"
        not_if "test -e #{::File.dirname(new_resource.name)}/`openssl crl -noout -hash -in #{new_resource.name}.crl`.r0"
      end
    crl_link.run_action(:run)
    if crl_link.updated?
      Chef::Log.debug "#{new_resource.name}-crl-symlink updated"
      @new_resource.updated_by_last_action(true)
    else
      Chef::Log.debug "#{new_resource.name}-crl-symlink not updated"
    end

  end

end
