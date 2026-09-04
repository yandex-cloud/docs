---
title: Point map with clusters in {{ datalens-full-name }}
description: In this article, you will learn how to create and customize the point map with clusters visualization type in {{ datalens-full-name }}.
---

# Point map with clusters ![](../../_assets/datalens/heatmap.svg) in {{ datalens-full-name }}

A point map with clusters differs from a [regular point map](point-map-chart.md) in clustering adjacent points. On the map, a cluster looks like a donut chart with the number of points displayed in the center.

{% note info %}

The number in the center only indicates the number of cluster points. You cannot select a different measure, e.g., the total of values across all points.

{% endnote %}

The behavior of points varies depending on the map scale:

* When scaling down, points merge into clusters.
* When scaling up, the distance between points increases and the cluster automatically splits into smaller clusters and/or individual points.

If the map has only one point in the selected scale, this point will not be clustered. In this case, instead of a donut chart, you will see a point just like in a regular point map.

Clustering on a map improves visualization when there is a large number of points. For example, if you want to show the location of all stores in a city on a map with clustering, points on the map will not overlap.

![point-chart](../../_assets/datalens/visualization-ref/cluster-point-map/cluster-point-map.png =800x)


{% include [geointellect-using](../../_includes/datalens/visualization-ref/geointellect-using.md) %}


## Wizard sections {#wizard-sections}

The following limitations apply:

* The **Point size**, **Tooltips**, and **Labels** sections only apply to individual points.
* You can only add a dimension to the **Colors** section.

Wizard<br/> section| Description
----- | ----
Points with clusters (Geopoints) | Dimension of the [Geopoint](../dataset/data-types.md#geopoint) type.
Point size | Measure. Sets the point size depending on the measure value.
Colors | Dimension. Sets cluster chart segmentation.
Labels | Measure. Displayed as text on a point. When using labels, you cannot manage the point size.
Tooltips | Dimension or measure. A tooltip that appears when you hover over a point. For `String` type fields, you can configure using the basic [Markdown](../dashboard/markdown.md) syntax: click the icon before the field name and enable **Markdown**.
Layer filters | Dimension or measure. It is used as a filter for the current layer.
Filters | Dimension or measure. It is used as a filter for the entire chart.

## Creating a point map with clusters {#create-diagram}

{% include [datalens-workbooks-collections-note](../../_includes/datalens/operations/datalens-workbooks-collections-note-step4.md) %}

1. {% include [create-1](../../_includes/datalens/visualization-ref/create-1.md) %}
1. {% include [create-2](../../_includes/datalens/visualization-ref/create-2.md) %}
1. {% include [create-3](../../_includes/datalens/visualization-ref/create-3.md) %}
1. {% include [create-4](../../_includes/datalens/visualization-ref/create-4.md) %}
1. {% include [create-5](../../_includes/datalens/visualization-ref/create-5.md) %}
1. Select the **Points with clusters (Geopoints)** layer type.
1. Drag a dimension of the [Geopoint](../dataset/data-types.md#geopoint) type from the dataset to the layer type selection section.
1. Set the point size for the point map. Drag a measure to the **Point size** section or click ![image](../../_assets/console-icons/gear.svg) in the line with the section name.
1. Color the points on the map. Drag a dimension to the **Colors** section.
1. Add tooltips to show the dimension and measure values when hovering over a point.

{% include [datalens-map-scale-note](../../_includes/datalens/datalens-map-scale-note.md) %}

{% include [you-can-3](../../_includes/datalens/visualization-ref/you-can-3.md) %}

## Recommendations {#recomendations}

* Use color palettes suitable for the goals and objectives of visualization.

{% include [see-also](../../_includes/datalens/visualization-ref/see-also-sub.md) %}