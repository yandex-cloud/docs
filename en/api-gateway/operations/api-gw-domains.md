# Connecting a domain

You can connect your own domain to access the API gateway. You can connect multiple domains to a single API gateway. In this case, the domain is identified by the `Host` header.

{% note warning %}

If a third-party DNS provider manages your domain, it must be a third-level domain or lower. For example, you can connect the _www.example.com_ domain but not _example.com_. This has to do with how CNAME records are processed on DNS hostings. Learn more in [RFC 1912, section 2.4](https://www.ietf.org/rfc/rfc1912.txt).

To use a top-level domain or higher, delegate it to [{{ dns-full-name }}](../../dns/) and create an [ANAME record](../../dns/concepts/resource-record.md#aname) in the DNS zone.

{% endnote %}

To connect a domain to an API gateway:

{% list tabs group=instructions %}

- Management console {#console}

   1. Add a CNAME record to your DNS provider or to your own DNS server:

      ```
      <domain> IN CNAME <API_gateway_service_domain>
      ```

      To find out an API gateway's service domain:

      1. Go to the [management console]({{ link-console-main }}).
      1. Select the folder where the API gateway is located, and in the service list, select **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
      1. Select the API gateway.
      1. You can see the service domain under **{{ ui-key.yacloud.serverless-functions.gateways.overview.section_base }}**.

      Domain names must end in a dot.

      To use a top-level domain or higher, delegate it to [{{ dns-full-name }}](../../dns/) and create an [ANAME record](../../dns/operations/resource-record-create.md) in the DNS zone. You can create a record in {{ dns-full-name }} both before and after creating the domain. See step 6.

   1. In the [management console]({{ link-console-main }}), select the folder containing the API gateway.

   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}** and:

      1. Add a [Let's Encrypt<sup>®</sup> certificate](../../certificate-manager/operations/managed/cert-create.md) or a [custom certificate](../../certificate-manager/operations/import/cert-create.md) for the domain you are connecting.

         {% note info %}

         Be sure to timely update your certificates. Learn more about updating [Let's Encrypt<sup>®</sup> certificates](../../certificate-manager/operations/managed/cert-update.md) and [user certificates](../../certificate-manager/operations/import/cert-update.md).

         {% endnote %}

      1. Wait for the certificate status to change to `Issued`.

   1. Go back to the folder page.

   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}** and:

      1. Select the API gateway.
      1. In the window that opens, go to ![image](../../_assets/api-gateway/domain-icon.svg) **{{ ui-key.yacloud.serverless-functions.gateways.item.switch_domains }}**.
      1. Click **{{ ui-key.yacloud.serverless-functions.gateways.domains.button_add }}**, select a certificate, and enter a domain name (FQDN).

   1. If you skipped step 1 and did not add a CNAME record, create an ANAME record in {{ dns-full-name }}:

      1. Click **{{ ui-key.yacloud.component.dns-integration.button_add-domain }}** in the domain row.
      1. If you do not have a DNS zone with the same name as the domain, create one. To do this, click **{{ ui-key.yacloud.dns.button_zone-create }}**.
      1. Select a different value in the **{{ ui-key.yacloud.dns.label_form-ttl }}** field, if required.
      1. Click **{{ ui-key.yacloud.common.create }}**.

- API {#api}

   To add a domain to an API gateway, use the [addDomain](../apigateway/api-ref/ApiGateway/addDomain.md) REST API method for the [ApiGateway](../apigateway/api-ref/ApiGateway/index.md) resource or the [ApiGatewayService/AddDomain](../apigateway/api-ref/grpc/apigateway_service.md#AddDomain) gRPC API call.

{% endlist %}
