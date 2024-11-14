---
title: How to disconnect a domain from the {{ api-gw-full-name }} gateway
description: In this tutorial, you will learn how to disconnect a domain from the {{ api-gw-full-name }} gateway.
---

# Disconnecting a domain

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the gateway.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
  1. Click the gateway name.
  1. Go to ![image](../../_assets/api-gateway/domain-icon.svg) **{{ ui-key.yacloud.serverless-functions.gateways.item.switch_domains }}**.
  1. Click ![image](../../_assets/options.svg) in the domain row and select **{{ ui-key.yacloud.serverless-functions.gateways.domains.button_acton-delete }}**.
  1. Confirm your action.
  1. Delete the resource record created when connecting the domain to the API gateway:
      
      * If your domain is delegated to {{ dns-name }}:

        1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
        1. Select the zone hosting the domain.
        1. Click ![image](../../_assets/options.svg) in the record row with the ![image](../../_assets/api-gateway/service-icon.svg) icon and select **{{ ui-key.yacloud.common.delete }}**.
        1. Confirm the deletion.

      * If a third-party DNS provider manages your domain, delete the record on the domain management page of your provider.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command for disconnecting a domain:

      ```bash
      yc serverless api-gateway remove-domain --help
      ```

  1. Run this command:

      ```bash
      yc serverless api-gateway remove-domain <API_gateway_ID> --domain-id <domain_ID>
      ```

  1. Delete the resource record created when connecting the domain to the API gateway:
      
      * If your domain is delegated to {{ dns-name }}:

        1. Get a list of all records in the DNS zone by specifying the relevant zone ID:

            ```
            yc dns zone list-records <DNS_zone_ID>
            ```
        
            The record in question is of the `ANAME` type and has a value in `<gateway_ID>.apigw.yandexcloud.net` format.

        1. Delete a record:

            ```
            yc dns zone delete-records <DNS_zone_ID> \
              --record "<domain_name> <TTL> <record_type> <value>"
            ```

      * If a third-party DNS provider manages your domain, delete the record on the domain management page of your provider.

- API {#api}

  To disconnect a domain from an API gateway, use the [removeDomain](../apigateway/api-ref/ApiGateway/removeDomain.md) REST API method for the [ApiGateway](../apigateway/api-ref/ApiGateway/index.md) resource or the [ApiGatewayService/RemoveDomain](../apigateway/api-ref/grpc/ApiGateway/removeDomain.md) gRPC API call.

  Delete the resource record created when connecting the domain to the API gateway:
      
  * If your domain is delegated to {{ dns-name }}, use the [updateRecordSets](../../dns/api-ref/DnsZone/updateRecordSets.md) REST API method for the [DnsZone](../../dns/api-ref/DnsZone/index.md) resource or the [DnsZoneService/UpdateRecordSets](../../dns/api-ref/grpc/DnsZone/updateRecordSets.md) gRPC API call.

  * If a third-party DNS provider manages your domain, delete the record on the domain management page of your provider.

{% endlist %}