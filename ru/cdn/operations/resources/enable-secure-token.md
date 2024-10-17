---
title: Настройка доступа по защищенному токену
description: Следуя данной инструкции, вы сможете настроить доступ к контенту ресурса {{ cdn-name }} по времени и по IP-адресу с помощью защищенного токена.
---

# Настройка доступа по защищенному токену

С помощью [защищенных токенов](../../concepts/secure-tokens.md) (_secure token_) вы можете ограничить доступ к файлам [CDN-ресурса](../../concepts/resource.md). Доступ к файлам будет осуществляться по [подписанным ссылкам](../../concepts/secure-tokens.md#protected-link) с ограниченным сроком действия.

Также с помощью защищенных токенов можно задать доверенный [IP-адрес](../../../vpc/concepts/address.md), с которого будет разрешен доступ к CDN-ресурсу.

### Включение доступа {#enable-secure-token}

Чтобы включить доступ по защищенному токену:
1. Придумайте секретный ключ — произвольную строку длиной от 6 до 32 символов. Он будет сохранен в настройках CDN-ресурса и использоваться для формирования подписанных ссылок.
1. На вашем сайте настройте [генерацию](../../concepts/secure-tokens.md#link-generation-code) подписанных ссылок с защищенными токенами.
1. Включите для CDN-ресурса доступ по защищенному токену:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором расположен ресурс.
     1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
     1. Нажмите на имя необходимого ресурса.
     1. В правом верхнем углу нажмите кнопку ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
     1. Включите опцию **{{ ui-key.yacloud.cdn.field_secure-key-enabled }}**:

        {% include [enable-secure-token](../../../_includes/cdn/enable-secure-token.md) %}

     1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

   - CLI {#cli}

     {% include [include](../../../_includes/cli-install.md) %}

     {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

     1. Посмотрите описание команды [CLI](../../../cli/) для редактирования ресурсов:

        ```bash
        yc cdn resource update --help
        ```

     1. Получите список всех ресурсов в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:

        ```bash
        yc cdn resource list --format yaml
        ```

        Результат:

        ```text
        id: bc8br5k6iohx********
        folder_id: b1gt6g8ht345********
        cname: testexample.com
        created_at: "2022-01-19T09:23:57.921365Z"
        updated_at: "2022-01-19T10:55:30.305141Z"
        active: true
        options:
          edge_cache_settings:
            enabled: true
            default value: "345600"
          cache_http_headers:
            enabled: true
            value:
            - content-type
            - content-length
            - connection
            - server
            - date
            - test
          stale:
            enabled: true
            value:
            - error
            - updating
          allowed_http_methods:
            value:
            - GET
            - POST
            - HEAD
            - OPTIONS
        origin_group_id: "89783"
        origin_group_name: My origins group
        origin_protocol: HTTP
        ssl_certificate:
          type: DONT_USE
          status: READY
        ```

        Сохраните идентификатор (`id`) ресурса, для которого вы хотите настроить доступ по защищенному токену.
     1. Включите доступ по защищенному токену:

        ```bash
        yc cdn resource update \
          --id <идентификатор_ресурса> \
          --secure-key <секретный_ключ> \
          --enable-ip-url-signing
        ```

        Где:
        * `--id` — идентификатор CDN-ресурса, для которого вы хотите включить доступ по защищенному токену.
        * `--secure-key` — секретный ключ, созданный ранее.
        * `--enable-ip-url-signing` — (опционально) параметр, который включает ограничение доступа к CDN-ресурсу по IP-адресу. Сам доверенный IP-адрес задается вне CDN-ресурса и указывается в качестве параметра при формировании [MD5](https://{{ lang }}.wikipedia.org/wiki/MD5)-хэша для подписанной ссылки. Если параметр не задан, доступ к файлам будет разрешен с любых IP-адресов.

   - {{ TF }} {#tf}

     {% include [terraform-install](../../../_includes/terraform-install.md) %}

     1. Откройте файл конфигурации {{ TF }} и добавьте параметры в блок с описанием CDN-ресурса:

        ```hcl
        resource "yandex_cdn_resource" "my_resource" {
          ...
          options {
            ...
            secure_key = "<секретный_ключ>"
            enable_ip_url_signing = true
          }
        }
        ```

        Где:
        * `secure_key` — секретный ключ, созданный ранее.
        * `enable_ip_url_signing` — (опционально) параметр, `true` или `false`. Включает ограничение доступа к CDN-ресурсу по IP-адресу. Сам доверенный IP-адрес задается вне CDN-ресурса и указывается в качестве параметра при формировании [MD5](https://{{ lang }}.wikipedia.org/wiki/MD5)-хэша для подписанной ссылки. Если параметр не задан, доступ к файлам будет разрешен с любых IP-адресов.

        Более подробную информацию о параметрах `yandex_cdn_resource` в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/cdn_resource).
     1. Примените изменения:

        {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     Проверить изменившиеся параметры CDN-ресурса можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/):

     ```bash
     yc cdn resource get <идентификатор_ресурса>
     ```

   - API {#api}

     Воспользуйтесь методом REST API [update](../../api-ref/Resource/update.md) для ресурса [Resource](../../api-ref/Resource/index.md) или вызовом gRPC API [ResourceService/Update](../../api-ref/grpc/Resource/update.md).

    {% endlist %}

    {% include [after-changes-tip](../../../_includes/cdn/after-changes-tip.md) %}

    После включения доступа по защищенному токену доступ к контенту CDN-ресурса по обычным ссылкам станет невозможен.

### Отключение доступа {#disable-secure-token}

Чтобы отключить доступ к CDN-ресурсу по защищенному токену:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором расположен ресурс.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
  1. Нажмите на имя необходимого ресурса.
  1. В правом верхнем углу нажмите кнопку ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Выключите опцию **{{ ui-key.yacloud.cdn.field_secure-key-enabled }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  Выполните команду:

  ```bash
  yc cdn resource update \
    --id <идентификатор_ресурса> \
    --clear-secure-key
  ```

  Где:
  * `--id` — идентификатор CDN-ресурса, для которого вы хотите отключить доступ по защищенному токену.
  * `--clear-secure-key` — параметр для отключения доступа по защищенному токену.

- {{ TF }} {#tf}

  1. Откройте файл конфигурации {{ TF }} и удалите параметры `secure_key` и `enable_ip_url_signing` в блоке с описанием CDN-ресурса:

     ```hcl
     resource "yandex_cdn_resource" "my_resource" {
       ...
       options {
         ...
         secure_key = "<секретный_ключ>"
         enable_ip_url_signing = true
       }
     }
     ```

     Более подробную информацию о параметрах `yandex_cdn_resource` в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/cdn_resource).
  1. Примените изменения:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  Проверить изменившиеся параметры CDN-ресурса можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/):

  ```bash
  yc cdn resource get <идентификатор_ресурса>
  ```

- API {#api}

  Воспользуйтесь методом REST API [update](../../api-ref/Resource/update.md) для ресурса [Resource](../../api-ref/Resource/index.md) или вызовом gRPC API [ResourceService/Update](../../api-ref/grpc/Resource/update.md).

{% endlist %}

{% include [after-changes-tip](../../../_includes/cdn/after-changes-tip.md) %}