# Синтез речи

## Список доступных голосов {#voices}

В {{ sk-hybrid-name }} доступны [премиум-голоса](../../speechkit/tts/voices.md#premium) и [Brand Voice](../../speechkit/tts/brand-voice/).

## Перед началом работы {#before-you-begin}

1. Установите на сервер [Docker Engine](https://docs.docker.com/engine/install/) и [Docker Compose](https://docs.docker.com/compose/install/).

1. [Аутентифицируйтесь](../../container-registry/operations/authentication.md) в Container Registry.

Рекомендуемую конфигурацию оборудования см. в разделе [{#T}](../system-requirements.md).

## Установка и настройка сервиса синтеза речи {#installing}

1. Поместите полученный от команды SpeechKit файл `docker-compose.yaml` в папку на вашем сервере.

1. Отредактируйте `docker-compose.yaml`: вместо `N` укажите число потоков вашего процессора в параметре `CPU_THREADS_NUM: N`.

   В Linux вы можете узнать количество потоков вашего сервера, используя команду:

   ```bash
   cat /proc/cpuinfo | grep -E "processor.+:" | wc -l
   ```

1. Скачайте все необходимые Docker-контейнеры:

   ```bash
   docker-compose pull
   ```

1. Запустите сервис {{ speechkit-name }}:

   ```bash
   docker-compose up -d
   ```

1. Дождитесь загрузки сервиса

   ```bash
   docker logs tts-server
   tts-server            | INFO: 2021-09-22 15:36:02.765 +0000 server_base.cpp:144 Load finished. Ready to server requests on 0.0.0.0:17001
   ```

Сервис синтеза речи будет доступен на TCP-порте **9080**.

## Тестирование производительности {#testing}

1. Скачайте контейнер с тестами:

   ```bash
   docker pull cr.yandex/${REGISTRY_ID}/tts-tools
   ```

1. Запустите контейнер `tts-tools`:

   ```bash
   docker run --network=host \
      --env ENVOY_HOST=0.0.0.0 \
      --env ENVOY_TTS_PORT=9080 \
      --env RPS=1 \
      tts-tools
   ```
   
   * `ENVOY_HOST` — IP-адрес сервиса синтеза. Если тесты запускаются на том же сервере, что и сервис синтеза, укажите значение `0.0.0.0`.
   * `ENVOY_TTS_PORT` — порт сервиса синтеза (по умолчанию `9080`).
   * `RPS` — количество запросов синтеза в секунду.

1. Результаты теста будут доступны в логах контейнера:

   ```bash
   docker logs tts-tools
   ```
