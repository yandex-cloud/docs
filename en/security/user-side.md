# Security tools available to cloud service users

## Authentication systems {#auth-syst}

The following types of accounts are currently available to {{ yandex-cloud }} users:

* {% if product == "yandex-cloud" %}[Yandex accounts](#passport-accounts){% endif %}{% if product == "cloud-il" %}[Google accounts](#google-accounts){% endif %}
* [Federated accounts](#fed-accounts)
* [Service accounts](#service-accounts)

{% if product == "yandex-cloud" %}
### Yandex ID accounts {#passport-accounts}

[Yandex ID]{% if lang == "ru" %}(https://yandex.ru/support/passport/index.html){% endif %}{% if lang == "en" %}(https://yandex.com/support/passport/index.html){% endif %} enables authentication and authorization of Yandex users and stores users' personal data. For authentication with your Yandex ID, use your username and password or your PIN and the Yandex.Key app if two-factor authentication is set up. If you pass authentication, Yandex ID sets a cookie for the yandex.TLD domain in your browser. Yandex.ID authenticates users, sets the cookies, and stores the cryptographic keys to control cookie integrity.

The set cookie is used by {{ iam-short-name }} to authenticate the user and issue them an IAM token to access the {{ yandex-cloud }} API. {{ iam-short-name }} stores the cryptographic keys used to control IAM token integrity.

To use the CLI, Yandex ID issues users an OAuth token. It's stored on the user's disk and used to get a temporary IAM token. In all cases, IAM tokens are valid for 24 hours and OAuth tokens are valid for one year from the date of issue. Yandex ID stores the cryptographic keys used to control OAuth token integrity.
{% endif %}
{% if product == "cloud-il" %}
### Google accounts {#google-accounts}

For authentication with your Google account, use your username and password or your PIN and the Google Authenticator app if two-factor authentication is set up.
{% endif %}

### Federated accounts {#fed-accounts}

If an [identity federation](../iam/concepts/federations.md) is used, the {{ iam-short-name }} service accepts a signed SAML token from a third-party identity provider. This token contains information about the authenticated user.

SAML token cryptographic signature keys are stored by the customer's identity provider. Therefore, it's the customer's responsibility to manage, use, and store the key safely. The public part of the key used for verifying the SAML token signature is set by the customer when configuring the identity federation and is then stored in {{ iam-short-name }}.

After receiving and verifying the SAML token signature, {{ iam-short-name }} creates or renews a user session using cookies. {{ iam-short-name }} stores and manages the cryptographic keys used to control cookie integrity.

### Service accounts {#service-accounts}

[Service accounts](../iam/concepts/users/service-accounts.md) are a special type of account for accessing {{ yandex-cloud }} resources on behalf of an application. Service account authentication can be done using the following types of keys:

* Authorized keys: RSA keys that are generated in {{ iam-short-name }}. Such keys can be downloaded by the user only once after their creation. {{ iam-short-name }} only stores the public part of a key. Its private part is stored by the user. It's the user's responsibility to ensure security for the private part. See [Authorized keys](../iam/concepts/authorization/key.md).
* Static keys that are used to access {{ message-queue-short-name }} (YMQ) and {{ objstorage-full-name }}. Copies of static keys are issued to the user immediately after they're created by {{ iam-short-name }}. Static keys are stored in {{ iam-short-name }} and used to check the integrity of requests to YMQ and {{ objstorage-full-name }}. See [Static access keys compatible with the AWS API](../iam/concepts/authorization/access-key.md).
* API keys that are used to access the {{ yandex-cloud }} API. API keys are used in some services for simplified authentication. See [API key](../iam/concepts/authorization/api-key.md).

## Network security {#network-sec}

To protect the cloud network infrastructure hosted in {{ yandex-cloud }}, we recommend managing incoming and outgoing traffic and dividing the virtual networks of the {{ yandex-cloud }} environment into segments based on tasks.

{% if product == "yandex-cloud" %}
For incoming traffic management, you should use a load balancer and VMs without public IPs. This reduces the attack surface and limits traffic to VMs using the appropriate protocols. You can integrate a network load balancer with Yandex DDoS Protection to safeguard your service from DDoS attacks. We recommend using virtual images or cloud services with a Web Application Firewall (WAF) to protect against Layer 7 (L7) DDoS attacks.
{% endif %}
{% if product == "cloud-il" %}
For incoming traffic management, you should use a load balancer and VMs without public IPs. This reduces the attack surface and limits traffic to VMs using the appropriate protocols.
{% endif %}

For outgoing traffic management, we recommend using VMs without public IPs and granting them internet access through a NAT instance that functions as a network gateway or proxy server.

For access control in {{ yandex-cloud }}, you can create a separate network for each of your development teams or each environment (development, testing, and production). With this approach, we recommend using network device images available on {{ marketplace-name }} to link networks to each other and control network flows between segments.

{% if product == "yandex-cloud" %}
We also recommend connecting to your local infrastructure or the internet using a VPN instance, network images from {{ marketplace-name }}, or {{ interconnect-full-name }}.
{% endif %}
{% if product == "cloud-il" %}
We also recommend connecting to your local infrastructure or the internet using a VPN instance.
{% endif %}

## Additional data protection tools {#more-tools}

{{ yandex-cloud }} protects customer data using cryptography tools. The user can additionally secure their data using {{ kms-short-name }} ({{ kms-name }}). It's designed to manage the user's cryptographic keys in {{ yandex-cloud }} and provides additional data encryption features.

Read more in the [{{ kms-full-name }} documentation](../kms/).
