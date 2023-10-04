# Adding users to {{ datalens-short-name }}

There are a few ways to add a user to {{ datalens-short-name }}:

1. [Via {{ datalens-short-name }}](#dl-user): If the user is not going to access other {{ yandex-cloud }} services. This method allows you to add users with a Yandex account. If the user later requires other {{ yandex-cloud }} services, you can [assign them an additional role](../../organization/security/index.md#add-role) in the organization with the current {{ datalens-short-name }} instance.

1. [Via {{ org-full-name }}](#org-user): If the user is going to use other {{ yandex-cloud }} services. This method allows you to invite [users with a Yandex](#passport-user) account to the organization or add [federated users](#federated-user) if you set up an identity federation.

{% note info %}

To add or invite users, you must be the organization's administrator (`organization-manager.admin` role) or owner (`organization-manager.organizations.owner` role).

{% endnote %}

### Adding a user via {{ datalens-short-name }} {#dl-user}

You can add users in the service settings. To do this:

1. Go to the {{ datalens-short-name }} [homepage]({{ link-datalens-main }}).
1. Open the service [settings]({{ link-datalens-settings }}) and click ![image](../../_assets/datalens/service-settings.svg) in the left-hand panel.
1. Under **Manage users**, click **Invite users**.
1. In the window that opens, enter the email address of the Yandex user you want to add (e.g., `{{ login-example }}`). You can list multiple email addresses to add multiple users.
1. Click **Send invitation**.

The user will receive an email with a {{ datalens-short-name }} invitation. Once the user accepts the invitation, they can log in to your organization and start using {{ datalens-short-name }}. The user will get the `{{ roles-datalens-creator }}` role in the organization with the current {{ datalens-short-name }} instance.

### Adding a user via {{ org-full-name }} {#org-user}

#### Inviting a user with a Yandex account {#passport-user}

To invite a user with a Yandex account, follow [this guide](../../organization/operations/add-account.md#add-or-invite-user-account) from the {{ org-full-name }} documentation.

{% note warning %}

Users can only use {{ datalens-short-name }} if they have a role that enables access to the service. To ensure they have access, wait for them to accept the invitation to your organization and [assign](../../organization/security/index.md#add-role) them the `{{ roles-datalens-creator }}` role.

{% endnote %}

#### Adding a federated user {#federated-user}

If you set up an [identity federation](../../organization/concepts/add-federation.md), follow [this guide](../../organization/operations/add-account.md#add-user-sso) to add a new federated user. After that, make sure to [assign](../../organization/security/index.md#add-role) them the `{{ roles-datalens-creator }}` role.
