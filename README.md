# venpay.ru - Оплата вендинговых услуг через QR-код

[![Build Status](https://travis-ci.org/dapi/venpay.ru.svg?branch=master)](https://travis-ci.org/dapi/venpay.ru)

# Зависимости

* Ubuntu 18.5
* Postgresql 10+
* Redis (для sidekiq)

# Разворачивани

1. Установите [rbenv](https://github.com/rbenv/rbenv)
1. Установите [nvm](https://github.com/nvm-sh/nvm)
2. Зайдите в каталог проекта.
3. Установите через нужную версию ruby через `rbenv install`
3. Установите через нужную версию node через `nvminstall`
4. Установите нужные модули `bundle install`
5. Проинициализируйте базу `rake db:setup`

# Запуск

```bash
./bin/webpack-dev-server & rails s
```

# Деплой

> cap production deploy

# Процесс обработки запроса

1. Браузер HTTP (5 минута в хроме)
2. Caddy (Front Web Server) (30 сек ?) -> Application Web Server (Ruby Rack Puma)
3. Ruby Rack Puma (15 секунд) -> Rovos Broker Server (Rack Ruby Eventmachine) - !!!
4. Rovos Broker Server (7 секунды) (TCP/IP / GSM) -> вендинговая машина (STM)

# TODO

## Убедиться что машину еще не включали.
 1. [ ] Если она уже включена то показывать страницу отсчета.
 2. [ ] Если была включена и закончила работу, то показывать
    страницу что по этой оплату кресло уже закончило массаж.
 3. [ ] Если машину еще не включали, то включить:

## Включение машины

 1. [x] Включить
 2. [ ] Убедиться что машина включилась. Для этого нужно ловить exception.
 3. [ ] Логировать в Rails.logger что машину включили и результат (response)
 4. [ ] Показывать клиенту страницу что кресло включится через несколько секунд и показывтаь обратный отсчёт.

## Если машина не включилась (поймали исключение), то:

 1. [ ] Логировать исключение в Rails.logger
 2. [ ] Отправить уведомление в Bugsang с указанием price, machine, error
 3. [ ] Говорить клиенту что включение не удалось и возвращать деньги

## payments#fail

1. Сообщить админам (bugsnag)
2. Записать в лог Rails.logger
2. Сообщить пользователю причину.
3. Дать возможность повторить оплату (например другой картой)

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
