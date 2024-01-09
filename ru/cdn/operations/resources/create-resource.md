---
title: "Как создать ресурс в {{ cdn-full-name }}"
description: "Следуя данной инструкции, вы сможете создать ресурс." 
---

# Создание ресурса


{% include [lets-encrypt-over](../../../_includes/cdn/lets-encrypt-over.md) %}


Чтобы создать [ресурс](../../concepts/resource.md):

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать ресурс.

  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.

  1. {% include [activate-provider](../../../_includes/cdn/activate-provider.md) %}

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

- CLI {#cli}
  
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
        folder_id: s0mefo1der7p********
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
      yc cdn resource create <доменное_имя_ресурса> \
        --origin-group-id <идентификатор_группы_источников> \
        --origin-protocol <протокол_для_источников>
      ```

      * Вместо группы источников `--origin-group-id` можно указать доменное имя источника, используя флаг `--origin-custom-source`.
      * Для `--origin-protocol` доступны значения `HTTP`, `HTTPS` и `MATCH` (как у клиента).
      
      Если вы хотите ограничить доступ к создаваемому ресурсу с помощью [защищенных токенов](../../concepts/secure-tokens.md) используйте параметры:
      * `--secure-key` — секретный ключ — произвольная строка длиной от 6 до 32 символов.
      * `--enable-ip-url-signing` — (опционально) параметр, который включает ограничение доступа к CDN-ресурсу по IP-адресу. Сам доверенный IP-адрес задается вне CDN-ресурса и указывается в качестве параметра при формировании [MD5](https://ru.wikipedia.org/wiki/MD5)-хэша для [подписанной ссылки](../../concepts/secure-tokens.md#protected-link). Если параметр не задан, доступ к файлам будет разрешен с любых IP-адресов.

      Cм. также [{#T}](./enable-secure-token.md).
      
      Подробнее о команде `yc cdn resource create` см. в [справочнике CLI](../../../cli/cli-ref/managed-services/cdn/resource/create.md).

- {{ TF }} {#tf}

  Провайдер CDN должен быть активирован до создания ресурса. Сделать это можно в [консоли управления]({{ link-console-main }}) или с помощью команды [YC CLI](../../../cli/quickstart.md):

  ```bash
  yc cdn provider activate \
    --folder-id <идентификатор_каталога> \
    --type gcore
  ```

  Где:
  * `--folder-id` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md), в котором вы хотите активировать провайдера CDN.
  * `--type` — тип провайдера: единственное возможное значение — `gcore`.

  {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры создаваемого CDN-ресурса:

      ```hcl
      resource "yandex_cdn_resource" "my_resource" {
          cname               = "<имя_домена>"
          active              = true
          origin_protocol     = "https"
          origin_group_id     = <идентификатор_группы_источников>
          secondary_hostnames = ["<дополнительное_доменное_имя_1>", "дополнительное_доменное_имя_2"]
          ssl_certificate {
            type = "certificate_manager"
            certificate_manager_id = "<идентификатор_сертификата>"
          }
          options {
            redirect_http_to_https = true
          }
      }
      ```

      Где:

      * `cname` — основное доменное имя для раздачи контента. Обязательный параметр.
      * `active` — (опционально) флаг, указывающий на доступ к контенту для конечных пользователей: `true` — контент из CDN доступен клиентам, `false` — доступ к контенту отключен. Значение по умолчанию: `true`.
      * `origin_protocol` — (опционально) протокол для источников. Значение по умолчанию: `http`.
      * `origin_group_id` — идентификатор [группы источников](../../concepts/origins.md). Обязательный параметр. Используйте идентификатор из описания группы источников в ресурсе `yandex_cdn_origin_group`.
      * `secondary_hostnames` — (опционально) дополнительные доменные имена.
      * `ssl_certificate` — (опционально) параметры SSL-сертификата:
        * `type` — тип сертификата, возможные значения:
          * `not_used` — без сертификата. Значение по умолчанию.
          * `certificate_manager` — пользовательский сертификат [{{ certificate-manager-full-name }}](../../../certificate-manager/concepts/imported-certificate.md). Укажите идентификатор сертификата в параметре `certificate_manager_id`.
        * `certificate_manager_id` — идентификатор пользовательского сертификата в {{ certificate-manager-name }}.
      * `options` — (опционально) дополнительные параметры CDN-ресурса:
        * `redirect_http_to_https` — параметр для переадресации клиентов с HTTP на HTTPS, возможные значения: `true` или `false`. Доступно при использовании SSL-сертификата.

        Более подробную информацию о параметрах `yandex_cdn_resource` в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/cdn_resource).

  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../../_tutorials/terraform-validate-plan-apply.md) %}

     {{ TF }} создаст все требуемые ресурсы. Проверить создание CDN-ресурса можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

     ```bash
     yc cdn resource list
     ```

- API {#api}

  Воспользуйтесь методом REST API [create](../../api-ref/Resource/create.md) для ресурса [Resource](../../api-ref/Resource/index.md) или вызовом gRPC API [ResourceService/Create](../../api-ref/grpc/resource_service.md#Create).

{% endlist %}

{% include [after-creation-tip](../../../_includes/cdn/after-creation-tip.md) %}

{% include [note-dns-aname](../../../_includes/cdn/note-dns-aname.md) %}

{% include [edge-center-features-note](../../../_includes/cdn/edge-center-features-note.md) %}

## Примеры {#examples}

{% list tabs group=instructions %}

- CLI {#cli}
  
  Создайте ресурс с протоколом HTTP:

    ```bash
    yc cdn resource create testexample.com \
      --origin-group-id 90209 \
      --origin-protocol HTTP
    ```

    Результат:

    ```bash
    id: s0me1dkfjq********

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
