# Work in {{ wiki-full-name }}

In {{ wiki-name }}, you can create pages in private or public [clusters](structure.md#clusters). You can use [personal pages](structure.md#personal_cluster) to store drafts and private working documents. Documents that might be useful to other employees should be stored in shared clusters.

{% if audience == "internal" %}
Examples of thematic clusters:

* Yandex service clusters are pages with service descriptions, plans, reports, and statistics.

* Division clusters are pages for divisions, departments, and Yandex internal services.

## Managing access {#access}

By default, the pages can be accessed by all Yandex employees. [External employees](page-management/access-setup.md#outstaff) may have limited access.

Page access is managed by page owners. Department and service managers ensure that all documents under DNA have the appropriate [privacy settings](page-management/access-setup.md).
{% endif %}

## Recommendations for working with public pages {#common-rules}

{{ wiki-full-name }} has no strict workflow rules{% if audience == "external" %}: each organization can have its own cluster hierarchy{% endif %}. You can follow the general guidelines to facilitate information exchange between colleagues:
{% if audience == "internal" %}

* Create pages in a cluster that is associated with the service, project, or department in question.
{% else %}

* Create public pages in clusters with appropriate topics.
{% endif %}

  If you accidentally created a page in the wrong cluster, you can [move](page-management/move-page.md) the page.

* Adding [cross-links](static-markup/links.md#wiki-ref) to other pages within the cluster will make it easier to search for necessary information.

* Open [page access](page-management/access-setup.md) to all employees{% if audience == "internal" %}, divisions, or service teams{% endif %} who may need it.

  By default, all users who have access to a page can edit it. The owner of a document can always [undo changes](history.md#return-to-old) and roll back to the previous version of the page.

* You can make the page [read-only](page-management/read-only.md) if you need to.

* If you don't want to edit someone else's page, leave a comment. The page owner and page followers will be notified about it.

