cat > 'test.temp' << __EOF__  
Listen 80
<VirtualHost *:80>
	# The ServerName directive sets the request scheme, hostname and port that
	# the server uses to identify itself. This is used when creating
	# redirection URLs. In the context of virtual hosts, the ServerName
	# specifies what hostname must appear in the request's Host: header to
	# match this virtual host. For the default virtual host (this file) this
	# value is not decisive as it is used as a last resort host regardless.
	# However, you must set it for any further virtual host explicitly.
	#ServerName www.example.com

	ServerAdmin webmaster@localhost
	ServerName localhost
	ServerAlias www.ss.localhost
	DocumentRoot /var/www

	# Available loglevels: trace8, ..., trace1, debug, info, notice, warn,
	# error, crit, alert, emerg.
	# It is also possible to configure the loglevel for particular
	# modules, e.g.
	#LogLevel info ssl:warn

	ErrorLog \${APACHE_LOG_DIR}/error.log
	CustomLog \${APACHE_LOG_DIR}/access.log combined

	# For most configuration files from conf-available/, which are
	# enabled or disabled at a global level, it is possible to
	# include a line for only one particular virtual host. For example the
	# following line enables the CGI configuration for this host only
	# after it has been globally disabled with "a2disconf".
	#Include conf-available/serve-cgi-bin.conf

	<Directory "/var/www">
		Allow from all
		Require all granted
	</Directory>
</VirtualHost>
__EOF__

PORT=100
SERVERADMIN=admin@example.com
SERVERNAME=www.localhost
DOCROOT=/srv/www/stage

sed  -e "s/Listen 80/Listen $PORT/" \
     -e "s/<VirtualHost \*:80>/<VirtualHost *:$PORT>/" \
     -e "s/ServerAdmin webmaster@localhost/ServerAdmin $SERVERADMIN/" \
     -e "s/ServerName localhost/ServerName $SERVERNAME/" \
     -e "s/ServerAlias localhost/ServerAlias $SERVERNAME/" \
     -e "s#DocumentRoot /var/www*#DocumentRoot $DOCROOT#"  \
     -e "s#<Directory \"/[^\"]*#<Directory \"$DOCROOT#" \
     test.temp > testm.temp

