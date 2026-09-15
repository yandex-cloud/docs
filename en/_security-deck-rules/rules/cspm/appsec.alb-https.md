### Yandex Application Load Balancer uses HTTPS {#alb-https}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | high | appsec.alb-https ||
|#

#### Description

**How this rule works:** The rule checks whether Application Load Balancer listeners use HTTPS instead of plain HTTP.

[Application Load Balancer](https://yandex.cloud/en/docs/application-load-balancer) supports both HTTP and HTTPS listeners. With an HTTP listener, traffic between clients and the balancer goes in clear text — anyone with access to the network in between can read or change requests and responses, including credentials, session cookies, and personal data.

Encrypting web traffic with TLS is an industry standard: modern browsers mark plain HTTP sites as insecure, restrict features such as authentication and geolocation on them, and increasingly drop HTTP support for new APIs.

For any service handling user data or authentication, use an HTTPS listener with a [TLS certificate](https://yandex.cloud/en/docs/certificate-manager/concepts/imported-certificate) from [Certificate Manager](https://yandex.cloud/en/docs/certificate-manager/).

**Risks if the rule is not followed:** Without HTTPS, all traffic between users and the load balancer is transmitted in clear text, exposing credentials, session tokens, and personal data to interception or modification by anyone with network access (MITM attacks).

#### Instructions and solutions

Set up an HTTPS listener on the balancer:

1. Add a TLS certificate to [Certificate Manager](https://yandex.cloud/en/docs/certificate-manager/operations/) — [issue one through Let's Encrypt](https://yandex.cloud/en/docs/certificate-manager/operations/managed/cert-create) or [import your own](https://yandex.cloud/en/docs/certificate-manager/operations/import/cert-create).
2. Add an HTTPS listener to the balancer using the [TLS termination guide](https://yandex.cloud/en/docs/application-load-balancer/tutorials/tls-termination/).
3. If the HTTP listener should remain only as a redirect to HTTPS, configure a [redirect from HTTP to HTTPS](https://yandex.cloud/en/docs/application-load-balancer/concepts/http-router#route-types). Otherwise, remove it.
