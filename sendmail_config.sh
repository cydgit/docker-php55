#!/bin/sh
# set host in hosts
#line=$(head -n 1 /etc/hosts)
#line2=$(echo $line | awk '{print $2}')
#echo "$line $line2.localdomain" >> /etc/hosts
#echo "$line $line2.localdomain"

#apt-get install -y sendmail sendmail-cf m4 \
#    && hostname >> /etc/mail/relay-domains \

hostname=$(hostname)
#echo $hostname
rep="${hostname} ${hostname}.docker.codetzar.com"
sed -e "s/${hostname}/${rep}/g" /etc/hosts > hosts
cp hosts /etc/hosts
rm hosts

m4 /etc/mail/sendmail.mc > /etc/mail/sendmail.cf

#remove localhost limit
sed -i -e "s/Port=smtp,Addr=127.0.0.1, Name=MTA/Port=smtp, Name=MTA/g" \
    /etc/mail/sendmail.mc
sendmail -bd

#sed -ri 's/^memory_limit\s*=\s*128M/memory_limit = 512M/g' /etc/php5/apache2/php.ini

#line=$(head -n 1 /etc/hosts | awk '{printf "%s %s.localdomain %s", $1, $2, $2}')
#sed -e "1 s/^.*$/${line}/g" /etc/hosts > hosts
# with sed -i, it actually performs a rename of /etc/hosts, but docker does not
# allow that, so we have to use a temp file and copy it to overwrite /etc/hosts
#cp hosts /etc/hosts
#rm hosts
