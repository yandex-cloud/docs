---
title: "Как изменить основные настройки ресурса в {{ cdn-full-name }}"
description: "Следуя данной инструкции, вы сможете изменить основные настройки ресурса." 
---

# Изменение основных настроек ресурса

Чтобы изменить основные настройки [ресурса](../../concepts/resource.md):

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором расположен ресурс.

  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.

  1. Нажмите на имя необходимого ресурса.

  1. В правом верхнем углу нажмите кнопку ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.

  1. Измените настройки ресурса.

       {% note warning %}

       Основное [доменное имя для раздачи контента](../../concepts/resource.md#hostnames) нельзя изменить.

       {% endnote %}

  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI

  {% include [include](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для редактирования ресурсов:

      ```bash
      yc cdn resource update --help
      ```

  1. Получите список всех ресурсов в каталоге по умолчанию:

      ```bash
      yc cdn resource list --format yaml
      ```

      Результат:

      ```bash
      id: s0me1dkfjq********
      folder_id: s0mef01der7p********
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

  1. Измените настройки ресурса:

      ```bash
      yc cdn resource update <идентификатор_ресурса> \
        <флаг> <новое_значение>
      ```

      Если вы хотите ограничить доступ к создаваемому ресурсу с помощью [защищенных токенов](../../concepts/secure-tokens.md) используйте параметры:
      * `--secure-key` — секретный ключ — произвольная строка длиной от 6 до 32 символов.
      * `--enable-ip-url-signing` — (опционально) параметр, который включает ограничение доступа к CDN-ресурсу по IP-адресу. Сам доверенный IP-адрес задается вне CDN-ресурса и указывается в качестве параметра при формировании [MD5](https://ru.wikipedia.org/wiki/MD5)-хэша для [подписанной ссылки](../../concepts/secure-tokens.md#protected-link). Если параметр не задан, доступ к файлам будет разрешен с любых IP-адресов.

      Cм. также [{#T}](./enable-secure-token.md).

      Подробнее о команде `yc cdn resource update` см. в [справочнике CLI](../../../cli/cli-ref/managed-services/cdn/resource/update.md).

- {{ TF }}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы изменить параметры CDN-ресурса, созданного с помощью {{ TF }}:

  1. Откройте файл конфигурации {{ TF }} и измените фрагмент с описанием ресурса.

     {% cut "Пример описания CDN-ресурса в конфигурации {{ TF }}" %}

     ```hcl
     resource "yandex_cdn_resource" "my_resource" {
         cname               = "cdn1.yandex-example.ru"
         active              = false
         origin_protocol     = "https"
         secondary_hostnames = ["cdn-example-1.yandex.ru", "cdn-example-2.yandex.ru"]
         origin_group_id     = "<идентификатор_группы_источников>"
         ...
         options {
           edge_cache_settings = "345600"
           ignore_cookie       = true
           ...
         }
     }
     ```

     {% endcut %}

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

  Воспользуйтесь методом REST API [update](../../api-ref/Resource/update.md) для ресурса [Resource](../../api-ref/Resource/index.md) или вызовом gRPC API [ResourceService/Update](../../api-ref/grpc/resource_service.md#Update).

{% endlist %}

{% include [after-changes-tip](../../../_includes/cdn/after-changes-tip.md) %}

## Примеры {#examples}

{% list tabs %}

- CLI

  Измените протокол для источников с HTTP на HTTPS и выберите сертификат Let's Encrypt®, [добавленный](../../../certificate-manager/operations/managed/cert-create.md) в {{ certificate-manager-name }}, или [загруженный](../../../certificate-manager/operations/import/cert-create.md) собственный сертификат:

    ```bash
    yc cdn resource update s0me1dkfjq******** \
      --origin-protocol HTTPS \
      --cert-manager-ssl-cert-id <идентификатор_сертификата>
    ```

  Результат:

    ```bash
    id: s0me1dkfjq********

    ...

    cname: testexample.com
    active: true

    ...

    origin_group_id: "89783"
    origin_group_name: My origins group
    origin_protocol: HTTPS
    ssl_certificate:
    type: CM
    status: CREATING
    ```

{% endlist %}