# Test agent monitoring

This monitoring enables you to collect data (metrics) related to the test agent status and show them on charts. The metrics are collected using [Telegraf](https://github.com/influxdata/telegraf). The monitoring charts are shown on the **Monitoring** tab for the selected test.

You can enable agent monitoring in the settings when you [create a test](../operations/create-test-bucket.md#create-test).

{% list tabs %}

- Form

   If you are setting up test parameters using a form in the interface, enable the `Agent monitoring` option. This enables a standard configuration of the agent monitoring that includes the following metrics:

   * [cpu](https://github.com/influxdata/telegraf/tree/master/plugins/inputs/cpu)
   * [diskio](https://github.com/influxdata/telegraf/tree/master/plugins/inputs/diskio)
   * [mem](https://github.com/influxdata/telegraf/tree/master/plugins/inputs/mem)
   * [net](https://github.com/influxdata/telegraf/tree/master/plugins/inputs/net)
   * [nstat](https://github.com/influxdata/telegraf/tree/master/plugins/inputs/nstat)
   * [system](https://github.com/influxdata/telegraf/tree/master/plugins/inputs/system)

- Configuration file

   If you use a configuration file to set up the test, describe the agent's monitoring configuration in the `telegraf` section. You can set up each metric using all the options that are available for it in Telegraf.

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

{% endlist %}
