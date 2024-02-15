{% list tabs group=instructions %}

- {{ org-name }} interface {#cloud-org}

    1. [Log in]({{ link-passport-login }}) as the organization administrator or owner.
    1. Go to [{{ org-full-name }}]({{ link-org-main }}).
    1. In the left-hand panel, select [{{ ui-key.yacloud_org.pages.users }}]({{ link-org-users }}) ![icon-users](../../_assets/console-icons/person.svg).
    1. In the top-right corner, click **{{ ui-key.yacloud_org.page.users.action.invite-users }}**.
    1. Enter the email addresses of the users you want to invite to the organization (e.g., `{{ login-example }}`).

      You can send invitations to any email address. Invited users will be able to select the appropriate Yandex account once they accept the invitation.


    1. Click **{{ ui-key.yacloud_org.entity.invitation.action_send-invitation }}**.

    To join an organization, the users you invited need to:

    1. Click the invite link, accept the invitation, and select the account for log-in.
    1. Log in to the organization.

    To access the [services](../../organization/concepts/manage-services.md#collaboration) enabled for the organization, the invited users simply need to log in to their Yandex account.

{% endlist %}