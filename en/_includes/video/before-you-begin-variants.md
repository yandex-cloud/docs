To get started with {{ video-name }}:

{% list tabs group=cloud_user %}

- New user {#new}

  1. [Log in]({{ link-passport-login }}) to your Yandex account. If you do not have an account, [create](https://yandex.com/support/id/en/authorization/registration.html) one.
  1. Open the {{ video-name }} [home page]({{ link-video-main }}).
  1. Request access to the [Preview version](../../overview/concepts/launch-stages.md).

     Wait until the request is approved.

  1. On the {{ video-name }} home page, confirm that you have read and accept the [Terms of use](https://yandex.com/legal/cloud_termsofuse/?lang=en), then click **Log in**.
  1. Create a [billing account](../../billing/operations/create-new-account.md).

- I am already using {{ yandex-cloud }} {#already}

  1. [Log in]({{ link-passport-login }}) to your Yandex account.
  1. Open the {{ video-name }} [home page]({{ link-video-main }}).
  1. Request access to the [Preview version](../../overview/concepts/launch-stages.md).
  1. Select one of these options:

     * If you already have an organization, select it from the drop-down menu and click **Open Cloud Video**.

       {% note info %}

       To activate a {{ video-name }} instance, you need the `admin` or `owner` role. For more information about roles, see [{#T}](../../organization/security/index.md).

       {% endnote %}

     * If you have a cloud but no organization, click **Open Cloud Center**. In the window that opens, enter a name and description for your organization and click **Create organization and Cloud Video**. For more information about working with organizations, see [Getting started with organizations](../../organization/quickstart.md).
   1. To use {{ video-name }}, make sure you have the _minimum_ [role](../../video/security/index.md#video-editor), `video.editor`, in the organization.

{% endlist %}

If you encounter a technical issue with the service, contact {{ yandex-cloud }} [support]({{ link-console-support }}).
