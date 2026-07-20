# {{ certificate-manager-name }} concepts

{{ certificate-manager-name }} is a service to manage [TLS certificates](https://en.wikipedia.org/wiki/Public_key_certificate#TLS/SSL_server_certificate) in {{ yandex-cloud }}. You can use the service to issue and renew Let's Encrypt certificates or add custom certificates.

{% note warning %}

* If using a Let's Encrypt certificate, pass the [domain ownership verification procedure](challenges.md) after you have added it.
* If you have a user certificate, be sure to renew it on time.

{% endnote %}

## Certificate types {#types}

{{ certificate-manager-name }} supports two types of certificates:
* Let's Encrypt certificates (`Managed`): Certificates issued through [Let's Encrypt](https://letsencrypt.org) and managed by {{ certificate-manager-name }}. For more information about these certificates, see [Let's Encrypt certificate](managed-certificate.md).
* Custom certificates (`Imported`): Certificates added by the user. Timely renewal of such certificates is under your own responsibility. For more information about these certificates, see [User certificate](imported-certificate.md).

## Certificate statuses {#statuses}

The lifecycle and statuses of certificates depend on their type.

* Let's Encrypt certificates (`Managed`) can have the following statuses:
  * `Validating`: Certificate was requested from Let's Encrypt and is awaiting a successful domain ownership verification.
  * `Issued`: Certificate was issued and can be used in services integrated with {{ certificate-manager-name }}.
  * `Invalid`: Certificate failed the verification: the domain ownership verification procedure took more than one week or failed.
    * `Renewing`: Certificate is being renewed.
    * `Renewal_failed`: Renewal failed.
* Custom (`Imported`) certificates always have the `Issued` status: the certificate was issued and can be used in services integrated with {{ certificate-manager-name }}.

## Sending notifications to users {#notify}

If the certificate is about to expire and could not be reissued automatically, you will get notified and prompted to pass the domain ownership verification procedure or upload a new version of the certificate.

### Where notifications are sent {#where}

Notifications are sent to:
* The email address specified in the cloud settings.
* Additional email addresses that are subscribed to notifications.

### When notifications are sent {#when}

Deadline for sending notifications:
* 21, 7, and 3 days before the certificate expires.
* After its expiration date.

## Monitoring the status of certificates {#monitoring}

You can set up metrics and alerts for certificate monitoring. You can see metric charts on the service [dashboard](../../monitoring/concepts/visualization/dashboard.md), which is created automatically.

List of certificate metrics:
* `certificate.days_until_expiration`: Shows the real number of days until a certificate's expiration date.

  You can use this metric to create alerts about the upcoming expiration of the certificate.
* `certificate.is_out_of_order`: Shows whether the certificate can be used for a TLS connection.
  * The metric equals one if the certificate cannot be used for a TLS connection, i.e., its status is `Invalid`, `Revoked`, or its validity period has expired.
  * In all other cases, the metric equals zero, including when the certificate's status is `Validating`.

    You can use this metric to create alerts to warn you about an out-of-order certificate.
* `quota.certificates_count.usage`: Shows the current usage of the [quota]({{ link-console-quotas }}) for the number of certificates per cloud.
* `quota.certificates_count.limit`: Shows the current limit on the number of certificates per cloud.

You can use metrics to create alerts. For more information, see [{#T}](../operations/alert.md).

#### Useful links {#see-also}

* [Services integrated with {{ certificate-manager-name }}](services.md)
* [Domain ownership verification](challenges.md)
