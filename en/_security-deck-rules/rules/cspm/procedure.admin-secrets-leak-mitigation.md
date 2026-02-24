### There is a guide for cloud administrators on handling compromised secrets {#admin-secrets-leak-mitigation}

#|
|| **kind** | **severity** | **ID** ||
|| manual | information | procedure.admin-secrets-leak-mitigation ||
|#

#### Description

{% note warning "**Manual check**" %}

Please follow the recommendations and change the rule status.

{% endnote %}

In Yandex Cloud, the [Secret Scanning Service](https://yandex.cloud/en/docs/security/operations/search-secrets) is enabled for everyone by default.
It detects structured cloud secrets that are available in the public domain in the following sources:

* Public GitHub repositories
* Yandex search index
* Helm charts in the Kubernetes marketplace

The following cloud secrets are detected:

* Yandex Cloud Session Cookie
* Yandex Cloud IAM token
* Yandex Cloud API Key
* Yandex Passport OAuth token
* Yandex Cloud AWS API compatible Access Secret
* Yandex Cloud SmartCaptcha Server Key
* Lockbox structured secrets

The service automatically notifies a customer of any found secrets belonging to their infrastructure:

* By email
* Using [Yandex Audit Trails events](https://yandex.cloud/en/docs/audit-trails/concepts/events)

#### Guides and solutions

* Make sure that:
  * [Contact information of the person in charge of an organization is valid](https://yandex.cloud/en/docs/security/standard/authentication#org-contacts)
  * [Yandex Audit Trails is enabled at the organization level](https://yandex.cloud/en/docs/security/standard/audit-logs#audit-trails)
  * [The administrator has read the guide to follow if secrets are compromised](https://yandex.cloud/en/docs/security/operations/search-secrets#secret-is-leaked)
