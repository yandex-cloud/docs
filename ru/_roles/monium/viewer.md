Роль `monium.viewer` позволяет просматривать информацию о ресурсах платформы Monium с возможностью чтения всех видов телеметрии.

Пользователи с этой ролью могут:

* просматривать информацию о [проектах](../../monium/concepts/glossary.md#project) и назначенных [правах доступа](../../iam/concepts/access-control/index.md) к ним;
* читать все виды телеметрии платформы Monium: [метрики](../../monium/metrics/quickstart.md), [логи](../../monium/logs/quickstart.md) и [распределенные трассировки](../../monium/traces/index.md);
* просматривать [дашборды](../../monium/concepts/visualization/dashboard.md) и их [виджеты](../../monium/concepts/visualization/widget.md);
* просматривать настроенные контекстные ссылки на [графиках](../../monium/concepts/visualization/widget.md#chart) дашбордов;
* просматривать список настроенных [быстрых ссылок](../../monium/concepts/glossary.md#project-menu) и информацию о них в меню проектов;
* просматривать информацию о [шардах](../../monium/concepts/glossary.md#shard), [кластерах](../../monium/concepts/glossary.md#cluster), [сервисах](../../monium/concepts/glossary.md#service) и их квотах;
* просматривать список [алертов](../../monium/concepts/alerting/alert.md), а также их настройки и историю срабатываний;
* просматривать настроенные [SLO](../../monium/slo/index.md) (Service Level Objectives);
* просматривать список и информацию о [каналах уведомлений](../../monium/concepts/alerting/notification-channel.md) для алертов;
* просматривать список и настройки [политик эскалации](../../monium/concepts/alerting/escalations.md#intro) для алертов;
* просматривать информацию об уведомлениях и [эскалациях](../../monium/concepts/alerting/escalations.md) для алертов;
* просматривать [мьюты](../../monium/alerts/mutes.md) — правила временного отключения [уведомлений](../../monium/concepts/alerting/notification-channel.md) для алертов;
* просматривать [лейблы](../../monium/traces/operations/traces-explorer.md), привязанные к ошибкам в логах;
* просматривать информацию о [правилах](../../monium/operations/prometheus/recording-rules.md) Yandex Managed Service for Prometheus®;
* просматривать информацию о [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролями `monium.auditor` и `monium.telemetry.reader`.
