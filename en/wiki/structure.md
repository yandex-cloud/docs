---
title: '{{ wiki-full-name }} structure'
description: In this tutorial, you will learn about the page structure in {{ wiki-name }}.
---

# Structure of {{ wiki-full-name }}

## Page tree {#structure}

{{ wiki-name }} pages are organized as a tree:

![](../_assets/wiki/wiki-sructure-diagram.png)

1. **{{ wiki-host-name }}**: {{ wiki-name }} homepage. The home page usually displays links to the main clusters, important links, or news.

1. **{{ wiki-host-name }}/page**: Top-level pages. These are usually pages related to a large general topic. For example, this could be the pages of a department, team, or project.

   {% note info %}

   The home page is not considered the parent page for top-level pages.

   {% endnote %}

1. **{{ wiki-host-name }}/page/subpage/...** : Pages of the second and lower levels.

Each page has one or more _authors_, i.e., users managing access to the page. Page authors are stated under the title.

## Partitions {#clusters}

{{ wiki-name }} pages form _clusters_:

![](../_assets/wiki/clusters.png)

A cluster is a page with all its subpages. Pages within a cluster are usually related to a common topic.

To [view or change the cluster structure](cluster-overview.md#subpages), click ![](../_assets/wiki/svg/structure-icon.svg) in the top panel.

## Personal cluster {#personal_cluster}

Each {{ wiki-name }} user has a _Personal cluster_ (`{{ wiki-username }}`). You can use your personal cluster to store your personal information, schedule, drafts, and more.

To go to your personal cluster, click ![](../_assets/wiki/svg/go-to-my-page-icon.svg) **{{ ui-key.beta-wiki.blocks_common_desktop.blocks_b-head.my_page }}** in the left-hand {{ wiki-name }} panel.

The personal cluster pages are available to all users by default.

As with other pages for which you are the author, you can [change](page-management/access-setup.md) the access settings for the pages of your personal cluster.