---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Creating a map

To create a map:

1. On the {{ datalens-full-name }} homepage, click **Create chart**.

1. Under **Dataset**, select a dataset to visualize. If you don't have a dataset, [create one](../dataset/create.md).

1. Select the chart type **Map**:

   {% list tabs %}

     - Point map
       1. Drag a dimension with the type [`Geopoint`](../../concepts/data-types#geopoint) from the dataset to the layer type selection section.
       1. Set the size of the points displayed on the point map. Move the measure to the **Size** section or click the **Size** icon in the section.
       1. Color the points on the map. Move the measure or dimension to the **Color** section.
       1. Add tooltips to show the dimension and measure values when hovering over a point.

     - Choropleth map
       1. Drag a dimension with the type [`Geopolygon`](../../concepts/data-types#geopolygon) from the dataset to the layer type selection section.
       1. Color the polygons on the map. Move the measure or dimension to the **Color** section.
       1. Add tooltips to show the dimension and measure values when hovering over a polygon.

     - Heat map
       1. Drag a dimension with the type [`Geopoint`](../../concepts/data-types#geopoint) from the dataset to the layer type selection section.
       1. Change the weight of the points on the heat map. To do this, drag the measure to the **Color** section.

   {% endlist %}

You can also:

* Add, rename, and delete a layer.
* Reorder the layers within a layer type.
* Apply a filter to the whole chart or one layer.

