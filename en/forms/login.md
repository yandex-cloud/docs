# How do I log in to the {{ forms-full-name }} for business

To work with [{{ forms-full-name }} for business](forms-for-org.md)log in to your corporate account. You can [create and edit](new-form.md) forms linked to your organization. You can also fill out forms that are [published for the organization employees only](restrictions.md#sec_access).

1. Go to the page for managing forms for business: [{{ link-forms-b2b }}]({{ link-forms-b2b }}).

1. Log in to the account you use to work in the organization:

   - To log in using your Yandex email address or the email address on your company's domain, click **{{ ui-key.forms.common.blocks_error-message.login-passport }}** and enter your username, such as `{{ example-account }}` or `login@example.com`.
   - If organization uses the Single Sign-On authentication scheme with an identity federation, click **{{ ui-key.forms.common.blocks_error-message.login-sso }}**, specify the federation ID, and log in to your corporate account.

   Get your federation ID from your administrator. For more information about the identity federations, see the [{{ org-full-name }} documentation](../organization/concepts/add-federation.md).

   {% note info %}

   If you haven't registered an organization, one will be [created automatically](enable-forms.md) the first time you log in to the {{ forms-full-name }} for business.

   {% endnote %}

1. If you're registered in multiple organizations, select the one you're going to use {{ forms-full-name }} in. To do this, click ![](../_assets/forms/settings-faded.png) in the page's upper-right corner and select organization.