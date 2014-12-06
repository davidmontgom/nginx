http://www.digicert.com/csr-creation-nginx.htm

openssl req -new -newkey rsa:2048 -nodes -keyout server.key -out server.csr

common(fqdn) = *.pixel.rtbhui.com


when generating the cert..

server.key = development.key
*.pixel.rtbhui.com.crt=development.pem