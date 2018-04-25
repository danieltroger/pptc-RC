#!/bin/bash
cat >._apache2_dir_conf << EOF
#Include /etc/apache2/mods-enabled/*.load
#Include /etc/apache2/mods-enabled/*.conf
LoadModule dir_module /usr/libexec/apache2/mod_dir.so
LoadModule mime_module /usr/libexec/apache2/mod_mime.so
ErrorLog $1/._apache2_dir_error.log
HostnameLookups Off
NameVirtualHost *:$2
ServerName deinmac
Listen $2
PidFile $1/._apache2_pid
<VirtualHost *:$2>
    ServerAdmin joyer@uc
    DocumentRoot $1
    <Directory />
        Options FollowSymLinks
        AllowOverride None
	DirectoryIndex index.html
	AddType text/html .html
    </Directory>
    <Directory $1/>
        Options Indexes FollowSymLinks MultiViews
        AllowOverride None
	DirectoryIndex index.html
        AddType text/html .html
    </Directory>
    ErrorLog $1/._apache2_dir_error.log
    LogLevel warn
</VirtualHost>

EOF

#apache2 -k $3 -X -f $1/._apache2_dir_conf
httpd -X -d  . -c "LockFile foobar" -c "ErrorLog /dev/stdout" -f $1/._apache2_dir_conf
