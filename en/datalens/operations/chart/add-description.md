---
title: How to add chart info in {{ datalens-full-name }}
description: Follow this guide to add chart info in {{ datalens-full-name }}.
---

# Adding chart info in {{ datalens-full-name }}

To add chart info, do the following:

1. Open the chart to add info for.
1. Click ![image](../../../_assets/console-icons/circle-info.svg) at the top of the screen.
1. Enter the information and click **Save**.

   {% cut "Adding chart info" %}

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

As a result, all users will see the ![image](../../../_assets/console-icons/circle-info.svg) icon in the top-right corner of the chart. Clicking it will open the **Chart info** window with the information.

{% cut "Viewing chart info" %}

{% list tabs group=charts %}

- Wizard {#wizard}

  ![description](../../../_assets/datalens/chart/chart-description.png)

- QL chart {#ql}

  ![description](../../../_assets/datalens/chart/ql-chart-description.png)


- Editor {#editor}

  ![description](../../../_assets/datalens/chart/editor-chart-description.png)


{% endlist %}

{% endcut %}

To remove chart info, save an empty field in the **Chart info** window. Users will no longer see the ![image](../../../_assets/console-icons/circle-info.svg) icon.
