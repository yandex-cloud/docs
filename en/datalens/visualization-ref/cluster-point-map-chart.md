---
title: Point map with clusters in {{ datalens-full-name }}
description: In this tutorial, you will learn how to create and customize the point map with clusters visualization type in {{ datalens-full-name }}.
---

# Point map with clusters ![](../../_assets/datalens/heatmap.svg) in {{ datalens-full-name }}

A point map with clusters differs from a [regular point map](point-map-chart.md) in clustering adjacent points. On the map, a cluster looks like a donut chart with the number of points displayed in the center.

{% note info %}

The number in the center only indicates the number of cluster points. You cannot select a different metric, e.g., the total of values across all points.

{% endnote %}

The behavior of points varies depending on the map scale:

* When scaling down, points merge into clusters.
* When scaling up, the distance between points increases and the cluster automatically splits into smaller clusters and/or individual points.

If the map has only one point in the selected scale, this point is not going to be clustered. In this case, instead of a donut chart, you will see a point just like in a regular point map.

Clustering on a map improves visualization when there is a large number of points. For example, if you want to show the location of all stores in a city on a map with clustering, points on the map will not overlap.

![point-chart](../../_assets/datalens/visualization-ref/cluster-point-map/cluster-point-map.png =800x)

## Wizard sections {#wizard-sections}

The following restrictions apply:

* The **Point size**, **Tooltips**, and **Signatures** sections only apply to individual points.
* You can only add a dimension to the **Color** section.

Wizard<br/> section| Description
----- | ----
Points with clusters (Geopoints) | Measure of the [Geopoint](../dataset/data-types.md#geopoint) type
Point size | Measure. Sets point size depending on the measure value.
Colors | Dimension. Sets cluster chart segmentation.
Labels | Measure. Displayed as text on a point. When used, point size control is blocked.
Tooltips | Dimension or measure. A tooltip that appears when you hover over a point. For `String` type fields, you can configure using basic [{#T}](../dashboard/markdown.md) syntax: click the icon before the field name and enable **Markdown**.
Layer filters | Dimension or measure. Used as a filter for the current layer.
Filters | Dimension or measure. Used as a filter for the entire chart.

## Creating a point map with clusters {#create-diagram}


{% include [datalens-workbooks-collections-note](../../_includes/datalens/operations/datalens-workbooks-collections-note-step4.md) %}


1. {% include [create-1](../../_includes/datalens/visualization-ref/create-1.md) %}
1. {% include [create-2](../../_includes/datalens/visualization-ref/create-2.md) %}
1. {% include [create-3](../../_includes/datalens/visualization-ref/create-3.md) %}
1. {% include [create-4](../../_includes/datalens/visualization-ref/create-4.md) %}
1. {% include [create-5](../../_includes/datalens/visualization-ref/create-5.md) %}
1. Select the **Points with clusters (Geopoints)** layer type.
1. Drag a dimension of the [Geopoint](../dataset/data-types.md#geopoint) type from the dataset to the layer type selection section.
1. Set the size of the points displayed on the point map. Drag a measure to the **Point size** section or click ![image](../../_assets/console-icons/gear.svg) in the line with the section name.
1. Color the points on the map. Drag a dimension to the **Color** section.
1. Add tooltips to show the dimension and measure values when hovering over a point.

{% include [datalens-map-scale-note](../../_includes/datalens/datalens-map-scale-note.md) %}

{% include [you-can-3](../../_includes/datalens/visualization-ref/you-can-3.md) %}

## Recommendations {#recomendations}

* Use color palettes corresponding to the goals and objectives of visualization.

{% include [see-also](../../_includes/datalens/visualization-ref/see-also-sub.md) %}