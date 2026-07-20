To get started with {{ video-name }}:

{% list tabs group=cloud_user %}

- New user {#new}

  1. [Log in]({{ link-passport-login }}) to your Yandex account. If you do not have an account, [create](https://yandex.com/support/id/en/authorization/registration.html) one.
  1. Open the {{ video-name }} [home page]({{ link-video-main }}).
  1. On the {{ video-name }} home page, confirm that you have read and accept the [Terms of use](https://yandex.com/legal/cloud_termsofuse/?lang=en), then click **Log in**.
  1. Create a [billing account](../../billing/operations/create-new-account.md).

- I am already using {{ yandex-cloud }} {#already}

  1. [Log in]({{ link-passport-login }}) to your Yandex account.
  1. Open the {{ video-name }} [home page]({{ link-video-main }}).
  1. Select one of these options:

     * If you already have an organization, select it from the drop-down menu and click **{{ ui-key.yacloud_video.organization.action_open-cloud-video }}**.

       {% note info %}

       To activate a {{ video-name }} instance, you need the `admin` or `owner` role. For more on roles, see [here](../../organization/security/index.md).

       {% endnote %}

     * If you have a cloud but no organization, click **Open Cloud Center**. In the window that opens, enter a name and description for your organization and click **Create organization and Cloud Video**. For working with organizations, see [Getting started with organizations](../../organization/quickstart.md).
   1. To use {{ video-name }}, make sure you have the _minimum_ [role](../../video/security/index.md#video-editor), `video.editor`, in the organization.

{% endlist %}

{% note info %}

Only users with a [Yandex ID](https://yandex.com/support/id/index.html) or [{{ yandex-360 }}](https://360.yandex.ru/) account can create new billing accounts. You cannot use a [federated](../../iam/concepts/users/accounts.md#saml-federation) account for that.

To link a billing account, the user needs to following [roles](../../video/security/index.md#service-roles):

* `billing.accounts.editor` or higher for a billing account.
* [`video.admin`](../../video/security/index.md#video-admin) or roles including its permissions, e.g., `{{ roles-organization-owner }}`, for an organization with {{ video-short-name }}.

{% endnote %}

If you encounter a technical issue with the service, contact {{ yandex-cloud }} [support]({{ link-console-support }}).
