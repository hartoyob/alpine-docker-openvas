openrc
openvas-manage-certs -a
openvasmd --create-user=admin --role=Admin
rc-service redis start
rc-service openvassd create_cache
rc-service openvasmd start
rc-service openvassd start
rc-service gsad start
openvasmd --rebuild --progress
