### API gateways use HTTPS and their own domains {#api-gateway-https}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | medium | appsec.api-gateway-https ||
|#

#### Description

[Yandex API Gateway](https://yandex.cloud/en/docs/api-gateway/) ensures secure connections over HTTPS. You can link your own domain and upload your own [security certificate](https://yandex.cloud/en/docs/certificate-manager/concepts/#types) to access your [API gateway](https://yandex.cloud/en/docs/api-gateway/concepts/) over HTTPS.

Without using the HTTPS protocol, traffic between the client and API gateway is transmitted unencrypted, running the following risks:

* Hackers intercepting data via, for example, MITM (man-in-the-middle) attacks.
* Leaks of confidential information, such as personal data, payment data, authorization tokens, passwords, etc.

#### Guides and solutions

Guides and solutions to use:

1. In the [management console](https://console.yandex.cloud/), select the folder the API gateway is in.
1. [Go](https://yandex.cloud/en/docs/console/operations/select-service#select-service) to API Gateway and in the window that opens, click the line with the API gateway in question.
1. In the left-hand menu, select **Domains** and click **Attach**.
1. In the window that opens, select a TLS certificate and specify the domain name matching this certificate.
1. Click **Attach**.