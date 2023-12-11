# Tracker


{% note info %}

This block is only available to users of [{{ forms-full-name }} for business](../forms-for-org.md).

{% endnote %}


In this block, users can search and select {{ tracker-name }} entities from the list of suggested ones. The type of entity is defined in the [prompt settings](#tracker-entity) and the list is arranged depending on the user permissions in {{ tracker-name }}.

For example, if a prompt requires specifying a queue, then, depending on the characters the user enters, they will be suggested a list of relevant queues they have access to.

## Block settings {#sec_settings}

### Question

Enter a field name or a prompt.

{% include [question](../../_includes/forms/question.md) %}

{% include [id-required-hidden](../../_includes/forms/id-required-hidden.md) %}

### {{ tracker-name }} entity type {#tracker-entity}

The following {{ tracker-name }} entities are available under **Tracker**:

* [Queue](../../tracker/queue-intro.md): Search by queue name, key, and ID
* [Issue](../../tracker/user/create-ticket.md): Search by issue name
* [Component](../../tracker/manager/components.md): Search by component name
* [Project](../../tracker/manager/project-new.md): Search by project name
* [Board](../../tracker/manager/agile-new.md): Search by board name
* [Sprint](../../tracker/manager/create-agile-sprint.md): Search by sprint name

The **Multiple answers** option allows the user to select multiple values, rather than a single one, from the list.

{% note info %}

When setting up integration, the **Tracker** variable values depend on the selected entity type:

* Queue: Key.
* Issue: Key and number.
* Component, project, board, and sprint: ID (use the **Response ID** variable).

{% endnote %}

### Filter responses {#filter}

You can use this option to filter response options in the **Tracker** block: upload entities from {{ tracker-name }} depending on the response given in a different **Tracker** block. To use filtering, add at least two **Tracker** blocks to the form:

* Parent block.
* Block with response options that are filtered depending on the response that the user selected in the parent block.

{% note warning %}

Filtering only applies to blocks with the **Issue** or **Component** entity type.

{% endnote %}

It is handy to use filtering along with the **Multiple answers** option, because it helps extend the list of response options. For instance, if the user selected multiple queues in the parent block, they will be able to select issues from both queues in the filtered block.

To filter response options:

1. Add a parent **Tracker** block to the form or select an existing block as the parent one.

1. Add a filtered block with the **Issue** or **Component** entity type to the form.

1. Enable **Filter responses**.

1. In the **Select a question to filter** list, choose **Tracker** as the parent block.


