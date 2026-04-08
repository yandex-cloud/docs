# Creating a dashboard

To create a new dashboard and add metrics to it:

* Open Grafana using the `https://grafana.sys.{{ cluster-domain }}` link and log in with your username and password.
* Open the **Dashboards** tab.
* Create a new dashboard: click **New** and select **New dashboard** in the menu that opens.
* In the window that opens, click **Add visualization**.
* Select a data source: Prometheus metrics or Loki logs.
* In the **Metric** field, specify a metric, labels, or values. To check query visualization, click **Run queries** and make sure the dashboard displays the correct data.
* Click **Save dashboard**.

You can also create dashboards using a custom resource. For more information, see [this grafana-operator guide](https://grafana.github.io/grafana-operator/docs/dashboards/).
