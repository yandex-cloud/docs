# Troubleshooting in {{ cdn-name }}

Below is the list of common issues with {{ cdn-name }} and ways to fix them.

## The CDN responds to file requests with 3xx codes (redirect) {#responses-3xx}

Make sure to specify the following [resource](concepts/resource.md) settings:

* Protocol used by the origins as the primary one (HTTP or HTTPS). If origins redirect requests from `http` URIs to `https` URIs, select HTTPS for the resource, and vice versa.
* `Host` HTTP header value to which origins respond without redirects.
  
  > For example, if the header value is set to `www.example.com`, and origins redirect requests with this value to `example.com`, change the value in the settings to `example.com`.

## The CDN responds to file requests with 4xx codes (client error) {#responses-4xx}

Make sure that:

* The resource settings allow end-user access to content.
* Origins return files in response to direct requests, bypassing the CDN.
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
  
Also, check the {{ cdn-name }} status [here](https://status.yandex.cloud/en/dashboard?service=cloud%20cdn).

## Updated settings failed to apply to the resource {#changes-not-applied}

{% include [after-changes-tip](../_includes/cdn/after-changes-tip.md) %}

## The CDN resource has the Not active status, preventing content delivery to users {#resource-not-active}

Resources can show as `Not active` due to receiving no user requests for 90 days or being deactivated manually. To make them active again, [enable](operations/resources/configure-basics.md) **{{ ui-key.yacloud.cdn.field_access }}** in the basic resource settings. To enable or disable resources, you need the `cdn.editor` role or higher.

## Unable to configure the TLS certificate {#tls-certificate}

{% include [lets-encrypt-over](../_includes/cdn/lets-encrypt-over.md) %}

{% include [certificate-usage](../_includes/cdn/certificate-usage.md) %}

Below is an example of a CLI error you receive when the certificate and the CDN resource reside in different folders:

```bash
ERROR: operation (id=bcdb6qaiw8mb********) failed: rpc error: code = InvalidArgument desc = folder ids of user and certificate don't match; operation-id: bcdb6qaiw8mb********
```
