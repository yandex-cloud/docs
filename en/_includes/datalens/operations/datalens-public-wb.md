1. In the left-hand panel, select ![collections](../../../_assets/console-icons/rectangles-4.svg) **Collections and workbooks**.
1. Open the workbook of interest and select a dashboard or chart.
1. At the top of the object, click ![image](../../../_assets/console-icons/ellipsis.svg) and select ![image](../../../_assets/console-icons/arrow-shape-turn-up-right.svg) **Share**.
1. In the window that opens, go to the ![image](../../../_assets/console-icons/globe.svg) **Public** tab and set up public access:
        
   {% list tabs group=datalens_public %}

   - For a dashboard {#dashboard}

      1. Enable ![image](../../../_assets/console-icons/plus.svg) **Public access**.        
      1. Optionally, click ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **Contribute to {{ datalens-short-name }} Gallery** and fill out the form for [adding a dashboard](../../../datalens/concepts/gallery.md#suggest) to the Gallery.
      1. Optionally, enable **Dashboard author** and specify the link to the dashboard source or author and its text. The link will be displayed at the bottom of the dashboard.
      1. Optionally, under **Linked objects**, select the objects to make public. By default, {{ datalens-short-name }} will automatically grant access to all linked objects.
      1. Click ![image](../../../_assets/console-icons/link.svg) **Copy link** at the bottom right.

         {% note info %}

         * The public access link grants access to the dashboard and all its linked objects to any internet user. To copy it, click **Copy link**.
         * The link from the browser address bar provides access to the dashboard and all its linked objects only to authenticated users with appropriate permissions.

         {% endnote %}

      {% cut "Publishing a dashboard" %}
   
      ![image](../../../_assets/datalens/concepts/datalens-public/shared-settings-public.png =419x415)

      {% endcut %}

   - For a chart {#chart}

      1. Enable ![image](../../../_assets/console-icons/plus.svg) **Public access**.
      1. Optionally, enable **Chart author** and specify the link to the chart source or author and its text. The link will be displayed at the bottom of the chart.
      1. Optionally, under **Linked objects**, select the objects to make public. By default, {{ datalens-short-name }} will automatically grant access to all linked objects.
      1. Click ![image](../../../_assets/console-icons/link.svg) **Copy link** at the bottom right.

         {% note info %}

         * The public access link grants access to the chart and all its linked objects to any internet user. To copy it, click **Copy link**.
         * The link from the browser address bar provides access to the chart and all its linked objects only to authenticated users with appropriate permissions.

         {% endnote %}

      {% cut "Publishing a chart" %}
   
      ![image](../../../_assets/datalens/concepts/datalens-public/shared-settings-chart-public.png =419x415)

      {% endcut %}

   {% endlist %}
