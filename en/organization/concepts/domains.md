---
title: Domains in {{ org-full-name }}
description: In {{ org-full-name }}, you can associate your domains with user pools and federations. Domains enable users to get authenticated as local users.
---

# Domains


In {{ org-full-name }}, you can [associate](../operations/user-pools/add-domain.md) your domains with [user pools](user-pools.md) or [identity federations](add-federation.md). The domain identifies the user container, e.g., a pool or federation, and the users within it. Such users have names in `<username>@<domain>` format.

You can only associate each domain with one user pool or federation.

To use a domain in a user pool or federation, domain ownership must be [verified](../operations/user-pools/validate-domain.md) via a DNS record.

## Login Discovery {#login-discovery}

_Login Discovery_ in {{ yandex-cloud }} maps users without relying on external authentication providers. This ensures proper authentication flow and streamlines system login for users. The available options for authentication by username and domain (`<username>@<domain>`) are as follows:

* If the domain and username are both associated with the pool, the user will get authenticated as a [local user](../../iam/concepts/users/accounts.md#local).
* If the username and domain match a [federated account](../../iam/concepts/users/accounts.md#saml-federation), the user will get authenticated as a federated user.
* If the username and domain match a [Yandex account](../../iam/concepts/users/accounts.md#passport), the user will be redirected to Yandex ID.
* Where one domain is used both for a Yandex account and for a federated or local account, the system will prompt the user to select the preferred authentication option.

The domain a user specifies must match the domain registered in the user pool, federation, or Yandex ID at all levels.

#### See also {#see-also}

* [{#T}](../operations/user-pools/manage-domain.md)
* [{#T}](../operations/manage-domain-in-federation.md)