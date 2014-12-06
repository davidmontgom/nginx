#include_recipe "python::pip"

package "python-dev" do
  action :install
end

package "python-pip" do
  action :install
end

=begin
python_pip "uwsgi" do
  version "1.9.14"
  action :install
end
=end

=begin
execute "uwsgi" do
  command "pip install uwsgi==2.0.1"
  user "root"
  action :run
  not_if {File.exists?("/usr/local/bin/uwsgi")}
end
=end



bash "install_uwsgi" do
  cwd "/usr/share"
  code <<-EOH
    UWSGI_EMBED_PLUGINS=msgpack pip install uwsgi==2.0.5.1
    #UWSGI_PROFILE=gevent pip install uwsgi==2.0.1
  EOH
  not_if {File.exists?("/usr/local/bin/uwsgi")}
end
