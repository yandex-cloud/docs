# Adding issue fields

## Standard issue fields {#section_ymd_ycj_1gb}

The most popular issue fields (settings) are available in {{ tracker-name }} by default. You can see the list of existing fields on the [{{ tracker-name }} settings]({{ link-admin-fields }}) page.

If the field you need is missing, you can [create a new one in your queue](create-param.md#section_local_field). If you want to add a field that will be available in all {{ tracker-name }} queues, {% if audience == "external" %}your organization's administrator can [create a global field](create-param.md#section_global_field){% else %}submit a request to create a global field using [this form](create-param.md#section_global_field){% endif %}.

Issue field | Description
----- | -----
**System** |
Followers | The usernames or names of users subscribed to the issue.<br/><br/>By default, followers have permission to read and edit the issue and are notified of any changes to it.<br/><br/>The access permissions for issues are determined by the [queue settings](../manager/queue-access.md). For details, contact the queue owner.
Access | By default, users in this group have permission to read and edit the issue, but they don't receive notifications about changes to the issue.<br/><br/>The access permissions for issues are determined by the [queue settings](../manager/queue-access.md). For details, contact the queue owner.
{% if audience == "internal" %}Mailing lists | Teams and departments subscribed to the issue.<br/><br/>By default, members of these teams have access to read and edit the issue and are notified of any changes to it.<br/><br/>The access permissions for issues are determined by the [queue settings](../manager/queue-access.md). For details, contact the queue owner.{% endif %}
Start date | Date when work on the issue started. You usually don't need to fill this in when creating an issue.
End date | Date when the issue was completed. You usually don't need to fill this in when creating an issue.
Deadline | Date by which the issue should be resolved.
Tags | Tags are text labels that make it easier to find and sort issues.
{% if audience == "internal" %}Goals | The goal in the [Goals](https://goals.yandex-team.ru) service that is dependent on this issue's completion.{% endif %}
Components | You can mark issues with special labels called [components](../manager/components.md). They will help you sort issues within the queue.<br/><br/>The list of possible components depends on the [queue settings](../manager/components.md#section_zrt_szk_xz).
Affected version | The version of the product that the issue is related to. The list of available versions is determined by the [queue settings](../manager/versions.md#section_f5q_bfl_xz).<br/><br/>The **Affected Version** field is usually used with **Bug** type issues.
Fix version | The version of the product that the issue is related to. The list of available versions is determined by the [queue settings](../manager/versions.md#section_f5q_bfl_xz).<br/><br/>The **Affected Version** field is usually used with **Bug** type issues.
**Time tracking** |
Original estimate | Initial estimation of time needed for the issue. Time is specified in `1w2d3h` format.
**Agile** |
Sprint | The name of the sprint that the issue belongs to.
Story Points | Estimated effort for the issue in terms of Story Points.

## Adding a local field {#section_local_field}

If you need to add a new issue field that is not available in {{ tracker-name }}, you can add local fields to your queue.

A local field can only be used in the issues of the queue it's linked to. The advantage of local fields is that the queue owner can manage them without the risk of affecting the workflows in other queues. Users working in other queues won't see this field in their issues.

To learn more about creating and using local fields, see [Local issue fields](../local-fields.md).

{% note alert %}

Local fields are temporarily not supported in certain cases. They will be implemented later. To learn more, see [Local field constraints](../local-fields.md#restrictions).

{% endnote %}

## Adding a global field {#section_global_field}

{% if audience == "external" %}

{% note alert %}

Only your organization's administrator can add global issue fields.

{% endnote %}

To add a new issue field (parameter):

1. Make sure that you are logged in as an administrator.

1. On the {{ tracker-name }} top panel, select ![](../../_assets/tracker/icon-settings.png) → **Configure {{ tracker-name }}**.

1. Go to the **Fields** tab.

1. Click **Create field**.

1. Select the field type and click **Continue**.

1. Set parameters for the new field:

    - **Category**. All {{ tracker-name }} fields are grouped into categories. Select the category that best suits the new field.

    - **Name**. Try to give the fields short and informative names.

    - **Name in English**. This name is shown in the English interface of {{ tracker-name }}.

    - **Type of number** (only for fields with the <q>number</q> type).

    - **List items** (only for fields with the <q>drop-down list</q> type). Specify the possible values and their order.

    - **Number of list items** (only for fields with the <q>drop-down list</q> type).

    - **Number of employees** (only for fields with the <q>user list</q> type).

1. Click **Create**.

{% else %}

If you need to create a new issue field, consider [adding a local field](../local-fields.md) linked to a specific queue. You should only create a global field if a local field is not suitable for some reason.

To add a new global issue field, order it using [this form](https://forms.yandex-team.ru/surveys/66769/). Requests are reviewed within 2-3 business days. If the issue is urgent, set its priority to <q>critical</q> and provide a comment as to why it's urgent.

{% endif %}

