openssl req -x509 -nodes -days 10950 -newkey rsa:2048 \
	-keyout certs/server.key \
	-out certs/server.crt \
	-config certs/san.cnf \
	-extensions v3_req
