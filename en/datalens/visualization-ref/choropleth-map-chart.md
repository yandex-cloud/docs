---
title: Choropleth map in {{ datalens-full-name }}
description: In this tutorial, you will learn how to create and customize the choropleth map visualization type in {{ datalens-full-name }}.
---

# Choropleth map ![](../../_assets/datalens/heatmap.svg) in {{ datalens-full-name }}

A choropleth map uses different colors and hues for entire areas and regions. Areas on a map are set using geopolygons. 

A _geopolygon_ is an element that consists of an area bounded by a closed line and the line itself. The measure value is expressed through color saturation or hue.

​A choropleth map is used to analyze a measure within a territorial unit. For example, you can use a choropleth map to demonstrate the density of population of individual districts.

![choropleth-map](../../_assets/datalens/visualization-ref/choropleth-map/choropleth-map.png =800x)

To show polygons on a map, add a [Geopolygon](../dataset/data-types.md#geopolygon) type field to your dataset:

* Create a text field with data formatted as `[[[55.60807, 37.5698], [55.60847, 37.56992], [55.60851, 37.57095]]]` for polygon point coordinates enclosed in square brackets. 
    You can first prepare data in a database and set the [Geopolygon](../dataset/data-types.md#geopolygon) data type in the dataset description interface.
* Use the `GEOPOLYGON(polygon_string)` [function](../function-ref/GEOPOLYGON.md) to create a calculated field with the [Geopolygon](../dataset/data-types.md#geopolygon) data type.
* If your data contains a field with names of cities, regions, or countries, use the [geopoint/geopolygon reference](https://geointellect.com/files/geo_for_datalens.zip) by a Yandex partner Geointellect.

Follow the [link](https://storage.yandexcloud.net/doc-files/Regions.csv) to download a sample CSV file with Russian region polygons.

## Wizard sections {#wizard-sections}

Wizard<br/> section| Description
----- | ----
Polygons (Geopolygons) | Measure of the [Geopolygon](../dataset/data-types.md#geopolygon) type
Colors | Dimension or measure. Affects the color and intensity of area fill.
Tooltips | Dimension or measure. A tooltip that appears when you hover over an area. For `String` type fields, you can configure using basic [{#T}](../dashboard/markdown.md) syntax: click the icon before the field name and enable **Markdown**.
Layer filters | Dimension or measure. Used as a filter for the current layer.
Filters | Dimension or measure. Used as a filter for the entire chart.

## Creating a choropleth map {#create-diagram}


{% include [datalens-workbooks-collections-note](../../_includes/datalens/operations/datalens-workbooks-collections-note-step4.md) %}


1. {% include [create-1](../../_includes/datalens/visualization-ref/create-1.md) %}
1. {% include [create-2](../../_includes/datalens/visualization-ref/create-2.md) %}
1. {% include [create-3](../../_includes/datalens/visualization-ref/create-3.md) %}
1. {% include [create-4](../../_includes/datalens/visualization-ref/create-4.md) %}
1. {% include [create-5](../../_includes/datalens/visualization-ref/create-5.md) %}
1. Select **Polygons (Geopolygons)** as the layer type.
1. Drag a dimension of the [Geopolygon](../dataset/data-types.md#geopolygon) type from the dataset to the layer type selection section.
1. Color the polygons on the map. Move the measure or dimension to the **Colors** section.
1. Add tooltips to show the dimension and measure values when hovering over a polygon.

{% include [datalens-map-scale-note](../../_includes/datalens/datalens-map-scale-note.md) %}

{% include [you-can-3](../../_includes/datalens/visualization-ref/you-can-3.md) %}

## Recommendations {#recomendations}

* Do not use a choropleth map to precisely compare some values.
* To make the comparison more precise, add data signatures or tooltips with information to the map.

{% include [see-also](../../_includes/datalens/visualization-ref/see-also-sub.md) %}