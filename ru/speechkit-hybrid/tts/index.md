---
title: "Как начать работать с синтезом речи  в {{ speechkit-full-name }}"
description: "Из статьи вы узнаете, как начать работать с синтезом речи в сервисе {{ speechkit-name }}."
---

# Синтез речи

## Список доступных голосов {#voices}

В {{ sk-hybrid-name }} доступны [премиум-голоса](../../{{ speechkit-slug }}/tts/voices.md#premium) и [Brand Voice](../../{{ speechkit-slug }}/tts/brand-voice/).

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
