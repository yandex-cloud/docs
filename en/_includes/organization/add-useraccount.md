{% list tabs %}

- Cloud Organization

    1. [Log in to an account]({{ link-passport-login }}) that belongs to an organization administrator or owner.
    1. Go to [{{ org-full-name }}]({{ link-org-main }}).
    1. In the left-hand panel, select [{{ ui-key.yacloud_org.pages.users }}]({{ link-org-users }}) ![icon-users](../../_assets/organization/icon-users.svg).
    1. In the top-right corner, click **{{ ui-key.yacloud_org.page.users.action.invite-users }}**.
    1. Enter the email addresses of the Yandex users you want to invite to the organization, such as `{{ login-example }}`.
    1. Click **{{ ui-key.yacloud_org.entity.invitation.action_send-invitation }}**.

    To join an organization, the users you invited need to:

    1. Click the invite link and accept the invitation.
    1. Log in to the organization.

    To access the [services](../../organization/concepts/manage-services.md#collaboration) enabled for the organization, the users you invited just need to log in to their Yandex account.

{% endlist %}