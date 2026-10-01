---
title: Установка Bitrix
description: Следуя данной инструкции, вы сможете установить приложение Битрикс в кластере Managed Service for Kubernetes.
---

# Установка Битрикс

**Битрикс** — приложение, которое выполняет подготовку и развертывание окружений для стандартной установки продуктов компании «1С-Битрикс» в кластере {{ managed-k8s-full-name }}.

Доступны два типа окружения — административное и продуктовое.

#### Административное окружение {#admin-environment}

Административное окружение предназначено для следующих задач:

* развертывание продуктов Битрикс с нуля или из резервной копии;
* внесение изменений в компоненты Битрикс через административную панель продукта;
* тестирование и разработка.

Окружение также подходит для установки стабильных версий приложений Битрикс.

Административное окружение поддерживает:

* клиент для работы с Git;
* выполнение агентов в cron-задачах;
* сервер очередей;
* морфологический поиск Sphinx;
* инструменты для сбора метрик PHP и Nginx.

Установить административное окружение можно из {{ marketplace-full-name }} или с помощью Helm-чарта.

#### Продуктовое окружение {#prod-environment}

Продуктовое окружение предназначено для отказоустойчивого и высокодоступного развертывания Битрикс. Оно поддерживает возможности административного окружения, кроме административной панели, и не предназначено для внесения изменений в компоненты Битрикс.

Установить продуктовое окружение можно только с помощью Helm-чарта. Перед установкой подготовьте собственные образы на базе поставляемых, добавив в них необходимые файлы Битрикс.

{% note info %}

Административное и продуктовое окружения совместно используют:

* базу данных {{ MY }};
* бакет {{ objstorage-name }}.

{% endnote %}

## Перед началом работы {#before-you-begin}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. Создайте в кластере {{ managed-k8s-name }} новые [пространства имен](../../concepts/index.md#namespace) для административного и продуктового окружения, например `bitrix-admin` и `bitrix-prod`.
1. Если вы хотите выпустить сертификат Let's Encrypt для сайта Битрикс с помощью [cert-manager](https://cert-manager.io/), установите приложение cert-manager c плагином {{ dns-full-name }} ACME webhook [по инструкции](cert-manager-cloud-dns.md).
1. Если вы хотите использовать собственный сертификат для сайта Битрикс, создайте в пространствах имен для обоих окружений ресурс `Secret` вида:

    ```yaml
    apiVersion: v1
    kind: Secret
    metadata:
      name: bitrix-tls-secret
      namespace: <пространство_имен>
    type: kubernetes.io/tls
    data:
      tls.crt: <Base64_encoded_сертификат>
      tls.key: <Base64_encoded_приватный_ключ_сертификата>
    ```

1. [Установите приложение csi-s3](./csi-s3.md). Это необходимо, так как {{ objstorage-name }} используется для хранения общих данных.
1. [Создайте бакет](../../../storage/operations/buckets/create.md), в котором будут размещаться общие папки проекта `upload` и `backup`.
1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md) с [ролью](../../../iam/concepts/access-control/roles.md) `storage.editor` на каталог, в котором располагается бакет.
1. [Создайте статический ключ доступа](../../../iam/operations/authentication/manage-access-keys.md) для сервисного аккаунта и сохраните его идентификатор и секретный ключ.
1. [Создайте кластер {{ mmy-name }}](../../../managed-mysql/operations/cluster-create.md) с параметрами:

   * **Сеть** — выберите сеть, в которой располагается кластер {{ managed-k8s-name }}.
   * В блоке **Хосты** проверьте, что опция **Публичный доступ** выключена для всех хостов.
   * **{{ ui-key.yacloud.mdb.forms.section_settings }}**:
     * **Innodb Flush Log At Trx Commit** — `2`;
     * **Innodb Strict Mode** — `Выключено`;
     * **Join Buffer Size** — `2621440`;
     * **Sort Buffer Size** — `2621440`;
     * **Sync Binlog** — `0`;
     * **Transaction Isolation** — `read committed`.

