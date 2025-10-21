---
title: How to add a description to a chart in {{ datalens-full-name }}
description: Follow this guide to add a description to a chart.
---

# Adding a description to a chart

To add a description to a chart:

1. Open the chart you want to add a description to.
1. Click ![image](../../../_assets/console-icons/circle-info.svg) at the top of the screen.
1. Enter the description and click **Save**.

   {% cut "Adding a description to a chart" %}

   {% list tabs group=charts %}

   - Wizard {#wizard}
  
     ![add-description](../../../_assets/datalens/chart/chart-add-description.png)
 
   - QL chart {#ql}
  
     ![add-description](../../../_assets/datalens/chart/ql-chart-add-description.png)

   
   - Editor {#editor}
  
     ![add-description](../../../_assets/datalens/chart/editor-chart-add-description.png)


   {% endlist %}

   {% endcut %}

1. In the top-right corner, click **Save**.

As a result, all users will see the ![image](../../../_assets/console-icons/circle-info.svg) icon in the top-right corner of the chart. Clicking it will open the **Chart info** window with the description.

{% cut "Viewing a chart description" %}

{% list tabs group=charts %}

- Wizard {#wizard}

  ![description](../../../_assets/datalens/chart/chart-description.png)

- QL chart {#ql}

  ![description](../../../_assets/datalens/chart/ql-chart-description.png)


- Editor {#editor}

  ![description](../../../_assets/datalens/chart/editor-chart-description.png)


{% endlist %}

{% endcut %}

To remove a chart description, save an empty description in the **Chart info** window. Users will no longer see the ![image](../../../_assets/console-icons/circle-info.svg) icon.
