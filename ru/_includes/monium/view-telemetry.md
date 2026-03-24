{% list tabs group=instructions %}

- Интерфейс {{ monium-name }} {#console}

  1. На главной странице [{{ monium-name }}]({{ link-monium }}) слева выберите **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.shards.title }}**.
  1. В списке выберите шард с названием вашего сервиса.

     Имя шарда формируется как `<имя_проекта>_<имя_кластера>_<имя_сервиса>`, например `folder__{{ folder-id-example }}_default_spring-petclinic`.
  
  1. Чтобы посмотреть отдельный тип данных, слева выберите:

     * **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}**.
       
       В строке запроса последовательно выберите `project`, `cluster`, `service` и нажмите **{{ ui-key.yacloud_monitoring.querystring.action.execute-query }}**.

       {% cut "Пример графика с метриками" %}
       
       ![image](../../_assets/monium/petclinic-metrics.png)
       
       {% endcut %}

       Подробнее о [работе с метриками](../../monium/operations/metric/metric-explorer.md).

     * **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.logs.title }}**.
     
       В строке запроса последовательно выберите `project`, `cluster`, `service` и нажмите **{{ ui-key.yacloud_monitoring.querystring.action.execute-query }}**.

       {% cut "Пример страницы с логами" %}
       
       ![image](../../_assets/monium/petclinic-logs.png)
       
       {% endcut %}

       Подробнее о [работе с логами](../../monium/logs/quickstart.md).
     
     * **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.traces.title }}**.

       В строке запроса последовательно выберите `project` и `service` и нажмите **Выполнить**.

       {% cut "Пример страницы с трейсами" %}
       
       ![image](../../_assets/monium/petclinic-traces.png)
       
       {% endcut %}

       Подробнее о [работе с трейсами](../../monium/traces/operations/traces-explorer.md).

{% endlist %}