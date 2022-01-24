# Adding selectors to dashboards

To add a selector to a dashboard:

1. Open the dashboard. If you don't have a dashboard, [create one](create.md).
1. At the top of the page, click **Edit**.
1. Click **Add** and choose **Selector**.
1. Fill in the widget parameters. Pay close attention to the following fields:

   1. **Title**. Sets the name of the widget. By default, it's not displayed on the dashboard. To display it, enable **Show**. The title will then be displayed to the left of the selector.
   1. **Selector type**. There are two types of selectors:

      * **Based on datasets**. Selector values are displayed from a dataset field.
      * **Manual input**. Values are set manually in the selector settings.

        [SQL charts](../../concepts/chart/index.md#sql-charts) support both selector types.

1. Fill in the selector parameters:

   {% list tabs %}

   - Based on dataset
     * **Dataset**. Defines a dataset with data for the selector.
     * **Field**. Defines a dataset field with selector values.
     * **Element type**. Defines the selector type: drop-down list, input field, or calendar.
     * **Multiple choice**. Determines whether multiple values can be selected.
     * **Default value**. Displayed once you open the dashboard.

   - Manual input
     * **Element type**. Defines the selector type: drop-down list, input field, or calendar.
     * **Field name**. Name of the field to link to other widgets.
     * **Possible values**. List of selector values.
     * **Multiple choice**. Determines whether multiple values can be selected.
     * **Description**. Sets the description of the widget. It's displayed at the bottom of the widget.
     * **Default value**. Displayed once you open the dashboard.

   {% endlist %}

   In [SQL charts](../../concepts/chart/index.md#sql-charts), you can control selector settings from the **Parameters** tab in the chart editing area and use the **Query** tab to specify a variable in the query itself in `not_var{{variable}}` format.

1. Click **Add**. The widget is displayed on the dashboard.
