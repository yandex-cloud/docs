---
title: Как изменить основные настройки ресурса в {{ cdn-full-name }}
description: Следуя данной инструкции, вы сможете изменить основные настройки ресурса.
---

# Изменение основных настроек ресурса

Чтобы изменить основные настройки [ресурса](../../concepts/resource.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором расположен ресурс.

  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.

  1. Нажмите на имя необходимого ресурса.

  1. В правом верхнем углу нажмите кнопку ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.

  1. Измените настройки ресурса.

      {% note warning %}

      Основное [доменное имя для раздачи контента](../../concepts/resource.md#hostnames) нельзя изменить.

      {% endnote %}

      * Чтобы добавить [метки](../../concepts/labels.md):

          * Нажмите кнопку **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
          * Введите метку в формате `ключ: значение`.
          * Нажмите **Enter**.

      * Чтобы настроить [TLS-сертификат](../../concepts/clients-to-servers-tls.md) для CDN-ресурса, в поле **{{ ui-key.yacloud.cdn.label_certificate-type }}** выберите одну из опций:

          * `{{ ui-key.yacloud.cdn.value_certificate-no }}` — ресурс будет доступен только по протоколу HTTP.


          * `{{ ui-key.yacloud.cdn.value_certificate-custom }}` — выберите сертификат. Ресурс будет доступен по протоколам HTTP и HTTPS.

              {% include [certificate-usage](../../../_includes/cdn/certificate-usage.md) %}

          Подробнее см. в разделе [{#T}](../../concepts/clients-to-servers-tls.md).

      * Чтобы включить [перенаправление запросов](../../concepts/http-rewrite.md) на CDN-ресурсе:

          1. Включите опцию **{{ ui-key.yacloud.cdn.field_rewrite-rule-redirect }}**.
          1. В поле **{{ ui-key.yacloud.cdn.field_rewrite-rule-body }}** задайте правило. Например: `/(.*) /new-folder/$1`.

              {% include [rewrite-rule-description](../../../_includes/cdn/rewrite-rule-description.md) %}

          1. В поле **{{ ui-key.yacloud.cdn.field_rewrite-rule-flag }}** задайте нужный [флаг](../../concepts/http-rewrite.md#flag):

              {% include [rewrite-flag-list](../../../_includes/cdn/rewrite-flag-list.md) %}

      * Чтобы ограничить доступ к контенту ресурса с помощью [защищенных токенов](../../concepts/secure-tokens.md), включите опцию **{{ ui-key.yacloud.cdn.field_secure-key-enabled }}**:

          {% include [enable-secure-token](../../../_includes/cdn/enable-secure-token.md) %}

          {% include [enable-ip-policy](../../../_includes/cdn/enable-ip-policy.md) %}

          Подробнее см. в разделе [{#T}](enable-secure-token.md).

  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

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

      ```text
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

      {% include [certificate-settings-cli](../../../_includes/cdn/certificate-settings-cli.md) %}

      Чтобы включить [перенаправление запросов](../../concepts/http-rewrite.md) на CDN-ресурсе, используйте параметры:

      * `--rewrite-body` – правило Rewrite. Например: `--rewrite-body '/(.*) /new-folder/$1'`.

          {% include [rewrite-rule-description](../../../_includes/cdn/rewrite-rule-description.md) %}
      * `--rewrite-flag` – [флаг](../../concepts/http-rewrite.md#flag). Возможные значения:

          {% include [rewrite-flag-list](../../../_includes/cdn/rewrite-flag-list.md) %}

      Чтобы отключить перенаправление запросов на CDN-ресурсе, используйте параметр `--clear-rewrite`.

      {% include [access-restrictions-cli](../../../_includes/cdn/access-restrictions-cli.md) %}

      Чтобы отключить политику доступа по IP-адресам, используйте параметр `--clear-ip-address-acl`.

      Чтобы добавить или удалить [метки](../../concepts/labels.md), используйте параметры `--add-labels`, `--remove-labels` и `--remove-all-labels`.

      Подробнее о команде `yc cdn resource update` см. в [справочнике CLI](../../../cli/cli-ref/cdn/cli-ref/resource/update.md).

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы изменить параметры CDN-ресурса, созданного с помощью {{ TF }}:

  1. Откройте файл конфигурации {{ TF }} и измените фрагмент с описанием ресурса:

      {% include [create-resource-tf](../../../_includes/cdn/create-resource-tf.md) %}

  1. В командной строке перейдите в папку, где расположен конфигурационный файл {{ TF }}.

  1. Проверьте конфигурацию командой:
     ```bash
     terraform validate
     ```

     Если конфигурация является корректной, появится сообщение:

     ```text
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

     Проверить изменение CDN-ресурса можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

     ```bash
     yc cdn resource list
     ```

- API {#api}

  Воспользуйтесь методом REST API [update](../../api-ref/Resource/update.md) для ресурса [Resource](../../api-ref/Resource/index.md) или вызовом gRPC API [ResourceService/Update](../../api-ref/grpc/Resource/update.md).

  Вы можете ограничить доступ к ресурсу с помощью [защищенных токенов](../../concepts/secure-tokens.md) и [политики доступа по IP-адресам](../../concepts/ip-address-acl.md).

{% endlist %}

{% include [after-changes-tip](../../../_includes/cdn/after-changes-tip.md) %}

## Примеры {#examples}

{% list tabs group=instructions %}

- CLI {#cli}

  Измените протокол для источников с HTTP на HTTPS и выберите сертификат Let's Encrypt®, [добавленный](../../../certificate-manager/operations/managed/cert-create.md) в {{ certificate-manager-name }}, или [загруженный](../../../certificate-manager/operations/import/cert-create.md) собственный сертификат:

    ```bash
    yc cdn resource update s0me1dkfjq******** \
      --origin-protocol HTTPS \
      --cert-manager-ssl-cert-id <идентификатор_сертификата>
    ```

  Результат:

    ```text
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