# Connecting a domain

You can connect your own domain to access the API gateway. You can connect multiple domains to a single API gateway. In this case, the domain is identified by the `Host` header.

{% note warning %}

It must be a third-level domain or lower. For example, you can connect the www.example.com domain but not example.com. This has to do with how CNAME records are processed on DNS hosting. Learn more in [RFC 1912, Section 2.4.](https://www.ietf.org/rfc/rfc1912.txt)

{% endnote %}

To connect a domain to an API gateway:

{% list tabs %}

- Management console

   1. Host a CNAME record with your DNS provider or on your own DNS server:

      ```
      <domain> IN CNAME <API gateway service domain>
      ```

      To find out an API gateway's service domain:

      1. Go to the [management console]({{ link-console-main }}).
      1. Select the folder where the API gateway is located, and in the service list, select **API Gateway**.
      1. Select the API gateway.
      1. You can see the service domain under **General information**.

      Domain names must end in a dot.

   1. In the [management console]({{ link-console-main }}), select the folder containing the API gateway.

   1. In the list of services, select **Certificate Manager** and:

      1. Create a [Let's Encrypt<sup>®</sup> certificate](../../certificate-manager/operations/managed/cert-create.md) or a [user certificate](../../certificate-manager/operations/import/cert-create.md).

         {% note info %}

         Be sure to timely update your certificates. Learn more about updating [Let's Encrypt<sup>®</sup> certificates](../../certificate-manager/operations/managed/cert-update.md) and [user certificates](../../certificate-manager/operations/import/cert-update.md).

         {% endnote %}

      1. Wait for the certificate status to change to `Issued`.

   1. Go back to the folder page.

   1. In the list of services, select **API Gateway** and:

      1. Select the API gateway.
      1. In the window that opens, go to **Domains**.
      1. Click **Connect**, select a certificate, and enter a domain name (FQDN).

- API

   To add a domain to an API gateway, use the [addDomain](../apigateway/api-ref/ApiGateway/addDomain.md) REST API method for the [ApiGateway](../apigateway/api-ref/ApiGateway/index.md) resource or the [ApiGatewayService/AddDomain](../apigateway/api-ref/grpc/apigateway_service.md#AddDomain) gRPC API call.

{% endlist %}
