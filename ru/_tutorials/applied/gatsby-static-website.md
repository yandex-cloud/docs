---
title: "Хостинг статического сайта на фреймворке Gatsby"
description: "Создание и размещение статического веб-сайта на фреймворке Gatsby в {{ yandex-cloud }}"
keywords:
  - gatsby
  - хостинг сайта gatsby
  - настройка сайта gatsby
  - gatsby сайт
---

# Хостинг статического сайта на фреймворке Gatsby в {{ objstorage-full-name }} 

С помощью этого руководства вы разместите свой статический сайт, созданный на фреймворке [Gatsby](https://www.gatsbyjs.com/docs), в сервисе {{ objstorage-name }} и настроите доступ к нему по HTTPS-протоколу. 

Чтобы создать и разместить статический сайт в {{ objstorage-name }}:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Зарегистрируйте доменное имя](#register-domain).
1. [Создайте сайт локально](#create-local-site).
1. [Создайте и настройте бакет {{ objstorage-name }}](#create-bucket).
1. [Загрузите сайт в бакет](#upload-site).
1. [Настройте доступ по HTTPS-протоколу](#configure-https).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит плата за хранение данных в {{ objstorage-name }}, операции с ними и исходящий трафик (см. [тарифы {{ objstorage-name }}](../../storage/pricing.md)).

## Зарегистрируйте доменное имя {#register-domain}

1. В личном кабинете вашего регистратора зарегистрируйте доменное имя, например `gatsbytest.ru`.
1. Чтобы получить доступ к именам из публичной зоны, делегируйте домен. Для этого в настройках домена укажите адреса DNS-серверов `ns1.{{ dns-ns-host-sld }}` и `ns2.{{ dns-ns-host-sld }}`.

	Делегирование происходит не сразу. Серверы интернет-провайдеров обновляют записи до 24 часов. 
	Проверить делегирование домена можно с помощью [сервиса Whois](https://www.reg.ru/whois/check_site) или утилиты `dig`:

	```bash
	dig +short NS gatsbytest.ru
	```

	Результат:

	```
	ns2.{{ dns-ns-host-sld }}.
	ns1.{{ dns-ns-host-sld }}.
	```

## Создайте сайт локально {#create-local-site}

Для целей тестирования создайте на локальном компьютере сайт, используя шаблон из библиотеки [Gatsby Starter Library](https://www.gatsbyjs.com/starters/).

1. Чтобы создать сайт, выполните команды:

	```
	npm install -g gatsby-cli
	gatsby new my-gatsby-project https://github.com/gatsbyjs/gatsby-starter-blog
	cd gatsby-starter-blog
	```

1. Проверьте, что сайт создан. Для этого выполните команду:

	```
	gatsby develop 
	```

	Дождитесь выполнения команды и убедитесь, что сайт доступен по адресу: 

	```
	http://localhost:8000
	```

## Создайте и настройте бакет {{ objstorage-name }} {#create-bucket}

### Создайте бакет

Чтобы разместить статический сайт в облаке, создайте бакет:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать [бакет](../../storage/concepts/bucket.md).
  1. Выберите сервис **{{ objstorage-name }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.storage.buckets.button_empty-create }}**.
  1. На странице создания бакета:
      1. В качестве имени бакета укажите зарегистрированное вами доменное имя, например `gatsbytest.ru`.
      1. Для целей тестирования укажите минимальный размер бакета.
      1. Выберите тип [доступа](../../storage/concepts/bucket.md#bucket-access) **Публичный** для всех операций.
      1. Нажмите кнопку **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  1. Создайте бакет в каталоге по умолчанию:

      ```bash
      yc storage bucket create \
         --name <имя_бакета> \
         --default-storage-class <класс_хранилища> \
         --max-size <максимальный_размер_бакета> \
         --public-read \
         --public-list \
         --public-config-read
      ```

      Где:

      * `--name` — имя бакета. Укажите зарегистрированное вами доменное имя, например `gatsbytest.ru`.        
      * `--default-storage-class` — [класс хранилища](../../storage/concepts/storage-class.md). Доступные значения:
         * `standard` — стандартное хранилище;
         * `cold` — холодное хранилище;
         * `ice` — ледяное хранилище.
      * `--max-size` — максимальный размер бакета в байтах. `0` — без ограничений.
      * `--public-read` — флаг для включения публичного доступа на чтение объектов в бакете.
      * `--public-list` — флаг для включения публичного доступа на просмотр списка объектов в бакете.
      * `--public-config-read` — флаг для включения публичного доступа на чтение настроек в бакете.

- AWS CLI {#aws-cli}

   Если у вас еще нет интерфейса командной строки AWS CLI, [установите и сконфигурируйте его](../../storage/tools/aws-cli.md).
    
   В терминале выполните команду, указав имя бакета и эндпоинт {{ objstorage-name }}:

   ```bash
   aws --endpoint-url=https://{{ s3-storage-host }} \
      s3 mb s3://<имя_бакета>
   ```
   Где:

   * `--name` — имя бакета. Укажите зарегистрированное вами доменное имя, например `gatsbytest.ru`.        

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:
     
     ```
     terraform {
       required_providers {
         yandex = {
           source = "yandex-cloud/yandex"
         }
       }
       required_version = ">= 0.13"
     }

     provider "yandex" {
       token     = "<IAM-_или_OAuth-токен>"
       cloud_id  = "<идентификатор_облака>"
       folder_id = "<идентификатор_каталога>"
       zone      = "{{ region-id }}-a"
     }

     resource "yandex_iam_service_account" "sa" {
       name = "<имя_сервисного_аккаунта>"
     }

     // Назначение роли сервисному аккаунту
     resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
       folder_id = "<идентификатор_каталога>"
       role      = "storage.editor"
       member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
     }

     // Создание статического ключа доступа
     resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
       service_account_id = yandex_iam_service_account.sa.id
       description        = "static access key for object storage"
     }

     // Создание бакета с использованием ключа
     resource "yandex_storage_bucket" "test" {
       access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
       secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
       bucket     = "<имя_бакета>"
     }
     ```

     Где:

     * `yandex_iam_service_account` — описание сервисного аккаунта, который создаст бакет и будет работать с ним:
       * `name` — имя сервисного аккаунта.
     * `yandex_storage_bucket` — описание бакета:
       * `bucket` — имя бакета. Укажите зарегистрированное вами доменное имя, например `gatsbytest.ru`.


  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:
        ```
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Разверните облачные ресурсы.

     1. Выполните команду:
        ```
        terraform apply
        ```

     1. Подтвердите создание ресурсов.

     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

- API {#api}

  Чтобы создать бакет, воспользуйтесь методом REST API [create](../../storage/api-ref/Bucket/create.md) для ресурса [Bucket](../../storage/api-ref/Bucket/index.md), вызовом gRPC API [BucketService/Create](../../storage/api-ref/grpc/bucket_service.md#Create) или методом S3 API [create](../../storage/s3/api-ref/bucket/create.md).

{% endlist %}

### Настройте бакет

Чтобы настроить бакет на хостинг статического сайта:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в бакет, для которого хотите настроить хостинг.
  1. Перейдите на вкладку ![website](../../_assets/console-icons/globe.svg) **{{ ui-key.yacloud.storage.bucket.switch_website }}**.
  1. В разделе **{{ ui-key.yacloud.storage.bucket.website.switch_hosting }}**:
      * в поле **{{ ui-key.yacloud.storage.bucket.website.field_index }}** укажите абсолютный путь к файлу главной страницы сайта. Для сайта из шаблона Gatsby укажите `index.html`;
      * при желании в поле **{{ ui-key.yacloud.storage.bucket.website.field_error }}** укажите абсолютный путь к файлу, который будет отображаться при ошибках 4хх. Для сайта из шаблона Gatsby укажите `404.html`.
  1. Нажмите кнопку **{{ ui-key.yacloud.storage.bucket.website.button_save }}**.

- {{ yandex-cloud }} CLI {#cli}
     
  1. Создайте файл с настройками хостинга в формате JSON. Например:
     
     ```json
     {
       "index": "index.html",
       "error": "404.html"
     }
     ```

     Где:

     * `index` — абсолютный путь к файлу главной страницы сайта. 
     * `error` — абсолютный путь к файлу, который будет отображаться пользователю при ошибках 4хх.
  
  1. Выполните следующую команду:

     ```bash
     yc storage bucket update --name <имя_бакета> \
       --website-settings-from-file <путь_к_файлу>
     ```
     
     Где:
     * `--name` — имя бакета, в данном примере `gatsbytest.ru`.
     * `--website-settings-from-file` — путь к файлу с настройками хостинга.

  Чтобы убедиться, что настройки хостинга появились в описании бакета, выполните команду:

  ```bash
  yc storage --name <имя_бакета> bucket get --full
  ```

  Результат:

  ```text
  website_settings:
    index: index.html
    error: error404.html
    redirect_all_requests: {}
  ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Перед началом работы, получите [статические ключи доступа](../../iam/operations/sa/create-access-key.md) — секретный ключ и идентификатор ключа, используемые для аутентификации в {{ objstorage-short-name }}.


  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     
     ```hcl
     provider "yandex" {
       token     = "<OAuth>"
       cloud_id  = "<идентификатор_облака>"
       folder_id = "<идентификатор_каталога>"
       zone      = "{{ region-id }}-a"
     }

     resource "yandex_storage_bucket" "test" {
       access_key = "<идентификатор_статического_ключа>"
       secret_key = "<секретный_ключ>"
       bucket     = "<имя_бакета>"
       acl        = "public-read"
     
       website {
         index_document = "index.html"
         error_document = "404.html"
       }
     
     }
     ```

     Где:

     * `access_key` — идентификатор статического ключа доступа.
     * `secret_key` — значение секретного ключа доступа.
     * `bucket` — имя бакета.
     * `acl` — параметры управления доступом [ACL](../../storage/concepts/acl.md#predefined-acls).
     * `website` — параметры веб-сайта:
       * `index_document` — абсолютный путь к файлу главной страницы сайта. Обязательный параметр.
       * `error_document` — абсолютный путь к файлу, который будет отображаться пользователю при ошибках `4хх`. Необязательный параметр.

  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет. 

  1. Разверните облачные ресурсы.

     1. Выполните команду:

     ```
     terraform apply
     ```
   
     1. Подтвердите создание ресурсов.

     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

- API {#api}

  Чтобы настроить хостинг статического сайта, воспользуйтесь методом REST API [update](../../storage/api-ref/Bucket/update.md) для ресурса [Bucket](../../storage/api-ref/Bucket/index.md), вызовом gRPC API [BucketService/Update](../../storage/api-ref/grpc/bucket_service.md#Update) или методом S3 API [upload](../../storage/s3/api-ref/hosting/upload.md).

{% endlist %} 

### Привяжите доменное имя

Создайте на [DNS-сервере](../../glossary/dns.md#dns-server) публичную [зону DNS](../../dns/concepts/dns-zone.md) и [ресурсную запись](../../dns/concepts/resource-record.md), которая связывает ваше доменное имя и бакет:

{% list tabs group=instructions %}

- {{ dns-full-name }} {#dns}

   1. В [консоли управления]({{ link-console-main }}) перейдите в бакет, для которого хотите использовать собственный домен.
   1. Перейдите на вкладку ![website](../../_assets/console-icons/globe.svg) **{{ ui-key.yacloud.storage.bucket.switch_website }}**.
   1. В разделе **{{ ui-key.yacloud.storage.bucket.website.switch_hosting }}** в блоке **{{ ui-key.yacloud.storage.bucket.website.title_connected-domains }}** нажмите кнопку **{{ ui-key.yacloud.component.dns-integration.button_add-domain }}**.
   1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.dns.button_zone-create }}** и выберите доменную зону, которая соответствует имени бакета, например `gatsbytest.ru.` (с точкой в конце). Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
   1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
   1. Нажмите кнопку **{{ ui-key.yacloud.storage.bucket.website.button_save }}**.

{% endlist %}

## Загрузите сайт в бакет {#upload-site}

Чтобы собрать и загрузить рабочую версию сайта в бакет, воспользуйтесь консольной утилитой [AWS CLI](https://aws.amazon.com/ru/cli/) и специальным [плагином S3](https://www.gatsbyjs.com/plugins/gatsby-plugin-s3/?=S3) из набора встроенных плагинов Gatsby. 

### Настройте AWS CLI

1. Для установки AWS CLI воспользуйтесь [инструкцией](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) на сайте производителя.
1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md).
1. [Назначьте сервисному аккаунту роли](../../iam/operations/sa/assign-role-for-sa.md), необходимые для вашего проекта. Подробнее о ролях см. в [документации {{ iam-name }}](../../iam/concepts/access-control/roles.md).
1. [Создайте статический ключ доступа](../../iam/operations/sa/create-access-key.md).
1. Для настройки AWS CLI введите команду `aws configure`. Команда запросит значения для следующих параметров:
   - `AWS Access Key ID` — идентификатор статического ключа, созданного на предыдущем шаге.
   - `AWS Secret Access Key` — содержимое статического ключа.
   - `Default region name` — регион `{{ region-id }}`.

   {% note info %}

   Для работы с {{ objstorage-name }} всегда указывайте регион — `{{ region-id }}`.
   Неверно указанный регион приведет к ошибке авторизации.

   {% endnote %}

1. Значения остальных параметров оставьте без изменений.

### Установите плагин S3

1. На локальной машине перейдите в папку сайта `gatsby-starter-blog` и выполните команду:

   ```
   npm i gatsby-plugin-s3
   ```

1. Откройте файл `gatsby-config.js` и добавьте декларацию плагина в секцию `plugins`:

   ```
   plugins: [
      {
        resolve: 'gatsby-plugin-s3',
        options: {
          bucketName: '<имя_бакета>',
          region: 'us-east-1',
          customAwsEndpointHostname: 'storage.yandexcloud.net'
        }
      },
      ...
   ]
   ```

   Где `<имя_бакета>` — имя бакета, в данном примере `gatsbytest.ru`.

   {% note info %}

   Не меняйте значение региона, это может привести к ошибке.

   {% endnote %}

1. Откройте файл `package.json` и добавьте запись `deploy` в секцию `scripts`:

   ```
   "scripts": {
   	"deploy": "gatsby-plugin-s3 deploy --yes",
      ...
   }
   ```

### Загрузите сайт в бакет

1. Скомпилируйте сайт, выполнив команду:

   ```
   sudo npm run build
   ```

1. Дождитесь окончания процесса компиляции и загрузите сайт в бакет, выполнив команду:

   ```
   sudo npm run deploy
   ```

1. По окончании загрузки убедитесь, что сайт доступен по доменному имени, перейдя в браузере по адресу:

   ```
   http://<имя_бакета>
   ```

   Где `<имя_бакета>` — имя бакета, в данном примере `gatsbytest.ru`.


## Настройте доступ по HTTPS-протоколу {#configure-https}

Чтобы настроить доступ к сайту по защищенному протоколу, получите сертификат безопасности и настройте HTTPS-доступ к бакету.

### Получите сертификаты от Let's Encrypt®

1. Добавьте новый сертификат от Let's Encrypt®:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в который будет добавлен сертификат.
      1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
      1. Нажмите кнопку **{{ ui-key.yacloud.certificate-manager.button_empty-action }}**.
      1. В открывшемся меню выберите **{{ ui-key.yacloud.certificate-manager.action_request }}**.
      1. В открывшемся окне в поле **{{ ui-key.yacloud.certificate-manager.metadata.field_name }}** введите имя сертификата.
      1. (Опционально) В поле **Описание** введите описание сертификата.
      1. В поле **{{ ui-key.yacloud.certificate-manager.request.field_domains }}** введите имя бакета, в котором размещен сайт. В данном примере это `gatsbytest.ru`.
      1. Выберите [тип проверки прав на домен](../../certificate-manager/concepts/challenges.md): `{{ ui-key.yacloud.certificate-manager.request.challenge-type_label_http }}`.
      1. Нажмите кнопку **{{ ui-key.yacloud.certificate-manager.request.button_request }}**.

   - CLI {#cli}

      1. Выполните команду:

         ```bash
         yc certificate-manager certificate request \
            --name gatsbycert \
            --domains gatsbytest.ru
         ```

         Где:
         * `--name` — имя сертификата.
         * `--domains` — домены сертификатов.

   - {{ TF }} {#tf}

      1. Опишите в конфигурационном файле {{ TF }} параметры ресурса, который необходимо создать:

         ```hcl
         resource "yandex_cm_certificate" "le-certificate" {
            name    = "<имя_сертификата>"
            domains = ["<домен>"]

            managed {
            challenge_type = "HTTP"
            }
         }
         ```

         Где:
         * `domains` — список доменов, для которых нужно создать сертификат. В данном примере это `gatsbytest.ru`.
         * `challenge_type` — [тип проверки прав на домен](../../certificate-manager/concepts/challenges.md), которую нужно [пройти](../../certificate-manager/operations/managed/cert-validate.md) владельцу домена. 

      1. Создайте ресурсы:

         {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      После этого в указанном [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder) будет создан сертификат. Проверить появление сертификата и его настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/):

      ```bash
      yc certificate-manager certificate get <имя_сертификата>
      ```

   - API {#api}

      Чтобы добавить сертификат, воспользуйтесь методом REST API [requestNew](../../certificate-manager/api-ref/Certificate/requestNew.md) для ресурса [Certificate](../../certificate-manager/api-ref/Certificate/) или вызовом gRPC API [CertificateService/RequestNew](../../certificate-manager/api-ref/grpc/certificate_service.md#RequestNew).

   {% endlist %}

   В списке сертификатов появится новый сертификат со статусом `Validating`. Этот статус означает, что запрос на выпуск сертификата от Let's Encrypt® создан, и для его успешной обработки вам необходимо пройти [процедуру проверки прав на домены](../../certificate-manager/operations/managed/cert-validate.md).

1. Получите информацию для прохождения проверки прав на домен:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в который был добавлен [сертификат](../../certificate-manager/concepts/managed-certificate.md).
     1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
     1. Выберите в списке сертификат, для которого необходимо пройти процедуру проверки и нажмите на него.
     1. В открывшемся окне в блоке **{{ ui-key.yacloud.certificate-manager.overview.section_challenges }}** будет указана информация для прохождения процедуры проверки прав — **Ссылка на размещение файла** и **Содержимое**.

   - CLI {#cli}

     1. Выполните команду:

        ```bash
        yc certificate-manager certificate get \
          --id fpq6gvvm6piu******** \
          --full
        ```

        Где:

        * `--id` — идентификатор [сертификата](../../certificate-manager/concepts/managed-certificate.md).
        * `--full` — показать список активных процедур проверки прав на домены.

        Результат:

        ```text
        id: fpq6gvvm6piu********
        folder_id: b1g7gvsi89m3********
        created_at: "2024-03-27T08:49:11.533771Z"
        name: gatsbycert
        type: MANAGED
        domains:
        - gatsbytest.ru
        status: VALIDATING
        updated_at: "2020-09-15T08:49:11.533771Z"
        challenges:
        - domain: gatsbytest.ru
          type: HTTP
          created_at: "2024-03-27T12:20:32.326Z"
          updated_at: "2024-03-27T12:30:16.709Z"
          status: PENDING
          message: Create a file in your web server's base directory.
          http_challenge:
            url: http://gatsbytest.ru/.well-known/acme-challenge/3LiH-nrTC7GdMbRgVqttEvdTODeNeaD0TtX********
            content: 3LiH-nrTC7GdMbRgVqttEvdTODeNeaD0TtXteWgtAH8.ZHCju15sJiKBwT8G5FTl7UtfmJWp1gKNYYP********
        ```

   - API {#api}

     Для получения информации, необходимой для прохождения процедуры проверки прав на домены, воспользуйтесь методом REST API [get](../../certificate-manager/api-ref/Certificate/get.md) для ресурса [Certificate](../../certificate-manager/api-ref/Certificate/) или вызовом gRPC API [CertificateService/Get](../../certificate-manager/api-ref/grpc/certificate_service.md#Get) с флагом `view=FULL`.

   {% endlist %}

1. На локальном компьютере в папке сайта `gatsby-starter-blog` создайте вложенные папки для размещения файла валидации. Для этого выполните:

   ```
   mkdir .well-known
   cd .well-known
   mkdir acme-challenge
   ```

1. Создайте файл валидации на основании полученной информации. Для этого из ссылки размещения файла валидации скопируйте последний компонент URL и создайте файл с данным именем в папке `acme-challenge`:

   ```
   cd acme-challenge
   nano <имя_файла>
   ```

   Где <имя_файла> — последний компонент ссылки размещения файла валидации.
   
   Например, если ссылка имеет вид: 
   ```
   http://gatsbytest.ru/.well-known/acme-challenge/3LiH-nrTC7GdMbRgVqttEvdTODeNeaD0TtX********
   ```

   Выполните: 
   ```
   nano 3LiH-nrTC7GdMbRgVqttEvdTODeNeaD0TtX********
   ```

   Сохраните в файл содержимое файла валидации.

1. После успешного прохождения проверки прав на домен, статус проверки домена в блоке **{{ ui-key.yacloud.certificate-manager.overview.section_challenges }}** изменится на `Valid`, а сертификат будет выпущен и перейдет в статус `Issued`.

### Настройте HTTPS-доступ к бакету

1. Добавьте сертификат в настройках HTTPS-доступа бакета:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

       1. В [консоли управления]({{ link-console-main }}) выберите каталог.
       1. Выберите сервис **{{ objstorage-name }}**.
       1. Нажмите на имя необходимого бакета, в данном примере это `gatsbytest.ru`.
       1. Перейдите на вкладку **{{ ui-key.yacloud.storage.bucket.switch_https }}**.
       1. В отобразившейся панели справа нажмите кнопку **{{ ui-key.yacloud.storage.bucket.https.button_empty-action }}**.
       1. В поле **{{ ui-key.yacloud.storage.bucket.https.field_source }}** выберите **{{ ui-key.yacloud.storage.bucket.https.value_method-certificate-manager }}**.
       1. В поле **{{ ui-key.yacloud.storage.bucket.https.field_certificate }}** выберите сертификат в появившемся списке. 
       1. Нажмите кнопку **{{ ui-key.yacloud.storage.bucket.https.button_save }}**.

   - {{ yandex-cloud }} CLI {#cli}

      Выполните следующую команду:

      ```bash
      yc storage bucket set-https --name <имя_бакета> --certificate-id <идентификатор_сертификата> 
      ```  

      Где:
      * `--name` — имя бакета, в данном примере это `gatsbytest.ru`;
      * `--certificate-id` — идентификатор сертификата в {{ certificate-manager-name }}.

      Результат:

      ```text
      source_type: SOURCE_TYPE_MANAGED_BY_CERTIFICATE_MANAGER
      certificate_id: fpqe2g0hfr0e********
      ```

   - {{ TF }} {#tf}

     Чтобы выбрать сертификат из {{ certificate-manager-name }}:

     1. Откройте файл конфигурации {{ TF }} и добавьте блок `https` в описание бакета:

        ```hcl
        ...
        resource "yandex_storage_bucket" "b" {
          bucket = "<имя_бакета>"

          https {
            certificate_id = "<идентификатор_сертификата>"
          }
        }
        ...
        ```

        Где:
        * `bucket` — имя бакета, в данном примере это `gatsbytest.ru`;
        * `certificate_id` — идентификатор сертификата в {{ certificate-manager-name }}, который будет использован для бакета.

     1. Проверьте конфигурацию командой:

        ```bash
        terraform validate
        ```
     
        Если конфигурация является корректной, появится сообщение:
     
        ```bash
        Success! The configuration is valid.
        ```

     1. Выполните команду:

        ```bash
        terraform plan
        ```
  
        В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

     1. Примените изменения конфигурации:

        ```bash
        terraform apply
        ```
     
     1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

        Проверить выбранный сертификат можно в [консоли управления]({{ link-console-main }}).

   - API {#api}

     Чтобы выбрать сертификат из {{ certificate-manager-name }}, воспользуйтесь методом REST API [setHTTPSConfig](../../storage/api-ref/Bucket/setHTTPSConfig.md) для ресурса [Bucket](../../storage/api-ref/Bucket/index.md) или вызовом gRPC API [BucketService/SetHTTPSConfig](../../storage/api-ref/grpc/bucket_service.md#SetHTTPSConfig).

   {% endlist %}

1. Проверьте, что сайт теперь доступен по защищенному протоколу, перейдя по адресу:

```
https://<имя_бакета>
```

Где `<имя_бакета>` — имя бакета, в примере это `gatsbytest.ru`

{% note info %}

Для активации настроек может потребоваться некоторое время.

{% endnote %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы остановить работу и перестать платить за созданные ресурсы:

1. [Удалите](../../storage/operations/objects/delete.md) все объекты из бакета.
1. [Удалите](../../storage/operations/buckets/delete.md) бакет.
