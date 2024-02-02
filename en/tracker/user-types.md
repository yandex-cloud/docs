# User types

{{ tracker-name }} supports multiple types of user accounts. Select the one that suits you best.

## Yandex ID accounts {#yandex-id}

Organization users can get authenticated using [Yandex ID](https://yandex.ru/support/id/index.html). They can register a Yandex ID account in the following ways:

* [Using an @yandex.ru email address](https://yandex.ru/support/id/authorization/registration.html).
* [Using a social media account](https://yandex.ru/support/id/social.html).
* [Using any other email address](https://yandex.ru/support/id/authorization/lite.html).

Things to remember when using a Yandex ID account:

1. An account is owned by the user.
1. Any organization service can be used: {{ ya-360 }} and {{ org-full-name }} will do equally well.
1. You can remove a user from an organization which will make them lose access to all its data. However, their account will still be available for personal use.

## {{ ya-360 }} accounts {#ya-360}

If you plan to use a {{ ya-360 }} organization, users can be registered using:

* An [organization domain](https://yandex.ru/support/business/domains/add-domain.html) created in {{ ya-360 }}.
* [Single Sign-On (SSO)](https://yandex.ru/support/business/sso.html).

Things to remember when using a Yandex ID account:

1. These are corporate accounts that are not available for personal use.
1. Yandex ID accounts and log-in are supported.
1. Removing a user from an organization deletes their account.
1. Users can be invited to any number of {{ yandex-cloud }} organizations.

## {{ org-full-name }} accounts {#cloud-org}

If you plan to use a {{ org-full-name }} organization, users can be registered using an [identity federation](../organization/concepts/add-federation.md). To log in, users should specify the federation ID or use a dedicated link.

You can set up multiple federations for your organization. Federated users will not be able to log in to any services other than {{ yandex-cloud }} services.

{% note info %}

Please note that an account in Yandex ID and an account in an identity federation are completely different accounts even if the same email address is used.

{% endnote %}