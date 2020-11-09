# Concepts {{ certificate-manager-name }}

{{ certificate-manager-name }} is a service for managing [TLS certificates](https://en.wikipedia.org/wiki/Public_key_certificate#TLS/SSL_server_certificate) in {{ yandex-cloud }}. You can use the service to obtain and update Let's Encrypt<sup>®</sup> certificates and add your own certificates.

{% note warning %}

* If you use a Let's Encrypt certificate, [check domain rights](challenges.md) after you add it.
* If you have a user certificate, be sure to renew it on time.

{% endnote %}

## Certificate types {#types}

{{ certificate-manager-name }} supports two types of certificates:

* Let's Encrypt certificates (`Managed` certificates): Certificates issued through [Let's Encrypt](https://letsencrypt.org) and managed by {{ certificate-manager-name }}. For more information about these certificates, see [Let's Encrypt certificate](managed-certificate.md).
* User certificates (`Imported` certificates): Certificates added by the user. You are responsible for renewing these certificates on time. For more information about these certificates, see [User certificate](imported-certificate.md).

## Certificate statuses {#statuses}

The lifecycle and statuses of certificates depend on their type.

* Let's Encrypt certificates (`Managed` certificates) can have the following statuses:
    * `Validating`: The certificate was requested from Let's Encrypt and is pending the domain rights check.
    * `Issued`: The certificate was obtained and can be used in services integrated with {{ certificate-manager-name }}.
    * `Invalid`: The certificate failed the check (the domain rights check took more than one week or failed).
    * `Renewing`: The certificate is being renewed.
    * `Renewal_failed`: The certificate failed to renew.
* User certificates (`Imported` certificates) always have the `Issued` status: the certificate was obtained and can be used in services integrated with {{ certificate-manager-name }}.

## Sending notifications to users {#notify}

If the certificate is about to expire and the service failed to reissue it automatically, you're sent a notification asking you to pass the rights check for a domain or upload a new version of the certificate yourself.

### Where notifications are sent {#where}

Notifications are sent to:

* The email address specified in the cloud settings.
* Additional email addresses that are subscribed to notifications.

### When notifications are sent {#when}

Deadline for sending notifications:

* 21, 7, and 3 days before the certificate expires.
* After its expiration date.

#### See also {#see-also}

- [Services integrated with {{ certificate-manager-name }}](services.md)
- [Check rights for domain](challenges.md)

