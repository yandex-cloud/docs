# Терминирование TLS

При работе с {{ sk-hybrid-name }} вы можете включить режим [терминирования TLS](https://en.wikipedia.org/wiki/TLS_termination_proxy), чтобы безопасно передавать данные для синтеза и распознавания по публичной сети. В этом случае исходные данные, которые поступали в сервер Envoy в открытом виде, будут проходить по защищенному соединению. 

Чтобы включить терминирование TLS:

1. В контейнер `envoy` скопируйте TLS-сертификат и приватный ключ. Файл сертификата дожен размещаться в `/etc/envoy/certs/cert.pem `, а ключ — в `/etc/envoy/certs/key.pem`.
1. Передайте переменную окружения `USE_TLS="true"` в контейнер лицензионного сервера `license_server`.

Вы также можете включить TLS проксирование с помощью `docker compose`:


```text
version: '3'
services:
  billing_agent:
    network_mode: host
    volumes:
      - persistent:/var/swaydb
    environment:
      STATIC_API_KEY: XXX
    image: billing_agent:0.15
  license_server:
    network_mode: host
    environment:
      USE_TLS: "true"
      LICENSE_MODE: billing_agent
    image: license-server:0.15
    depends_on:
      - billing_agent
  envoy:
    network_mode: host
    volumes:
      - certs:/etc/envoy/certs
    environment:
      ENVOY_UID: 0      
    image: envoy:0.15
    depends_on:
      - license_server

```
