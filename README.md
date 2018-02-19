# sh-nagios-plugins
Custom bash nagios plugins

For using custom plugin in nagios 
nrpe server you should create custom 
command in `/etc/nagios/nrpe.cfg` 

For example:
```
command[custom_check_free_disk_space]=/usr/lib/nagios/plugins/custom_check_free_disk_space.sh -w 60 -c 80
```
You should find another commands in `nrp.cfg` and paste your custom command.

On your monitoring server you should add service to server configuration. For example in `/usr/local/nagios/etc/servers/test.cfg`
```
define service {
        use                             generic-service
        host_name                       test
        service_description             Free space
        check_command                   check_nrpe!custom_check_free_disk_space
        notifications_enabled           1
}
```