



directory "/var/geo" do
  mode "0666"
  action :create
end

bash "install_geo" do
  user "root"
  cwd "/var/geo"
  code <<-EOH
    wget http://geolite.maxmind.com/download/geoip/database/GeoLiteCountry/GeoIP.dat.gz
    gunzip GeoIP.dat.gz
    wget http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz
    gunzip GeoLiteCity.dat.gz
  EOH
  action :run
  not_if {File.exists?("/var/geo/GeoLiteCity.dat")}
end



bash "install_geoip2" do
  user "root"
  code <<-EOH
  EOH
  action :run
end

package "python-geoip" do
  action :install
end

