---
title: "Как создать ресурс в {{ cdn-full-name }}"
description: "Следуя данной инструкции, вы сможете создать ресурс." 
---

# Создание ресурса


{% include [lets-encrypt-over](../../../_includes/cdn/lets-encrypt-over.md) %}


Чтобы создать [ресурс](../../concepts/resource.md):

{% list tabs %}

- Консоль управления
  
  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать ресурс.

  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.

  1. Если у вас еще нет CDN-ресурсов, нажмите кнопку **{{ ui-key.yacloud.cdn.label_activate-provider-empty-container_action-text }}**. Подключение происходит автоматически.

  1. Нажмите кнопку **{{ ui-key.yacloud.cdn.button_resource-create }}**.

  1. В блоке **{{ ui-key.yacloud.cdn.label_section-content }}** выберите **{{ ui-key.yacloud.cdn.label_content-query-type }}** `{{ ui-key.yacloud.cdn.value_query-type-one-origin }}` или `{{ ui-key.yacloud.cdn.value_query-type-group-origin }}`:

      * При запросе контента `{{ ui-key.yacloud.cdn.value_query-type-one-origin }}` выберите **{{ ui-key.yacloud.cdn.label_source-type }}**: `{{ ui-key.yacloud.cdn.value_source-type-url }}`, `{{ ui-key.yacloud.cdn.value_source-type-bucket }}` или `{{ ui-key.yacloud.cdn.value_source-type-balancer }}`. Укажите источник. Подробнее о типах см. в разделе [{#T}](../../concepts/origins.md).

      * При запросе контента `{{ ui-key.yacloud.cdn.value_query-type-group-origin }}` выберите [группу источников](../../concepts/origins.md#groups) или создайте новую:
          * Нажмите кнопку **{{ ui-key.yacloud.common.label_create-new_female }}**.
          * Введите **{{ ui-key.yacloud.cdn.field_group-name }}**.
          * Настройте **{{ ui-key.yacloud.cdn.label_section-origins-list }}**:
              * Укажите **{{ ui-key.yacloud.cdn.label_source-type }}**: `{{ ui-key.yacloud.cdn.value_source-type-url }}`, `{{ ui-key.yacloud.cdn.value_source-type-bucket }}` или `{{ ui-key.yacloud.cdn.value_source-type-balancer }}`. Подробнее о типах см. в разделе [{#T}](../../concepts/origins.md).
              * Укажите источник.
              * Выберите **{{ ui-key.yacloud.cdn.field_origin-state }}**: `{{ ui-key.yacloud.cdn.label_status-active }}` или `{{ ui-key.yacloud.cdn.label_status-backup }}`. Подробнее о приоритетах см. в разделе [{#T}](../../concepts/origins.md#groups).
          * Добавьте другие источники, если необходимо.
          * Нажмите кнопку **{{ ui-key.yacloud.common.create }}**. В поле **{{ ui-key.yacloud.cdn.label_origins-group }}** вы увидите название созданной группы.

     Подробнее см. в разделе [{#T}](../../concepts/origins.md).

  1. В блоке **{{ ui-key.yacloud.cdn.label_section-domain }}** введите **{{ ui-key.yacloud.cdn.label_personal-domain }}**. Вы можете добавить более одного **Доменного имени**. Поддерживаются имена с символами не из ASCII, например кириллическими, и [Punycode](https://{{ lang }}.wikipedia.org/wiki/Punycode). Первое имя считается основным.

     {% note warning %}

     После создания ресурса изменить основное имя будет невозможно.

     {% endnote %}
      
     В настройках вашего DNS-хостинга создайте для указанных доменных имен CNAME-записи со значением, которое отображается внизу блока **{{ ui-key.yacloud.cdn.label_section-domain }}**. Подробнее см. в разделе [{#T}](../../concepts/resource.md#hostnames).

  1. В блоке **{{ ui-key.yacloud.cdn.label_section-additional }}**:

      1. Выберите **{{ ui-key.yacloud.cdn.label_protocol }}**.
      1. Выберите способ переадресации клиентов: `{{ ui-key.yacloud.cdn.value_do-not-use }}` или `{{ ui-key.yacloud.cdn.value_redirect-https-to-http }}`.

         Чтобы включить переадресацию клиентов с HTTP на HTTPS, создайте CDN-ресурс без переадресации и получите TLS-сертификат для доменного имени. Затем в настройках CDN-ресурса [выберите](configure-basics.md) переадресацию клиентов `{{ ui-key.yacloud.cdn.value_redirect-http-to-https }}`.

      1. Включите или выключите **{{ ui-key.yacloud.cdn.label_access }}**.
      1. В поле **{{ ui-key.yacloud.cdn.label_certificate-type }}** выберите одну из опций:
      
          * `{{ ui-key.yacloud.cdn.value_certificate-no }}` — ресурс будет доступен только по протоколу HTTP.
          * `{{ ui-key.yacloud.cdn.value_certificate-custom }}` — выберите сертификат в {{ certificate-manager-name }}. Это может быть как [сертификат от Let's Encrypt®](../../../certificate-manager/concepts/managed-certificate.md), так и [пользовательский сертификат](../../../certificate-manager/concepts/imported-certificate.md).
          
          Подробнее см. в разделе [{#T}](../../concepts/clients-to-servers-tls.md).

      1. Выберите значение **{{ ui-key.yacloud.cdn.label_host-header }}**: `{{ ui-key.yacloud.cdn.value_host-header-default }}`, `{{ ui-key.yacloud.cdn.value_host-header-resend }}` или выберите `{{ ui-key.yacloud.cdn.value_host-header-custom }}` и введите **{{ ui-key.yacloud.cdn.label_custom-host-header }}**. Подробнее см. в разделе [{#T}](../../concepts/servers-to-origins-host.md).

  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI
  
  {% include [include](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
  
  1. Если вы создаете первый ресурс, сначала подключитесь к провайдеру:

      ```bash
      yc cdn provider activate --type gcore
      ```

  1. Посмотрите описание команды CLI для создания ресурсов:

      ```bash
      yc cdn resource create --help
      ```

  1. Получите список групп источников в каталоге:

      ```bash
      yc cdn origin-group list --format yaml
      ```
  
      Результат:

      ```bash
      - id: "90209"
        folder_id: somefolder7p********
        name: test-group-1
        use_next: true
        origins:
        - id: "561547"
          origin_group_id: "90209"
          source: www.example2.com
          enabled: true
          backup: true
        - id: "561546"
          origin_group_id: "90209"
          source: www.example1.com
          enabled: true
      - id: "90208"
        folder_id: b1g86q4m5ve********
        name: test-group
        use_next: true
        origins:
        - id: "561545"
          origin_group_id: "90208"
          source: www.a2.com
          enabled: true
          backup: true
        - id: "561544"
          origin_group_id: "90208"
          source: www.a1.com
          enabled: true
        ```      

  1. Создайте ресурс:
  
      ```bash
      yc cdn resource create <доменное имя ресурса> \
        --origin-group-id <идентификатор группы источников> \
        --origin-protocol <протокол для источников>
      ```

      * Вместо группы источников `--origin-group-id` можно указать доменное имя источника, используя флаг `--origin-custom-source`.
      * Для `--origin-protocol` доступны значения `HTTP`, `HTTPS` и `MATCH` (как у клиента).

      Подробнее о команде `yc cdn resource create`  см. в [справочнике CLI](../../../cli/cli-ref/managed-services/cdn/resource/create.md).

- {{ TF }}

  Поставщик CDN должен быть активирован до использования ресурсов CDN. Сделать это можно в [консоли управления]({{ link-console-main }}) или с помощью команды [YC CLI](../../../cli/quickstart.md):

  ```
  yc cdn provider activate --folder-id <идентификатор каталога> --type gcore
  ```

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры создаваемого CDN-ресурса:

      
      ```hcl
      terraform {
        required_providers {
          yandex = {
            source  = "yandex-cloud/yandex"
            version = "0.69.0"
          }
        }
      }

      provider "yandex" {
        token     = "<OAuth>"
        cloud_id  = "<идентификатор облака>"
        folder_id = "<идентификатор каталога>"
        zone      = "<зона доступности>"
      }

      resource "yandex_cdn_resource" "my_resource" {
          cname               = "cdn1.yandex-example.ru"
          active              = false
          origin_protocol     = "https"
          secondary_hostnames = ["cdn-example-1.yandex.ru", "cdn-example-2.yandex.ru"]
          origin_group_id     = yandex_cdn_origin_group.my_group.id
      }
      ```



      Где:

      * `cname` — основное доменное имя для раздачи контента. Обязательный параметр.
      * `active` — флаг, указывающий на доступ к контенту для конечных пользователей. `True` — контент из CDN будет доступен клиентам. Необязательный параметр, значение по умолчанию: `true`.
      * `origin_protocol` — протокол для источников. Необязательный параметр, значение по умолчанию: `http`.
      * `secondary_hostnames` — дополнительные доменные имена. Необязательный параметр.
      * `origin_group_id` — идентификатор [группы источников](../../concepts/origins.md). Обязательный параметр. Используйте идентификатор из описания группы источников в ресурсе `yandex_cdn_origin_group`.

      Более подробную информацию о параметрах `yandex_cdn_resource` в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/cdn_resource).

  1. В командной строке перейдите в папку, где расположен конфигурационный файл {{ TF }}.

  1. Проверьте конфигурацию командой:
     ```
     terraform validate
     ```

     Если конфигурация является корректной, появится сообщение:

     ```
     Success! The configuration is valid.
     ```

  1. Выполните команду:
     ```
     terraform plan
     ```
  
     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Примените изменения конфигурации:
     ```
     terraform apply
     ```
     
  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить изменение CDN-ресурса можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

     ```
     yc cdn resource list
     ```

- API

  Воспользуйтесь методом REST API [create](../../api-ref/Resource/create.md) для ресурса [Resource](../../api-ref/Resource/index.md) или вызовом gRPC API [ResourceService/Create](../../api-ref/grpc/resource_service.md#Create).

{% endlist %}

{% include [after-creation-tip](../../../_includes/cdn/after-creation-tip.md) %}

{% include [edge-center-features-note](../../../_includes/cdn/edge-center-features-note.md) %}

## Примеры {#examples}

{% list tabs %}

- CLI
  
  Создайте ресурс с протоколом HTTP:

    ```bash
    yc cdn resource create testexample.com \
      --origin-group-id 90209 \
      --origin-protocol HTTP
    ```

    Результат:

    ```bash
    id: someidkfjq********

    ...

    cname: testexample.com
    active: true

    ...

    origin_group_id: "90209"
    origin_group_name: test-group-1
    origin_protocol: HTTP
    ssl_certificate:
    type: DONT_USE
    status: READY
    ```

{% endlist %}
