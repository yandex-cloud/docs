# How to work in {{ wiki-full-name }}

In {{ wiki-name }}, you can create pages in private or public [clusters](structure.md#clusters). Use [private pages](structure.md#personal_cluster) to store your drafts and work materials. Use shared themed clusters for documents that can be helpful to colleagues.

{% if audience == "internal" %}

Examples of themed clusters:

* Clusters of Yandex services are pages with service descriptions, roadmaps, reports, and analytics.

* Clusters of divisions are pages maintained by Yandex departments, groups, and service teams.

## Access control {#access}

All Yandex employees have access to pages by default. For [outstaffers](page-management/access-setup.md#outstaff), access can be limited.

Authors are responsible for granting access rights for their pages. Department heads and service team leaders are responsible for [privacy settings](page-management/access-setup.md) for NDA documents.
{% endif %}

## Recommendations for working with public pages {#common-rules}

{{ wiki-full-name }} provides no strict work rules{% if audience == "external" %}: each organization can configure their own custom cluster structure{% endif %}. To make it easier to exchange information with colleagues, follow the general recommendations:
{% if audience == "internal" %}

* Create pages in the cluster of the service, project, or department you are writing about.
{% else %}

* Create public pages in clusters with a relevant theme.
{% endif %}

  If you created a page in a wrong cluster by mistake, you can [move](page-management/move-page.md) the page.

* Add [cross links](static-markup/links.md#wiki-ref) to other cluster pages so that people can easily find relevant information.

* Grant [access](page-management/access-setup.md) to the page to all employees{% if audience == "internal" %}, departments, or service teams{% endif %} that need it.

  By default, all users who have access to a page can edit it. The author can always [undo changes](history.md#return-to-old) and revert to a previous page version.

* Make your page [read-only](page-management/access-setup.md#read-only) if you don't want others to edit it.

* If you want to avoid editing someone else's page, leave a comment to it: both the author and followers will be notified.

