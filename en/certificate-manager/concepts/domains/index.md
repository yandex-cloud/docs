---
title: Domain
description: A domain is a unique domain name you can use in {{ yandex-cloud }} services that require a confirmation of the user's domain rights.
---

# Domain

{% include [preview-stage](../../../_includes/certificate-manager/preview-stage.md) %}

A domain is a unique domain name you can use in [{{ yandex-cloud }} services](services.md) that require a confirmation of the user's domain rights.

## Confirming rights for domains {#confirmation}

To confirm your ownership of a domain, link a valid [Let's Encrypt certificate](../managed-certificate.md) to it. Once you confirm your rights, no other user will be able to confirm their rights to a domain with the same domain name.

{% note warning %}

* You cannot add a domain confirmed by another user.
* The period of domain ownership after its confirmation is one year.
 
    After this period expires, you need to confirm the domain ownership again.

{% endnote %}

## Domain statuses {#statuses}

Domains can have the following statuses:
* `Validating`: Domain is awaiting a successful domain rights check.
* `Valid`: Domain has been confirmed and can be used in services integrated with {{ certificate-manager-name }}.
* `Invalid`: Domain failed the domain rights check.
* `Revalidating`: Domain is awaiting a repeat domain rights check as the previous one has expired.

#### See also {#see-also}

- [Services integrated with the domain management system](services.md)
- [Domain rights check](../challenges.md)
