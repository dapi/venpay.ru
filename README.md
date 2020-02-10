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

> openssl genrsa -out broker.venpay.ru.key 2048  # Может лишнее, не помню уже
> openssl req -new -key broker.venpay.ru.key -out broker.venpay.ru.csr  
> openssl req -in broker.venpay.ru.csr -noout -text 
> openssl genrsa -out ca.key 2048
> openssl req -new -x509 -key ca.key -out ca.crt 
> openssl x509 -req -in broker.venpay.ru.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out broker.venpay.ru.crt
> cat broker.venpay.ru.crt ca.crt > broker.venpay.ru.bundle.crt 
> scp broker.venpay.ru.bundle.crt wwwuser@venpay.ru:/home/wwwuser/venpay.ru/shared/config/
> scp broker.venpay.ru.key wwwuser@venpay.ru:/home/wwwuser/venpay.ru/shared/config/
> scp broker.venpay.ru.pub wwwuser@venpay.ru:/home/wwwuser/venpay.ru/shared/config/
> scp ca.*  wwwuser@venpay.ru:/home/wwwuser/venpay.ru/shared/config/
> cat broker.venpay.ru.key >> broker.venpay.ru.pem 

Тестируем:

> curl -k https://broker.venpay.ru/machines --cert ./broker.venpay.ru.pem

или

> curl -k https://broker.venpay.ru/machines --cert ./broker.venpay.ru.pem \
  --cacert ./ca.pem --key ./broker.venpay.ru.key

Примеры отсюда: https://gist.github.com/Soarez/9688998
