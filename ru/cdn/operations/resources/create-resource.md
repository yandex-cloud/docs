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
  1. Нажмите кнопку **{{ ui-key.yacloud.cdn.button_resource-create }}**.
  1. Задайте основные настройки CDN-ресурса:

      {% note tip %}

      {% include [copy-configuration](../../../_includes/cdn/copy-configuration.md) %}

      {% endnote %}

      * В блоке **{{ ui-key.yacloud.cdn.label_section-content }}**:
        * Включите или отключите **{{ ui-key.yacloud.cdn.label_access }}**.
        * В поле **{{ ui-key.yacloud.cdn.label_content-query-type }}** выберите `{{ ui-key.yacloud.cdn.value_query-type-one-origin }}` или `{{ ui-key.yacloud.cdn.value_query-type-group-origin }}`:
          * При запросе контента `{{ ui-key.yacloud.cdn.value_query-type-one-origin }}` выберите **{{ ui-key.yacloud.cdn.label_source-type }}**: `{{ ui-key.yacloud.cdn.value_source-type-url }}`, `{{ ui-key.yacloud.cdn.value_source-type-bucket }}` или `{{ ui-key.yacloud.cdn.value_source-type-balancer }}` и укажите [источник](../../concepts/origins.md).
          * При запросе контента `{{ ui-key.yacloud.cdn.value_query-type-group-origin }}` выберите [группу источников](../../concepts/origins.md#groups) или создайте новую:
            1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
            1. Введите **{{ ui-key.yacloud.cdn.field_group-name }}**.
            1. Настройте **{{ ui-key.yacloud.cdn.label_section-origins-list }}**:
                * Укажите **{{ ui-key.yacloud.cdn.label_source-type }}**: `{{ ui-key.yacloud.cdn.value_source-type-url }}`, `{{ ui-key.yacloud.cdn.value_source-type-bucket }}` или `{{ ui-key.yacloud.cdn.value_source-type-balancer }}`.
                * Укажите источник.
                * Выберите **{{ ui-key.yacloud.cdn.field_origin-state }}**: `{{ ui-key.yacloud.cdn.label_status-active }}` или `{{ ui-key.yacloud.cdn.label_status-backup }}`.
            1. Добавьте другие источники, если необходимо.
            1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**. В поле **{{ ui-key.yacloud.cdn.label_origins-group }}** вы увидите название созданной группы источников.

          {% note info %}

          Если CDN-ресурс относится к одному [провайдеру CDN](../../concepts/providers.md), а выбранная существующая группа источников — к другому, будет создан дубликат группы источников под провайдер CDN-ресурса.

          {% endnote %}

          Подробнее см. в разделе [{#T}](../../concepts/origins.md).
        * В поле **{{ ui-key.yacloud.cdn.label_protocol }}** выберите протокол для источников.
        * В поле **{{ ui-key.yacloud.cdn.label_personal-domain }}** укажите основное доменное имя, которое будете использовать в ссылках с сайта на контент, размещенный в CDN. Например: `cdn.example.com`.

          Вы можете добавить более одного **Доменного имени**. Поддерживаются имена с символами не из [ASCII](https://{{ lang }}.wikipedia.org/wiki/ASCII), например, кириллическими, и [Punycode](https://{{ lang }}.wikipedia.org/wiki/Punycode). Первое имя считается основным.

          {% note alert %}

          Основное доменное имя для раздачи контента невозможно изменить после создания CDN-ресурса.

          {% endnote %}

        * (опционально) Добавьте [метки](../../concepts/labels.md):
          1. Нажмите кнопку **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
          1. Введите метку в формате `ключ: значение`.
          1. Нажмите **Enter**.

      * В блоке **{{ ui-key.yacloud.cdn.label_section-additional }}**:
        * В поле **{{ ui-key.yacloud.cdn.label_redirect }}** выберите `{{ ui-key.yacloud.cdn.value_do-not-use }}` или `{{ ui-key.yacloud.cdn.value_redirect-https-to-http }}`.

          Чтобы включить переадресацию клиентов с HTTP на HTTPS, создайте CDN-ресурс без переадресации и получите [TLS-сертификат](../../concepts/clients-to-servers-tls.md) для доменного имени. Затем в настройках CDN-ресурса [выберите](configure-basics.md) переадресацию клиентов `{{ ui-key.yacloud.cdn.value_redirect-http-to-https }}`.
        * В поле **{{ ui-key.yacloud.cdn.label_certificate-type }}** выберите одну из опций:
          * `{{ ui-key.yacloud.cdn.value_certificate-no }}` — ресурс будет доступен только по протоколу HTTP.
          * `{{ ui-key.yacloud.cdn.value_certificate-custom }}` — выберите сертификат. Ресурс будет доступен по протоколам HTTP и HTTPS.

          {% include [certificate-usage](../../../_includes/cdn/certificate-usage.md) %}

          [Подробнее о настройке TLS-сертификатов для HTTPS-соединений](../../concepts/clients-to-servers-tls.md)
        * В поле **{{ ui-key.yacloud.cdn.label_host-header }}** выберите значение: `{{ ui-key.yacloud.cdn.value_host-header-default }}`, `{{ ui-key.yacloud.cdn.value_host-header-resend }}` или выберите `{{ ui-key.yacloud.cdn.value_host-header-custom }}` и введите **{{ ui-key.yacloud.cdn.label_custom-host-header }}**. 
      
          [Подробнее о заголовке Host в запросах CDN-серверов к источникам](../../concepts/servers-to-origins-host.md)
        * (опционально) Чтобы включить [перенаправление запросов](../../concepts/http-rewrite.md) на CDN-ресурсе:
          1. Включите опцию **{{ ui-key.yacloud.cdn.field_rewrite-rule-redirect }}**.
          1. В поле **{{ ui-key.yacloud.cdn.field_rewrite-rule-body }}** задайте правило. Например: `/(.*) /new-folder/$1`.

              {% include [rewrite-rule-description](../../../_includes/cdn/rewrite-rule-description.md) %}

          1. В поле **{{ ui-key.yacloud.cdn.field_rewrite-rule-flag }}** задайте нужный [флаг](../../concepts/http-rewrite.md#flag):

              {% include [rewrite-flag-list](../../../_includes/cdn/rewrite-flag-list.md) %}

        * (опционально) Чтобы ограничить доступ к контенту ресурса с помощью [защищенных токенов](../../concepts/secure-tokens.md), включите опцию **{{ ui-key.yacloud.cdn.field_secure-key-enabled }}**:

          {% include [enable-secure-token](../../../_includes/cdn/enable-secure-token.md) %}

          [Подробнее о доступе по защищенному токену](enable-secure-token.md)

        * {% include [enable-ip-policy](../../../_includes/cdn/enable-ip-policy.md) %}

        * (опционально) Чтобы задать [провайдера CDN](../../concepts/providers.md), включите опцию **Выбрать провайдера** и укажите предпочитаемый вариант.

          По умолчанию выбран провайдер `{{ cdn-full-name }}`.

          {% include [provider-binding](../../../_includes/cdn/provider-binding.md) %}

  1. Нажмите **{{ ui-key.yacloud.common.continue }}**.
  1. (опционально) В разделе **{{ ui-key.yacloud.cdn.label_resource-cache }}**:

      {% include [setup-later](../../../_includes/cdn/setup-later.md) %}

      * В блоке **{{ ui-key.yacloud.cdn.label_resource-cache-cdn-cache }}**:
        * Включите опцию **{{ ui-key.yacloud.cdn.label_resource-cache-cdn-cache-enabled }}**.
        * Выберите тип настроек: `{{ ui-key.yacloud.cdn.label_resource-cache-cdn-cache-settings-type-source-settings }}` или `{{ ui-key.yacloud.cdn.label_resource-cache-cdn-cache-settings-type-custom-settings }}`.
        * Выберите время жизни кеша из списка.
        * (Опционально) Для типа настроек `{{ ui-key.yacloud.cdn.label_resource-cache-cdn-cache-settings-type-custom-settings }}` задайте время жизни кеша для нужных HTTP-кодов ответа.
      * В блоке **{{ ui-key.yacloud.cdn.label_resource-cache-browser-cache }}**:
        * Включите опцию **{{ ui-key.yacloud.cdn.label_resource-cache-browser-cache-enabled }}**.
        * Выберите время жизни кеша из списка.
      * В блоке **{{ ui-key.yacloud.cdn.label_additional }}**:
        * Выберите опцию игнорирования Cookie.
        * Выберите опцию игнорирования Query-параметров.
      * Чтобы контент отправлялся клиентам с CDN-серверов в сжатом виде, выберите опцию **{{ ui-key.yacloud.cdn.label_resource-content-gzip-on }}**.

        Контент будет отправляться в формате gzip и с HTTP-заголовком `Content-Encoding`. Из источников будет запрашиваться только несжатый контент.

        [Подробнее о сжатии файлов](enable-compression.md)

      * Чтобы файлы объемом больше 10 МБ запрашивались и кешировались по частям, каждая размером не больше 10 МБ, выберите опцию **{{ ui-key.yacloud.cdn.label_resource-content-slice }}**.

        Чтобы сегментация работала, источники контента должны поддерживать частичные GET-запросы с заголовком `Range`.

        [Подробнее о сегментации](enable-segmentation.md)

      [Подробнее о кешировании](configure-caching.md)

  1. Нажмите **{{ ui-key.yacloud.common.continue }}**.
  1. В разделе **{{ ui-key.yacloud.cdn.label_resource-http-headers }}**:

      {% include [setup-later](../../../_includes/cdn/setup-later.md) %}

      * В блоке **{{ ui-key.yacloud.cdn.label_resource-http-headers-request-headers }}**:
        * В поле **{{ ui-key.yacloud.cdn.label_headers }}** нажмите **{{ ui-key.yacloud.common.add }}**.
        * Введите имена и значения нужных заголовков.
      * В блоке **{{ ui-key.yacloud.cdn.label_resource-http-headers-response-headers }}**:
        * В поле **{{ ui-key.yacloud.cdn.label_headers }}** нажмите **{{ ui-key.yacloud.common.add }}**.
        * Введите имена и значения нужных заголовков.

        [Подробнее о настройке HTTP-заголовков запросов и ответов](configure-headers.md)
      * В блоке **{{ ui-key.yacloud.cdn.label_resource-http-headers-cors }}**:
        * В поле **{{ ui-key.yacloud.cdn.label_resource-http-headers-cors-access }}** укажите, нужно ли добавлять этот заголовок к ответам.
        * При добавлении заголовка выберите, при каких значениях заголовка `Origin` разрешен доступ к контенту. Чтобы разрешить доступ только определенным источникам, выберите `{{ ui-key.yacloud.cdn.label_resource-http-headers-cors-settings-http-origin-for-source-domains }}`, укажите доменные имена источников и нажмите кнопку **{{ ui-key.yacloud.cdn.button_add-domain }}**.

        [Подробнее о настройке CORS при ответах клиентам](configure-cors.md)

      * В блоке **{{ ui-key.yacloud.cdn.label_resource-http-headers-http-methods }}** выберите **{{ ui-key.yacloud.cdn.label_resource-http-headers-allowed-methods }}** из выпадающего списка.

        [Подробнее о настройке HTTP-методов](configure-http.md)
  1. Нажмите **Создать и продолжить**.
  1. (опционально) В разделе **Дополнительно**:

      {% include [setup-later](../../../_includes/cdn/setup-later.md) %}

      * В блоке **Настройки выгрузки логов** включите выгрузку.

        [Подробнее о выгрузке логов](configure-logs.md)
      * В блоке **Настройки экранирования источников** включите экранирование и в поле **{{ ui-key.yacloud.cdn.label_shielding-location }}** выберите необходимую локацию.

        [Подробнее об экранировании](enable-shielding.md)
  1. Нажмите **{{ ui-key.yacloud.common.continue }}**.

- CLI {#cli}

  {% include [include](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

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

- {{ TF }} {#tf}

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

- API {#api}

  Воспользуйтесь методом REST API [create](../../api-ref/Resource/create.md) для ресурса [Resource](../../api-ref/Resource/index.md) или вызовом gRPC API [ResourceService/Create](../../api-ref/grpc/Resource/create.md).

  Вы можете ограничить доступ к ресурсу с помощью [защищенных токенов](../../concepts/secure-tokens.md) и [политики доступа по IP-адресам](../../concepts/ip-address-acl.md).

{% endlist %}

{% include [get-and-create-cname](../../../_includes/cdn/get-and-create-cname.md) %}

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