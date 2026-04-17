{% list tabs group=instructions %}

- Интерфейс {{ monium-name }} {#console}

  1. На главной странице [{{ monium-name }}]({{ link-monium }}) слева выберите раздел с нужным типом данных:
     * **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}**.
     * **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.logs.title }}**.   
     * **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.traces.title }}**.

  1. Вверху на шкале времени задайте промежуток поиска данных.
  
  1. В строке поиска введите запрос для поиска данных телеметрии:
       
      {% include [application-labels](application-labels.md) %}
  
  1. Нажмите **{{ ui-key.yacloud_monitoring.querystring.action.execute-query }}** или **{{ ui-key.yacloud_monitoring.querystring.button.apply-and-parse }}**.
  
     На странице будут показаны данные, соответствующие запросу.

     {% cut "Пример страницы с метриками" %}
       
     ![image](../../_assets/monium/petclinic-metrics.png)
       
     {% endcut %}

     Подробнее о [работе с метриками](../../monium/operations/metric/metric-explorer.md).

     {% cut "Пример страницы с логами" %}
       
     ![image](../../_assets/monium/petclinic-logs.png)
       
     {% endcut %}

     Подробнее о [работе с логами](../../monium/logs/logs-explorer.md).

     {% cut "Пример страницы с трейсами" %}
       
     ![image](../../_assets/monium/petclinic-traces.png)
       
     {% endcut %}

     Подробнее о [работе с трейсами](../../monium/traces/operations/traces-explorer.md).

  1. Чтобы посмотреть информацию о шарде с данными, слева выберите **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.shards.title }}** и затем шард с названием вашего сервиса.

{% endlist %}