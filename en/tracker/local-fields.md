# Local issue fields

If you need to add a new issue field that is not available in {{ tracker-name }}, you can add local fields to your queue.

{% note info %}

You can see the list of existing global fields on the [{{ tracker-name }} settings]({{ link-admin-fields }}) page.

{% endnote %}

A local field can only be used in the issues of the queue it's linked to. The advantage of local fields is that the queue owner can manage them without the risk of affecting the workflows in other queues. Users working in other queues won't see this field in their issues.

## Add a local field

{% note alert %}

By default, [only the queue owner](manager/queue-access.md) can configure a queue.

{% endnote %}

1. Open the [queue page](user/queue.md).

1. To the left of the queue name, select ![](../_assets/tracker/icon-settings.png) → **Configure**.

1. Go to the **Queue fields** tab.

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

## Edit a local field

Editing local field parameters via the {{ tracker-name }} web interface is not supported. To do this, you can use the [{{ api-name }}](concepts/queues/edit-local-field.md).

{% if audience == "internal" %}

You can also submit a request to edit local field parameters via this [form](https://forms.yandex-team.ru/surveys/66769/). In the request comment, specify the queue the field is linked to.

Requests are reviewed within 2-3 business days. If the issue is urgent, set its priority to <q>critical</q> and provide a comment on why it's urgent.

{% endif %}

## Local field constraints {#restrictions}

#### Local field features

- To search for issues in a local field using the query language, you need to [specify a queue before the key or field name](user/query-filter.md#local_fields).

- When you [move](user/move-ticket.md) or [clone](user/clone.md) issues with local fields to a different queue, the local field values are automatically deleted.

#### Where you can't use local fields

Local fields are temporarily not supported in certain cases. They will be implemented later.

- On issue boards, local fields are not displayed on [cards](manager/edit-agile-board.md#sec_layout). Also, local fields can't be used in [filters on issue boards](user/agile.md#section_cxl_x31_2gb).

- You can't use local fields in [SLA rules](sla-head.md).

- You can't edit the values of local fields using [bulk change operations](manager/bulk-change.md).

## Accessing local fields via the API {#local-fields-api}

The following two types of actions are supported when working with local fields via the [{{ tracker-name }} API](about-api.md):

- Assign a value to a local field.

  To get or change the value for an issue's local field via the API, specify the field ID in the [request](concepts/issues/patch-issue.md) body, for example `603fb94c38bbe658d04da2e6--<field key>: "<new local field value>"`.

  To find out the ID of a local field, run a query that lets you get [a list of local fields in a certain queue](concepts/queues/get-local-fields.md).

- Change a local field's parameter, such as its name or description, or add multiple parameter values. For more information, see the [{{ tracker-name }} API reference](concepts/queues/edit-local-field.md).

