# Управление балансировщиком нагрузки {{ mdb-lb }}

В {{ mpg-name }} доступен [балансировщик нагрузки {{ mdb-lb }}](../concepts/load-balancer.md), который автоматически распределяет запросы по хостам БД в зависимости от их роли и доступности.

{% include [preview-tp](../../_includes/mdb/preview-support.md) %}

Вы можете:

* [Получить FQDN балансировщика](#fqdn).
* [Включить или отключить балансировщик](#enable-balancer).

## Получить FQDN балансировщика {#fqdn}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите]({{ link-console-main }}/link/managed-postgresql) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Нажмите на имя нужного кластера.
  1. Скопируйте значение в поле **FQDN балансировщика**.

{% endlist %}

## Включить балансировщик {#enable-balancer}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите]({{ link-console-main }}/link/managed-postgresql) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Выберите кластер и нажмите кнопку ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** на панели сверху.
  1. В блоке **DB Proxy** включите опцию **Балансировка DB Proxy** и укажите параметры балансировки по репликам в блоке **Настройки портов**:

      {% include [lb-settings](../../_includes/mdb/mpg/load-balancer-settings.md) %}

  Если балансировщик вам больше не нужен, таким же образом отключите опцию **Балансировка DB Proxy**.

{% endlist %}

