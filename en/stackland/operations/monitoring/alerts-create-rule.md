# Creating an alert rule

To create a new alert rule:

* Open Grafana using the `https://grafana.sys.{{ cluster-domain }}` link and log in with your username and password.
* Open the **Alert rules** tab.
* Create a new alert rule by clicking **New alert rule**.
* Under **Enter alert rule name**, give it a name.
* Under **Define query and alert condition**, specify the query that will be used to define the issue. Use [PromQL](https://prometheus.io/docs/prometheus/latest/querying/basics/) for queries.
* Under **Set evaluation behavior**, specify how often the query will be checked and how long the issue will be monitored.
* Under **Configure labels and notifications**, specify the channels through which issue notifications will be sent.
* Under **Configure notification message**, specify the message template that will be used when sending a notification. For template syntax examples, see [this Prometheus guide](https://prometheus.io/docs/alerting/latest/notifications/).
* Click **Save rule and exit** to save the alert rule.

The new alert will appear on the **Alert rules** page.
