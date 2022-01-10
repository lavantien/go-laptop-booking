rm *.pem

# 1. Generate CA's private key and self-signed certificate
openssl req -x509 -newkey rsa:4096 -days 36500 -nodes -keyout ca-key.pem -out ca-cert.pem -subj "/C=VN/ST=Ho-Chi-Minh/L=Ho-Chi-Minh/O=lavantien/OU=Education/CN=*.github.com/emailAddress=tien@email.com"

echo "CA's self-signed certificate"
openssl x509 -in ca-cert.pem -noout -text

# 2. Generate web server's private key and certificate signing request (CRS)
openssl req -newkey rsa:4096 -nodes -keyout server-key.pem -out server-req.pem -subj "/C=VN/ST=Ho-Chi-Minh/L=Ho-Chi-Minh/O=go-laptop-booking/OU=Computer/CN=*.laptop-booking.com/emailAddress=laptop-booking@email.com"

# 3. Use CA's private key to sign web server's CSR and get back the signed certificate
openssl x509 -req -in server-req.pem -days 36500 -CA ca-cert.pem -CAkey ca-key.pem -CAcreateserial -out server-cert.pem -extfile server-ext.cnf

echo "Server's signed certificate"
openssl x509 -in server-cert.pem -noout -text

# 4. Generate client's private key and certificate signing request (CRS)
openssl req -newkey rsa:4096 -nodes -keyout client-key.pem -out client-req.pem -subj "/C=VN/ST=Ho-Chi-Minh/L=Ho-Chi-Minh/O=client/OU=Computer/CN=*.client.com/emailAddress=client@email.com"

# 3. Use CA's private key to sign client's CSR and get back the signed certificate
openssl x509 -req -in client-req.pem -days 36500 -CA ca-cert.pem -CAkey ca-key.pem -CAcreateserial -out client-cert.pem -extfile client-ext.cnf

echo "Client's signed certificate"
openssl x509 -in client-cert.pem -noout -text
