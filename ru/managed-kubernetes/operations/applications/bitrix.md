---
title: Установка Bitrix
description: Следуя данной инструкции, вы сможете установить приложение Битрикс в кластере Managed Service for Kubernetes.
---

# Установка Битрикс

**Битрикс** — приложение, которое выполняет подготовку и развертывание окружений для стандартной установки продуктов компании «1С-Битрикс» в кластере {{ managed-k8s-full-name }}.

Доступно два типа окружения:

* Административное окружение, которое предназначено:

   * для развертывания продуктов Битрикс с нуля или из резервной копии;
   * для внесения изменений в компоненты Битрикс с помощью административной панели продукта;
   * для тестирования и разработки.

   Административное окружение поддерживает:

   * клиент для работы с Git;
   * выполнение агентов в cron-задачах;
   * сервер очередей;
   * морфологический поиск Sphinx;
   * инструменты для сбора метрик PHP и Nginx.

   Окружение можно установить как из {{ marketplace-full-name }}, так и с помощью Helm-чарта.

   Вы можете использовать административное окружение для установки стабильных версий приложений Битрикс.

* Продуктовое окружение, которое поддерживает все возможности административного окружения, но не предназначено для внесения каких-либо изменений в компоненты Битрикс. В продуктовом окружении отсутствует административная панель.

  Вы можете запустить в продуктовом окружении несколько реплик `Deployment`, что дает отказоустойчивость.

  Для установки продуктового окружения вам потребуется подготовить образы на базе поставляемых с добавлением необходимых файлов Битрикс.

  Продуктовое окружение можно установить только с помощью Helm-чарта.

{% note info %}

Административное и продуктовое окружения совместно используют:

* базу данных {{ MY }};
* бакет {{ objstorage-name }}.

{% endnote %}

## Перед началом работы {#before-you-begin}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. Создайте в кластере {{ managed-k8s-name }} новое [пространство имен](../../concepts/index.md#namespace) `bitrix-space` для административного окружения и `bitrix-prod` для продуктового окружения.
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

