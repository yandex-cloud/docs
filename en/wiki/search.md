# Searching by {{ wiki-name }}

To perform a search by text on Wiki pages:

1. In the {{ wiki-name }} left panel, click ![](../_assets/wiki/svg/search.svg) **Search**.

1. Enter your query in the search bar. The Wiki pages that contain the specified text will be shown under the search bar.



1. To refine the search results, press **Enter** in the search bar and use filters in the right panel:

   - **Cluster**. The URL of a [cluster](structure.md#clusters) relative to the `{{ wiki-host-name }}` homepage. For example, to find text on subpages of the `{{ wiki-username }}` cluster, enter `users/userName`.
   - **Page author**: The name or username of the {{ wiki-name }} page author.
   - **Created** or **Updated**: The date when the page was created or last changed.
   - **Document type**: Search for a specific type of {{ wiki-name }} document (page, table, or file).



1. Sort the search results: by relevance, last update, or creation date.




{% note warning %}

Recent changes to Wiki pages may appear in search results after a delay, since the pages are indexed once every 30 minutes.

{% endnote %}