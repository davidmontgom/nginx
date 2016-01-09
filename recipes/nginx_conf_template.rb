service "nginx" do
  supports :restart => true, :start => true, :stop => true, :reload => true
  action [ :enable, :start]
end

template "/etc/nginx/nginx.conf" do
  path "/etc/nginx/nginx.conf"
  source "base.nginx.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  notifies :reload, resources(:service => "nginx")
  variables :frontends_count => node["cpu"]["total"], :uwsgi_port => node['nginx']['flask']['uwsgi']['port']
end

  

