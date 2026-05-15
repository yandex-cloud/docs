{% list tabs group=instructions %}

- {{ monium-name }} UI {#console}

  1. On the [{{ monium-name }}]({{ link-monium }}) home page, select the relevant data type section on the left:
     * **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}**.
     * **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.logs.title }}**.   
     * **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.traces.title }}**.

  1. At the top, set the data search period on the timeline.
  
  1. In the search bar, enter a query to search for telemetry data:
       
      {% include [application-labels](application-labels.md) %}
  
  1. Click **{{ ui-key.yacloud_monitoring.querystring.action.execute-query }}** or **{{ ui-key.yacloud_monitoring.querystring.button.apply-and-parse }}**.

     The page will show data that matches the query.

     {% cut "Example of a page with metrics" %}
       
     ![image](../../_assets/monium/petclinic-metrics.png)
       
     {% endcut %}

     More on [metrics](../../monium/metrics/metric-explorer.md).

     {% cut "Example of a page with logs" %}
       
     ![image](../../_assets/monium/petclinic-logs.png)
       
     {% endcut %}

     More on [logs](../../monium/logs/logs-explorer.md).

     {% cut "Example of a page with traces" %}
       
     ![image](../../_assets/monium/petclinic-traces.png)
       
     {% endcut %}

     More on [traces](../../monium/traces/operations/traces-explorer.md).

  1. To view information about the data shard, select **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.shards.title }}** on the left and then select the shard with your service name.

{% endlist %}