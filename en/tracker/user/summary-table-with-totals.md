# Pivot table with totaled values

![](../../_assets/tracker/widgets/table-with-sum.png)

Special pivot table with two parameters. In contrast to a simple pivot table, the intersections show the sum of the values of a third parameter, instead of the number of issues. You can use this table to track the time spent by users on different queue components.

To configure a widget, set the following:

- **Widget name**: Name to display in the widget header.

- **Issue source**: Filter on the basis of which the list of issues is formed. You can select a [system](default-filters.md) filter or a [previously created](create-filter.md) filter from the list or specify a filter using the [query language](query-filter.md) or parameters.

- **Columns**: Parameter to use for table columns.

- **Rows**: Parameter to use for table rows.

- **Cells**: Parameter whose totals are displayed at intersections.

- **Number of rows on page**: Maximum number of table rows to display in the widget. If there are more rows than the maximum, you can see them by clicking **{{ ui-key.startrek.ui_components_dashboard_TableWidget.show-all }}** at the bottom of the widget.

- **Sort rows**: Sorting order for table rows.

- **Sort columns**: Sorting order for table columns.

- **Show total**: If this option is enabled, the table includes the total of all rows and columns.

