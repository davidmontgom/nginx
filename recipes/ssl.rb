datacenter = node.name.split('-')[0]
server_type = node.name.split('-')[1]
location = node.name.split('-')[2]
  
directory "/home/ubuntu/ssl" do
  owner "root"
  group "root"
  mode "0755"
  recursive true
  action :create
  #not_if {File.exists?("/home/ubuntu/.ec2/lock")}
end

if node.chef_environment == "development"
    sslkey = "development.key"
    sslpem = "development.pem"
else
    sslkey = "production.key"
    sslpem = "production.pem"
end

if node.chef_environment == "production" and location=="singapore"
    sslkey = "hkproduction.key"
    sslpem = "hkproduction.pem"
end

if node.chef_environment == "development"
  template "/home/ubuntu/ssl/development.key" do
    path "/home/ubuntu/ssl/development.key"
    source "#{sslkey}.erb"
    owner "root"
    group "root"
    mode "0644"
    #notifies :reload, resources(:service => "nginx")
  end
  template "/home/ubuntu/ssl/development.pem" do
    path "/home/ubuntu/ssl/development.pem"
    source "#{sslpem}.erb"
    owner "root"
    group "root"
    mode "0644"
    #notifies :reload, resources(:service => "nginx")
  end
end

if node.chef_environment == "production"
  template "/home/ubuntu/ssl/production.key" do
    path "/home/ubuntu/ssl/production.key"
    source "#{sslkey}.erb"
    owner "root"
    group "root"
    mode "0644"
    #notifies :reload, resources(:service => "nginx")
  end
  template "/home/ubuntu/ssl/production.pem" do
    path "/home/ubuntu/ssl/production.pem"
    source "#{sslpem}.erb"
    owner "root"
    group "root"
    mode "0644"
    #notifies :reload, resources(:service => "nginx")
  end
end

