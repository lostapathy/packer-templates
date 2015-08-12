ruby_version = node['ruby']['version']

execute 'apt-get update' do
  command 'apt-get update'
end

#include_recipe "ntp"
package 'git'
package 'build-essential'
package 'libaspell-dev'
package 'libsqlite3-dev'
package 'libreadline-gplv2-dev'
package 'build-essential'
package 'libssl-dev'
package 'libreadline-dev'
package 'zlib1g-dev'
package 'curl'

src_filepath = "ruby-#{ruby_version}.tar.gz"
remote_file "/tmp/#{src_filepath}" do
  source "http://cache.ruby-lang.org/pub/ruby/2.2/#{src_filepath}"
  not_if { ::File.size?("/tmp/#{src_filepath}") || ::File.exists?("/usr/local/bin/ruby") }
end

cookbook_file "/etc/profile.d/ruby.sh" do
  path "/etc/profile.d/ruby.sh"
  source "ruby.sh"
end

extract_path = "/tmp/ruby-#{ruby_version}"
bash 'extract_module' do
  cwd ::File.dirname("~/")
  code <<-EOH
    tar xzf /tmp/#{src_filepath} -C /tmp/
    cd #{extract_path}
    ./configure --without-X11 --without-tcl --without-tk
    make
    sudo make install
    cd ..
    rm -rf #{extract_path}
    /usr/local/bin/gem install bundler
    EOH
  not_if { ::File.exists?("/usr/local/bin/ruby") && ::File.exists?("/usr/local/bin/bundle")}
end
