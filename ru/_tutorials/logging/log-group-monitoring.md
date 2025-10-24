# Мониторинг записи событий в лог-группу

Отслеживание определенных метрик лог-группы поможет заранее узнать о возможных проблемах и избежать потери данных.

Для каждой лог-группы есть предустановленные графики мониторинга, которые позволяют изучить следующую информацию:

* **Records** — группа графиков по обработке записей:
  * **Records successfully ingested** — количество успешно полученных записей.
  * **Records saved** — количество сохраненных записей.
  * **Records read** — количество прочитанных записей.
  * **Records ingest errors** — количество ошибок при получении записей.
  * **Records save lag** — задержка между получением и сохранением записей.
  * **Records read errors** — количество ошибок при чтении записей.

* **Requests** — группа графиков о запросах на загрузку данных:
  * **Ingest requests** — количество запросов на загрузку данных.
  * **Ingest requests errors** — количество ошибок при выполнении запросов на загрузку данных.
  * **Ingest requests duration** — среднее время выполнения запросов на загрузку данных.

Чтобы отслеживать метрики работы с лог-группой вместе с другими показателями, например с метриками событий [{{ at-name }}](../../audit-trails/tutorials/alerts-monitoring.md), соберите метрики на одном дашборде {{ monitoring-name }}.

Добавьте на дашборд график по [метрике](../../monitoring/metrics-ref/logging-ref.md) `group.service.ingested_records_per_second` — она отображает реальную скорость записи логов в лог-группу. Сравнение этой величины с установленной [квотой](../../logging/concepts/limits.md#logging-quotas) `Максимальная скорость записи` помогает определить, не достигает ли поток логов максимально разрешенной скорости. Дополнительный график по метрике `group.service.ingest_requests_per_second` со статусом `ERROR` позволит вовремя обнаружить ошибки при записи.

{% list tabs group=instructions %}

- Интерфейс {{ monitoring-short-name }} {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
  1. Перейдите на вкладку **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.dashboards.title }}**.
  1. Напротив названия нужного дашборда нажмите ![image](../../_assets/console-icons/ellipsis.svg) → **{{ ui-key.yacloud_monitoring.actions.common.edit }}**.
  1. В нижнем блоке нажмите **{{ ui-key.yacloud_monitoring.dashboard.widget-placeholder.add-graph }}**.
  1. Создайте запрос для отслеживания занятого места:

      1. В редакторе запроса нажмите ![image](../../_assets/console-icons/plus.svg).
      1. В списке сервисов **service=** выберите `{{ ui-key.yacloud_monitoring.services.label_logging }}`.
      1. В списке метрик **name=** выберите `group.service.ingested_records_per_second`.
      1. В списке меток выберите нужную лог-группу (**group=**).

  1. Нажмите **{{ ui-key.yacloud_monitoring.querystring.action.add-query }}** и аналогичным способом создайте запрос для отображения максимального размера бакета — в списке метрик **name=** выберите `group.ingest_requests_per_second` и **status=** — `ERROR`.
  1. Нажмите **{{ ui-key.yacloud_monitoring.querystring.action.execute-query }}**, чтобы проверить отображение графиков.

  1. Назовите график и добавьте порог:

      1. В области с графиком нажмите ![image](../../_assets/console-icons/gear.svg) **{{ ui-key.yacloud_monitoring.wizard.settings }}**.
      1. На открывшейся панели раскройте блок **{{ ui-key.yacloud_monitoring.wizard.tab.general }}**.
      1. В поле **{{ ui-key.yacloud_monitoring.wizard.general.name }}** укажите название графика, например `Bucket Used Space`.
      1. Раскройте блок **{{ ui-key.yacloud_monitoring.wizard.tab.thresholds }}**.
      1. Нажмите **{{ ui-key.yacloud_monitoring.wizard.thresholds.add }}**.
      1. Укажите имя порога `Квота — максимальная скорость записи` и выберите цвет.
      1. Закройте панель настроек графика.

  1. Справа вверху нажмите **{{ ui-key.yacloud_monitoring.actions.common.save }}**.

{% endlist %}