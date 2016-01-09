datacenter = node.name.split('-')[0]
environment = node.name.split('-')[1]
location = node.name.split('-')[2]
server_type = node.name.split('-')[3]
slug = node.name.split('-')[4] 

service "nginx" do
  supports :restart => true, :start => true, :stop => true, :reload => true
  action [ :enable, :start]
end


#remote-flask.pixel.nginx.conf.erb



if location=='local'
  template "/etc/nginx/nginx.conf" do
    path "/etc/nginx/nginx.conf"
    source "base.nginx.conf.erb"
    owner "root"
    group "root"
    mode "0644"
    notifies :reload, resources(:service => "nginx")
    variables :frontends_count => node["cpu"]["total"], :uwsgi_port => node['nginx']['flask']['uwsgi']['port']
  end
else
  template "/etc/nginx/nginx.conf" do
    path "/etc/nginx/nginx.conf"
    source "base.nginx.conf.erb"
    owner "root"
    group "root"
    mode "0644"
    notifies :reload, resources(:service => "nginx")
    variables :frontends_count => node["cpu"]["total"], :uwsgi_port => node['nginx']['flask']['uwsgi']['port']
  end
end
  

