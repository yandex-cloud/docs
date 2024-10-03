# Fixing the "You cannot enable redirect HTTP to HTTPS when HTTPS is disabled" error


## Issue description {#issue-description}

When trying to create a CDN resource, you see this error:
```
status": 400,
"message": "error: general api error: {"options":{"redirect_http_to_https":{"enabled":["You cannot enable redirect HTTP to HTTPS when HTTPS is disabled. Please enable HTTPS and add SSL certificate first"]}}}",
"code": "GATEWAY_REQUEST_ERROR",
"title": "Error",
"description": "error: general api error: {"options":{"redirect_http_to_https":{"enabled":["You cannot enable redirect HTTP to HTTPS when HTTPS is disabled. Please enable HTTPS and add SSL certificate first"]}}}",
"details": {
"grpcCode": 3
}

```
## Solution {#issue-resolution}

Before enabling the HTTP to HTTPS redirect option, you need to set up HTTPS for the domain. Namely, you need to create or add an existing certificate for the domain name to be used for content distribution via CDN.

The certificate is added in [Certificate Manager](https://cloud.yandex.ru/docs/certificate-manager/quickstart/).

In the CDN creation dialog, specify the certificate stored in Certificate Manager. After this, you can enable request redirect from HTTP to HTTPS.

{% note info %}

Our CDN host partner provider, G-Core Labs, has changed the logic of CDN creation. Now, users are required to enable HTTPS on their sources; for this reason, we changed handling of resource creation on our side.

{% endnote %}

## If the issue persists {#if-issue-still-persists}

If the above actions didn't help, [create a request for support](https://console.cloud.yandex.ru/support?section=contact).
When creating a request, please attach a screenshot of your settings page.

Please also create a resource with HTTPS and a certificate request enabled. Once HTTPS is set up, activate the redirect from HTTP to HTTPS.
