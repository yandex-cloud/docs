# Fixing the `You cannot enable redirect HTTP to HTTPS when HTTPS is disabled` error



## Issue description {#issue-description}

When trying to create a CDN resource, you get this error:
```
"status": 400,
"message": "error: general api error: {"options":{"redirect_http_to_https":{"enabled":["You cannot enable redirect HTTP to HTTPS when HTTPS is disabled. Please enable HTTPS and add SSL certificate first"]}}}",
"code": "GATEWAY_REQUEST_ERROR",
"title": "Error",
"description": "error: general api error: {"options":{"redirect_http_to_https":{"enabled":["You cannot enable redirect HTTP to HTTPS when HTTPS is disabled. Please enable HTTPS and add SSL certificate first"]}}}",
"details": {
"grpcCode": 3
}

```
## Solution {#issue-resolution}

Before enabling HTTP to HTTPS redirects, you need to set up HTTPS for your domain. Namely, you need to create or add an existing certificate for the domain name to use for content distribution via CDN.

Add the certificate using [{{ certificate-manager-name }}](../../../certificate-manager/quickstart/index.md).

In the CDN creation dialog box, specify the certificate stored in {{ certificate-manager-name }}. After this, you can enable request redirects from HTTP to HTTPS.

{% note info %}

Our CDN host provider, G-Core Labs, has changed its logic of CDN creation. Now, users are required to enable HTTPS on their sources; for this reason, we changed handling of resource creation on our side.

{% endnote %}

## If the issue persists {#if-issue-still-persists}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). When creating a request, please attach a screenshot of your settings page.

We also recommend that you create a resource with HTTPS and a certificate request enabled. Once HTTPS is set up, enable redirects from HTTP to HTTPS.