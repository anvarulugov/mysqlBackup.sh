#!/bin/bash

#----------------------------------------------------------
# MySQL Database backup shell script
# by Anvar Ulugov <wasatiyatm@gmail.com>
#----------------------------------------------------------

host=127.0.0.1
user=root
pass=secret
databases=( db1 db2 db3 )
excluded_tables=(
table1
table2
table3
)
date=`date +"%Y-%m-%d"`
path=/media/yandexdisk

mkdir /home/user/${date}
cd /home/user/${date}
for db in "${databases[@]}"
do :
        ignored_tables_string=''
        for TABLE in "${excluded_tables[@]}"
        do :
                 ignored_tables_string+=" --ignore-table=${db}.${TABLE}"
        done
        mysqldump --host=${host} --user=${user} --password=${pass} --single-transaction --compact --no-data ${db} > ${date}-${db}.sql
        mysqldump --host=${host} --user=${user} --password=${pass} ${db} --compact --skip-triggers --no-create-info ${ignored_tables_string} >> ${date}-${db}.sql
done
cd ..
tar -zcf ${date}.tar.gz ${date}
rm -rf ${date}
mv ${date}.tar.gz /media/yandexdisk/
