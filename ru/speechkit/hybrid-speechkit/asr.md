# Распознавание речи

## Перед началом работы {#before-you-begin}

1. Установите на сервер [Docker Engine](https://docs.docker.com/engine/install/) и [Docker Compose](https://docs.docker.com/compose/install/).

1. [Аутентифицируйтесь](../../container-registry/operations/authentication) в Container Registry.

Рекомендуемую конфигурацию оборудования см. в разделе [{#T}](system-requirements.md).

## Установка и настройка сервиса потокового распознавания

1. Поместите полученный от команды SpeechKit файл `docker-compose.yaml` в папку на вашем сервере

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
   docker logs cpu-models-tts-server_1
   ```
   
   ```
   cpu-models-tts-server_1  | Server listening on 0.0.0.0:50053
   cpu-models-tts-server_1  | Waiting for join...
   ```

Сервис распознавания речи будет доступен на TCP-порте **8080**.

## Тестирование производительности

1. Скачайте контейнер с тестами:

   ```bash
   docker pull cr.yandex/${REGISTRY_ID}/stt-tools
   ```

1. Запустите контейнер `stt-tools`:

   ```bash
   docker run -it --network=host \
      --env ENVOY_HOST="0.0.0.0" \
      --env ENVOY_PORT=8080 \
      --env CONNECTIONS=10 \
      stt-tools
   ```

   * `ENVOY_HOST` — IP-адрес сервиса распознавания. Если тесты запускаются на том же сервере, что и сервис распознавания, укажите значение `0.0.0.0`.
   * `ENVOY_PORT` — порт сервиса распознавания (по умолчанию `8080`).
   * `CONNECTIONS` — количество одновременно активных каналов.

1. Результаты теста будут доступны в логах контейнера:

   ```bash
   docker logs stt-tools
   ```