1. Если вы хотите использовать сервер очередей (модуль Битрикс Push and Pull), создайте секретный ключ для него:

    ```shell
    docker container run --rm \
        --name push_server_key_generate alpine:3.21 \
        sh -c "(cat /dev/urandom | tr -dc A-Za-z0-9 | head -c 128) && echo ''"
    ```

    Сохраните результат выполнения команды.

1. Если вы планируете использовать продуктовое окружение, подготовьте ресурсы {{ container-registry-name }} для загрузки необходимых Docker-образов:

   1. Создайте реестр контейнеров:

      ```bash
      yc container registry create --name yc-auto-cr
      ```

   1. Сконфигурируйте [Docker credential helper](../../../container-registry/operations/authentication.md#cred-helper). Он позволяет работать с приватными реестрами {{ yandex-cloud }}, не выполняя команду `docker login`.

      Для настройки credential helper выполните команду:

      ```bash
      yc container registry configure-docker
      ```

1. {% include [check-sg-prerequsites](../../../_includes/managed-kubernetes/security-groups/check-sg-prerequsites-lvl3.md) %}

    {% include [sg-common-warning](../../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

## Установка с помощью {{ marketplace-name }} {#marketplace-install}

1. В [консоли управления]({{ link-console-main }}) выберите каталог.
1. [Перейдите]({{ link-console-main }}/link/managed-kubernetes) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Выберите [кластер {{ managed-k8s-name }}](../../concepts/index.md#kubernetes-cluster).
1. Нажмите на вкладку **{{ ui-key.yacloud.shared.layout.PageTabs.button_other_hnYwF }}** ![chevron-down](../../../_assets/console-icons/chevron-down.svg) и выберите **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.
1. В разделе **{{ ui-key.yacloud.marketplace-v2.label_available-products }}** выберите [Битрикс](/marketplace/products/yc/bitrix-env) и нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
1. Задайте настройки приложения:
   * **Пространство имен** — выберите пространство имен для административного окружения, созданное ранее.
   * **Название приложения** — укажите название приложения.
   * **Размер тома** — укажите размер [тома](../../concepts/volume.md) для хранения файлов Битрикс. Размер указывается в `Gi`.
   * **Класс хранилища** — выберите класс хранилища для тома.
   * **Доменное имя проекта** — укажите полное доменное имя проекта.
   * **IP-адрес балансировщика** — укажите IP-адрес балансировщика, если вы уже его зарезервировали.
   * **Политика управления трафиком** — выберите [политику маршрутизации внешнего трафика]({{ k8s-api-link }}#servicespec-v1-core).
   * **Использовать certmanager** — выберите опцию, чтобы автоматически получить сертификат от издателя Let's Encrypt.

     Для успешного получения сертификата [зарегистрируйте публичную доменную зону](../../../dns/operations/zone-create-public.md) и делегируйте домен. Для домена в этой зоне будет выдан сертификат с прохождением проверки DNS-01.

   * **Электронная почта для получения уведомлений от Let's Encrypt** – если выбрана опция **Использовать certmanager**, укажите адрес электронной почты для получения уведомлений от издателя Let's Encrypt.
   * **Имя издателя** — если выбрана опция **Использовать certmanager**, укажите имя ресурса `ClusterIssuer` или `Issuer`, который будет использоваться для автоматического получения SSL/TLS-сертификатов.
   * **Секрет, содержащий tls.crt и tls.key** — если certmanager не используется, укажите имя секрета, созданного ранее.
   * **Настроить git** — выберите опцию для работы с Git-репозиторием.

     В этом случае укажите параметры Git-репозитория в полях:

     * **Адрес git-репозитория** — адрес репозитория в формате протокола SSH.
     * **Ветка** — рабочая ветка Git-репозитория.
     * **Пользователь** — имя пользователя Git-репозитория.
     * **Электронная почта** — электронная почта пользователя Git-репозитория.
     * **Ключ доступа** — укажите Base64-закодированное содержимое публичного ключа доступа к репозиторию.

   * **Использовать cron для запуска агентов** — выберите опцию для запуска агентов Битрикс по расписанию, заданному в `ConfigMap` `<название_приложения>-<пространство_имен_административного_окружения>-cron`. По умолчанию в `ConfigMap` настроено выполнение заданий агентов раз в минуту и резервное копирование проекта раз в сутки. Также вы можете добавить собственные расписания.
   * **Использовать сервер очередей** — выберите опцию для работы сервера очередей (модуль Битрикс Push and Pull). Ресурс `Deployment` для развертывания сервера запускается в отдельном поде.
   * **Секретный ключ** — если выбрана опция **Использовать сервер очередей**, укажите секретный ключ, созданный ранее.
   * **Использовать Sphinx** — выберите опцию для использования полнотекстового поиска Sphinx. Ресурс `Deployment` для развертывания Sphinx запускается в отдельном поде.
   * **Использовать встроенный Redis** — оставьте опцию включенной, чтобы развернуть Redis вместе с приложением. В этом случае поля **Хост внешнего Redis** и **Пароль Redis** должны оставаться пустыми.

     Для подключения к отдельно развернутому Redis отключите эту опцию и задайте параметры:

     * **Хост внешнего Redis** — укажите адрес сервера, доступного из приложения. Обязательный параметр.
     * **Порт внешнего Redis** — укажите порт подключения. По умолчанию — `6379`.
     * **Пароль Redis** — укажите пароль для подключения. Оставьте поле пустым, если сервер не требует пароль.

     Redis используется для хранения сессий независимо от опции **Хранить кеш в Redis**. При отключении встроенного Redis подключение к внешнему обязательно.

   * **Хранить кеш в Redis** — выберите опцию для хранения кеша Битрикс в Redis. Не рекомендуется включать в административном окружении.
   * **Экспортировать метрики PHP** — выберите опцию, чтобы включить метрики PHP.
   * **Экспортировать метрики NGINX** — выберите опцию, чтобы включить метрики NGINX.
   * **Класс хранилища для S3** — по умолчанию `csi-s3`.
   * **Идентификатор ключа S3**, **Секретный ключ S3** — укажите [полученные ранее](#before-you-begin) идентификатор и секретный ключ статического ключа.
   * **S3-бакет** — укажите имя [созданного ранее](#before-you-begin) бакета {{ objstorage-name }}.
   * **SMTP-сервер**, **SMTP-порт**, **Пользователь почтового ящика**, **Пароль от почтового ящика** — укажите параметры подключения к почтовому серверу.
   * **Версия PHP** — укажите версию PHP для Битрикс. Доступные версии: `8.2.33`, `8.3.33`, `8.4.25`, `8.5.10`.
   * **Использовать bitrixsetup.php** — выберите опцию для установки Битрикс с нуля.
   * **Использовать restore.php** — выберите опцию для восстановления Битрикс из резервной копии.

1. Нажмите кнопку **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Дождитесь перехода приложения в статус `Deployed`.
1. Откройте в браузере проект по указанному в настройках доменному имени и установите продукт Битрикс с помощью мастера установки. На этапе настройки базы данных укажите адрес хоста, имя базы данных, логин и пароль пользователя в [созданном ранее](#before-you-begin) кластере {{ mmy-name }}.
1. Проверьте [средства работы с Git-репозиторием](#working-with-git).

## Установка с помощью Helm-чарта {#helm-install}

1. {% include [Установка Helm](../../../_includes/managed-kubernetes/helm-install.md) %}

   Дополнительные параметры чарта и доступные теги образов перечислены в файле `values.yaml`. Чтобы вывести его содержимое, выполните команду:

   ```bash
   helm show values oci://{{ mkt-k8s-key.yc_bitrix-env.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_bitrix-env.helmChart.tag }}
   ```

1. {% include [Install and configure kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}
1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с административным окружением Битрикс выполните команду:

   ```bash
   helm pull oci://{{ mkt-k8s-key.yc_bitrix-env.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_bitrix-env.helmChart.tag }} \
     --untar && \
   helm install \
     --namespace <пространство_имен_административного_окружения> \
     --set volumeSize="<размер_тома_Битрикс>" \
     --set fqdn="<доменное_имя_сайта_Битрикс>" \
     --set loadBalancerIP="<IP-адрес_балансировщика>" \
     --set features.cron=<использовать_cron_для_запуска_агентов> \
     --set features.push=<использовать_сервер_очередей> \
     --set features.sphinx=<использовать_поиск_Sphinx> \
     --set features.phpExporter=<экспортировать_метрики_PHP> \
     --set features.nginxExporter=<экспортировать_метрики_NGINX> \
     --set features.git=<использовать_Git> \
     --set git.repoUrl="<SSH_URL_репозитория>" \
     --set git.name="<имя_пользователя_Git>" \
     --set git.email="<электронная_почта_пользователя_Git>" \
     --set git.secret="<Base64_ключ_доступа_пользователя_Git>" \
     --set s3.secret.accessKey="<идентификатор_ключа_бакета>" \
     --set s3.secret.secretKey="<секретный_ключ_бакета>" \
     --set s3.bucket="<имя_бакета>" \
     --set msmtprc.host="<FQDN_почтового_сервера>" \
     --set msmtprc.port="<порт_почтового_сервера>" \
     --set msmtprc.user="<имя_пользователя_почтового_сервера>" \
     --set msmtprc.password="<пароль_пользователя_почтового_сервера>" \
     --set push.key="<секретный_ключ_Push_сервера_Битрикс>" \
     --set certmanager.enabled=false \
     --set tls.existingSecret="<имя_секрета_с_сертификатом>" \
     bitrix ./bitrix-env/
   ```

   При использовании certmanager для выпуска сертификата вместо параметров `tls.existingSecret` и `certmanager.enabled=false` укажите параметры:

   * `certmanager.issuer=<ресурс_Issuer_или_ClusterIssuer>`
   * `certmanager.email=<электронная_почта_для_уведомлений_от_Lets_Encrypt>`.

   {% include [Support OCI](../../../_includes/managed-kubernetes/note-helm-experimental-oci.md) %}

   После развертывания административного окружения откройте проект по указанному доменному имени и установите продукт Битрикс с помощью мастера установки. На этапе настройки базы данных укажите параметры подключения к [созданному ранее](#before-you-begin) кластеру {{ mmy-name }}.

1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с продуктовым окружением Битрикс:
   1. Если ваш проект загружен в Git-репозиторий, скачайте репозиторий в папку `bitrix`:

       ```shell
       git clone <SSH_URL_репозитория> bitrix
       ```

   1. Подготовьте образ приложения Битрикс с PHP. Используйте один и тот же тег `<версия_php>` на всех этапах: чарт определяет по нему путь к конфигурации PHP. Тег должен содержать полную версию в формате `MAJOR.MINOR.PATCH`, например `8.5.10`.

      1. Скачайте образ `bitrix-admin-php`:

         ```shell
         docker pull {{ mkt-k8s-key.yc_bitrix-env.dockerImages.php.repository.name }}:<версия_php>
         ```

      1. Установите тег в реестре, [созданном ранее](#before-you-begin):

         ```shell
         docker tag {{ mkt-k8s-key.yc_bitrix-env.dockerImages.php.repository.name }}:<версия_php> {{ registry }}/<идентификатор_реестра>/bitrix-env/bitrix/bitrix-admin-php:<версия_php>
         ```

      1. Создайте в директории с папкой `bitrix` файл `Dockerfile` со следующим содержимым:

          ```text
          FROM {{ registry }}/<идентификатор_реестра>/bitrix-env/bitrix/bitrix-admin-php:<версия_php>
          COPY --chown=bitrix:bitrix bitrix/ /home/bitrix/www
          WORKDIR /home/bitrix/www
          ```

      1. Соберите Docker-образ для установки продуктового окружения с помощью команды:

         ```shell
         docker build --platform linux/amd64 \
             -t {{ registry }}/<идентификатор_реестра>/bitrix-prod-php:<версия_php> \
             --no-cache .
         ```

      1. Отправьте полученный образ в реестр с помощью команды:

         ```shell
         docker push {{ registry }}/<идентификатор_реестра>/bitrix-prod-php:<версия_php>
         ```

   1. Аналогично выполненным шагам из п. 2, подготовьте образ Битрикс с NGINX `bitrix-prod-nginx` на основе базового образа `{{ mkt-k8s-key.yc_bitrix-env.dockerImages.nginx.repository.name }}:<версия_nginx>`.

   1. Подготовьте файл `.settings.php` с настройками установленного продукта Битрикс. Например, экспортируйте его из контейнера `php` пода Deployment `<имя_релиза>-<пространство_имен_административного_окружения>-main`:

      ```bash
      kubectl exec \
        --namespace <пространство_имен_административного_окружения> \
        deploy/<имя_релиза>-<пространство_имен_административного_окружения>-main \
        -c php -- cat /home/bitrix/www/bitrix/.settings.php > settings.php
      ```

   1. Создайте Secret `bitrix-user-settings` с ключом `.settings.php` в пространстве имен продуктового окружения, созданном ранее:

      ```bash
      kubectl create secret generic bitrix-user-settings \
        --namespace <пространство_имен_продуктового_окружения> \
        --from-file=.settings.php=./settings.php
      ```

   1. Выполните установку Helm-чарта:

       ```bash
       helm pull oci://{{ mkt-k8s-key.yc_bitrix-env.helmChart.name }} \
         --version {{ mkt-k8s-key.yc_bitrix-env.helmChart.tag }} \
         --untar && \
       helm install \
         --namespace <пространство_имен_продуктового_окружения> \
         --set environment=prod \
         --set replicaCount=<количество_реплик_подов_Битрикс> \
         --set fqdn="<доменное_имя_сайта_Битрикс>" \
         --set loadBalancerIP="<IP-адрес_балансировщика>" \
         --set features.cron=<использовать_cron_для_запуска_агентов> \
         --set features.push=<использовать_сервер_очередей> \
         --set features.sphinx=<использовать_поиск_Sphinx> \
         --set features.phpExporter=<экспортировать_метрики_PHP> \
         --set features.nginxExporter=<экспортировать_метрики_NGINX> \
         --set s3.secret.accessKey="<идентификатор_ключа_бакета>" \
         --set s3.secret.secretKey="<секретный_ключ_бакета>" \
         --set s3.bucket="<имя_бакета>" \
         --set msmtprc.host="<FQDN_почтового_сервера>" \
         --set msmtprc.port="<порт_почтового_сервера>" \
         --set msmtprc.user="<имя_пользователя_почтового_сервера>" \
         --set msmtprc.password="<пароль_пользователя_почтового_сервера>" \
         --set push.key="<секретный_ключ_Push_сервера_Битрикс>" \
         --set settings.existingSecret="bitrix-user-settings" \
         --set php.image="{{ registry }}/<идентификатор_реестра>/bitrix-prod-php:<версия_php>" \
         --set nginx.image="{{ registry }}/<идентификатор_реестра>/bitrix-prod-nginx:<версия_nginx>" \
         --set certmanager.enabled=false \
         --set tls.existingSecret="<имя_секрета_с_сертификатом>" \
         bitrix ./bitrix-env/
       ```

       При использовании certmanager для выпуска сертификата вместо параметров `tls.existingSecret` и `certmanager.enabled=false` укажите параметры:

       * `certmanager.issuer="<ресурс_Issuer_или_ClusterIssuer>"`
       * `certmanager.email="<электронная_почта_для_уведомлений_от_Lets_Encrypt>"`.

       {% include [Support OCI](../../../_includes/managed-kubernetes/note-helm-experimental-oci.md) %}

## Работа с репозиторием Git {#working-with-git}

Работа с репозиторием возможна только в административном окружении.

1. Подключитесь к контейнеру пода в административном окружении:

   ```shell
   kubectl -n <пространство_имен_административного_окружения> exec \
     <имя_пода_bitrix_main> \
     -c git -it -- sh
   ```

1. В контейнере доступны команды `git`, а также вспомогательный скрипт `/scripts/commit-all.sh` для загрузки изменений из папки `bitrix` в настроенный ранее репозиторий. Для использования выполните команду:

   ```shell
   /scripts/commit-all.sh <описание commit>
   ```

#### Полезные ссылки {#see-also}

* [1С-Битрикс: Веб-окружение](https://dev.1c-bitrix.ru/learning/course/index.php?COURSE_ID=32&LESSON_ID=29234&LESSON_PATH=3903.4862.29228.29234)
* [Контейнерное окружение для Битрикс](https://github.com/bitrix-tools/env-docker)
