---
title: Как создать ресурс в {{ cdn-full-name }}
description: Следуя данной инструкции, вы сможете создать ресурс.
---

# Создание ресурса

Чтобы создать [ресурс](../../concepts/resource.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать ресурс.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
  1. {% include [activate-provider](../../../_includes/cdn/activate-provider.md) %}
  1. Нажмите кнопку **{{ ui-key.yacloud.cdn.button_resource-create }}**.
  1. В блоке **{{ ui-key.yacloud.cdn.label_section-content }}** выберите **{{ ui-key.yacloud.cdn.label_content-query-type }}** `{{ ui-key.yacloud.cdn.value_query-type-one-origin }}` или `{{ ui-key.yacloud.cdn.value_query-type-group-origin }}`:
     * При запросе контента `{{ ui-key.yacloud.cdn.value_query-type-one-origin }}` выберите **{{ ui-key.yacloud.cdn.label_source-type }}**: `{{ ui-key.yacloud.cdn.value_source-type-url }}`, `{{ ui-key.yacloud.cdn.value_source-type-bucket }}` или `{{ ui-key.yacloud.cdn.value_source-type-balancer }}`. Укажите [источник](../../concepts/origins.md).
     * При запросе контента `{{ ui-key.yacloud.cdn.value_query-type-group-origin }}` выберите [группу источников](../../concepts/origins.md#groups) или создайте новую:
        * Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
        * Введите **{{ ui-key.yacloud.cdn.field_group-name }}**.
        * Настройте **{{ ui-key.yacloud.cdn.label_section-origins-list }}**:
           * Укажите **{{ ui-key.yacloud.cdn.label_source-type }}**: `{{ ui-key.yacloud.cdn.value_source-type-url }}`, `{{ ui-key.yacloud.cdn.value_source-type-bucket }}` или `{{ ui-key.yacloud.cdn.value_source-type-balancer }}`.
           * Укажите источник.
           * Выберите **{{ ui-key.yacloud.cdn.field_origin-state }}**: `{{ ui-key.yacloud.cdn.label_status-active }}` или `{{ ui-key.yacloud.cdn.label_status-backup }}`.
        * Добавьте другие источники, если необходимо.
        * Нажмите кнопку **{{ ui-key.yacloud.common.create }}**. В поле **{{ ui-key.yacloud.cdn.label_origins-group }}** вы увидите название созданной группы источников.

     Подробнее см. в разделе [{#T}](../../concepts/origins.md).

  1. При необходимости добавьте [метки](../../concepts/labels.md):

      1. Нажмите кнопку **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
      1. Введите метку в формате `ключ: значение`.
      1. Нажмите **Enter**.

  1. В блоке **{{ ui-key.yacloud.cdn.label_section-domain }}** введите **{{ ui-key.yacloud.cdn.label_personal-domain }}**. Вы можете добавить более одного **Доменного имени**. Поддерживаются имена с символами не из [ASCII](https://{{ lang }}.wikipedia.org/wiki/ASCII), например, кириллическими, и [Punycode](https://{{ lang }}.wikipedia.org/wiki/Punycode). Первое имя считается основным.

     {% note warning %}

     После создания ресурса изменить основное имя будет невозможно.

     {% endnote %}

     В настройках вашего DNS-хостинга создайте для указанных доменных имен [записи CNAME](../../../dns/concepts/resource-record.md#cname) со значением, которое отображается внизу блока **{{ ui-key.yacloud.cdn.label_section-domain }}**. Подробнее см. в разделе [{#T}](../../concepts/resource.md#hostnames).
  1. В блоке **{{ ui-key.yacloud.cdn.label_section-additional }}**:
     1. Выберите **{{ ui-key.yacloud.cdn.label_protocol }}**.
     1. Выберите способ переадресации клиентов: `{{ ui-key.yacloud.cdn.value_do-not-use }}` или `{{ ui-key.yacloud.cdn.value_redirect-https-to-http }}`.

        Чтобы включить переадресацию клиентов с HTTP на HTTPS, создайте CDN-ресурс без переадресации и получите [TLS-сертификат](../../concepts/clients-to-servers-tls.md) для доменного имени. Затем в настройках CDN-ресурса [выберите](configure-basics.md) переадресацию клиентов `{{ ui-key.yacloud.cdn.value_redirect-http-to-https }}`.
     1. Включите или выключите **{{ ui-key.yacloud.cdn.label_access }}**.
     1. В поле **{{ ui-key.yacloud.cdn.label_certificate-type }}** выберите одну из опций:
         * `{{ ui-key.yacloud.cdn.value_certificate-no }}` — ресурс будет доступен только по протоколу HTTP.


         * `{{ ui-key.yacloud.cdn.value_certificate-custom }}` — выберите сертификат. Ресурс будет доступен по протоколам HTTP и HTTPS.

           {% include [lets-encrypt-over](../../../_includes/cdn/lets-encrypt-over.md) %}

           {% include [certificate-usage](../../../_includes/cdn/certificate-usage.md) %}

         Подробнее см. в разделе [{#T}](../../concepts/clients-to-servers-tls.md).
     1. Выберите значение **{{ ui-key.yacloud.cdn.label_host-header }}**: `{{ ui-key.yacloud.cdn.value_host-header-default }}`, `{{ ui-key.yacloud.cdn.value_host-header-resend }}` или выберите `{{ ui-key.yacloud.cdn.value_host-header-custom }}` и введите **{{ ui-key.yacloud.cdn.label_custom-host-header }}**. Подробнее см. в разделе [{#T}](../../concepts/servers-to-origins-host.md).
     1. Чтобы включить [перенаправление запросов](../../concepts/http-rewrite.md) на CDN-ресурсе:

         1. Включите опцию **{{ ui-key.yacloud.cdn.field_rewrite-rule-redirect }}**.
         1. В поле **{{ ui-key.yacloud.cdn.field_rewrite-rule-body }}** задайте правило. Например: `/(.*) /new-folder/$1`.

             {% include [rewrite-rule-description](../../../_includes/cdn/rewrite-rule-description.md) %}

         1. В поле **{{ ui-key.yacloud.cdn.field_rewrite-rule-flag }}** задайте нужный [флаг](../../concepts/http-rewrite.md#flag):

             {% include [rewrite-flag-list](../../../_includes/cdn/rewrite-flag-list.md) %}

     1. Чтобы ограничить доступ к контенту ресурса с помощью [защищенных токенов](../../concepts/secure-tokens.md), включите опцию **{{ ui-key.yacloud.cdn.field_secure-key-enabled }}**:

          {% include [enable-secure-token](../../../_includes/cdn/enable-secure-token.md) %}

        Подробнее см. в разделе [{#T}](enable-secure-token.md).

     1. {% include [enable-ip-policy](../../../_includes/cdn/enable-ip-policy.md) %}

  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [include](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Если вы создаете первый ресурс, сначала подключитесь к провайдеру:

     ```bash
     yc cdn provider activate --type gcore
     ```

  1. Посмотрите описание команды [CLI](../../../cli/) для создания ресурсов:

     ```bash
     yc cdn resource create --help
     ```

  1. Получите список [групп источников](../../concepts/origins.md#groups) в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder):

     ```bash
     yc cdn origin-group list --format yaml
     ```

     Результат:

     ```text
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

     * Вместо группы источников `--origin-group-id` можно указать доменное имя [источника](../../concepts/origins.md), используя параметр `--origin-custom-source`.
     * Для `--origin-protocol` доступны значения `HTTP`, `HTTPS` и `MATCH` (как у клиента).

     {% include [certificate-settings-cli](../../../_includes/cdn/certificate-settings-cli.md) %}

     Чтобы включить [перенаправление запросов](../../concepts/http-rewrite.md) на CDN-ресурсе, используйте параметры:

     * `--rewrite-body` – правило Rewrite. Например: `--rewrite-body '/(.*) /new-folder/$1'`.

         {% include [rewrite-rule-description](../../../_includes/cdn/rewrite-rule-description.md) %}

     * `--rewrite-flag` – [флаг](../../concepts/http-rewrite.md#flag). Возможные значения:

         {% include [rewrite-flag-list](../../../_includes/cdn/rewrite-flag-list.md) %}

     * Чтобы добавить [метки](../../concepts/labels.md), используйте параметр `--add-labels`. Например: `--add-labels key1=value1`.

     {% include [access-restrictions-cli](../../../_includes/cdn/access-restrictions-cli.md) %}

     Подробнее о команде `yc cdn resource create` см. в [справочнике CLI](../../../cli/cli-ref/cdn/cli-ref/resource/create.md).
  1. Получите значение [CNAME-записи](../../../dns/concepts/resource-record.md#cname) для CDN-ресурса:

     ```bash
     yc cdn resource get-provider-cname
     ```

     Результат:

     ```text
     cname: cl-ms6*****90.edgecdn.ru
     folder_id: b1gt6g8ht345********
     ```

  1. В сервисе [{{ dns-full-name }}](../../../dns/) [создайте ресурсную запись](../../../dns/operations/resource-record-create.md) с полученным значением.

- {{ TF }} {#tf}

  Провайдер CDN должен быть активирован до создания ресурса. Сделать это можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/):

  ```bash
  yc cdn provider activate \
    --folder-id <идентификатор_каталога> \
    --type gcore
  ```

  Где:
  * `--folder-id` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md), в котором вы хотите активировать провайдера CDN.
  * `--type` — тип провайдера: единственное возможное значение — `gcore`.

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры создаваемого CDN-ресурса:

     {% include [create-resource-tf](../../../_includes/cdn/create-resource-tf.md) %}

  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} создаст все требуемые ресурсы. Проверить создание CDN-ресурса можно в [консоли управления]({{ link-console-main }}) или с помощью команды CLI:

     ```bash
     yc cdn resource list
     ```

  1. Получите значение [CNAME-записи](../../../dns/concepts/resource-record.md#cname) для CDN-ресурса:

     ```bash
     yc cdn resource get-provider-cname
     ```

     Результат:

     ```text
     cname: cl-ms6*****90.edgecdn.ru
     folder_id: b1gt6g8ht345********
     ```

  1. В сервисе [{{ dns-full-name }}](../../../dns/) [создайте ресурсную запись](../../../dns/operations/resource-record-create.md) с полученным значением.

- API {#api}

  Если вы создаете первый ресурс, подключитесь к провайдеру CDN. Для этого воспользуйтесь методом REST API [activate](../../api-ref/Provider/activate.md) для ресурса [Provider](../../api-ref/Provider/index.md) или вызовом gRPC API [ProviderService/Activate](../../api-ref/grpc/Provider/activate.md).
  1. Воспользуйтесь методом REST API [create](../../api-ref/Resource/create.md) для ресурса [Resource](../../api-ref/Resource/index.md) или вызовом gRPC API [ResourceService/Create](../../api-ref/grpc/Resource/create.md).

     Вы можете ограничить доступ к ресурсу с помощью [защищенных токенов](../../concepts/secure-tokens.md) и [политики доступа по IP-адресам](../../concepts/ip-address-acl.md).
  1. Создайте [CNAME-запись](../../../dns/concepts/resource-record.md#cname) для CDN-ресурса в [{{ dns-full-name }}](../../../dns):
     * Чтобы получить значение CNAME-записи для CDN-ресурса, воспользуйтесь методом REST API [getProviderCName](../../api-ref/Resource/getProviderCName.md) для ресурса [Resource](../../api-ref/Resource/index.md) или вызовом gRPC API [ResourceService/GetProviderCName](../../api-ref/grpc/Resource/getProviderCName.md).
     * Чтобы создать ресурсную запись в зоне DNS, воспользуйтесь методом REST API [updateRecordSets](../../../dns/api-ref/DnsZone/updateRecordSets.md) для ресурса [DnsZone](../../../dns/api-ref/DnsZone/index.md) или вызовом gRPC API [DnsZoneService/UpdateRecordSets](../../../dns/api-ref/grpc/DnsZone/updateRecordSets.md).

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

  ```text
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