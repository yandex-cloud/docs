[Документация Yandex Cloud](../../index.md) > [Yandex SpeechKit Hybrid](../index.md) > Распознавание речи > О технологии

# Распознавание речи

## Перед началом работы {#before-you-begin}

1. Установите на сервер [Docker Engine](https://docs.docker.com/engine/install/) и [Docker Compose](https://docs.docker.com/compose/install/).

1. [Аутентифицируйтесь](../../container-registry/operations/authentication.md) в Container Registry.

Рекомендуемая конфигурация оборудования приведена в разделе [Системные требования](../system-requirements.md).

## Установка и настройка сервиса потокового распознавания {#installing}

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

1. Запустите сервис SpeechKit:

   ```bash
   docker-compose up -d
   ```

1. Дождитесь загрузки сервиса
   ```bash
   docker logs stt-server
   ```

   ```text
   stt-server  | Server listening on 0.0.0.0:50053
   stt-server  | Waiting for join...
   ```

Сервис распознавания речи будет доступен на TCP-порте **8080**.