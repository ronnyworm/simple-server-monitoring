# Simple Server Monitoring

1. move these files to a directory on your server
2. `gem install mail`
3. `mv send_mail_example.rb send_mail.rb`
4. set smtp credentials in send_mail.rb
5. get inspired by example_check_configuration.sh to do your own checks for website uptime/disk space/running services and more
6. run it yourself for testing (always with sudo because of permissions for running critical services e.g. ufw) or add it to your crontab directly `sudo server_monitoring.sh configuration.sh`

## crontab suggestion
`sudo crontab -e`

	30 7 * * * f=/some/folder; $f/server_monitoring.sh $f/check_configuration.sh >> $f/monitoring.log 2>&1
	if you need more than once per day
	15 7-22 * * * f=/some/folder; $f/server_monitoring.sh $f/check_configuration_critical.sh >> $f/monitoring-critical.log 2>&1
