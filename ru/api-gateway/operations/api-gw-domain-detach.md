---
title: Как отключить домен от API-шлюза {{ api-gw-full-name }}
description: Из статьи вы узнаете, как отключить домен от API-шлюза {{ api-gw-full-name }}.
---

# Отключить домен

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится API-шлюз.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
  1. Нажмите на имя нужного API-шлюза.
  1. Перейдите в раздел ![image](../../_assets/api-gateway/domain-icon.svg) **{{ ui-key.yacloud.serverless-functions.gateways.item.switch_domains }}**.
  1. В строке с доменом нажмите кнопку ![image](../../_assets/options.svg) и выберите **{{ ui-key.yacloud.serverless-functions.gateways.domains.button_acton-delete }}**.
  1. Подтвердите отключение.
  1. Удалите ресурсную запись, созданную при подключении домена к API-шлюзу:
      
      * Если ваш домен делегирован {{ dns-name }}:

        1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
        1. Выберите зону, в которой находится домен.
        1. Нажмите ![image](../../_assets/options.svg) в строке записи со значком ![image](../../_assets/api-gateway/service-icon.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.
        1. Подтвердите удаление.

      * Если вашим доменом управляет сторонний DNS-провайдер, удалите запись на странице управления доменом вашего провайдера.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для отключения домена:

      ```bash
      yc serverless api-gateway remove-domain --help
      ```

  1. Выполните команду:

      ```bash
      yc serverless api-gateway remove-domain <идентификатор_API-шлюза> --domain-id <идентификатор_домена>
      ```

  1. Удалите ресурсную запись, созданную при подключении домена к API-шлюзу:
      
      * Если ваш домен делегирован {{ dns-name }}:

        1. Получите список всех записей в зоне DNS, указав идентификатор этой зоны:

            ```
            yc dns zone list-records <идентификатор_зоны_DNS>
            ```
        
            Нужная запись имеет тип `ANAME` и значение вида `{{ api-host-apigw }}`.

        1. Удалите запись:

            ```
            yc dns zone delete-records <идентификатор_зоны_DNS> \
              --record "<доменное_имя> <TTL> <тип_записи> <значение>"
            ```

      * Если вашим доменом управляет сторонний DNS-провайдер, удалите запись на странице управления доменом вашего провайдера.

- API {#api}

  Чтобы отключить домен от API-шлюза, воспользуйтесь методом REST API [removeDomain](../apigateway/api-ref/ApiGateway/removeDomain.md) для ресурса [ApiGateway](../apigateway/api-ref/ApiGateway/index.md) или вызовом gRPC API [ApiGatewayService/RemoveDomain](../apigateway/api-ref/grpc/ApiGateway/removeDomain.md).

  Удалите ресурсную запись, созданную при подключении домена к API-шлюзу:
      
  * Если ваш домен делегирован {{ dns-name }}, воспользуйтесь методом REST API [updateRecordSets](../../dns/api-ref/DnsZone/updateRecordSets.md) для ресурса [DnsZone](../../dns/api-ref/DnsZone/index.md) или вызовом gRPC API [DnsZoneService/UpdateRecordSets](../../dns/api-ref/grpc/DnsZone/updateRecordSets.md).

  * Если вашим доменом управляет сторонний DNS-провайдер, удалите запись на странице управления доменом вашего провайдера.

{% endlist %}