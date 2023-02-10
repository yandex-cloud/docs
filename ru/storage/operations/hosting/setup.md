# Настройка хостинга

{{ objstorage-name }} позволяет настроить бакет:

* Для [хостинга статического сайта](#hosting).
* Для [переадресации всех запросов](#redirects).
* Для [условной переадресации запросов](#redirects-on-conditions).

## Хостинг статического сайта {#hosting}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в бакет, для которого хотите настроить хостинг.
  1. Убедитесь, что для бакета установлен публичный доступ. Если нет, то воспользуйтесь инструкцией [{#T}](../buckets/bucket-availability.md).
  1. В левой панели выберите пункт **Веб-сайт**.
  1. В разделе **Хостинг** укажите:
      * Главную страницу сайта.
      * Страницу, которая будет отображаться пользователю при ошибках 4хх. Необязательно.
  1. Нажмите **Сохранить**.

- {{ yandex-cloud }} CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для настройки хостинга статического сайта в бакете:

     ```bash
     yc storage bucket update --help
     ```
     
  1. Создайте файл с настройками хостинга в формате JSON. Например:
     
     ```json
     {
       "index": "index.html",
       "error": "error404.html"
     }
     ```

     Где:
     * `index` — абсолютный путь к файлу главной страницы сайта. 
     * `error` — абсолютный путь к файлу, который будет отображаться пользователю при ошибках 4хх.  
  
  1. Выполните следующую команду:

     ```bash
     yc storage bucket update --name <имя_бакета> \
       --website-settings-from-file <путь_к_файлу_с_настройками_хостинга>
     ```
     
     Где:
     * `--name` — имя бакета.
     * `--website-settings-from-file` — путь к файлу с настройками хостинга.

     Результат:

     ```text
     name: my-bucket
     folder_id: b1gjs8dck8bvb10chmjf
     default_storage_class: STANDARD
     versioning: VERSIONING_SUSPENDED
     max_size: "10737418240"
     acl: {}
     created_at: "2022-12-14T08:42:16.273717Z"
     ```

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

- {{ TF }}

  Если у вас ещё нет {{ TF }}, {% if audience != "internal" %}[установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform){% else %}установите его и настройте провайдер {{ yandex-cloud }}{% endif %}.

  Перед началом работы, получите {% if audience != "internal" %}[статические ключи доступа](../../../iam/operations/sa/create-access-key.md){% else %}статические ключи доступа{% endif %} — секретный ключ и идентификатор ключа, используемые для аутентификации в {{ objstorage-short-name }}.

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     {% if product == "yandex-cloud" %}

     ```hcl
     provider "yandex" {
       token     = "<OAuth>"
       cloud_id  = "<идентификатор облака>"
       folder_id = "<идентификатор каталога>"
       zone      = "{{ region-id }}-a"
     }

     resource "yandex_storage_bucket" "test" {
       access_key = "<идентификатор статического ключа>"
       secret_key = "<секретный ключ>"
       bucket     = "<имя бакета>"
       acl        = "public-read"
     
       website {
         index_document = "index.html"
         error_document = "error.html"
       }
     
     }
     ```

     {% endif %}

     {% if product == "cloud-il" %}

     ```
     provider "yandex" {
       endpoint         = "{{ api-host }}:443"
       token            = "<статический ключ сервисного аккаунта>"
       cloud_id         = "<идентификатор облака>"
       folder_id        = "<идентификатор каталога>"
       zone             = "{{ region-id }}-a"
       storage_endpoint = "{{ s3-storage-host }}"
     }

     resource "yandex_storage_bucket" "test" {
       access_key = "<идентификатор статического ключа>"
       secret_key = "<секретный ключ>"
       bucket     = "<имя бакета>"
       acl        = "public-read"

       website {
         index_document = "index.html"
         error_document = "error.html"
       }

     }
     ```

     {% endif %}

     Где:

     * `access_key` — идентификатор статического ключа доступа.
     * `secret_key` — значение секретного ключа доступа.
     * `bucket` — имя бакета.
     * `acl` — параметры управления доступом [ACL](../../concepts/acl.md#predefined-acls).
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

     1. Если в конфигурации нет ошибок, выполните команду:

     ```
     terraform apply
     ```
   
     1. Подтвердите создание ресурсов.

     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

{% endlist %}

## Переадресация всех запросов {#redirects}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в бакет, для которого хотите настроить переадресацию.
  1. Убедитесь, что для бакета установлен публичный доступ. Если нет, то воспользуйтесь инструкцией [{#T}](../buckets/bucket-availability.md).
  1. В левой панели выберите пункт **Веб-сайт**.
  1. В разделе **Переадресация** укажите:
      * Доменное имя хоста, на который будут перенаправляться все запросы к текущему бакету.
      * Протокол, если указанный хост принимает запросы строго по определенному протоколу.

- {{ yandex-cloud }} CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для настройки переадресации всех запросов:

     ```bash
     yc storage bucket update --help
     ```
     
  1. Создайте файл с настройками переадресации в формате JSON. Например:
     
     ```json
     {
       "redirectAllRequests": {
         "protocol": "PROTOCOL_HTTP",
         "hostname": "example.com"
       }
     }
     ```

     Где:
     * `protocol` — протокол передачи данных: `PROTOCOL_HTTP` или `PROTOCOL_HTTPS`. По умолчанию используется протокол из исходного запроса.
     * `hostname` — доменное имя хоста, на который будут перенаправляться все запросы к текущему бакету.
  
  1. Выполните следующую команду:

     ```bash
     yc storage bucket update --name <имя_бакета> \
       --website-settings-from-file <путь_к_файлу_с_настройками_переадресации>
     ```

     Где:
     * `--name` — имя бакета.
     * `--website-settings-from-file` — путь к файлу с настройками переадресации.

     Результат:

     ```text
     name: my-bucket
     folder_id: b1gjs8dck8bvb10chmjf
     default_storage_class: STANDARD
     versioning: VERSIONING_SUSPENDED
     max_size: "10737418240"
     acl: {}
     created_at: "2022-12-14T08:42:16.273717Z"
     ```

- {{ TF }}
 
  {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

  {% if audience != "internal" %}

  Подробнее о {{ TF }} [читайте в документации](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  {% endif %}

  Чтобы настроить переадресацию всех запросов:

  1. Откройте файл конфигурации {{ TF }} и добавьте параметр `redirect_all_requests_to` в описание ресурса `yandex_storage_bucket`:

     ```hcl
     ...
     resource "yandex_storage_bucket" "test" {
       access_key = "<идентификатор_статического_ключа>"
       secret_key = "<секретный_ключ>"
       bucket     = "<имя_бакета>"
       acl        = "public-read"
     
       website {
         index_document = "<абсолютный_путь_к_файлу_главной_страницы_сайта>"
         error_document = "<абсолютный_путь_к_файлу_ошибок>"
		 redirect_all_requests_to = "<имя_хоста>"
       }
     }
     ...
     ```

     Где:
     * `access_key` — идентификатор статического ключа доступа.
     * `secret_key` — значение секретного ключа доступа.
     * `bucket` — имя бакета.
     * `acl` — параметры управления доступом [ACL](../../concepts/acl.md#predefined-acls).
     * `website` — параметры веб-сайта:
       * `index_document` — абсолютный путь к файлу главной страницы сайта. Обязательный параметр.
       * `error_document` — абсолютный путь к файлу, который будет отображаться пользователю при ошибках `4хх`. Необязательный параметр.
       * `redirect_all_requests_to` — доменное имя хоста, на который будут перенаправляться все запросы к текущему бакету. Вы можете указать префикс протокола (`http://` или `https://`). По умолчанию используется протокол из исходного запроса.

     Более подробную информацию о параметрах ресурса `yandex_storage_bucket` в {{ TF }} см. в [документации провайдера]({{ tf-provider-link }}/storage_bucket#static-website-hosting).

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

     Проверить настройку переадресации запросов можно в [консоли управления]({{ link-console-main }}).

{% endlist %}

## Условная переадресация запросов {#redirects-on-conditions}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в бакет, для которого хотите настроить условную переадресацию запросов.
  1. Убедитесь, что для бакета установлен публичный доступ. Если нет, то воспользуйтесь инструкцией [{#T}](../buckets/bucket-availability.md).
  1. В левой панели выберите пункт **Веб-сайт**.
  1. В разделе **Хостинг** добавьте правило переадресации и в нем укажите условие для выполнения переадресации и новый адрес.
      * Условие. Например, можно выполнить переадресацию при получении заданного кода ответа или если начало ключа объекта в запросе совпадает с указанным.
      * Переадресация:
        * Доменное имя хоста, на который должны перенаправляться запросы, удовлетворившие условию.
        * Протокол, по которому должен быть отправлен переадресованный запрос.
        * Код ответа для определения типа редиректа.
        * Замена всего ключа или только его начала, указанного в условии.

- {{ yandex-cloud }} CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для настройки условной переадресации запросов:

     ```bash
     yc storage bucket update --help
     ```
     
  1. Создайте файл с настройками условной переадресации в формате JSON. Например:
     
     ```json
     {
       "routingRules": [
         {
           "condition": {
             "httpErrorCodeReturnedEquals": "404",
             "keyPrefixEquals": "key"
           },
           "redirect": {
             "hostname": "example.com",
             "httpRedirectCode": "301",
             "protocol": "PROTOCOL_HTTP",
             "replaceKeyPrefixWith": "prefix",
             "replaceKeyWith": "key"
           } 
         }
       ]
     }
     ```

     Где:
     * `condition` — условие, при котором выполняется перенаправление:
     
       * `httpErrorCodeReturnedEquals` — HTTP-код ответа.
       * `keyPrefixEquals` — префикс ключа объекта.
       
     * `redirect` — настройки перенаправления:
     
       * `hostname` — доменное имя хоста, на который будут перенаправляться все запросы к текущему бакету.
       * `httpRedirectCode` — новый HTTP-код ответа.
       * `protocol` — новый протокол передачи данных: `PROTOCOL_HTTP` или `PROTOCOL_HTTPS`. По умолчанию используется протокол из исходного запроса. 
       * `replaceKeyPrefixWith` — новый префикс ключа объекта.
       * `replaceKeyWith` — новый ключ объекта.
  
  1. Выполните следующую команду:

     ```bash
     yc storage bucket update --name <имя_бакета> \
       --website-settings-from-file <путь_к_файлу_с_настройками_условной_переадресации>
     ```

     Где:
     * `--name` — имя бакета.
     * `--website-settings-from-file` — путь к файлу с настройками условной переадресации.

     Результат:

     ```text
     name: my-bucket
     folder_id: b1gjs8dck8bvb10chmjf
     default_storage_class: STANDARD
     versioning: VERSIONING_SUSPENDED
     max_size: "10737418240"
     acl: {}
     created_at: "2022-12-14T08:42:16.273717Z"
     ```

- {{ TF }}
 
  {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

  {% if audience != "internal" %}
  
  Подробнее о {{ TF }} [читайте в документации](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  {% endif %}

  Чтобы настроить условную переадресацию запросов:

  1. Откройте файл конфигурации {{ TF }} и добавьте параметр `routing_rules` в описание бакета:

     ```hcl
     ...
     resource "yandex_storage_bucket" "test" {
       access_key = "<идентификатор_статического_ключа>"
       secret_key = "<секретный_ключ>"
       bucket     = "<имя_бакета>"
       acl        = "public-read"
     
       website {
         index_document = "<абсолютный_путь_к_файлу_главной_страницы_сайта>"
         error_document = "<абсолютный_путь_к_файлу_ошибок>"
		 routing_rules            = <<EOF
         [
	       {
             "Condition": {
               "KeyPrefixEquals": "<префикс_ключа_объекта>",
               "HttpErrorCodeReturnedEquals": "<HTTP-код_ответа>"
             },
             "Redirect": {
               "Protocol": "<новая_схема>",
               "HostName": "<новое_доменное_имя>",
               "ReplaceKeyPrefixWith": "<новый_префикс_ключа_объекта>",
               "ReplaceKeyWith": "<новый_ключ_объекта>",
               "HttpRedirectCode": "<новый_HTTP-код_ответа>"
             }
           },
         ...
         ]
         EOF
       }
     }
     ...
     ```

     Где:
     * `access_key` — идентификатор статического ключа доступа.
     * `secret_key` — значение секретного ключа доступа.
     * `bucket` — имя бакета.
     * `acl` — параметры управления доступом [ACL](../../concepts/acl.md#predefined-acls).
     * `website` — параметры веб-сайта:
       * `index_document` — абсолютный путь к файлу главной страницы сайта. Обязательный параметр.
       * `error_document` — абсолютный путь к файлу, который будет отображаться пользователю при ошибках `4хх`. Необязательный параметр.
       * `routing_rules` — правила переадресации запросов в формате JSON. В полях `Condition` и `Redirect` каждого правила должно быть хотя бы по одной паре <q>ключ — значение</q>. Подробнее о поддерживаемых полях см. в [схеме данных](../../s3/api-ref/hosting/upload.md#request-scheme) соответствующего метода {% if lang == "ru" and audience != "internal" %}[API](../../../glossary/rest-api.md){% else %}API{% endif %} (вкладка **Для условной переадресации запросов**).

     Более подробную информацию о параметрах ресурса `yandex_storage_bucket` в {{ TF }} см. в [документации провайдера]({{ tf-provider-link }}/storage_bucket#static-website-hosting).

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

     Проверить настройку условной переадресации запросов можно в [консоли управления]({{ link-console-main }}).
        
{% endlist %}
