# Working in {{ wiki-full-name }}

In {{ wiki-name }}, you can create pages in private or public [clusters](structure.md#clusters). Use [private pages](structure.md#personal_cluster) to store your drafts and work materials. Use shared themed clusters for documents that can be helpful to colleagues.

{% if audience == "internal" %}
Examples of themed clusters:

* Yandex service clusters: Pages with service descriptions, plans, reports, and analytics.

* Division clusters: Pages of Yandex departments and services.

## Access management {#access}

By default, access to pages is granted to all Yandex employees. Access for [external employees](page-management/access-setup.md#outstaff) can be limited.

Access rights for a page can be configured by its author. A department or service head is to make sure that all NDA documents have the appropriate [privacy settings](page-management/access-setup.md).
{% endif %}

## Recommendations for working with public pages {#common-rules}

{{ wiki-full-name }} has no strict work rules{% if audience == "external" %}: each organization can configure their own custom cluster structure{% endif %}. To make it easier to exchange information with colleagues, follow the general recommendations:
{% if audience == "internal" %}
* Create pages in clusters of relevant services, projects, or departments.
   {% else %}
* Create public pages in clusters with a relevant theme.
   {% endif %}

   If you created a page in a wrong cluster by mistake, you can [move](page-management/move-page.md) the page.

* Add [cross links](static-markup/links.md#wiki-ref) to other cluster pages so that people can easily find relevant information.

* Grant page [access](page-management/access-setup.md) to any employees{% if audience == "internal" %}, departments, or service teams{% endif %} that this page may be helpful to.

   By default, all users who have access to a page can edit it. The author can always [undo changes](history.md#return-to-old) and revert to a previous page version.

* Make your page [read-only](page-management/access-setup.md#read-only) if you don't want others to edit it.

* If you want to avoid editing someone else's page, leave a comment to it: both the author and followers will be notified.