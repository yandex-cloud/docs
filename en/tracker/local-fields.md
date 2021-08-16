# Local issue fields

If you want to add a new issue parameter that isn't already an existing field in {{ tracker-name }}, you can add local fields to your queue.

{% note info %}

You can see the list of existing global fields on the [{{ tracker-name }} settings]({{ link-admin-fields }}) page.

{% endnote %}

You can only use a local field for issues in the queue that the field is linked to. The advantage of local fields is that the queue owner can manage them without the risk of affecting the workflow in other queues. Users working in other queues won't see this field in their issues.

## Add a local field

{% note alert %}

By default, [only the queue owner](manager/queue-access.md) can configure a queue.

{% endnote %}

1. Open the [queue page](user/queue.md).

1. To the left of the queue name, select ![](../_assets/tracker/icon-settings.png) → **Administration**.

1. Go to the **Queue fields** tab.

1. Click **Create field**.

1. Select the field type and click **Continue**.

1. Set parameters for the new field:

    - **Category**. All {{ tracker-name }} fields are grouped into categories. Select the category that best suits the new field.

    - **Name**. Try to give the fields short and informative names.

    - **Name in English**. This name will be shown in the {{ tracker-name }} English interface.

    - **Type of number** (only for fields with the <q>number</q> type).

    - **List items** (only for fields with the <q>drop-down list</q> type). Specify the possible values and their order.

    - **Number of list items** (only for fields with the <q>drop-down list</q> type).

    - **Number of employees** (only for fields with the <q>selecting employees</q> type).

1. Click **Create**.


## Local field constraints {#restrictions}

#### Local field features

- To search for issues in a local field using the query language, you need to [specify a queue before the key or field name](user/query-filter.md#local_fields).

- When you [move](user/edit-ticket.md#section_xwx_qpn_jz) or [clone](user/clone.md) issues with local fields to a different queue, the local field values are automatically deleted.

#### Where you can't use local fields

Local fields are temporarily not supported in some issue use scenarios. Support for these scenarios will be added later.

- On issue boards, local fields are not displayed on [cards](manager/edit-agile-board.md#sec_layout). Also, local fields can't be used in [filters on issue boards](user/agile.md#section_cxl_x31_2gb).

- You can't use local fields in [macros](manager/create-macroses.md), [SLA rules](sla-head.md), or [status transition functions](manager/workflow-action-edit.md).

- You can't edit the values of local fields using [bulk change operations](manager/bulk-change.md).


## How to access local fields via the API

To get or change the value for an issue local field via the [{{ tracker-name }} API](user/API.md), specify the field ID in the request body like: `603fb94c38bbe658d04da2e6--<field key>`.

To find out the ID of a local field, run a query that allows you to get a list of local fields in a certain queue:


```
curl -X GET 'https://api.tracker.yandex.net/v2/queues/<queue key>/localFields' \
-H 'Authorization: OAuth <OAuth token>' \
-H 'X-Org-Id: <organization ID>'
```

