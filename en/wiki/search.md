# Searching {{ wiki-name }}

You can do a text search in Wiki pages. To do this, use the search bar that appears at the top right of each page{% if audience == "internal" %}. Enter your query and click ![](../_assets/wiki/search-icon.png) or press **Enter**.{% else %}.

1. Enter your search query and click the ![](../_assets/wiki/search-icon.png) icon or press **Enter**.

1. For more accurate search results, use filters from the panel on the right:
   - **Cluster**. Cluster [address](structure.md#clusters) in relation to the home page `{{ wiki-host-name }}`. For example, to find a text on subpages within the cluster `{{ wiki-username }}`, enter `users/username`.
   - **Page owner**. Page owner username {{ wiki-name }}.
   - **Creation date** or **Update date**. The time period when the page was created or the last edited.
   - **Document type**. Document search on {{ wiki-name }} by type: page, table, or file.

1. Sort the search results: by relevance, last update, or creation date.

{% endif %}

{% note warning %}

It may take some time for search results to update in accordance with the changes you made, since pages are indexed once every 30 minutes.

{% endnote %}