1. [Создайте бакет](../../../storage/operations/buckets/create.md), в котором будут размещаться общие папки проекта `upload` и `backup`.
1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md) с [ролью](../../../iam/concepts/access-control/roles.md) `storage.editor` на каталог, в котором располагается бакет.
1. [Создайте статический ключ доступа](../../../iam/operations/authentication/manage-access-keys.md) для сервисного аккаунта и сохраните его идентификатор и секретный ключ.
1. [Создайте кластер {{ mmy-name }}](../../../managed-mysql/operations/cluster-create.md) с параметрами:

   * **Сеть** — выберите сеть, в которой располагается кластер {{ managed-k8s-name }}.
   * В блоке **Хосты** проверьте, что опция **Публичный доступ** выключена для всех хостов.
   * **{{ ui-key.yacloud.mdb.forms.section_settings }}**:
     * **Innodb Flush Log At Trx Commit** — `2`;
     * **Innodb Strict Mode** — `Выключено`;
     * **Sync Binlog** — `1000`;
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

   1. Сконфигурируйте [Docker Credential helper](../../../container-registry/operations/authentication.md#cred-helper). Он позволяет работать с приватными реестрами {{ yandex-cloud }}, не выполняя команду `docker login`.

      Для настройки Credential helper выполните команду:

      ```bash
      yc container registry configure-docker
      ```

1. {% include [check-sg-prerequsites](../../../_includes/managed-kubernetes/security-groups/check-sg-prerequsites-lvl3.md) %}

    {% include [sg-common-warning](../../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

## Установка с помощью {{ marketplace-name }} {#marketplace-install}

1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Нажмите на имя нужного [кластера {{ managed-k8s-name }}](../../concepts/index.md#kubernetes-cluster) и выберите вкладку ![image](../../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.
1. В разделе **{{ ui-key.yacloud.marketplace-v2.label_available-products }}** выберите [Битрикс](/marketplace/products/yc/bitrix) и нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
1. Задайте настройки приложения:
   * **Пространство имен** — выберите пространство имен, созданное ранее.
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

   * **Использовать cron для запуска агентов** — выберите опцию для запуска агентов Битрикс по расписанию, заданному в `ConfigMap` `<название_приложения>-bitrix-space-cron`. По умолчанию в `ConfigMap` настроено выполнение заданий агентов раз в минуту и резервное копирование проекта раз в сутки. Также вы можете добавить собственные расписания.
   * **Использовать сервер очередей** — выберите опцию для работы сервера очередей (модуль Битрикс Push and Pull). Ресурс `Deployment` для развертывания сервера запускается в отдельном поде.
   * **Секретный ключ** — если выбрана опция **Использовать сервер очередей**, укажите секретный ключ, созданный ранее.
   * **Использовать Sphinx** — выберите опцию для использования полнотекстового поиска Sphinx. Ресурс `Deployment` для развертывания Sphinx запускается в отдельном поде.
   * **Хранить кеш в Redis** — выберите опцию для хранения кеша Битрикс в Redis. В кластере будет развернут отдельный `StatefulSet` `<название_приложения>-redis-*` в пространстве имен приложения. Не рекомендуется включать в административном окружении, так как это может привести к деградации производительности.
   * **Экспортировать метрики PHP** — выберите опцию, чтобы включить метрики PHP.
   * **Экспортировать метрики NGINX** — выберите опцию, чтобы включить метрики NGINX.
   * **Класс хранилища для S3** — по умолчанию `csi-s3`.
   * **Идентификатор ключа S3**, **Секретный ключ S3** — укажите [полученные ранее](#before-you-begin) идентификатор и секретный ключ статического ключа.
   * **S3-бакет** — укажите имя [созданного ранее](#before-you-begin) бакета {{ objstorage-name }}.
   * **Размер папки upload** — укажите размер каталога для загрузок в бакете. Размер указывается в `Gi`.
   * **Размер папки backup** — укажите размер каталога для хранения резервных копий в бакете. Размер указывается в `Gi`.
   * **SMTP-сервер**, **SMTP-порт**, **Пользователь почтового ящика**, **Пароль от почтового ящика** — укажите параметры подключения к почтовому серверу.
   * **MySQL-хост**, **Пользователь БД**, **Пароль пользователя БД**, **База данных** — укажите параметры подключения к базе данных {{ MY }} в [созданном ранее](#before-you-begin) кластере {{ mmy-name }}.
   * **Версия NGINX** — выберите версию NGINX для Битрикс.
   * **Версия PHP** — выберите версию PHP для Битрикс.
   * **Использовать bitrixsetup.php** — выберите опцию для установки Битрикс с нуля.
   * **Использовать restore.php** — выберите опцию для восстановления Битрикс из резервной копии.

1. Нажмите кнопку **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Дождитесь перехода приложения в статус `Deployed`.
1. Откройте в браузере проект по указанному в настройках доменному имени и установите продукт Битрикс с помощью мастера установки.
1. Проверьте [средства работы с Git-репозиторием](#working-with-git).

## Установка с помощью Helm-чарта {#helm-install}

1. {% include [Установка Helm](../../../_includes/managed-kubernetes/helm-install.md) %}
1. {% include [Install and configure kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}
1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с административным окружением Битрикс выполните команду:

   ```bash
   helm pull oci://{{ mkt-k8s-key.yc_bitrix-env.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_bitrix-env.helmChart.tag }} \
     --untar && \
   helm install \
     --namespace bitrix-space \
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
     --set-json 'mysql={"host":"<FQDN_хоста_MySQL>","login":"<имя_пользователя_MySQL>","password":"<пароль_пользователя_MySQL>","database":"<имя_базы_данных_MySQL>"}' \
     --set certmanager.enabled=false \
     --set tls.existingSecret="<имя_секрета_с_сертификатом>" \
     --set features.cache=<использовать_кеш_Redis> .
     bitrix ./bitrix/
   ```

   При использовании certmanager для выпуска сертификата вместо параметров `tls.existingSecret` и `certmanager.enabled=false` укажите параметры:

   * `certmanager.issuer=<ресурс_Issuer_или_ClusterIssuer>`
   * `certmanager.email=<электронная_почта_для_уведомлений_от_Lets_Encrypt>`.

   {% include [Support OCI](../../../_includes/managed-kubernetes/note-helm-experimental-oci.md) %}

1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с продуктовым окружением Битрикс:
   1. Создайте в кластере новое [пространство имен](../../concepts/index.md#namespace) `bitrix-prod`.
   1. Создайте локально папку `bitrix` или, если ваш проект загружен в Git-репозиторий, скачайте репозиторий в эту папку:

       ```shell
       git clone <SSH_URL_репозитория> bitrix
       ```

   1. Подготовьте образ приложения Битрикс с PHP:

      1. Скачайте образ `bitrix-admin-php`:

         ```shell
         docker pull {{ mkt-k8s-key.yc_bitrix-env.dockerImages.php.repository.name }}:{{ mkt-k8s-key.yc_bitrix-env.dockerImages.php.repository.tag }}
         ```

      1. Установите тег в реестре, [созданном ранее](#before-you-begin):

         ```shell
         docker tag {{ mkt-k8s-key.yc_bitrix-env.dockerImages.php.repository.name }}:{{ mkt-k8s-key.yc_bitrix-env.dockerImages.php.repository.tag }} {{ registry }}/<идентификатор_реестра>/bitrix-env/bitrix/bitrix-admin-php
         ```

      1. Создайте в директории с папкой `bitrix` файл `Dockerfile-php` со следующим содержимым:

          ```text
          FROM {{ registry }}/<идентификатор_реестра>/bitrix-env/bitrix/bitrix-admin-php
          COPY --chown=bitrix:bitrix bitrix/ /home/bitrix/www
          WORKDIR /home/bitrix/www
          ```

      1. Соберите Docker-образ для установки продуктового окружения с помощью команды:

         ```shell
         docker build --platform linux/amd64 \
             -f Dockerfile-php \
             -t {{ registry }}/<идентификатор_реестра>/bitrix-prod-php \
             --no-cache .
         ```

      1. Отправьте полученный образ в реестр с помощью команды:

         ```shell
         docker push {{ registry }}/<идентификатор_реестра>/bitrix-prod-php
         ```

   1. Аналогично выполненным шагам из п. 2, подготовьте образ Битрикс с NGINX `bitrix-prod-nginx` на основе базового образа `{{ mkt-k8s-key.yc_bitrix-env.dockerImages.nginx.repository.name }}:{{ mkt-k8s-key.yc_bitrix-env.dockerImages.nginx.repository.tag }}`.

   1. Выполните установку Helm-чарта:

       ```bash
       helm pull oci://{{ mkt-k8s-key.yc_bitrix-env.helmChart.name }} \
         --version {{ mkt-k8s-key.yc_bitrix-env.helmChart.tag }} \
         --untar && \
       helm install \
         --namespace bitrix-prod \
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
         --set mysql.host="<FQDN_хоста_MySQL>" \
         --set mysql.login="<имя_пользователя_MySQL>" \
         --set mysql.password="<пароль_пользователя_MySQL>" \
         --set mysql.database="<имя_базы_данных_MySQL>" \
         --set php.image="{{ registry }}/<идентификатор_реестра>/bitrix-prod-php" \
         --set nginx.image="{{ registry }}/<идентификатор_реестра>/bitrix-prod-nginx" \
         --set certmanager.enabled=false \
         --set tls.existingSecret="<имя_секрета_с_сертификатом>" \
         bitrix ./bitrix/
       ```

       При использовании certmanager для выпуска сертификата вместо параметров `tls.existingSecret` и `certmanager.enabled=false` укажите параметры:

       * `certmanager.issuer="<ресурс_Issuer_или_ClusterIssuer>"`
       * `certmanager.email="<электронная_почта_для_уведомлений_от_Lets_Encrypt>"`.

       {% include [Support OCI](../../../_includes/managed-kubernetes/note-helm-experimental-oci.md) %}

## Работа с репозиторием Git {#working-with-git}

Работа с репозиторием возможна только в административном окружении.

1. Подключитесь к контейнеру пода в административном окружении:

   ```shell
   kubectl -n bitrix-space exec \
     <имя_пода_bitrix_main> \
     -c git -it -- \
     sh /home/bitrix/www $
   ```

1. В контейнере доступны команды `git`, а также вспомогательный скрипт `/scripts/commit-all.sh` для загрузки изменений из папки `bitrix` в настроенный ранее репозиторий. Для использования выполните команду:

   ```shell
   /scripts/commit-all.sh <описание commit>
   ```

## См. также {#see-also}

* [Контейнерное окружение для Битрикс](https://github.com/bitrix-tools/env-docker)
* [1С-Битрикс: Управление сайтом](https://dev.1c-bitrix.ru/docs/php.php#tab-admins-link)
* [1С-Битрикс24](https://helpdesk.bitrix24.ru/)
* [Отраслевые решения 1С-Битрикс](https://dev.1c-bitrix.ru/docs/solutions.php)