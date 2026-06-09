# Логирование работы {{ sk-hybrid-name }}

Вы можете контролировать, какие действия контейнеров {{ sk-hybrid-name }} будут записываться в логи. Уровень логирования определяется параметром `LOGGING_LEVEL`. 

Возможные уровни логирования:

* `DEBUG`  
* `NOTICE` 
* `INFO` (значение по умолчанию)
* `WARNING` 
* `ERROR`
* `EMERG` 
* `ALERT` 
* `CRITICAL_INFO`

## Определение уровня логирования при запуске контейнера {#run}

Чтобы определить уровень логирования, задайте значение переменной при запуске контейнера {{ sk-hybrid-name }}, например:

```bash
docker run --network=host-e LOGGING_LEVEL=DEBUG -e LICENSE_MODE=billing_agent <образ_лицензионного_сервера>
```

## Определение уровня логирования в файле docker compose {#docker-compose}

Если вы запускаете контейнеры {{ sk-hybrid-name }} с помощью Docker Compose, вы можете задать уровень логирования для каждого контейнера в файле конфигурации. 

Например, следующая конфигурация задаст уровени логирования `INFO` для контейнера `billing_agent`, `NOTICE` для лицензионного сервера и `WARNING` для контейнера `envoy`.

```text
version: '3'
services:
  billing_agent:
    network_mode: host
    volumes:
      - persistent:/var/swaydb
    environment:
      LOGGING_LEVEL: INFO
      STATIC_API_KEY: XXX
    image: billing_agent:0.15
  license_server:
    network_mode: host
    environment:
      LICENSE_MODE: billing_agent
      LOGGING_LEVEL: NOTICE
    image: license-server:0.15
    depends_on:
      - billing_agent
  envoy:
    network_mode: host
    environment:
      LOGGING_LEVEL: WARNING
      ENVOY_UID: 0      
    image: envoy:0.15
    depends_on:
      - license_server

```