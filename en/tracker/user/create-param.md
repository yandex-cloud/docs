# Adding issue fields

## Standard issue fields {#section_ymd_ycj_1gb}

The most popular issue fields (settings) are available in {{ tracker-name }} by default. See the list of available fields on the [{{ tracker-name }} settings]{% if audience == "external" %}({{ link-admin-fields }}){% else %}({{ link-admin-fields-ya }}){% endif %} page.

{% if audience == "external" %} If the field you need is missing, your organization's admin can [create a new field](create-param.md#section_pxn_fp4_xgb).{% else %}If the field you need is missing, send a request to create a new field using the [form](create-param.md#section_bjz_3p4_xgb).{% endif %}

| Issue field | Description |
| ----- | ----- |
| **System** |
| Followers | Usernames or names of users subscribed to the issue.<br/><br/>By default, followers have access to read and edit the issue and are notified of any changes to it.<br/><br/>The access permissions for issues are determined by the [queue settings](../manager/queue-access.md). For details, contact the queue owner. |
| Access | By default, users in this group have access to read and edit the issue, but they do not receive notifications of changes to the issue.<br/><br/>The access permissions for issues are determined by the [queue settings](../manager/queue-access.md). For details, contact the queue owner. |
| Maillists | [Teams and departments]{% if locale == "ru" %} (https://yandex.ru/support/connect/manage.html){% else %}(https://yandex.com/support/connect/manage.html){% endif %} subscribed to the issue.<br/><br/>By default, the members of these teams have access to read and edit the issue and are notified of any changes to it.<br/><br/>The access permissions for issues are determined by the [queue settings](../manager/queue-access.md). For details, contact the queue owner. |
| Start date | Date when progress started on the issue. You usually don't need to fill this in when creating an issue. |
| End date | Date when the issue was completed. You usually don't need to fill this in when creating an issue. |
| Deadline | Date by which the issue should be resolved. |
| Tags | Tags are text labels that make it easier to find and sort issues. |
{% if audience == "internal" %}| Goals | The goal in the [Goals](https://goals.yandex-team.ru) service that is dependent on this issue's completion. |{% endif %}
| Components | You can mark issues with special labels called [components](../manager/components.md). They will help you sort issues within the queue.<br/><br/>The list of possible components depends on the [queue settings](../manager/components.md). |
| Affected version | The version of the product that the issue is related to. The list of available versions is determined by the [queue settings](../manager/versions.md#section_f5q_bfl_xz).<br/><br/>The **Affected Version** field is usually used with **Bug** type issues. |
| Fix version | The version of the product that the issue is related to. The list of available versions is determined by the [queue settings](../manager/versions.md#section_f5q_bfl_xz).<br/><br/>The **Affected Version** field is usually used with **Bug** type issues. |
| **Time tracking** |
| Original estimate | Initial estimation of time needed for the issue. Time is specified in the format `1w2d3h`. |
| **Agile** |
| Sprint | The name of the sprint that the issue belongs to. |
| Story Points | Estimated effort for the issue in terms of Story Points. |

{% if audience == "external" %}

## Adding issue fields {#section_pxn_fp4_xgb}

{% note warning %}

Only the company administrator can add new issue fields.

{% endnote %}

The most popular issue fields (settings) are available in {{ tracker-name }} by default. To add a new field:

1. Make sure that you are logged in as the admin.

1. On the top panel in {{ tracker-name }}, choose ![](../../_assets/tracker/icon-settings.png) → **Settings {{ tracker-name }}**.

1. Go to the **Fields** tab.

1. Click **Create field**.

1. Select the field type and click **Next**.

1. Set parameters for the new field:
    - **Category**. All {{ tracker-name }} fields are grouped into categories. Select the category that best suits the new field.
    - **Name**. Try to give the fields short and informative names.
    - **Name in English**. This name will be shown in the {{ tracker-name }} English interface.
    - **Type of number** (only for fields with the <q>number</q> type).
    - **List items** (only for fields with the <q>drop-down list</q> type). Specify the possible values and their order.
    - **Number of list items** (only for fields with the <q>drop-down list</q> type).
    - **Number of employees** (only for fields with the <q>selecting employees</q> type).

1. Click **Create**.

{% else %}

## Adding issue fields {#section_bjz_3p4_xgb}

The most popular issue fields (settings) are available in {{ tracker-name }} by default. To add a new issue field, order it using the form below.

In comments to your request, specify what field you need to create: global (available in all {{ tracker-name }} queues) or local (linked to a specific queue). We recommend ordering local fields if they're suitable for you, taking into account the current restrictions.

{% note warning %}

Local fields are temporarily not supported in some issue use scenarios. Support for these scenarios will be added later. For more information, see [{#T}](../local-fields.md#restrictions).

{% endnote %}

Requests are processed within 2-3 business days. If the issue is urgent, increase its priority to <q>critical</q> and write in the comments why it's urgent.

{% endif %}

{% if audience == "external" %}

[Contact support](../troubleshooting.md)

{% endif %}

