[Документация Yandex Cloud](../index.md) > [Yandex SpeechKit Hybrid](index.md) > Создание демонстрационного стенда > Создание стенда SpeechKit Hybrid

# Создание демонстрационного стенда SpeechKit Hybrid

SpeechKit Hybrid предоставляет возможности сервиса Yandex SpeechKit для [распознавания](stt/testing.md) и [синтеза](tts/testing.md) речи. Вы можете развернуть демонстрационный стенд SpeechKit Hybrid с помощью сервисов Yandex Cloud через Terraform. Так можно потестировать приложения распознавания и синтеза, размещаемые в [Docker-контейнерах](https://yandex.cloud/ru/blog/posts/2022/03/docker-containers).

Работа по созданию демонстрационного стенда ведется на двух машинах:

* Локальной. Ниже предполагается, что используется ОС Linux.
* Виртуальной, соответствует [системным требованиям](system-requirements.md) SpeechKit Hybrid. На этой ВМ запускаются Docker-контейнеры.

В демонстрационном стенде рассматривается модель лицензирования [Cloud Billing](pricing.md#billing), поэтому сведения о каждом запросе к сервису SpeechKit Hybrid [отправляются](architecture.md) в сервис Yandex Cloud Billing.

Чтобы развернуть демонстрационный стенд SpeechKit Hybrid:

1. [Начните работу с Yandex Cloud](#get-started).
1. [Установите дополнительные зависимости](#prepare).
1. [Подготовьте SSH-ключи](#ssh).
1. [Добавьте переменные для конфигурации Terraform](#variables).
1. [Создайте инфраструктуру с помощью Terraform](#create-infrastructure).
1. [Организуйте постоянный канал связи с сервером Yandex Cloud](#communication-channel).
1. [Проведите нагрузочное тестирование распознавания и синтеза речи](#stt-and-tts).

В случае ошибок воспользуйтесь [инструкцией по отладке](quickstart-debugging.md).

## Начните работу с Yandex Cloud {#get-started}

1. Зарегистрируйтесь в Yandex Cloud. Процесс регистрации различается для физических и юридических лиц:

   * [регистрация физических лиц](../getting-started/individuals/registration.md);
   * [регистрация юридических лиц](../getting-started/legal-entity/registration.md).

1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud.
1. Создайте каталог в консоли управления. В нем будут располагаться ваши ресурсы:

   1. В [консоли управления](https://console.yandex.cloud) на панели сверху нажмите ![image](../_assets/console-icons/layout-side-content-left.svg) или ![image](../_assets/console-icons/chevron-down.svg) и выберите нужное [облако](../resource-manager/concepts/resources-hierarchy.md#cloud).
   1. Справа от названия облака нажмите ![image](../_assets/console-icons/ellipsis.svg).
   1. Выберите ![image](../_assets/console-icons/plus.svg) **Создать каталог**.
   
      ![create-folder1](../_assets/resource-manager/create-folder-1.png)
   
   1. Введите имя [каталога](../resource-manager/concepts/resources-hierarchy.md#folder). Требования к имени:
   
       * длина — от 3 до 63 символов;
       * может содержать строчные буквы латинского алфавита, цифры и дефисы;
       * первый символ — буква, последний — не дефис.
   
   1. (Опционально) Введите описание каталога.
   1. Выберите опцию **Создать сеть по умолчанию**. Будет создана [сеть](../vpc/concepts/network.md#network) с подсетями в каждой зоне доступности. Также в этой сети будет создана [группа безопасности по умолчанию](../vpc/concepts/security-groups.md#default-security-group), внутри которой весь сетевой трафик разрешен.
   1. Нажмите кнопку **Создать**.
   
      ![create-folder2](../_assets/resource-manager/create-folder-2.png)

1. [Создайте сервисный аккаунт](../iam/operations/sa/create.md) `sk-hybrid-example`.

   Сервисный аккаунт позволяет гибко настраивать права доступа. Подробнее о сервисном аккаунте читайте в разделе [Сервисные аккаунты](../iam/concepts/users/service-accounts.md).

1. [Назначьте сервисному аккаунту роли](../iam/operations/sa/assign-role-for-sa.md):

   * `compute.editor` — чтобы создать ВМ Yandex Cloud;
   * `container-registry.images.puller` — чтобы работать с Docker-образами в реестре [Yandex Container Registry]({ link-docs }}/container-registry/);
   * `iam.serviceAccounts.keyAdmin` — чтобы создать [API-ключ](../iam/concepts/authorization/api-key.md) для аутентификации в Yandex Cloud Billing.

1. [Создайте API-ключ](../iam/operations/authentication/manage-api-keys.md#create-api-key).

   Сохраните идентификатор и секретную часть ключа. Их нельзя запросить позднее.

1. [Создайте реестр](../container-registry/operations/registry/registry-create.md) в Container Registry.
1. [Сообщите команде SpeechKit](https://center.yandex.cloud/support) идентификатор реестра. В вашем реестре появятся необходимые контейнеры и образы.

## Установите дополнительные зависимости {#prepare}

На локальной машине:

1. [Установите интерфейс командной строки](../cli/operations/install-cli.md) Yandex Cloud (CLI).
1. [Аутентифицируйте свой сервисный аккаунт](../cli/operations/authentication/service-account.md) через CLI.
1. [Установите Terraform](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

## Подготовьте репозиторий с конфигурацией Terraform {#repository}

На локальной машине:

1. Склонируйте [репозиторий с конфигурацией Terraform](https://github.com/yandex-cloud-examples/yc-speechkit-hybrid-deployment/), из которой будет развернута необходимая инфраструктура:

   ```bash
   git clone git@github.com:yandex-cloud-examples/yc-speechkit-hybrid-deployment.git
   ```

1. В терминале перейдите в директорию склонированного репозитория.

## Подготовьте SSH-ключи {#ssh}

SSH-ключи понадобятся для аутентификации при подключении к ВМ Yandex Cloud. Чтобы подготовить их, выполните следующие действия на локальной машине:

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

## Добавьте переменные для конфигурации Terraform {#variables}

В директории репозитория `yc-speechkit-hybrid-deployment` располагается файл `terraform.tfvars.template`. Он представляет собой Terraform-шаблон, по которому задаются переменные окружения. Эти переменные передаются CLI и Terraform во время выполнения команд.

Чтобы задать переменные для конфигурации Terraform, выполните следующие действия на локальной машине:

1. Создайте копию Terraform-шаблона в директории репозитория `yc-speechkit-hybrid-deployment`:

   ```bash
   cp ./terraform.tfvars.template ./terraform.tfvars
   ```

1. Укажите значения переменных в файле `terraform.tfvars`:

   * `CR_REGISTRY_ID` — идентификатор реестра Container Registry;
   * `BILLING_STATIC_API_KEY` — секретная часть API-ключа.

1. (Опционально) Добавьте переменную `NODES_GPU_INTERRUPTIBLE = false`.

   Конфигурация Terraform в репозитории предполагает создание [прерываемой ВМ](../compute/concepts/preemptible-vm.md). Вы можете отключить возможность прерывания с помощью переменной `NODES_GPU_INTERRUPTIBLE`. Ее значение по умолчанию — `true`, оно прописано в файле `variables.tf` в репозитории `yc-speechkit-hybrid-deployment`.

## Создайте инфраструктуру с помощью Terraform {#create-infrastructure}

Инфраструктура, необходимая для работы со SpeechKit Hybrid, описана в файлах `networks.tf` и `node-deploy.tf` в репозитории `yc-speechkit-hybrid-deployment`. Файл `networks.tf` содержит конфигурацию сущностей:

* сеть;
* подсеть;
* внутренняя зона DNS;
* группа безопасности.

Файл `node-deploy.tf` содержит конфигурацию ВМ и сервиса SpeechKit Hybrid.

Подробнее о конфигурации сущностей читайте на сайте [Terraform](../terraform/index.md) и в документации соответствующего сервиса Yandex Cloud.

Чтобы создать инфраструктуру, выполните следующие действия на локальной машине:

{% list tabs group=instructions %}

* Terraform {#tf}

   1. В терминале перейдите в директорию репозитория `yc-speechkit-hybrid-deployment`.
   1. [Получите данные для аутентификации](../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) сервисного аккаунта `sk-hybrid-example`. Вы можете добавить данные в переменные окружения или указать эти данные в файле `main.tf`, в блоке `provider "yandex"`.
   1. [Настройте и инициализируйте провайдеры Terraform](../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).

      В репозитории в качестве конфигурационного файла с настройками провайдеров используется файл `main.tf`, поэтому повторно создавать такой файл не нужно.

   1. Проверьте корректность файлов конфигурации Terraform с помощью команды:

      ```bash
      terraform validate
      ```

   1. Создайте инфраструктуру:

      1. Выполните команду для просмотра планируемых изменений:
      
         ```bash
         terraform plan
         ```
      
         Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
      
      1. Если вас устраивают планируемые изменения, внесите их:
         1. Выполните команду:
      
            ```bash
            terraform apply
            ```
      
         1. Подтвердите изменение ресурсов.
         1. Дождитесь завершения операции.

      В указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud).

{% endlist %}

## Организуйте постоянный канал связи с сервером Yandex Cloud {#communication-channel}

Для работы по модели лицензирования Cloud Billing обпеспечьте сетевую связность между узлом Yandex Cloud Billing `billing.datasphere.yandexcloud.net:443` и ВМ, на которой разворачивается сервис SpeechKit Hybrid. Чтобы проверить доступность узла:

1. На локальной машине получите публичный IP-адрес созданной ВМ:

   ```bash
   yc compute instance list
   ```

   Публичный адрес понадобится для подключения к ВМ.

   Пример результата:

   ```text
   +-----------+-------------------------------+---------------+---------+-------------+--------------+
   |     ID    |              NAME             |    ZONE ID    | STATUS  | EXTERNAL IP | INTERNAL IP  |
   +-----------+-------------------------------+---------------+---------+-------------+--------------+
   | fhmjvr*** | sk-hybrid-compose-example-*** | ru-central1-a | RUNNING | 158.160.*** | 192.168.***  |
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

Чтобы оценить корректность и производительность тестовой инсталляции SpeechKit Hybrid, используйте Docker-контейнеры с утилитой нагрузочного тестирования для распознавания и синтеза речи. Эти контейнеры описаны в файле `node-deploy.tf`, они были созданы вместе с [инфраструктурой](#create-infrastructure).

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
      cr.yandex/<идентификатор_реестра>/release/tools/stt-tools:0.20
   ```

   В команде укажите публичный IP-адрес ВМ и идентификатор созданного ранее реестра Container Registry.

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
      cr.yandex/<идентификатор_реестра>/release/tools/tts-tools:0.20
   ```

   В команде укажите публичный IP-адрес ВМ и идентификатор созданного ранее реестра Container Registry.

   Здесь:

   * `ENVOY_HOST` — IP-адрес сервиса синтеза;
   * `ENVOY_TTS_PORT` — порт сервиса синтеза (по умолчанию `9080`);
   * `RPS` — количество запросов синтеза в секунду.

1. Подождите несколько минут, пока проводятся распознавание и синтез речи.
1. Посмотрите результаты тестирования в логах контейнера:

   * `docker logs stt-tools` — для распознавания речи;
   * `docker logs tts-tools` — для синтеза речи.

   Пока в логах не появится строка `Load finished. Ready to serve requests on 0.0.0.0:17001`, сервисы распознавания и синтеза речи не будут отвечать на запросы. Ожидание может занять 2–10 минут.

   Далее в логах появится сообщение о том, что компонент [Envoy](architecture.md) начал прослушивать порт `8080` для распознавания речи и порт `9080` для синтеза речи. Это означает, что сервис SpeechKit Hybrid запущен и готов обслуживать клиентские запросы.

1. (Опционально) Остановите нагрузочное тестирование.

   Во время нагрузочного тестирования команды `docker run` не будут реагировать на сигналы прерывания **Ctrl** + **C**. Если вы хотите остановить работу контейнеров, выполните команду:

   * `docker stop stt-tools` — для распознавания речи;
   * `docker stop tts-tools` — для синтеза речи.