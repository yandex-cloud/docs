---
title: "How to view the structure of pages and sections in {{ wiki-full-name }}"
description: "In this tutorial, you will learn how to view the structure of pages and sections in {{ wiki-name }}."
---

# Viewing the page and cluster hierarchy

## Table of contents of a page {#toc}

To view the table of contents of a page:

1. Open the page.

1. In the top-right panel, click ![](../_assets/wiki/svg/ico-toc.svg) **Page contents**.

1. To insert a table of contents into the text of your page, use the [`not_var{{toc}}` dynamic block](actions/toc.md).

## Cluster structure {#subpages}

A page with all its subpages forms a [cluster](structure.md). To view the cluster structure:

1. Open the page.

1. In the top panel, click ![](../_assets/wiki/svg/structure-icon.svg) **{{ ui-key.beta-wiki.blocks_common_desktop.blocks_b-page-more-panel.tree }}**.

1. To see all subpages, click the expand list icon ![](../_assets/wiki/svg/navigation-tree-item.svg) to the left of the parent page name.

1. To change the position of pages in the tree, click on the desired page, drag it along the structure of the cluster, and then click **{{ ui-key.beta-wiki.blocks_common_desktop.blocks_b-editor-struct.page_save }}**.

## Embedding a cluster tree in a page {#action-tree}

Using the `not_var{{tree}}` dynamic block, you can create a tree of cluster pages and place it on any page.

To build a tree for the current page, place `not_var{{tree}}` block in its text.

You can customize the appearance of the page tree using [additional parameters](actions/page-lists.md).