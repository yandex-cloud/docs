---
title: "How to add an issue field in {{ tracker-full-name }}"
description: "In this tutorial, you will learn how to add an issue field in {{ tracker-name }}. The fields can be global or local. You can use preset fields or create custom ones."
---

# Adding an issue field

## Standard issue fields {#default-fields}

The most popular issue fields (settings) are available in {{ tracker-name }} by default. You can see the list of existing fields on the [Settings {{ tracker-name }}]({{ link-admin-fields }}) page.

If you can't find a relevant parameter among them, you can [create a new field in your queue](#section_local_field). If you want to add a field that will be available in all {{ tracker-name }} queues,  admin can [create a global field](#section_global_field).

| Issue field | Description |
----- | -----
**{{ ui-key.startrek-backend.fields.issue.fields.system }}**
QA engineer | User assigned to test the issue.
{{ ui-key.startrek-backend.fields.issue.author-key-value }} | User who created the issue.
{{ ui-key.startrek-backend.fields.issue.possibleSpam }} | Spam flag for issues created through services with [integration](../manager/queue-mail.md).
{{ ui-key.startrek-backend.fields.issue.end-key-value }} | Date when work on the issue was completed.
{{ ui-key.startrek-backend.fields.issue.start-key-value }} | Date when work on the issue started.
{{ ui-key.startrek-backend.fields.issue.dueDate-key-value }} | Date by which the issue must be resolved.
{{ ui-key.startrek-backend.fields.issue.boards }} | List of boards the issue appears on.
{{ ui-key.startrek-backend.fields.issue.access }} | List of users who can read and edit the issue but do not receive notifications of changes.<br/><br/>The issue access permissions are determined by the [queue settings](../manager/queue-access.md).
{{ ui-key.startrek-backend.fields.issue.summary-key-value }} | Issue name.
{{ ui-key.startrek-backend.fields.issue.modifier }} | User who last modified the issue.
{{ ui-key.startrek-backend.fields.issue.assignee-key-value }} | User who will work on the issue.
{{ ui-key.startrek-backend.fields.issue.fixVersions-key-value }} | Product version the issue belongs to. The list of available [versions](../manager/versions.md) is determined by the queue settings.
{{ ui-key.startrek-backend.fields.issue.key-key-value }} | Unique ID of the issue within the queue. It is generated automatically.
{{ ui-key.startrek-backend.fields.issue.commentWithoutExternalMessageCount }} | Number of issue comments created in {{tracker-name}}.
{{ ui-key.startrek-backend.fields.issue.commentWithExternalMessageCount }} | Number of issue comments created via [email](../manager/queue-mail.md).
{{ ui-key.startrek-backend.fields.issue.components-key-value }} | Labels that can be used to mark up and sort the issues within the queue.<br/><br/>The list of available [components](../manager/components.md) is determined by the queue settings.
{{ ui-key.startrek-backend.fields.issue.followers }} | List of users subscribed to the issue. By default, they can read and edit the issue and receive notifications of all changes.<br/><br/>The issue access permissions are determined by the [queue settings](../manager/queue-access.md).
{{ ui-key.startrek-backend.fields.issue.affectedVersions-key-value }} | [Product version](../manager/versions.md) the issue belongs to. The list of available versions is determined by the queue settings.
{{ ui-key.startrek-backend.fields.issue.pendingReplyFrom }} | List of users [invited to comment](comments.md#call-comment) on the issue. As soon as a user responds, their name is removed from this field.
{{ ui-key.startrek-backend.fields.issue.updated-key-value }} | Date and time the [issue was last updated](history.md).
{{ ui-key.startrek-backend.fields.issue.description-key-value }} | Issue statement: a description of what needs to be done.
{{ ui-key.startrek-backend.fields.issue.queue }} | [Key of the queue](../manager/create-queue.md#key) that contains the issue.
{{ ui-key.startrek-backend.fields.issue.lastCommentUpdatedAt }} | Date and time the issue was last commented on.
{{ ui-key.startrek-backend.fields.issue.priority-key-value }} | Importance of the issue.
{{ ui-key.startrek-backend.roles.role.name.voted-by-follower }} | List of users who voted for the issue.
{{ ui-key.startrek-backend.fields.issue.votes }} | Number of users [who voted for the issue](votes.md).
{{ ui-key.startrek-backend.fields.issue.project-key-value }} | Names of [projects](../manager/project-new.md) the issues belongs to.
{{ ui-key.startrek-backend.fields.issue.resolved }} | Date and time the issue was marked as [resolved](../manager/create-resolution.md).
{{ ui-key.startrek-backend.fields.issue.followingMaillists }} | Teams and departments subscribed to the issue. By default, they can read and edit the issue and receive notifications of all changes.<br/><br/>The issue access permissions are determined by the [queue settings](../manager/queue-access.md).
{{ ui-key.startrek-backend.fields.issue.resolution-key-value }} | Reason for closing the issue.
{{ ui-key.startrek-backend.fields.issue.resolver }} | User who marked the issue as resolved.
{{ ui-key.startrek-backend.fields.issue.created-key-value }} | Date and time the issue was created.
{{ ui-key.startrek-backend.fields.issue.status-key-value }} | Current progress on the issue. For example: <q>Open</q>, <q>In progress</q>, <q>Testing</q>. For more information, see [Setting up statuses](../manager/workflow-status-edit.md).
{{ ui-key.startrek-backend.fields.issue.statusStartTime }} | Date and time the issue status was last changed.
{{ ui-key.startrek-backend.fields.issue.tags-key-value }} | Text labels that make sorting and searching for issues easier. For more information, see [Structuring issues](../structure.md).
{{ ui-key.startrek-backend.fields.issue.type-key-value }} | Type of the issue, e.g., <q>New feature</q>, <q>Bug</q>, or <q>Improvement</q>. For more information, see [{#T}](../manager/add-ticket-type.md).
**{{ ui-key.startrek-backend.fields.issue.fields.timetracking }}** |
{{ ui-key.startrek-backend.fields.issue.spent-key-value }} | Time the assignee [spent resolving the issue](time-spent.md).
{{ ui-key.startrek-backend.fields.issue.estimation-key-value }} | Time the user plans to spend on the issue. The field value decreases when the [time spent](time-spent.md#show-time-spent) is specified.
{{ ui-key.startrek-backend.fields.issue.originalEstimation-key-value }} | Initial estimation of time needed to resolve the issue.
**{{ ui-key.startrek-backend.fields.issue.fields.agile }}** |
{{ ui-key.startrek-backend.fields.issue.storyPoints }} | Issue complexity in Story Points. For more information, see [Basic concepts of agile development](../manager/agile.md#dlen_sp).
{{ ui-key.startrek-backend.fields.issue.sprint }} | Name of the [sprint](../manager/create-agile-sprint.md) the issue belongs to.
**{{ ui-key.startrek-backend.fields.issue.fields.email }}** |
{{ ui-key.startrek-backend.fields.issue.emailTo }} | Full list of recipients the user specified in the **To** field when sending the email.
{{ ui-key.startrek-backend.fields.issue.emailCc }} | Email address the user specified in the **Cc** field when sending the email.
{{ ui-key.startrek-backend.fields.issue.emailFrom }} | Email address of the sender.
{{ ui-key.startrek-backend.fields.issue.emailCreatedBy }} | Email address that received the email from which the issue was generated.
**{{ ui-key.startrek-backend.fields.issue.fields.sla }}** |
{{ ui-key.startrek-backend.fields.issue.sla-key-value }} | Timer that tracks the time for processing issues in the queue. For example, you can set the time within which the assignee has to respond to a new issue. For more information, see [SLA](../sla-head.md).

## Local fields {#section_local_field}

If you need to add a new issue field that is not available in {{ tracker-name }}, you can add local fields to your queue.

A local field can only be used in the issues of the queue it's linked to. The advantage of local fields is that the queue owner can manage them without the risk of affecting the workflows in other queues. Users working in other queues won't see this field in their issues.

For more information about creating and using local fields, see [{#T}](../local-fields.md).

{% note alert %}

Local fields are temporarily not supported in certain cases. Such support will be implemented later. For more information, see [Local field constraints](../local-fields.md#restrictions).

{% endnote %}

## Global fields {#section_global_field}

### Adding a global field {#add_global_field}


{% note alert %}

Only an [administrator](../role-model.md) can add global fields.

{% endnote %}

To add a new issue field (parameter):

1. Make sure you are authorized as an [administrator](../role-model.md).

1. In the left-hand panel, select ![](../../_assets/tracker/svg/admin.svg) **Admin** → **{{ tracker-name }} settings**.

1. Click the **Fields** tab.

1. Click **Create field**.

1. Select the field type and click **Next**.

1. Set parameters for a new field:
   * **Category**. All {{ tracker-name }} fields are grouped into categories. Select the category that best suits the new field.

   * **Name in Russian**. Try to give short and concise names to your fields.

   * **Name in English**. This name is shown in the English interface of {{ tracker-name }}.

   * **Type of number** (only for fields with the <q>Number</q> type).

   * **List items** (only for fields with the <q>Dropdown list</q> type): Enter the possible values and their order.

   * **Item selection** (only for fields with the <q>Dropdown list</q> type).

   * **Number of employees** (only for fields with the <q>User list</q> type).

1. Click **Create**.



### Edit a global field {#edit_global_field}

Editing the parameters of a global issue field isn't supported in the {{ tracker-name }} web interface. For this purpose, use requests to {{ api-name }}:

* HTTP request for [renaming a global field](../concepts/issues/patch-issue-field-name.md).

* HTTP request for [changing the acceptable values of a global field](../concepts/issues/patch-issue-field-value.md).

### Delete a global field {#delete_global_field}

You can't delete a global field, but you can hide it in the {{ tracker-name }} interface. For this, in the body of the request to {{ api-name }} for [changing the global field](../concepts/issues/patch-issue-field-value.md), set the `hidden` parameter to `true`.

You can't add a hidden field to an issue using the right panel.
