default[:ssl][:country_name] = "DE"
default[:ssl][:state_name] = "Berlin"
default[:ssl][:locality_name] = "Berlin"
default[:ssl][:organization_name] = ""

case node[:platform]
when 'gentoo'
  default[:openssl][:config] = '/etc/ssl/openssl.cnf'
when 'centos'
  default[:openssl][:config] = '/etc/pki/tls/openssl.cnf'
else
  raise "#{node[:platform]} is not supported"
end
