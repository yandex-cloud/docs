---
title: Heat map in {{ datalens-full-name }}
description: In this tutorial, you will learn how to create and customize the heat map visualization type in {{ datalens-full-name }}.
---

# Heat map ![](../../_assets/datalens/heatmap.svg) in {{ datalens-full-name }}

A heat map shows the density of point distribution. Map areas are colored with a gradient ranging from green to red: the more points are grouped in an area, the closer its color is to red.

### What you need to know about heat maps

+ Heat maps are used to display clusters of large numbers of points.

   {% note info %}

   If there are few points, using this type of map may distort the detected dependencies.

   {% endnote %}

+ A heat map is at its most effective when representing a dataset of many points within a small geographical area. 

   If there are few points, their values can be expressed through the intensity of their color: the higher the value, the closer the color is to red.

+ A heat map helps you find dependencies that might otherwise be hidden due to overlapped points on the map (in case of a [point](point-map-chart.md) map).

   For example, you can use a heat map to determine the districts where customers order for delivery most often.

   ![heat-map](../../_assets/datalens/visualization-ref/heatmap/heatmap.png =800x)

## Wizard sections {#wizard-sections}

Wizard<br/> section| Description
----- | ----
Heat map (Geopoints) | Measure of the [Geopoint](../dataset/data-types.md#geopoint) type
Colors | Dimension or measure. Affects the intensity of point fill.
Layer filters | Dimension or measure. Used as a filter for the current layer.
Filters | Dimension or measure. Used as a filter for the entire chart.

## Creating a heat map {#create-diagram}


{% include [datalens-workbooks-collections-note](../../_includes/datalens/operations/datalens-workbooks-collections-note-step4.md) %}


1. {% include [create-1](../../_includes/datalens/visualization-ref/create-1.md) %}
1. {% include [create-2](../../_includes/datalens/visualization-ref/create-2.md) %}
1. {% include [create-3](../../_includes/datalens/visualization-ref/create-3.md) %}
1. {% include [create-4](../../_includes/datalens/visualization-ref/create-4.md) %}
1. {% include [create-5](../../_includes/datalens/visualization-ref/create-5.md) %}
1. Select the **Heat map (Geopoints)** layer type.
1. Drag a dimension of the [Geopoint](../dataset/data-types.md#geopoint) type from the dataset to the layer type selection section.
1. Change the weight of the points on the heat map. To do this, drag the measure to the **Colors** section.
1. Optionally, update the [color settings](#color-settings) for the measure.

{% include [datalens-map-scale-note](../../_includes/datalens/datalens-map-scale-note.md) %}

{% include [you-can-2](../../_includes/datalens/visualization-ref/you-can-2.md) %}

### Color setting {#color-settings}

To change the color settings:

1. Click ![image](../../_assets/console-icons/gear.svg) in the **Colors** section (the icon appears when you hover over the section).
1. In the color settings, specify:

   {% include [color-setting](../../_includes/datalens/visualization-ref/color-setting.md) %}

1. Click **Apply**.

## Recommendations {#recomendations}

* Use a heat map if your dataset has many enough points. If there are few points, using this type of map may distort the detected dependencies.
* The intensity of point and area fill on a heat map varies depending on the map's scale. Please keep this in mind.


## Use cases {#examples}

* [{#T}](../tutorials/data-from-csv-geo-visualization.md)


{% include [see-also](../../_includes/datalens/visualization-ref/see-also-sub.md) %}