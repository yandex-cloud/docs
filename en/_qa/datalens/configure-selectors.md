### How do I set up selectors to list only the elements pertaining to a specific dataset sample? {#how-to-configure-selectors}

There are several ways to do this:

* As a selector type, select **Manual input** and list the desired values. After creating the selector, set up links between the selector and charts on the dashboard. This method is good if values don't change based on the sample.
* Create a new selector and use the link to filter out values in the desired selector.
* Using a calculated field:
   * Create a calculated field that defines a list of values. Example: `CASE ([country], "BY", "CIS", "KZ", "CIS", "RU", "CIS", "Other countries")`.
   * Output this field as an additional selector and set its default value to `"CIS"`.
      In this case, in the second selector, the default values will be `"BY"`, `"KZ"`, and `"RU"`.
* If no other values are used, create a dataset with the specified values and create a selector based on this dataset. Link the selector to the chart.