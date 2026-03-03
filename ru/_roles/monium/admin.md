Роль `monium.admin` позволяет управлять ресурсами платформы Monium, просматривать и записывать все виды телеметрии, а также управлять проектами и доступом к ним.

Пользователи с этой ролью могут:
* просматривать информацию о [проектах](../../monium/concepts/glossary.md#project), а также создавать, настраивать и удалять их;
* просматривать информацию о назначенных [правах доступа](../../iam/concepts/access-control/index.md) к проектам и изменять такие права доступа;
* читать и записывать все виды телеметрии платформы Monium: [метрики](../../monium/metrics/quickstart.md), [логи](../../monium/logs/quickstart.md) и [распределенные трассировки](../../monium/traces/index.md);
* просматривать [дашборды](../../monium/concepts/visualization/dashboard.md) и их [виджеты](../../monium/concepts/visualization/widget.md), а также создавать, изменять и удалять дашборды;
* просматривать настроенные контекстные ссылки на [графиках](../../monium/concepts/visualization/widget.md#chart) дашбордов, а также создавать, изменять и удалять контекстные ссылки;
* просматривать список настроенных [быстрых ссылок](../../monium/concepts/glossary.md#project-menu) и информацию о них в меню [проекта](../../monium/concepts/glossary.md#project), а также создавать, изменять и удалять быстрые ссылки;
* просматривать информацию о [шардах](../../monium/concepts/glossary.md#shard), [кластерах](../../monium/concepts/glossary.md#cluster), [сервисах](../../monium/concepts/glossary.md#service) и их квотах, а также создавать, изменять и удалять шарды;
* просматривать список [алертов](../../monium/concepts/alerting/alert.md), их настройки и историю срабатываний, а также создавать, изменять и удалять алерты;
* просматривать настроенные [SLO](../../monium/slo/index.md) (Service Level Objectives), а также создавать, изменять и удалять SLO;
* просматривать список и информацию о [каналах уведомлений](../../monium/concepts/alerting/notification-channel.md) для алертов, а также создавать, изменять и удалять каналы уведомлений;
* просматривать список и настройки [политик эскалации](../../monium/concepts/alerting/escalations.md#intro) для алертов, а также создавать, изменять и удалять политики эскалации;
* просматривать информацию об уведомлениях и [эскалациях](../../monium/concepts/alerting/escalations.md) для алертов, а также создавать, изменять и удалять эскалации;
* просматривать, а также создавать, изменять и удалять [мьюты](../../monium/alerts/mutes.md) — правила временного отключения [уведомлений](../../monium/concepts/alerting/notification-channel.md) для алертов;
* просматривать, а также добавлять новые, редактировать и удалять существующие [лейблы](../../monium/traces/operations/traces-explorer.md) к ошибкам в логах;
* просматривать информацию о [правилах](../../monium/operations/prometheus/recording-rules.md) Yandex Managed Service for Prometheus®, а также создавать, изменять и удалять такие правила;
* просматривать информацию о [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `monium.editor`.
