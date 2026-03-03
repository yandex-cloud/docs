# Adding an SLO widget to a dashboard

## SLO list {#list}

This widget displays a list of SLOs with current SLI values and the remaining error budget. Clicking an SLO name opens the respective view page.

{% note info %}

Changing the dashboard time range does not affect the SLO widget. It always shows the current values.

{% endnote %}
 
## Widget settings {#settings}

* **Title**: Widget title.
* **Project**: {{ monium-name }} project to search in.
* **Selector**: Selector for SLO search in the project.
* **Sort by**: Selects the field and order for sorting the SLO list. By default, SLOs are sorted by remaining error budget in ascending order.

Available labels for SLO search and filtering:

* `id`: SLO ID
* `name`: SLO name
* `labels.LABEL_NAME`: SLO labels
* `status`: SLO calculation status
* `window`: SLO calculation window

Thanks to the selector, it is enough to configure the widget just once. Any new SLOs added to the project will appear on the widget if they meet the selector and filter criteria.

