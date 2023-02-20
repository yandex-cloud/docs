# Exporting an issue queue to YT

You can export issue queues from {{ tracker-name }} to [YT](https://yt.yandex-team.ru/docs/) , a service for distributed storage and processing of large amounts of data. This might be helpful when you need to build analytics in {{ datalens-name }}.

To export a queue, use a special form; you must be the owner of the relevant queue to do so. The queue exported to YT is synced with the queue in {{ tracker-name }} every hour. Please note that all queue issues are exported, even those with limited access.

## Data representation {#data-format}

Exported queues are available in the HAHN cluster, namely, in the [home/startrek/tables/prod/yandex-team](https://yt.yandex-team.ru/hahn/navigation?path=//home/startrek/tables/prod/yandex-team) folder. It includes two subfolders:
* **queue**: List of queues with export requested. Each of these queues contains tables with queue entities:
   *
      ##comments##
   *
      ##components##
   *
      ##issue_events##
   *
      ##issues##
   *
      ##projects##
   *
      ##schema_version##
   *
      ##versions##
   *
      ##worklogs##

* **common**: List of entities that are common for all the queues in {{ tracker-name }}:
   *
      ##csi_results##
   *
      ##priorities##
   *
      ##resolutions##
   *
      ##schema_version##
   *
      ##sprints##
   *
      ##statuses##
   *
      ##survey_results##
   *
      ##surveys##
   *
      ##types##
   *
      ##users##

Each table uses unique identifiers (`id`) that are primary keys. If the content of a field is represented as hash, the value itself is stored in another table. To get it, run a ##JOIN## query using this hash as the `id` value.

## Permissions {#access-rights}

The STARTREK team members are responsible for exporting queues to YT and keeping them up-to-date. No one else can write data to YT tables and delete data.

The `read-approver` role is granted to the owners of exported queues. It allows them to approve read permissions for individual employees.

{% note alert %}

The queue owner must be scrupulous about granting read permissions, since all queue issues are exported, even those with limited access.

{% endnote %}

Read permissions can be requested via IDM and the appropriate role must be approved by the queue owner. Users with read permissions can view queue tables in the HAHN cluster.

{% note tip %}

If a queue has no owner, e.g., the previous owner left the job, a new owner should be appointed. This can be done by a queue team member with the [permission to edit the settings](queue-access.md). If there is no such team member, contact [support](../troubleshooting.md) to have a new owner appointed. To do this, select the following items in the form:
* Issue\problem area: Queues.
* Request type: Access.

{% endnote %}

## How to request queue export {#order-rollout}

You can request queue export using [this form](https://forms.yandex-team.ru/surveys/13669/). In the form, list the keys of queues you are requesting export for.

Queues are exported to the HAHN cluster. Each queue can only be exported to a separate folder. By default, all texts, such as issue descriptions and comments, will be masked with ##.

You can disable masking after getting approval from the information security service. If you select this option, an issue is created directly from the form in the DATAAPROVE queue and your queue will only be exported after the created issue is resolved.

{% note info %}

Queues with issues using personal data cannot be exported even in masked format.

{% endnote %}
