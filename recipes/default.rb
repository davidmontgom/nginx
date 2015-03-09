execute "install_nginx" do
  command "nginx=stable;add-apt-repository ppa:nginx/$nginx;apt-get update"
  user "root"
  action :run
  #not_if do ! File.exists?("/tmp/nginx_lock") end
  not_if {File.exists?("#{Chef::Config[:file_cache_path]}/nginx_lock")}
end

package "nginx-extras" do
  action :install
end

bash "kill_nginx" do
  cwd "#{Chef::Config[:file_cache_path]}"
  code <<-EOH
    #sudo kill `sudo lsof -t -i:80`
    sudo killall -9 nginx
    sudo service nginx start
    touch #{Chef::Config[:file_cache_path]}/nginx_kill.lock
  EOH
  not_if {File.exists?("#{Chef::Config[:file_cache_path]}/nginx_kill.lock")}
end


execute "remove-sites-available" do
  command "rm /etc/nginx/sites-available/default"
  user "root"
  action :run
  only_if {File.exists?("/etc/nginx/sites-available/default")}
end


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

file "#{Chef::Config[:file_cache_path]}/nginx_lock" do
  owner "root"
  group "root"
  mode "0755"
  content "ping"
  action :create
end