# venpay.ru - Оплата вендинговых услуг через QR-код

[![Build Status](https://travis-ci.org/dapi/venpay.ru.svg?branch=master)](https://travis-ci.org/dapi/venpay.ru)

# Зависимости

* postgresql 10+
* redis (для sidekiq)

# Запуск

```bash
rvm install
bundle
rake db:setup
rails s
```

# Развертка

> cap production deploy

# Создание сертификатов

> cd ./config/certs/

> openssl genrsa -out broker.venpay.ru.key 2048  # Generate an RSA key for the CA
> openssl req -new -key broker.venpay.ru.key -out broker.venpay.ru.csr  # Generate a CSR
> openssl rsa -in broker.venpay.ru.key -pubout -out broker.venpay.ru.pub  # Extract public key

> openssl genrsa -out ca.key 2048
> openssl req -new -x509 -key ca.key -out ca.crt  # Generate a self signed certificate for the CA

> openssl x509 -req -in broker.venpay.ru.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out broker.venpay.ru.crt  # Signing

> cat broker.venpay.ru.crt ca.crt > broker.venpay.ru.bundle.crt 
> openssl verify -CAfile ca.crt broker.venpay.ru.bundle.crt  # Verify

> cat broker.venpay.ru.crt broker.venpay.ru.key > broker.venpay.ru.pem 

> scp broker.venpay.ru.bundle.crt wwwuser@venpay.ru:/home/wwwuser/venpay.ru/shared/config/certs/
> scp broker.venpay.ru.key wwwuser@venpay.ru:/home/wwwuser/venpay.ru/shared/config/certs/
> scp broker.venpay.ru.pub wwwuser@venpay.ru:/home/wwwuser/venpay.ru/shared/config/certs/
> scp broker.venpay.ru.pem wwwuser@venpay.ru:/home/wwwuser/venpay.ru/shared/config/certs/
> scp ca.crt* wwwuser@venpay.ru:/home/wwwuser/venpay.ru/shared/config/certs/

Тестируем:

> curl -k https://broker.venpay.ru/machines --cert ./broker.venpay.ru.pem

или

> curl -k https://broker.venpay.ru/machines --cert ./broker.venpay.ru.pem \
  --cacert ./ca.pem --key ./broker.venpay.ru.key

Примеры отсюда: https://gist.github.com/Soarez/9688998
