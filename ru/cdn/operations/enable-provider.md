---
title: Как подключиться к провайдеру {{ cdn-full-name }}
description: Следуя данной инструкции, вы сможете подключиться к провайдеру {{ cdn-full-name }}.
---

# Подключение к провайдеру {{ cdn-name }}

Создать в [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder) CDN-ресурс и группу источников можно только в том случае, если этот каталог подключен к CDN-провайдеру. При подключении к CDN-провайдеру для каталога генерируется уникальное значение `cname`, которое необходимо для создания [ресурсных записей](../../dns/concepts/resource-record.md#cname) CNAME на CDN-ресурсы.

Чтобы подключить каталог к CDN-провайдеру и получить значение `cname`:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, который нужно подключить к CDN-провайдеру.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
  1. Если CDN-провайдер еще не активирован, нажмите кнопку **{{ ui-key.yacloud.cdn.label_activate-provider-empty-container_action-text }}**. Подключение произойдет автоматически.

      Если кнопки **{{ ui-key.yacloud.cdn.label_activate-provider-empty-container_action-text }}** нет и вам доступно создание ресурсов и групп источников — провайдер уже активирован.

  1. Значение `cname` для создания [ресурсных записей](../../dns/concepts/resource-record.md#cname) на CDN-ресурсы отображается в блоках:
      * **{{ ui-key.yacloud.cdn.label_section-domain }}** при создании CDN-ресурса.
      * **{{ ui-key.yacloud.cdn.label_dns-settings_title }}** на странице информации о CDN-ресурсе.

- CLI {#cli}

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  1. Подключитесь к провайдеру:

      ```bash
      yc cdn provider activate --type gcore
      ```

  1. Получите значение CNAME-записи для CDN-ресурса:

      ```bash
      yc cdn resource get-provider-cname
      ```

      Результат:

      ```yaml
      cname: cl-ms6*****90.edgecdn.ru
      folder_id: b1gt6g8ht345********
      ```

- API {#api}

  Чтобы подключиться к провайдеру, воспользуйтесь методом REST API [activate](../../cdn/api-ref/Provider/activate.md) для ресурса [Provider](../../cdn/api-ref/Provider/index.md) или вызовом gRPC API [ProviderService/Activate](../../cdn/api-ref/grpc/provider_service.md#Activate).

  Чтобы получить значение `cname` для каталога, воспользуйтесь методом REST API [getProviderCName](../../cdn/api-ref/Resource/getProviderCName.md) для ресурса [Resource](../../cdn/api-ref/Resource/index.md) или вызовом gRPC API [ResourceService/GetProviderCName](../../cdn/api-ref/grpc/resource_service.md#GetProviderCName).

{% endlist %}