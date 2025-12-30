---
title: Map in {{ datalens-full-name }}
description: In this tutorial, you will learn how to create and customize the map visualization type in {{ datalens-full-name }}.
---

# Map ![](../../_assets/datalens/heatmap.svg) in {{ datalens-full-name }}

Maps are used for geoanalytics: displaying and analyzing business indicators on a map. 

### What you can see on maps

+ Population size and density.
+ Number of commercial facilities and their revenue.
+ Other measures potentially affecting business performance.

## Map layer types

* **Areas**
    
    A layer of this type represents entire areas or regions. The measure value is expressed through colors or hues.    
    By adding tooltips with region names and measures you can make the chart info easier to read.

* **Points**
    
     Points can represent individual objects, such as cities, stores, pickup points, or customer addresses.
     There are two ways to show the value: through point color and size.

* **Lines**
    
     Lines are used to show connections between objects on the map, such as airline flights or cargo transportation routes.

* **Heatmap**

    Shows the density of points on the map. This map type is useful for displaying large numbers of points and areas of their clustering.

    ![image](../../_assets/datalens/visualization-ref/map/map.png =800x)

## What you need to know about maps

+ To create a map, add either coordinates with the [Geopoint](../dataset/data-types.md#geopoint) type or areas with the [Geopolygon](../dataset/data-types.md#geopolygon) type to the data source.

+ Use the **Center** and **Scale** [settings](../concepts/chart/settings.md#common-settings) to show a portion of the map.

+ A single map supports up to five layers of any visualization type. 

## Geolayers

**Map** chart layers are called _geolayers_. Geolayers are used to present measures as points or polygons.

### What you can do with geolayers

* Rename a layer.
* Set transparency using the slider.
* Reorder layers within the visualization type.
    However, you cannot change the order of visualization types (top-to-bottom: point map, polyline map, chloropleth map, and heatmap).


You can purchase pre-calculated geolayers from partners in [{{ marketplace-full-name }}](https://yandex.cloud/ru/marketplace?tab=datalens&categories=geolayer).


{% note info %}

You cannot create maps in [QL charts](../concepts/chart/index.md#sql-charts).

{% endnote %}

{% include [see-also](../../_includes/datalens/visualization-ref/see-also-sub.md) %}
