To get started with {{ datalens-short-name }}:

{% list tabs %}

- New user

   1. Open the [({{ link-datalens-main }}) homepage]{{ datalens-short-name }}.
   1. Click **Open DataLens**.
   1. Select one of the options:

      * If you previously logged in to your Yandex account, click **Log in**. The DataLens home page opens.
      * If you are not logged in to your Yandex account or do not have one:

         * To log in using your Yandex email address or an email address on your organization's domain, click **Log in to your Yandex account** and enter your username, for example, `login@yandex.ru` or `login@example.com`. If you haven't registered an organization yet, one will be created automatically the first time you log in to DataLens.
         * If your organization uses the Single Sign-On authentication scheme with an identity federation, click **Log in via SSO**, specify the federation ID, and log in to your corporate account.

- I'm already using {{ yandex-cloud }}

   1. Open the [({{ link-datalens-main }}) homepage]{{ datalens-short-name }}.
   1. Click **Open DataLens**.
   1. Select one of the options:

      * If you already have an organization, select it from the drop-down menu in the **Organizations** tab and click **Open DataLens**.

         {% note info %}

         To activate a {{ datalens-short-name }} instance, the user must have the `admin` or `owner` role. For more information about roles, see [{#T}](../../../organization/roles.md).

         {% endnote %}

      * If you have a cloud but no organization, click **Add new DataLens**. In the window that opens, enter your organization's name and description and click **Create organization and DataLens**. For more information about working with organizations, see [Getting started with organizations](../../../organization/quick-start.md).

{% endlist %}

If you have a technical question about the service, please contact {{ yandex-cloud }} [support]({{ link-console-support }}). To ask for advice, discuss the solution to your problem or best practices of the service, write to the [{{ datalens-short-name }}](https://t.me/YandexDataLens) chat in Telegram.
