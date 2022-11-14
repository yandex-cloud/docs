To get started with {{ datalens-short-name }}:

{% if product == "yandex-cloud" %}

{% list tabs %}

- New user

   1. [Log in]({{ link-passport-login }}) to your Yandex account. If you don't have an account, [create](https://yandex.ru/support/passport/authorization/registration.html) one.
   1. Open the {{ datalens-short-name }} [homepage]({{ link-datalens-main }}).
   1. Click **Open Datalens**.
   1. Click **Log in**.

- I'm already using {{ yandex-cloud }}

   1. [Log in]({{ link-passport-login }}) to your Yandex account.
   1. Open the {{ datalens-short-name }} [homepage]({{ link-datalens-main }}).
   1. Click **Open Datalens**.
   1. Select one of the options:

      * If you already have an organization, select it from the drop-down menu in the **Organizations** tab and click **Open DataLens**.

         {% note info %}

         To activate a {{ datalens-short-name }} instance, the user must have the `admin` or `owner` role. For more information about roles, see [{#T}](../../organization/roles.md).

         {% endnote %}

      * If you have a cloud but no organization, click **Add new DataLens**. In the window that opens, enter your organization's name and description and click **Create organization and DataLens**. For more information about working with organizations, see [Getting started with organizations](../../organization/quick-start.md).

{% endlist %}

If you have a technical question about the service, please contact {{ yandex-cloud }} [support]({{ link-console-support }}). To ask for advice, discuss the solution to your problem or best practices of the service, write to the [{{ datalens-short-name }}](https://t.me/YandexDataLens) chat in Telegram.

{% endif %}

{% if product == "cloud-il" %}

1. Go to the [management console]({{ link-console-main }}) and log in to {{ yandex-cloud }}.
1. Open the {{ datalens-short-name }} [homepage]({{ link-datalens-main }}).
1. Create a [workbook](../../datalens/concepts/index.md#workbooks-and-collections), which is a container for storing {{ datalens-short-name }} entities.
   1. Click **Create** → **Create workbook**.
   1. Enter a name for the workbook.
   1. Click **Create**.

If you have a technical question about the service, please contact {{ yandex-cloud }} [support]({{ link-console-support }}).

{% endif %}