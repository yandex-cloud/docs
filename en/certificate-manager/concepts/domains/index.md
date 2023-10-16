---
title: "Domain"
description: "A domain is a unique domain name that can be used in {{ yandex-cloud }} services that require confirmation of the user's rights to the domain."
---

# Domain

{% include [preview-stage](../../../_includes/certificate-manager/preview-stage.md) %}

A domain is a unique domain name that can be used in [{{ yandex-cloud }} services](services.md) that require confirmation of the user's rights to the domain.

## Confirming rights for domains {#confirmation}

To confirm your ownership of a domain, link a valid [Let's Encrypt certificate](../managed-certificate.md) to it. Once you confirm your rights, no other user will be able to confirm their rights to a domain with the same domain name.

{% note warning %}

* You can't create a domain that was confirmed by another user.
* The period of domain ownership after its confirmation is one year.

   After this period expires, you need to confirm domain ownership again.

{% endnote %}

## Domain statuses {#statuses}

Domains can have the following statuses:
* `Validating`: The domain is pending the domain rights check.
* `Valid`: The domain is confirmed and can be used in services integrated with {{ certificate-manager-name }}.
* `Invalid`: The domain failed the domain rights check.
* `Revalidating`: The domain is pending the domain rights recheck as the previous check validity expired.

#### See also {#see-also}

- [Services integrated with the domain management system](services.md)
- [Check rights for domain](../challenges.md)
