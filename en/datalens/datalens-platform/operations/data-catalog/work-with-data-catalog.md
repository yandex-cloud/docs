---
title: Working with metadata in {{ datalens-platform-full-name }}
description: Follow this guide to view metadata, sort it, see where it was ingested from, and explore its relationships with data processing workflows in {{ datalens-platform-full-name }}.
---

# Viewing metadata

To view [metadata](../../concepts/data-catalog/index.md) of an external source, enable the **Get metadata** option when [creating a connection](../../quickstart.md#create-connection). If you want to view metadata of tables ingested to the [REST catalog](../../concepts/rest-catalog/index.md), first [create and activate a data transfer](../data-transfer/regular-copy.md).

To view the metadata summary, you [will need this role](../../security/index.md): `View metadata`.

## Viewing resources {#view-resources}

All resources of the {{ datalens-platform-full-name }} analytics platform are displayed as a tree, which can be built from data storages or from [assigned domains](metadata-markup.md). To view information about a specific object:

1. Go to the ![image](../../../../_assets/console-icons/folder-magnifier.svg) **Metadata** section, **Resource catalog** tab.
1. Select how to build the resource tree: **From storages** or **From domains**.
1. Click ![image](../../../../_assets/console-icons/funnel.svg) and select the object types to display in the tree to narrow down the selection.
1. Expand the tree structure to explore the metadata of a specific data object.

   The right-hand panel shows the metadata of the selected object: its type, structure, assigned [domains](metadata-markup.md#domains), [tags](metadata-markup.md#classifications-and-tags), or [terms](metadata-markup.md#glossaries-and-terms), [relationships](metadata-linage.md) with other data, and versions of this object.

For each object, you can configure or change the [metadata markup](metadata-markup.md#specific-markup) or go to the [SQL editor](../sql/work-with-sql.md) to create queries and build a data sample for analysis.

## Viewing metadata summary {#view-metadata-dashboard}

The **Metadata summary** dashboard in {{ datalens-platform-full-name }} shows aggregated statistics on data catalog objects: metadata, domains, glossaries, classifications, and dashboards. Use that dashboard to assess how completely metadata is filled in and how it has grown over the selected period. To view the summary:

1. Go to the ![image](../../../../_assets/console-icons/folder-magnifier.svg) **Metadata** section, **Resource catalog** tab.
1. Select **Metadata summary**.

   The dashboard consists of three types of widgets: counter charts (current picture), trend charts (changes over time), and tables (latest or related objects).

1. At the top of the dashboard, open the selector and select the desired time interval. All widgets automatically recalculate for the selected period.
1. Hover over a graph to see the exact value in a tooltip. For chart widgets, use the visualization type (bar chart, line chart, table, etc.) toggle buttons in the top-right corner of the widget. In table widgets, scroll through the list to view all rows.

## View relationships and processes {#view-metadata-processes}

The **Relationships and processes** section shows a graph of relationships between metadata objects: connections and data stores, charts, workbooks, and other resources. The graph shows where the data comes from and where it goes next. That is, you can trace the data path from the source to the final objects.

To view relationships and processes:

1. Go to the ![image](../../../../_assets/console-icons/folder-magnifier.svg) **Metadata** section, **Resource catalog** tab.
1. Select **Relationships and processes**.

The graph shows each object as a separate card (node), with arrows between the cards showing the direction of the relationship from the source to the consumer. Each node card shows:

* Object icon and name; click either to open the object.
* Object type (e.g., `datastore` or `chart`).
* Object location (e.g., `DataLens/Users/user1/my-workbook`).

Filters are available above the graph, and you can combine them:

* **All objects**: Select the object to build a relationship graph for. Start typing the name to find the desired object in the list.
* **Depth**: Specify how many levels of relationships to expand the graph from the selected object. Use the up and down arrows to change the **Depth** field value (e.g., `Depth 1`).
* **Show additional relationships**: Select to show additional object relationships on the graph.
* **Personal data**: Select to highlight objects containing personal data.

Use the navigation and zoom controls to move around the graph.

You can export the object’s relationships to a file. Click **Download** above the graph and select the format: **CSV** or **JSON**.
