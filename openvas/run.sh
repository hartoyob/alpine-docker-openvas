openrc
openvas-manage-certs -a
rc-service redis start
rc-service openvassd create_cache
rc-service openvasmd start
rc-service openvassd start
rc-service gsad start
openvasmd --rebuild --progress
openvasmd --create-user=admin --role=Admin
openvasmd --user=admin --new-password=openvas2018
tail -F /var/log/openvas/*
