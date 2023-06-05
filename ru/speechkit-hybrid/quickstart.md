# Начало работы с {{ sk-hybrid-name }}

В {{ sk-hybrid-name }} доступны приложения {{ speechkit-full-name }} для синтеза и распознавания речи:

* Приложение для синтеза речи `tts`.
* Приложение для распознавания речи `stt`.
* Утилиты для нагрузочного тестирования.

Чтобы начать работу с сервисом, протестируйте развертывание приложений в [Docker-контейнерах](/blog/posts/2022/03/docker-containers) внутри вашей инфраструктуры.

## Перед началом работы {#before-you-begin}

1. Проверьте, что ваше оборудование соответствует [системным требованиям](system-requirements.md#hardware).
1. [Установите и настройте](system-requirements.md#software) необходимое окружение.
1. Установите на сервер [Docker Engine](https://docs.docker.com/engine/install/) и [Docker Compose](https://docs.docker.com/compose/install/).

## Развертывание приложения синтеза речи {#example-tts}

1. Создайте в отдельной директории файл `docker-compose.yaml`, предназначенный только для тестирования развертывания приложения:

   {% cut "docker-compose.yaml" %}

   ```yaml
   version: '3'
   services:

     tts:
       network_mode: host
       environment:
         - LICENSE_SERVICE_ENDPOINTS=0.0.0.0:9087
         - SERVICE_HOST=0.0.0.0
         - SERVICE_PORT=17009
         - UNISTAT_PORT=17003
         - GRPC_VERBOSITY=debug
         - LOGGING_LEVEL=INFO
         - TZ=UTC
         - NVIDIA_VISIBLE_DEVICES=0
         - NVIDIA_DRIVER_CAPABILITIES=compute,utility
       image: cr.yandex/<идентификатор реестра>/tts/v100/tts_server:<SK Hybrid version>
       deploy:
         resources:
           reservations:
             devices:
               - capabilities: ["gpu"]
                 driver: nvidia
                 device_ids: ["0"]

     license_server:
       network_mode: host
       environment:
         LICENSE_MODE: billing_agent
         LOGGING_LEVEL: INFO
         USE_TLS: "false"
         STATIC_API_KEY: <API KEY>
       image: cr.yandex/<идентификатор реестра>/license_server:<SK Hybrid version>

     envoy:
       network_mode: host
       image: cr.yandex/<идентификатор реестра>/envoy:<SK Hybrid version>
       environment:
         LOGGING_LEVEL: INFO
         ENVOY_UID: 0
       volumes:
         - ./log:/var/log/envoy
       depends_on:
         - license_server
   ```

   {% endcut %}

   В файле укажите параметры, полученные при [настройке окружения](#before-you-begin):

   * `<API KEY>` — идентификатор созданного API-ключа.
   * `<идентификатор реестра>` – идентификатор реестра {{ container-registry-name }}.
   * `<SK Hybrid version>` – версия образа {{ sk-hybrid-name }}.

1. Запустите приложение из директории с файлом `docker-compose.yaml`:

   ```bash
   docker-compose up
   ```

## Развертывание приложения распознавания речи {#example-stt}

{% note warning %}

Не рекомендуется разворачивать приложения синтеза и распознавания речи на одной ВМ, так как это создает большую нагрузку на систему.

{% endnote %}

1. Создайте в отдельной директории файл `docker-compose.yaml`, предназначенный только для тестирования развертывания приложения:

   {% cut "docker-compose.yaml" %}

   ```yaml
   version: '3'
   services:

     asr:
       network_mode: host
       privileged: true
       environment:
         - LICENSE_SERVICE_ENDPOINTS=0.0.0.0:8087
         - SERVICE_HOST=0.0.0.0
         - SERVICE_PORT=17002
         - UNISTAT_PORT=17003
         - GRPC_VERBOSITY=debug
         - LOGGING_LEVEL=INFO
         - TZ=UTC
         - NVIDIA_VISIBLE_DEVICES=0
         - NVIDIA_DRIVER_CAPABILITIES=compute,utility
       image: cr.yandex/<идентификатор реестра>/stt/v100/stt_server:<SK Hybrid version>
       deploy:
         resources:
           reservations:
             devices:
               - capabilities: ["gpu"]
                 driver: nvidia
                 device_ids: ["0"]

     license_server:
       network_mode: host
       environment:
         LICENSE_MODE: billing_agent
         LOGGING_LEVEL: INFO
         USE_TLS: "false"
         STATIC_API_KEY: <API KEY>
       image: cr.yandex/<идентификатор реестра>/license_server:<SK Hybrid version>

     envoy:
       network_mode: host
       image: cr.yandex/<идентификатор реестра>/envoy:<SK Hybrid version>
       environment:
         LOGGING_LEVEL: INFO
         ENVOY_UID: 0
       volumes:
         - ./log:/var/log/envoy
       depends_on:
         - license_server
   ```

   {% endcut %}

   В файле укажите параметры, полученные при [настройке окружения](#before-you-begin):

   * `<API KEY>` — идентификатор созданного API-ключа.
   * `<идентификатор реестра>` – идентификатор реестра {{ container-registry-name }}.
   * `<SK Hybrid version>` – версия образа {{ sk-hybrid-name }}.

1. Запустите приложение для распознавания речи из директории с файлом `docker-compose.yaml`:

   ```bash
   docker-compose up
   ```

## Нагрузочное тестирование {#load-testing}

Чтобы оценить корректность и производительность тестовой инсталляции {{ sk-hybrid-name }}, используйте контейнеры с утилитой нагрузочного тестирования для [синтеза](tts/testing.md) и [распознавания](stt/testing.md) речи.

1. Запустите нагрузочное тестирование синтеза речи на ВМ с приложением для синтеза речи:

   ```bash
   docker run -it \
       --network=host \
       --env ENVOY_HOST="0.0.0.0" \
       --env ENVOY_TTS_PORT=9080 \
       --env USE_SSL=1 \
       --env RPS=1 \
       cr.yandex/<идентификатор реестра>/tools/tts-tools:0.19
   ```

1. Запустите нагрузочное тестирование распознавания речи на ВМ с приложением для распознавания речи:

   ```bash
   docker run -it \
       --network=host \
       --env SEND_MODE=RealTime \
       --env CONNECTIONS=30 \
       --env ENVOY_HOST="0.0.0.0" \
       --env ENVOY_PORT=8080 \
       --env USE_SSL=1 \
       --env ERRORS_THRESHOLD=0.1 
       cr.yandex/<идентификатор реестра>/tools/stt-tools:0.20
   ```

Если приложения работают успешно, на консоль выводятся сообщения c процентилями времени обработки запросов и другой информацией:

```text
INFO: 2023-02-17 11:22:37.106 +0000 load_test.cpp:167 q=0.75: 250ms
INFO: 2023-02-17 11:22:37.106 +0000 load_test.cpp:167 q=0.9: 300ms
INFO: 2023-02-17 11:22:37.106 +0000 load_test.cpp:167 q=0.95: 300ms
INFO: 2023-02-17 11:22:37.106 +0000 load_test.cpp:167 q=0.99: 850ms
INFO: 2023-02-17 11:22:37.186 +0000 load_test.cpp:112 Total billing units: 260
INFO: 2023-02-17 11:22:37.186 +0000 load_test.cpp:218 SPS = 27.09172898
INFO: 2023-02-17 11:22:37.186 +0000 load_test.cpp:263 Errors statistics: 0% (0/50)
```

## См. также {#what-is-next}

* [Установка и настройка сервиса потокового распознавания](stt/index.md).
* [Установка и настройка сервиса синтеза речи](tts/index.md).
* [Мониторинг сервисов](monitoring.md).
