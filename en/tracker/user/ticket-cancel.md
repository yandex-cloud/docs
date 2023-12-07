# Deleting an issue

You cannot delete an issue in {{ tracker-name }}. This operation is disabled for the convenience of your organization and employees. This makes sure the information about all issues remains in the database and can be fetched at any time. If you created an issue by mistake and want to cancel it because your plans have changed, close the issue with a proper resolution.

For example, duplicate issues can be closed with the <q>{{ ui-key.startrek-backend.applinks.samsara.resolution.duplicate }}</q> resolution, while issues created by mistake can be closed with the <q>Canceled</q> resolution. For more information about how to close issues, see [Working with issues](ticket-in-progress.md#section_kyj_gbm_2z).

To hide an unwanted issue from search results and dashboards, you may need to clear the **Assignee** field, delete its links to other issues, or perform some other action, depending on the search parameters you want to hide it for.


{% note tip %}

You can [delete a queue](../manager/delete-queue.md) and all the issues in it: [Move](move-ticket.md) the issues you don't need to a special queue and then delete it.

{% endnote %}

