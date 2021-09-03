# How {{ wiki-name }} works

## Structure {#structure}

{{ wiki-name }} pages are organized as a tree:

![](../_assets/wiki/wiki-sructure-diagram.png)

1. **{{ wiki-host-name }}**: The {{ wiki-name }} home page. The home page usually displays links to the main clusters, important links, and news.

1. **{{ wiki-host-name }}/page**: Top-level pages. These pages usually share a common theme. For example, they can all be related to a single department, team, or project.

    {% note info %}

    The home page is not considered a parent page in relation to top-level pages.

    {% endnote %}

1. **{{ wiki-host-name }}/page/subpage/...**: Second- and subsequent-level pages.

Each page has one or more _authors_, which are users who manage access to the page. The page author's name is displayed under the page title.

## Clusters {#section_wdq_z4d_sy}

{{ wiki-name }} pages form _clusters_:

![](../_assets/wiki/clusters.png)

A page with all its subpages together form one cluster. Pages within a cluster are usually related to a 
common topic.

## Personal cluster {#personal_cluster}

Each {{ wiki-name }} user has a _personal cluster_ (`{{ wiki-username }}`). You can use your personal cluster to store your personal information, schedule, drafts, or whatever you want. To access your personal cluster, click **My page** in the {{ wiki-name }} upper panel. Personal clusters can be viewed by other users by default.

In each personal cluster, there is a notes section that is closed to other users (`{{ wiki-notes }}`). You can [create notes](create-note.md) with two clicks from any {{ wiki-name }} page. To go to the Notes cluster, click **Notes** in the {{ wiki-name }} header.

As with other pages for which you are the author, you can [change](page-managment/access-setup.md) access settings for the pages in your personal cluster and the notes section.

