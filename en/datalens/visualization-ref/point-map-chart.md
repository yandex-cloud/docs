# Point map ![](../../_assets/datalens/heatmap.svg)

Each point is plotted by its geographic coordinates.

The size of a point can indicate the value of a measure: the larger the point area, the higher the measure value. This type of map is also called a bubble map.

Points may have different colors depending on the category they belong to. The color of a point can also indicate the value of a measure: the higher the value, the more intense the point fill.

This map is used to monitor how points are distributed across the area. For example, you can plot the location of stores on a point map and highlight a group with a high profit.

![point-chart](../../_assets/datalens/visualization-ref/point-chart/point-chart.png)

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


1. Go to the {{ datalens-short-name }} [home page]({{ link-datalens-main }}).
1. In the left-hand panel, select ![chart](../../_assets/console-icons/chart-column.svg) **Charts**.
1. Click **Create chart** → **Chart**.
1. At the top left, click ![image](../../_assets/console-icons/circles-intersection.svg) **Select dataset** and specify the dataset to visualize. If you do not have a dataset, [create one](../dataset/create-dataset.md#create).
1. Select **Map** for chart type.
1. Select the **Points (Geopoints)** layer type.
1. Drag a dimension of the [Geopoint](../dataset/data-types.md#geopoint) type from the dataset to the layer type selection section.
1. Set the size of the points displayed on the point map. Drag a measure to the **Point size** section or click ![image](../../_assets/console-icons/gear.svg) in the line with the section name.
1. Color the points on the map. Move the measure or dimension to the **Colors** section.
1. Add tooltips to show the dimension and measure values when hovering over a point.

{% include [datalens-map-scale-note](../../_includes/datalens/datalens-map-scale-note.md) %}

You can also:

* Add, rename, and delete a layer.
* Reorder the layers within a layer type.
* Apply a filter to the whole chart or one layer.

## Recommendations {#recomendations}

* Use color palettes corresponding to the goals and objectives of visualization.
* If the density of points on the map is high, make them less transparent. This will help you see where data intersects.


## Use cases {#examples}

* [{#T}](../tutorials/data-from-ch-to-geolayers-visualization.md)
* [{#T}](../tutorials/data-from-ch-geocoder.md)


#### See also {#see-also}

* [{#T}](../operations/dashboard/create.md)
* [{#T}](../operations/dashboard/add-chart.md)
* [{#T}](../operations/dashboard/add-selector.md)