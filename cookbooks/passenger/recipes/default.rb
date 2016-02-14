bash 'update' do
  code <<-EOH
    apt-get update
    apt-get upgrade -y
  EOH
end

package "libcurl4-openssl-dev"
package "apache2-threaded-dev"
package "libapr1-dev"
package "libaprutil1-dev"
package "apache2-mpm-worker"

bash 'install_passenger' do
  cwd ::File.dirname("~/")
  code <<-EOH
    /usr/local/bin/gem install passenger --version #{node['passenger']['version']}
    /usr/local/bin/passenger-install-apache2-module --auto
  EOH
  not_if { ::File.exists?("/usr/local/lib/ruby/gems/2.2.0/gems/passenger-#{node['passenger']['version']}/buildout/apache2/mod_passenger.so") }
end

template "/etc/apache2/mods-available/passenger.load" do
  source "passenger.load.erb"
  owner "root"
  mode '0644'
  variables "gem_dir" => Dir.open("/usr/local/lib/ruby/gems").entries.reject{|x| x == "." || x == ".."}.first 
end

bash 'enable_passenger' do
  code <<-EOH
    a2enmod passenger
  EOH
end
  