---
title: Point map in {{ datalens-full-name }}
description: In this tutorial, you will learn how to create and customize the point map visualization type in {{ datalens-full-name }}.
---

# Point map ![](../../_assets/datalens/heatmap.svg) in {{ datalens-full-name }}

Each point is plotted by its geographic coordinates.

+ **Point size**

    Point size can represent the value of the measure: the bigger the point, the higher the value. This map type can also called the bubble map.

+ **Point color**

    Different points colors mean that the points belong to different categories. Color intensity represents the value of the measure.

This map type is used to monitor the territorial distribution of points. For example, you can use the point map to plot stores and highlight the group of higher-profit ones.

![point-chart](../../_assets/datalens/visualization-ref/point-chart/point-chart.png =800x)

## Wizard sections {#wizard-sections}

Wizard<br/> section| Description
----- | ----
Points (Geopoints) | Measure of the [Geopoint](../dataset/data-types.md#geopoint) type
Point size | Measure. Sets point size depending on the measure value.
Colors | Dimension or measure. Affects the intensity of point fill.
Labels | Measure. Displayed as text on a point. When used, point size control is blocked.
Tooltips | Dimension or measure. A tooltip that appears when you hover over a point. For `String` type fields, you can configure using basic [{#T}](../dashboard/markdown.md) syntax: click the icon before the field name and enable **Markdown**.
Layer filters | Dimension or measure. Used as a filter for the current layer.
Filters | Dimension or measure. Used as a filter for the entire chart.

## Creating a point map {#create-diagram}


{% include [datalens-workbooks-collections-note](../../_includes/datalens/operations/datalens-workbooks-collections-note-step4.md) %}


1. {% include [create-1](../../_includes/datalens/visualization-ref/create-1.md) %}
1. {% include [create-2](../../_includes/datalens/visualization-ref/create-2.md) %}
1. {% include [create-3](../../_includes/datalens/visualization-ref/create-3.md) %}
1. {% include [create-4](../../_includes/datalens/visualization-ref/create-4.md) %}
1. {% include [create-5](../../_includes/datalens/visualization-ref/create-5.md) %}
1. Select the **Points (Geopoints)** layer type.
1. Drag a dimension of the [Geopoint](../dataset/data-types.md#geopoint) type from the dataset to the layer type selection section.
1. Set the size of the points displayed on the point map. Drag a measure to the **Point size** section or click ![image](../../_assets/console-icons/gear.svg) in the line with the section name.
1. Color the points on the map. Move the measure or dimension to the **Colors** section.
1. Add tooltips to show the dimension and measure values when hovering over a point.

{% include [datalens-map-scale-note](../../_includes/datalens/datalens-map-scale-note.md) %}

{% include [you-can-3](../../_includes/datalens/visualization-ref/you-can-3.md) %}

## Recommendations {#recomendations}

* Use color palettes corresponding to the goals and objectives of visualization.
* If the points are too clustered, lower their opacity. This will help you see where data intersects.


## Use cases {#examples}

* [{#T}](../tutorials/data-from-ch-to-geolayers-visualization.md)
* [{#T}](../tutorials/data-from-ch-geocoder.md)


{% include [see-also](../../_includes/datalens/visualization-ref/see-also-sub.md) %}