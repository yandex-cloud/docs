### Yandex Cloud CDN uses HTTPS and its own SSL certificate {#cdn-https}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | low | appsec.cdn-https ||
|#

#### Description

[Cloud CDN](https://yandex.cloud/en/docs/cdn) supports two paths that can carry user traffic in clear text: from the client to the CDN edge and from the CDN edge to the origin. If either path uses HTTP, traffic between users and the origin (including authentication cookies and other sensitive data) can be read or modified by anyone on the network in between.

Encrypting web traffic with TLS is an industry standard: modern browsers mark plain HTTP sites as insecure and restrict features such as authentication and geolocation on them. The recommended setup for a CDN resource is HTTPS on both legs — from the client to the edge and from the edge to the origin — using a [TLS certificate](https://yandex.cloud/en/docs/certificate-manager/concepts/imported-certificate) from [Certificate Manager](https://yandex.cloud/en/docs/certificate-manager/).

**Risks if the rule is not followed:** Without HTTPS on CDN paths, authentication cookies, session tokens, and other sensitive data transmitted between users and the origin can be intercepted or modified by attackers with network access, enabling session hijacking and data theft.

#### Instructions and solutions

Configure HTTPS for the CDN resource:

1. Add a TLS certificate to [Certificate Manager](https://yandex.cloud/en/docs/certificate-manager/operations/) — [issue one through Let's Encrypt](https://yandex.cloud/en/docs/certificate-manager/operations/managed/cert-create) or [import your own](https://yandex.cloud/en/docs/certificate-manager/operations/import/cert-create).
2. [Enable HTTPS on the CDN resource](https://yandex.cloud/en/docs/cdn/operations/resources/configure-basics) and select the certificate.
3. Configure the CDN to connect to the origin over HTTPS, and enable redirect from HTTP to HTTPS for client-side traffic.
