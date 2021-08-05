---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Creating a tree chart

To create a tree chart:

1. On the {{ datalens-full-name }} [home page]({{ link-datalens-main }}), click **Create chart**.
1. Under **Dataset**, select a dataset to visualize. If you don't have a dataset, [create one](../dataset/create.md).
1. Select **Tree chart** as the chart type.
1. Drag one or more dimensions from the dataset to the **Dimensions** section.
1. Drag a measure from the dataset to the **Size** section. The values are displayed as rectangles. The areas of the rectangles are proportional to the corresponding values of the selected measure.
1. Drag a measure or dimension to the **Colors** section. As a result, the rectangles are colored depending on the value of the added measure or dimension.

   {% note info %}

   A dimension that you can add to the **Colors** section must be from the **Dimensions** section.

   {% endnote %}

1. Drag a dimension or measure from the dataset to the **Filters** section. The field can be empty. In this case, no filters are applied.