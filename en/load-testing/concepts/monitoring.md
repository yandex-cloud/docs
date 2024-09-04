# Test agent monitoring

This monitoring enables you to collect data (metrics) related to the test agent status and show them on charts. You can collect metrics using the [Telegraf](https://github.com/influxdata/telegraf) agent or YCMonitoring plugin. The monitoring charts are shown on the **{{ ui-key.yacloud.load-testing.label_monitoring-report }}** tab for the selected test.

You can enable test agent monitoring in the settings when you [create a test](../operations/create-test-bucket.md#create-test):

{% list tabs %}

- Form

   If you are setting up test parameters using a form in the interface, enable the **Agent monitoring** option. This enables a standard configuration of the agent monitoring that includes the following metrics:

   * [cpu](https://github.com/influxdata/telegraf/tree/master/plugins/inputs/cpu)
   * [diskio](https://github.com/influxdata/telegraf/tree/master/plugins/inputs/diskio)
   * [mem](https://github.com/influxdata/telegraf/tree/master/plugins/inputs/mem)
   * [net](https://github.com/influxdata/telegraf/tree/master/plugins/inputs/net)
   * [nstat](https://github.com/influxdata/telegraf/tree/master/plugins/inputs/nstat)
   * [system](https://github.com/influxdata/telegraf/tree/master/plugins/inputs/system)

   You can also configure the YCMonitoring plugin to collect metrics from the {{ monitoring-full-name }} API and display metric charts in the **{{ ui-key.yacloud.load-testing.label_monitoring-report }}** section of the load test.

   {% note warning %}

   To use the plugin, the service account needs the `monitoring.viewer role` in the relevant folder.
   Before using the plugin, make sure the test agent is running the latest version. Update the agent, if required.

   {% endnote %}

   {% note info %}

   {{ monitoring-full-name }} metrics for different cloud services are collected at intervals ranging from 15 to 60 seconds, so the results for short-running tests may be undescriptive. We recommend using a plugin for long-running tests (10 minutes or more).

   {% endnote %}

   To set up the YCMonitoring plugin:

   1. Under **{{ ui-key.yacloud.load-testing.label_test-settings }}**, click ![image](../../_assets/plus-sign.svg) **Chart** in the **YC Monitoring Metrics** section.
   1. In the **Chart name** field, specify the chart name.
   1. In the **Query** field, enter your query in the [{{ monitoring-name }} query language](../../monitoring/concepts/querying.md).
   1. If you want, you can similarly add other charts.


- Telegraf

   To set up metric collection using the Telegraf plugin, specify the agent's monitoring configuration in the `telegraf` section of the configuration file. You can set up each metric using all the options that are available for it in Telegraf.

   Sample settings of the `telegraf` section in the test configuration file:

   ```yaml
   telegraf:
      enabled: true
      package: yandextank.plugins.Telegraf
      config:
      metrics:
         cpu:
         percpu: true
         totalcpu: false
         fieldpass:
            - time_user
            - time_steal
            - usage_idle
   ```

   In the monitoring agent configuration, you can also describe the metrics that are missing in Telegraf.

   Sample `custom` metric:

   ```yaml
   telegraf:
      enabled: true
      package: yandextank.plugins.Telegraf
      config:
      metrics:
         custom:
            diff: 1
            measure: call
            label: test
            cmd: curl -s 'http://localhost:6100/stat'  | python3 -c 'import sys, json; j = json.load(sys.stdin); print("\n".join(rerp(c["values"]["accept"]) for c in j["charts"] if c["name"] == "localqueue_wait_time"))'
   ```

- YCMonitoring

   To set up metric collection using the YCMonitoring plugin, specify the agent's monitoring configuration in the `ycmonitoring` section of the configuration file. With this plugin, you can collect monitoring metrics from the {{ monitoring-full-name }} API.

   {% note warning %}

   To use the plugin, the service account needs the `monitoring.viewer role` in the relevant folder.
   Before using the plugin, make sure the test agent is running the latest version. Update the agent, if required.

   {% endnote %}

   {% note info %}

   {{ monitoring-full-name }} metrics for different cloud services are collected at intervals ranging from 15 to 60 seconds, so the results for short-running tests may be undescriptive. We recommend using a plugin for long-running tests (10 minutes or more).

   {% endnote %}

   Here is the minimum plugin configuration format:

   ```yaml
   ycmonitoring:
     enabled: true
     package: yandextank.plugins.YCMonitoring
     panels:
       <panel_name_1>:
         group_name: <group_name_1>
         queries:
           - <query1>
           - <query2>
       <panel2name>:
         group_name: <group_name_2>
         queries:
           - <query3>
   ```
   Where:
   * `panels`: Dictionary of panels for collecting monitoring metrics.
   * `panel_name`: Dictionary key and chart name on the dashboard.
   * `group_name`: Panel grouping key. The default value is the address of the API host used to collect metrics.
   * `query`: Query in the [{{ monitoring-name }} query language](../../monitoring/concepts/querying.md).

   Here is an example of the `telegraf` section settings in the test configuration file:

   ```yaml
   ycmonitoring:
     enabled: true
     package: yandextank.plugins.YCMonitoring
     panels:
       target_connections:
         queries:
           - '"network_connections.quota_utilization"{folderId="b1g7j67rou********ne", service="compute", resource_id="agent007"}'
       target_cpu:
         queries:
           - '"cpu_usage"{folderId="b1g7j67rou********ne", service="compute", resource_id="agent007"}'
       received_packets:
         queries:
           - '"network_received_packets"{folderId="b1g7j67rou********ne", service="compute", resource_id="agent007", resource_type="vm", interface_number="*"}'
   ```
   Where:
   * `resource_id`: Test agent name.
   * `folderId`: ID of the folder containing the test agent.

   This plugin also allows you to configure additional parameters:

   ```yaml
   panels:
     panel_name:
       ...
   api_host: monitoring.api.cloud.yandex.net:443
   token: LOADTESTING_YC_TOKEN
   timeout: 5s
   request_timeout: 10s
   poll_interval: 60s
   ignore_labels: ['service', 'resource_type', 'device', 'interface_number', 'source_metric', 'subcluster_name', 'shard', 'dc']
   priority_labels: ['cpu_name', 'label']
   ```

   Where:
   * `api_host`: Address of the {{ monitoring-name }} API used to collect data. The default value is `monitoring.api.cloud.yandex.net:443`.
   * `token`: [IAM token](../../iam/concepts/authorization/iam-token.md) file path. The default value is taken from the `LOADTESTING_YC_TOKEN` environment variable.
   * `timeout`: Timeout for the plugin to shut down once the load test is over. The default value is 5 seconds.
   * `request_timeout`: {{ monitoring-name }} API request timeout. The default value is 10 seconds.
   * `poll_interval`: Interval between {{ monitoring-name }} API requests. The default value is 60 seconds.
   * `priority_labels`: List of labels to use in naming the monitoring metric.
   * `ignore_labels`: List of labels to ignore in naming the monitoring metric.

   The last two parameters are used to generate names for metrics on the charts. Each metric name is based on the dictionary keys of the relevant request and items in the `ignore_labels` and `priority_labels` lists. Non-alphanumeric characters in names are replaced with hyphens.

{% endlist %}
