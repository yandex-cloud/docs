# Local issue fields

If you need to add a new issue field that is not available in {{ tracker-name }}, you can add local fields to your queue.

{% note info %}

You can see the list of existing global fields on the [{{ tracker-name }} settings]({{ link-admin-fields }}) page.

{% endnote %}

A local field can only be used in the issues of the queue it's linked to. The advantage of local fields is that the queue owner can manage them without the risk of affecting the workflows in other queues. Users working in other queues will not see this field in their issues.

## Adding a local field {#add-local-field}

{% note alert %}

By default, [only the queue owner](manager/queue-access.md) can configure a queue.

{% endnote %}

1. Open the [queue page](user/queue.md).

1. In the top-right corner of the page, click ![](../_assets/tracker/svg/settings-old.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

1. Go to the **Queue fields** tab.

1. Click **Create field**.

1. Select the field type and click **Continue**.

1. Set parameters for a new field:
   * **Category** All {{ tracker-name }} fields are grouped into categories. Select the category that best suits the new field:
      * System
      * Time tracking
      * Agile
      * Email
      * SLA

      For more information about the fields and categories, see [Standard issue fields](user/create-param.md#default-fields).

   * **Name**: Try to give short and concise names to your fields.

   * **Name in English**: This name is shown in the English interface of {{ tracker-name }}.

   * **Type of number** (only for fields with the <q>Number</q> type).

   * **List items** (only for the <q>Drop-down list</q> fields): Enter the possible values and their order.

   * **Item selection** (only for the <q>Drop-down list</q> fields).

   * **Number of employees** (only for fields with the <q>user list</q> type).

1. Click **Create**.

## Edit a local queue field {#edit-local-field}

Editing the parameters of a local field isn't supported in the {{ tracker-name }} web interface. To do this, you can use the [{{ api-name }}](concepts/queues/edit-local-field.md).


## Local field constraints {#restrictions}

#### Using local fields

* To use the query language to search issues by a local field, [specify a queue before the field's key or name](user/query-filter.md#local_fields).

* When you [move](user/move-ticket.md) or [clone](user/clone.md) issues with local fields to a different queue, the local field values are automatically deleted.

* When you use [macros](manager/create-macroses.md), [triggers](user/trigger.md), or [automatic actions](user/autoactions.md), to insert the value of a local field to a [comment](user/set-action.md#create-comment), [formula](user/set-action.md#section_calc_field), or [HTTP request](user/set-action.md#create-http) by a [variable](user/vars.md#local-fields), use the `{{issue.local.<field ID>}}` format.

#### Where you cannot use local fields

Local fields are temporarily not supported in certain cases. Such support will be implemented later.

* When creating an issue board, you won't be able to add issues automatically using the value of a local field. You can add this condition later, on the board [editing](manager/edit-agile-board.md#board-settings) page, using the [query language](user/query-filter.md).

* On the issue board, local fields are not shown on [cards](manager/edit-agile-board.md#sec_layout).

* You can't use local fields in [SLA rules](sla-head.md).

* You can't edit the values of local fields using [bulk change operations](manager/bulk-change.md).

## Accessing local fields via the API {#local-fields-api}

The following two types of actions are supported when working with local fields via the [{{ tracker-name }} API](about-api.md):

* Assign a value to a local field.

   To get or change the value for an issue's local field via the API, specify the field ID in the [request body](concepts/issues/patch-issue.md), for example `603fb94c38bbe658d04da2e6--<field key>: "<new local field value>"`.

   To find out the ID of a local field, run a query that allows you to [get a list of local fields in a certain queue](concepts/queues/get-local-fields.md).

* Change a local field's parameter, such as its name or description, or multiple parameter values. For more information, see the [{{ tracker-name }} API reference](concepts/queues/edit-local-field.md).
