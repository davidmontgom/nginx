data_bag("my_data_bag")
db = data_bag_item("my_data_bag", "my")
#location = node.name.split('-')[2]

if node.name.include? "-"
  datacenter = node.name.split('-')[0]
  server_type = node.name.split('-')[1]
  location = node.name.split('-')[2]
end
if node.name.include? "X"
  datacenter = node.name.split('X')[0]
  server_type = node.name.split('X')[1]
  location = node.name.split('X')[2]
end

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
  

