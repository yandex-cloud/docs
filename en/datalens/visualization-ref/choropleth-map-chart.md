# Choropleth map ![](../../_assets/datalens/heatmap.svg)

A choropleth map uses different colors or shades to display entire areas and regions. Areas on a map are set using geopolygons. A geopolygon is an element that consists of an area bounded by a close line and the line itself. The value of a measure is indicated through the intensity of color or its shade.

To show polygons on a map, add a [Geopolygon](../dataset/data-types.md#geopolygon) type field to your dataset:

* Create a text field with data like `[[[55.60807, 37.5698], [55.60847, 37.56992], [55.60851, 37.57095]]]`, with polygon point coordinates enclosed in square brackets. You can first prepare data in a database and set the [Geopolygon](../dataset/data-types.md#geopolygon) data type in the dataset description interface.
* Use the `GEOPOLYGON(polygon_string)` [function](../function-ref/GEOPOLYGON.md) to create a calculated field with the [Geopolygon](../dataset/data-types.md#geopolygon) data type.
* If your data contains a field with a city, region, or country name, use the [geopoint/geopolygon reference](https://geointellect.com/files/geo_for_datalens.zip) by a Yandex partner Geointellect.

Follow the [link](https://storage.yandexcloud.net/doc-files/Regions.csv) to download a sample CSV file with Russian region polygons.

​A choropleth map is used to analyze a measure within a territorial unit. For example, you can use a choropleth map to show the population density of individual districts.

![choropleth-map](../../_assets/datalens/visualization-ref/choropleth-map/choropleth-map.png)


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


1. Go to the {{ datalens-short-name }} [home page]({{ link-datalens-main }}).
1. In the left-hand panel, select ![chart](../../_assets/console-icons/chart-column.svg) **Charts**.
1. Click **Create chart** → **Chart**.
1. At the top left, click ![image](../../_assets/console-icons/circles-intersection.svg) **Select dataset** and specify the dataset to visualize. If you do not have a dataset, [create one](../dataset/create-dataset.md#create).
1. Select **Map** for chart type.
1. Select **Polygons (Geopolygons)** as the layer type.
1. Drag a dimension of the [Geopolygon](../dataset/data-types.md#geopolygon) type from the dataset to the layer type selection section.
1. Color the polygons on the map. Move the measure or dimension to the **Colors** section.
1. Add tooltips to show the dimension and measure values when hovering over a polygon.

You can also:

* Add, rename, and delete a layer.
* Apply a filter to the whole chart or one layer.

## Recommendations {#recomendations}

* Do not use a choropleth map to precisely compare some values.
* To make the comparison more precise, add data signatures or tooltips with information to the map.
