# Enabling {{ wiki-full-name }}

Users of organizations registered on the {{ yandex-cloud }} platform can use {{ wiki-full-name }} to create a corporate knowledge base. For more information about {{ wiki-full-name }} features, see [{#T}](overview.md).

You can enable {{ wiki-full-name }} for an existing organization or create a new one. For more information about organizations, see the documentation [{{ org-full-name }}](../organization/).

## Activate {{ wiki-name }} in the existing organization {#current-org}

If you already have an organization in {{ org-full-name}}, {{ wiki-full-name }} is automatically activated when any user of the organization logs in for the first time:

1. Go to the {{ wiki-name }} homepage: [{{ link-wiki }}]({{ link-wiki }}).

1. [Log in](login.md) to the account you use to work in the organization.

1. If your account is registered in several organizations, select the one where you want to activate {{ wiki-full-name }}. Then click **{{ ui-key.yacloud.common.continue }}**.

## Migrating to {{ wiki-name }} from Confluence

If you are using Confluence and want to migrate to {{ wiki-full-name }}, our experts will help you migrate your posts to {{ wiki-name }}. To do this, [contact support]({{ link-support }}).

## Create a new organization {#new-org}

If you have no organization in {{ org-full-name}}, you can create a new one when you first log in to {{ wiki-full-name }}.

{% note warning %}

An organization can only be created for users who have a Yandex account.

{% endnote %}

1. Log in to your [Yandex account]({{ link-passport }}). If you do not have an account, [create]({{ support-passport-create }}) one.

1. Go to the {{ wiki-name }} homepage: [{{ link-wiki }}]({{ link-wiki }}).

1. Accept the {{ yandex-cloud }} terms of use and click **{{ ui-key.yacloud_components.usermenu.label_login }}**.

   Your organization is automatically created and {{ wiki-full-name }} is activated.

1. In {{ org-full-name}}, add users to your organization or set up an identity federation so that your employees can use their work accounts to access {{ yandex-cloud }} services. For more information, see the [{{ org-full-name}} documentation](../organization/manage-users.md).
