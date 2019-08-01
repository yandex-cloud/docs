# Creating charts using a text query

To create a chart using a text query, follow these steps:

1. On the {{ monitoring-full-name }} service homepage, click **Create chart**.

1. Under **Queries**, click the ![image](../../_assets/ellipsis.svg) icon and select **Edit as text**.

1. Specify the mandatory labels with the necessary values, separated by a comma:

    ```
    project="your_project_name", cluster="your_cluster_name", service="service_name"
    ```

1. Enter optional labels to view the metrics on a chart.

    {% note important %}

    You can add up to 50 metrics per chart.

    {% endnote %}

1. Click ![image](../../_assets/checkmark.png). The metric appears on the chart.

1. Click **Finish**. Enter a name for the chart and select the directory to save it to.

1. Click **Save**. The chart is saved in the specified directory.

## Sample request {#query-example}

Query for the `disk_read_bytes` metric of the {{ compute-full-name }} VM:

```
project="project_id", cluster="cluster_id", service="compute", resource_type="vm", resource_id="resource_id", name="disk_read_bytes"
```

