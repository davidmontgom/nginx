execute "install_nginx" do
  command "nginx=stable;add-apt-repository ppa:nginx/$nginx;apt-get update;touch /tmp/nginx_lock"
  user "root"
  action :run
  #not_if do ! File.exists?("/tmp/nginx_lock") end
  not_if {File.exists?("/tmp/nginx_lock")}
end

package "nginx-full" do
  action :install
end

execute "remove-sites-available" do
  command "rm /etc/nginx/sites-available/default"
  user "root"
  action :run
  only_if {File.exists?("/etc/nginx/sites-available/default")}
end
=begin
execute "remove-sites-enabled" do
command "rm /etc/nginx/sites-enabled/default"
user "root"
action :run
only_if {File.exists?("/etc/nginx/sites-enabled/default")}
end
=end

service "nginx" do
  supports :restart => true, :start => true, :stop => true, :reload => true
  action [ :enable,:start]
end




directory "/etc/nginx/html" do
  owner "root"
  group "root"
  mode "0755"
  action :create
end

file "/etc/nginx/html/index.html" do
  owner "root"
  group "root"
  mode "0755"
  content "bidder"
  action :create
end

directory "/etc/nginx/html/ping" do
  owner "root"
  group "root"
  mode "0755"
  action :create
end

file "/etc/nginx/html/ping/index.html" do
  owner "root"
  group "root"
  mode "0755"
  content "ping"
  action :create
end