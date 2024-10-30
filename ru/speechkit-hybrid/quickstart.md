---
title: Как создать демонстрационный стенд {{ sk-hybrid-name }}
description: По этой инструкции вы можете создать приложения для распознавания и синтеза речи, а также утилиты для нагрузочного тестирования.
---

# Создание демонстрационного стенда {{ sk-hybrid-name }}

{{ sk-hybrid-name }} предоставляет возможности сервиса {{ speechkit-full-name }} для [распознавания](stt/testing.md) и [синтеза](tts/testing.md) речи. Вы можете развернуть демонстрационный стенд {{ sk-hybrid-name }} с помощью сервисов {{ yandex-cloud }} через {{ TF }}. Так можно потестировать приложения распознавания и синтеза, размещаемые в [Docker-контейнерах](/blog/posts/2022/03/docker-containers).

Работа по созданию демонстрационного стенда ведется на двух машинах:

* Локальной. Ниже предполагается, что используется ОС Linux.
* Виртуальной, соответствует [системным требованиям](system-requirements.md) {{ sk-hybrid-name }}. На этой ВМ запускаются Docker-контейнеры.

В демонстрационном стенде рассматривается модель лицензирования [Cloud Billing](pricing.md#billing), поэтому сведения о каждом запросе к сервису {{ sk-hybrid-name }} [отправляются](architecture.md) в сервис {{ billing-name }}.

Чтобы развернуть демонстрационный стенд {{ sk-hybrid-name }}:

1. [{#T}](#get-started).
1. [{#T}](#prepare).
1. [{#T}](#ssh).
1. [{#T}](#variables).
1. [{#T}](#create-infrastructure).
1. [{#T}](#communication-channel).
1. [{#T}](#stt-and-tts).

В случае ошибок воспользуйтесь [инструкцией по отладке](quickstart-debugging.md).

## Начните работу с {{ yandex-cloud }} {#get-started}

1. Зарегистрируйтесь в {{ yandex-cloud }}. Процесс регистрации различается для физических и юридических лиц:

   * [регистрация физических лиц](../getting-started/individuals/registration.md);
   * [регистрация юридических лиц](../getting-started/legal-entity/registration.md).

1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }}.
1. Создайте каталог в консоли управления. В нем будут располагаться ваши ресурсы:

   {% include [create-folder](../_includes/create-folder.md) %}

1. [Создайте сервисный аккаунт](../iam/operations/sa/create.md) `sk-hybrid-example`.

   Сервисный аккаунт позволяет гибко настраивать права доступа. Подробнее о сервисном аккаунте читайте в разделе [{#T}](../iam/concepts/users/service-accounts.md).

1. [Назначьте сервисному аккаунту роли](../iam/operations/sa/assign-role-for-sa.md):

   * `compute.editor` — чтобы создать ВМ {{ yandex-cloud }};
   * `container-registry.images.puller` — чтобы работать с Docker-образами в реестре [{{ container-registry-full-name }}](../container-registry/index.yaml);
   * `iam.serviceAccounts.keyAdmin` — чтобы создать [API-ключ](../iam/concepts/authorization/api-key.md) для авторизации в {{ billing-name }}.

1. [Создайте API-ключ](../iam/operations/api-key/create.md).

   Сохраните идентификатор и секретную часть ключа. Их нельзя запросить позднее.

1. [Создайте реестр](../container-registry/operations/registry/registry-create.md) в {{ container-registry-name }}.
1. [Сообщите команде {{ speechkit-name }}]({{ link-console-support }}) идентификатор реестра. В вашем реестре появятся необходимые контейнеры и образы.

## Установите дополнительные зависимости {#prepare}

На локальной машине:

1. [Установите интерфейс командной строки](../cli/operations/install-cli.md) {{ yandex-cloud }} (YC CLI).
1. [Аутентифицируйте свой сервисный аккаунт](../cli/operations/authentication/service-account.md) через YC CLI.
1. [Установите {{ TF }}](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

## Подготовьте репозиторий с конфигурацией {{ TF }} {#repository}

На локальной машине:

1. Склонируйте [репозиторий с конфигурацией {{ TF }}](https://github.com/yandex-cloud-examples/yc-speechkit-hybrid-deployment/), из которой будет развернута необходимая инфраструктура:

   ```bash
   git clone git@github.com:yandex-cloud-examples/yc-speechkit-hybrid-deployment.git
   ```

1. В терминале перейдите в директорию склонированного репозитория.

## Подготовьте SSH-ключи {#ssh}

SSH-ключи понадобятся для аутентификации при подключении к ВМ {{ yandex-cloud }}. Чтобы подготовить их, выполните следующие действия на локальной машине:

1. Если у вас нет пары из открытого и закрытого SSH-ключей, создайте ее:

   ```bash
   ssh-keygen -t rsa -f $HOME/.ssh/speechkit_hybrid
   ```

   После запуска команды будет предложено ввести пароль для закрытого ключа. Если не хотите указывать пароль, нажмите **Enter**.

1. В директории склонированного репозитория создайте символическую ссылку, которая указывает на публичный SSH-ключ:

   ```bash
   ln -s ~/.ssh/<название_ключа>.pub ./keys/ssh-user-id-rsa.pub
   ```

   В команде передаются:

   * `~/.ssh/<название_ключа>.pub` — файл с публичным SSH-ключом. Если вы создали ключ в предыдущем шаге, укажите `~/.ssh/speechkit_hybrid.pub`.
   * `./keys/ssh-user-id-rsa.pub` — символическая ссылка. Путь указан относительно текущей директории репозитория.

## Добавьте переменные для конфигурации {{ TF }} {#variables}

В директории репозитория `yc-speechkit-hybrid-deployment` располагается файл `terraform.tfvars.template`. Он представляет собой {{ TF }}-шаблон, по которому задаются переменные окружения. Эти переменные передаются YC CLI и {{ TF }} во время выполнения команд.

Чтобы задать переменные для конфигурации {{ TF }}, выполните следующие действия на локальной машине:

1. Создайте копию {{ TF }}-шаблона в директории репозитория `yc-speechkit-hybrid-deployment`:

   ```bash
   cp ./terraform.tfvars.template ./terraform.tfvars
   ```

1. Укажите значения переменных в файле `terraform.tfvars`:

   * `CR_REGISTRY_ID` — идентификатор реестра {{ container-registry-name }};
   * `BILLING_STATIC_API_KEY` — секретная часть API-ключа.

1. (Опционально) Добавьте переменную `NODES_GPU_INTERRUPTIBLE = false`.

   Конфигурация {{ TF }} в репозитории предполагает создание [прерываемой ВМ](../compute/concepts/preemptible-vm.md). Вы можете отключить возможность прерывания с помощью переменной `NODES_GPU_INTERRUPTIBLE`. Ее значение по умолчанию — `true`, оно прописано в файле `variables.tf` в репозитории `yc-speechkit-hybrid-deployment`.

## Создайте инфраструктуру с помощью {{ TF }} {#create-infrastructure}

Инфраструктура, необходимая для работы со {{ sk-hybrid-name }}, описана в файлах `networks.tf` и `node-deploy.tf` в репозитории `yc-speechkit-hybrid-deployment`. Файл `networks.tf` содержит конфигурацию сущностей:

* сеть;
* подсеть;
* внутренняя зона DNS;
* группа безопасности.

Файл `node-deploy.tf` содержит конфигурацию ВМ и сервиса {{ sk-hybrid-name }}.

Подробнее о конфигурации сущностей читайте на сайте [{{ TF }}]({{ tf-provider-link }}) и в документации соответствующего сервиса {{ yandex-cloud }}.

Чтобы создать инфраструктуру, выполните следующие действия на локальной машине:

{% list tabs group=instructions %}

* {{ TF }} {#tf}

   1. В терминале перейдите в директорию репозитория `yc-speechkit-hybrid-deployment`.
   1. [Получите данные для аутентификации](../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) сервисного аккаунта `sk-hybrid-example`. Вы можете добавить данные в переменные окружения или указать эти данные в файле `main.tf`, в блоке `provider "yandex"`.
   1. [Настройте и инициализируйте провайдеры {{ TF }}](../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).

      В репозитории в качестве конфигурационного файла с настройками провайдеров используется файл `main.tf`, поэтому повторно создавать такой файл не нужно.

   1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

      ```bash
      terraform validate
      ```

   1. Создайте инфраструктуру:

      {% include [terraform-apply](../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Организуйте постоянный канал связи с сервером {{ yandex-cloud }} {#communication-channel}

Для работы по модели лицензирования Cloud Billing обпеспечьте сетевую связность между узлом {{ billing-name }} `billing.datasphere.yandexcloud.net:443` и ВМ, на которой разворачивается сервис {{ sk-hybrid-name }}. Чтобы проверить доступность узла:

1. На локальной машине получите публичный IP-адрес созданной ВМ:

   ```bash
   {{ yc-compute-instance }} list
   ```

   Публичный адрес понадобится для подключения к ВМ.

   Пример результата:

   ```text
   +-----------+-------------------------------+---------------+---------+-------------+--------------+
   |     ID    |              NAME             |    ZONE ID    | STATUS  | EXTERNAL IP | INTERNAL IP  |
   +-----------+-------------------------------+---------------+---------+-------------+--------------+
   | fhmjvr*** | sk-hybrid-compose-example-*** | {{ region-id }}-a | RUNNING | 158.160.*** | 192.168.***  |
   | ...                                                                                              |
   +-----------+-------------------------------+---------------+---------+-------------+--------------+
   ```

   Публичный адрес указан в поле `EXTERNAL IP`.

1. [Подключитесь к ВМ по SSH](../compute/operations/vm-connect/ssh.md#vm-connect):

   ```bash
   ssh <имя_пользователя>@<публичный_IP-адрес_ВМ>
   ```

   Здесь `<имя_пользователя>` — имя учетной записи пользователя ВМ.

1. Выполните команду:

   ```bash
   nc -vz billing.datasphere.yandexcloud.net 443
   ```

   Если узел доступен по сети, команда возвращает результат:

   ```text
   Connection to billing.datasphere.yandexcloud.net 443 port [tcp/https] succeeded!
   ```

## Проведите нагрузочное тестирование распознавания и синтеза речи {#stt-and-tts}

Чтобы оценить корректность и производительность тестовой инсталляции {{ sk-hybrid-name }}, используйте Docker-контейнеры с утилитой нагрузочного тестирования для распознавания и синтеза речи. Эти контейнеры описаны в файле `node-deploy.tf`, они были созданы вместе с [инфраструктурой](#create-infrastructure).

Чтобы провести нагрузочное тестирование:

1. Подключитесь к ВМ по SSH.
1. Убедитесь, что порты `8080` и `9080` открыты для приема клиентских запросов:

   ```bash
   telnet <публичный_адрес_ВМ> 8080 && telnet <публичный_адрес_ВМ> 9080
   ```

1. Запустите распознавание речи:

   ```bash
   docker run --rm --name stt-tools \
      --env ENVOY_HOST=<публичный_адрес_ВМ> \
      --env ENVOY_PORT=8080 \
      --env CONNECTIONS=40 \
      {{ registry }}/<идентификатор_реестра>/release/tools/stt-tools:0.20
   ```

   В команде укажите публичный IP-адрес ВМ и идентификатор созданного ранее реестра {{ container-registry-name }}.

   Здесь:

   * `ENVOY_HOST` — IP-адрес сервиса распознавания;
   * `ENVOY_PORT` — порт сервиса распознавания (по умолчанию `8080`);
   * `CONNECTIONS` — количество одновременно активных каналов.

1. Запустите синтез речи:

   ```bash
   docker run --rm --name tts-tools \
      --network=host \
      --env ENVOY_HOST=<публичный_адрес_ВМ> \
      --env ENVOY_TTS_PORT=9080 \
      --env RPS=20 \
      {{ registry }}/<идентификатор_реестра>/release/tools/tts-tools:0.20
   ```

   В команде укажите публичный IP-адрес ВМ и идентификатор созданного ранее реестра {{ container-registry-name }}.

   Здесь:

   * `ENVOY_HOST` — IP-адрес сервиса синтеза;
   * `ENVOY_TTS_PORT` — порт сервиса синтеза (по умолчанию `9080`);
   * `RPS` — количество запросов синтеза в секунду.

1. Подождите несколько минут, пока проводятся распознавание и синтез речи.
1. Посмотрите результаты тестирования в логах контейнера:

   * `docker logs stt-tools` — для распознавания речи;
   * `docker logs tts-tools` — для синтеза речи.

   Пока в логах не появится строка `Load finished. Ready to serve requests on 0.0.0.0:17001`, сервисы распознавания и синтеза речи не будут отвечать на запросы. Ожидание может занять 2–10 минут.

   Далее в логах появится сообщение о том, что компонент [Envoy](architecture.md) начал прослушивать порт `8080` для распознавания речи и порт `9080` для синтеза речи. Это означает, что сервис {{ sk-hybrid-name }} запущен и готов обслуживать клиентские запросы.

1. (Опционально) Остановите нагрузочное тестирование.

   Во время нагрузочного тестирования команды `docker run` не будут реагировать на сигналы прерывания **Ctrl** + **C**. Если вы хотите остановить работу контейнеров, выполните команду:

   * `docker stop stt-tools` — для распознавания речи;
   * `docker stop tts-tools` — для синтеза речи.
