---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Security tools available to cloud service users

## Authentication systems {#auth-syst}

The following types of accounts are currently available to Yandex.Cloud users:

- [Yandex.Passport accounts](#passport-accounts)
- [Federated accounts](#fed-accounts)
- [Service accounts](#service-accounts)

### Yandex.Passport accounts {#passport-accounts}

[Yandex.Passport](https://yandex.com/support/passport/index.html) enables authentication and authorization of Yandex users and stores users' personal data. For authentication via Yandex.Passport, use your username and password or your PIN and the Yandex.Key app if two-factor authentication is set up. If you pass authentication, Yandex.Passport installs a cookie for the yandex.TLD domain in your browser. Yandex.Passport authenticates users, sets the cookies, and stores the cryptographic keys to control cookie integrity.

The set cookie is used by {{ iam-short-name }} to authenticate the user and issue them an IAM token to access the Yandex.Cloud API. {{ iam-short-name }} stores the cryptographic keys used to control IAM token integrity.

To use the CLI, Yandex.Passport issues users an OAuth token. It's stored on the user's disk and used to get a temporary IAM token. In all cases, IAM tokens are valid for 24 hours and OAuth tokens are valid for one year from the date of issue. Yandex.Passport stores the cryptographic keys used to control OAuth token integrity.

### Federated accounts {#fed-accounts}

If you use an [identity federation](../../iam/concepts/users/identity-federations), {{ iam-short-name }} accepts a signed SAML token from a third-party identity provider. This token contains information about the authenticated user.

SAML token cryptographic signature keys are stored by the customer's identity provider. Therefore, it's the customer's responsibility to manage, use, and store the key safely. The public part of the key used for verifying the SAML token signature is set by the customer when configuring the identity federation and is then stored in {{ iam-short-name }}.

After receiving and verifying the SAML token signature, {{ iam-short-name }} sets a cookie for the cloud.yandex.TLD domain for the user. {{ iam-short-name }} stores and manages the cryptographic keys used to control cookie integrity.

### Service accounts {#service-accounts}

[Service accounts](../../iam/concepts/users/service-accounts) are special accounts used to access Yandex.Cloud resources on behalf of an application. Service account authentication can be done using the following types of keys:

- Authorized keys: RSA keys that are generated in {{ iam-short-name }}. Such keys can be downloaded by the user only once after their creation. {{ iam-short-name }} only stores the public part of a key. Its private part is stored by the user. It's the user's responsibility to ensure security for the private part. See Authorized keys.
- Static keys that are used to access {{ message-queue-short-name }} (YMQ) and {{ objstorage-full-name }}. Copies of static keys are issued to the user immediately after they're created by {{ iam-short-name }}. Static keys are stored in {{ iam-short-name }} and used to check the integrity of requests to YMQ and {{ objstorage-full-name }}. See Static access keys compatible with the AWS API.
- API keys that are used to access the Yandex.Cloud API. API keys are used in some services for simplified authentication. See the API key section.

## Network security {#network-sec}

To protect the cloud network infrastructure hosted in Yandex.Cloud, we recommend managing incoming and outgoing traffic and dividing the virtual networks of Yandex.Cloud environment into segments based on tasks.

For incoming traffic management, you should use a load balancer and VMs without public IPs. This reduces the attack surface and limits traffic to VMs using the appropriate protocols. You can integrate the network load balancer with Yandex DDoS Protection to safeguard your service from DDoS attacks. We recommend using virtual images or cloud services with a Web Application Firewall (WAF) to protect against Layer 7 (L7) DDoS attacks.

For outgoing traffic management, we recommend using VMs without public IPs and granting them internet access through a NAT instance that functions as a network gateway or proxy server.

For access restriction in Yandex.Cloud, you can create a separate network for each of your development teams or each environment (development, testing, production). With this approach, we recommend using network device images available on Yandex Cloud Marketplace to link networks to each other and control network flow between segments.

We also recommend connecting to your local infrastructure or the internet using a VPN instance, network images from Yandex Cloud Marketplace, or Yandex Cloud Interconnect.

## Additional data protection tools {#more-tools}

Yandex.Cloud protects customer data using cryptography tools. The user can additionally secure their data using {{ kms-short-name }} ({{ kms-name }}). It's designed to manage the user's cryptographic keys in Yandex.Cloud and provides additional data encryption features.

Read more in the [{{ kms-full-name }} documentation](../../kms/).

