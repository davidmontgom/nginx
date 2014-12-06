service "monit"
template "/etc/monit/conf.d/nginx.conf" do
  path "/etc/monit/conf.d/nginx.conf"
  source "monit.nginx.conf.erb"
  owner "root"
  group "root"
  mode "0755"
  notifies :restart, resources(:service => "monit")
end