package "openssl"

template node[:openssl][:config] do
  source "openssl.cnf.erb"
  owner "root"
  group "root"
  mode "0644"
end
