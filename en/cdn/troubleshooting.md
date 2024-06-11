# Troubleshooting in {{ cdn-name }}

Below is the list of the most frequent issues with {{ cdn-name }} and ways to resolve them.

## The CDN responds to file requests with 3xx codes (redirect) {#responses-3xx}

Check that the [resource](concepts/resource.md) settings include:

* Protocol used by the origins as the primary one (HTTP or HTTPS). If origins redirect requests from a URI with the `http` scheme to a URI with the `https` scheme, you must select the HTTPS protocol for the resource, and vice versa.
* Value of the HTTP `Host` header from which origins do not redirect requests.

   > For example, if the header value is configured as `www.example.com`, and the origins redirect requests with this value to `example.com`, change the value in the settings to `example.com`.

## The CDN responds to file requests with 4xx codes (client error) {#responses-4xx}

Make sure that:

* End-client access to the content is allowed in the resource settings.
* Origins return files in response to direct requests (bypassing the CDN).
* Origins allow and correctly process requests that match the resource settings:

   * Over the specified protocol: HTTP or HTTPS.
   * With the specified value of the `Host` HTTP header and other headers.

## The CDN responds to file requests with 5xx codes (server error) {#responses-5xx}

{% include [ipv4-note](../_includes/cdn/ipv4-note.md) %}

Make sure that:

* Origins respond to CDN server requests within 5 seconds.
* Origins allow and correctly process requests that match the resource settings:

   * Over the specified protocol: HTTP or HTTPS.
   * With the specified value of the `Host` HTTP header and other headers.

Also check the {{ cdn-name }} status on the [{{ yandex-cloud }} special page](https://status.yandex.cloud/en/dashboard?service=cloud%20cdn).

## Updated settings are not applied to the resource {#changes-not-applied}

{% include [after-changes-tip](../_includes/cdn/after-changes-tip.md) %}

## A CDN resource has the Not active status and content is not available to users {#resource-not-active}

Resources may have the `Not active` status due to receiving no user requests for 90 days or being deactivated manually. To make them active again, [enable](operations/resources/configure-basics.md) the **{{ ui-key.yacloud.cdn.field_access }}** option in the basic resource settings. Resources can be activated and deactivated by users with the `cdn.editor` role or higher.

## Unable to configure the TLS certificate {#tls-certificate}

{% include [lets-encrypt-over](../_includes/cdn/lets-encrypt-over.md) %}

{% include [certificate-usage](../_includes/cdn/certificate-usage.md) %}

Below is an example of a CLI error you receive when the certificate and the CDN resource are located in different folders:

```bash
ERROR: operation (id=bcdb6qaiw8mb********) failed: rpc error: code = InvalidArgument desc = folder ids of user and certificate don't match; operation-id: bcdb6qaiw8mb********
```
