# Adding issue fields

## Standard issue fields {#section_ymd_ycj_1gb}

The most popular issue fields (settings) are available in {{ tracker-name }} by default. You can see the list of existing fields on the [{{ tracker-name }} settings]({{ link-admin-fields }}) page.

If the field you need is missing, you can [create a new one in your queue](create-param.md#section_local_field). If you want to add a field that will be available in all {{ tracker-name }} queues, {% if audience == "external" %}the administrator can [create a global field](create-param.md#section_global_field){% else %}submit a request to create a global field using [this form](create-param.md#section_global_field){% endif %}.

Issue field | Description
----- | -----
**System**
QA-engineer | The user who is assigned to test the task.
Author | The user who created the issue.
Possible spam | Spam flag for tasks created by services with [integration](../manager/queue-mail.md).
End date | Date when the issue was resolved.
Start date | Date when the issue was initiated.
Deadline | Date by which the issue should be resolved.
Boards | A list of boards the issue belongs to.
Access | A list of users who have permission to read and edit the issue but don't receive notifications about issue updates.<br/><br/>Access permissions to issues are depend on the [queue settings](../manager/queue-access.md).
Issue | Issue name.
Last update by | Last user to make changes to the issue.
Assignee | User handling the issue.
Fix Version | Product version that the issue belongs to. The list of available [versions](../manager/versions.md) is determined by issue settings.
Key | Unique issue ID used within its queue. Created automatically.
Comments <br/>without messages | Number of issue comments created in {{tracker-name}}.
Comments <br/>with messages | Number of issue comments created via [email](../manager/queue-mail.md).
Components | Tags used to mark and sort issues within a queue.<br/><br/>The list of available [components](../manager/components.md) is determined by issue settings.
Followers | A list of users following the issue. By default, users can view and edit issues and receive all notifications about issue updates.<br/><br/>Access permissions to issues depend on the [queue settings](../manager/queue-access.md).
Affected Version | [Product version](../manager/versions.md) that the issue belongs to. The list of available versions depends on the queue settings.
Pending reply <br/>from | A list of users who have been [called to comment on the issue](comments.md#call-comment). Users are removed from this field as soon as they reply in a comment.
Updated | Date and time of the [latest issue update](history.md).
Description | The field describes the issue and explains what has to be done.
Queue | [Key of the queue](../manager/create-queue.md#key) that the issue belongs to.
Last Comment | Date and time of the last comment in the issue.
Priority | The value determines the issue's importance.
Voted By | A list of users who voted on the issue.
Votes | Number of users [who voted](votes.md).
Project | Names of [projects](../manager/project-new.md) the issue belongs to.
Resolved | Date and time when the issue was {% if audience != "internal" %}[resolved](../manager/create-resolution.md){% else %}resolved{% endif %}.
Mailing lists | Teams and departments subscribed to the issue. By default, these users can view and edit issues and receive all notifications about issue updates.<br/><br/>Access permissions depend on the [queue settings](../manager/queue-access.md).
Resolution | Reason for closing the issue.
Resolver | User who closed the issue.
Created | Date and time of issue creation.
Status | Current issue progress. Examples: <q>Open</q>, <q>In progress</q>, <q>Testing</q>. For more information, see [Setting up issue statuses](../manager/workflow-status-edit.md).
Last status change | Date and time of issue status update.
Tags | Text labels that make it easier to search for issues and sort them. For more information, see [Structuring issues](../structure.md).
| {% if audience == "internal" %}Goals | Issue goal as specified in [Goals](https://goals.yandex-team.ru) that is dependent on the issue's completion.{% endif %} |
Type | Issue type, such as <q>New feature</q>, <q>Bug</q>, or <q>Improvement</q>. For more information, see [{#T}](../manager/add-ticket-type.md).
**Time Tracking** |
Time spent | Time that the assignee [spent resolving the issue](time-spent.md).
Estimate | Time that the assignee is planning to spend on the issue. The field value decreases when [time spent](time-spent.md#section_cqc_hkh_vcb) is specified.
Original estimate | The initial estimation of the time it should take to resolve the issue.
**Agile** |
Story Points | Issue complexity visualized as Story Points. For more information, see [Basic concepts of agile development](../manager/agile.md#dlen_sp).
Sprint | Name of the [sprint](../manager/create-agile-sprint.md) that the issue belongs to.
**Email** |
Email To | A list of email addresses the user specified in the **Email To** field when sending an email.
Email Cc | Email address that the user specified in the **Cc** field when sending an email.
Email From | Sender's email address.
Created By email to | Email address that received the message triggering issue creation.
**SLA** |
SLA | Timer that tracks the timeframe for processing issues in a queue. For example, you can specify the time allowed for the assignee to respond to a newly created issue. For more information, see [SLA](../sla-head.md).

## Adding a local field {#section_local_field}

If you need to add a new issue field that is not available in {{ tracker-name }}, you can add local fields to your queue.

A local field can only be used in the issues of the queue it's linked to. The advantage of local fields is that the queue owner can manage them without the risk of affecting the workflows in other queues. Users working in other queues won't see this field in their issues.

To learn more about creating and using local fields, see [Local issue fields](../local-fields.md).

{% note alert %}

Local fields are temporarily not supported in certain cases. They will be implemented later. For more information, see [Local field constraints](../local-fields.md#restrictions).

{% endnote %}

## Adding a global field {#section_global_field}

{% if audience == "external" %}

{% note alert %}

Only the [administrator](../role-model.md) can add global issue fields.

{% endnote %}

To add a new issue field (parameter):

1. Make sure you are logged in as an [administrator](../role-model.md).

1. On the {{ tracker-name }} top panel, select ![](../../_assets/tracker/icon-settings.png) → **Configure {{ tracker-name }}**.

1. Go to the **Fields** tab.

1. Click **Create field**.

1. Select the field type and click **Continue**.

1. Set parameters for the new field:

    - **Category**. All {{ tracker-name }} fields are grouped into categories. Select the category that best suits the new field.

    - **Name in Russian**. Try to give the fields short and informative names.

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

