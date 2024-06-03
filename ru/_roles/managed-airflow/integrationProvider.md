Роль `managed-airflow.integrationProvider` позволяет кластеру Apache Airflow™ взаимодействовать от имени сервисного аккаунта с пользовательскими ресурсами, необходимыми для работы кластера. Роль назначается сервисному аккаунту, привязанному к кластеру Apache Airflow™.

{% cut "Сервисные аккаунты с этой ролью могут:" %}

* добавлять записи в [лог-группы](../../logging/concepts/log-group.md);
* просматривать информацию о лог-группах;
* просматривать информацию о приемниках логов;
* просматривать информацию о назначенных [правах доступа](../../iam/concepts/access-control/index.md) к ресурсам сервиса Cloud Logging;
* просматривать информацию о выгрузках логов;
* просматривать информацию о [метриках](../../monitoring/concepts/data-model.md#metric) Monitoring и их [метках](../../monitoring/concepts/data-model.md#label), а также загружать и выгружать метрики;
* просматривать список [дашбордов](../../monitoring/concepts/visualization/dashboard.md) и [виджетов](../../monitoring/concepts/visualization/widget.md) Monitoring и информацию о них, а также создавать, изменять и удалять дашборды и виджеты;
* просматривать историю [уведомлений](../../monitoring/concepts/alerting/notification-channel.md) Monitoring;
* просматривать список [бакетов](../../storage/concepts/bucket.md) и информацию о них, в том числе о регионе размещения, [версионировании](../../storage/concepts/versioning.md), [шифровании](../../storage/concepts/encryption.md), конфигурации [CORS](../../storage/concepts/cors.md), конфигурации [хостинга статических сайтов](../../storage/concepts/hosting.md), конфигурации [HTTPS](../../storage/concepts/bucket.md#bucket-https), настройках [логирования](../../storage/concepts/server-logs.md), назначенных правах доступа, [публичном доступе](../../storage/concepts/bucket.md#bucket-access) и [классе хранилища](../../storage/concepts/storage-class.md#default-storage-class) по умолчанию;
* просматривать списки [объектов](../../storage/concepts/object.md) в бакетах и информацию об объектах, в том числе о конфигурации [жизненных циклов](../../storage/concepts/lifecycles.md) объектов, назначенных правах доступа к объектам, текущих [составных загрузках](../../storage/concepts/multipart.md), версиях объектов c их [метаданными](../../storage/concepts/object.md#metadata), временных и бессрочных [блокировках версий объектов](../../storage/concepts/object-lock.md);
* просматривать [метки](../../storage/concepts/tags.md) бакетов, объектов и версий объектов, а также статистику сервиса Object Storage;
* просматривать информацию о [секретах Yandex Lockbox](../../lockbox/concepts/secret.md#secret) и назначенных правах доступа к ним;
* просматривать информацию о квотах сервисов [Object Storage](../../storage/concepts/limits.md#storage-quotas), [Monitoring](../../monitoring/concepts/limits.md#monitoring-quotas) и [Yandex Lockbox](../../lockbox/concepts/limits.md#quotas);
* просматривать информацию об [облаке](../../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).

{% endcut %}

Включает разрешения, предоставляемые ролями `logging.writer`, `monitoring.editor`, `storage.viewer` и `lockbox.viewer`.

Роль не разрешает доступ к содержимому секретов Yandex Lockbox. Для того чтобы кластер Apache Airflow™ имел доступ к содержимому секретов в Yandex Lockbox, выдайте [сервисному аккаунту](../../iam/concepts/users/service-accounts.md) дополнительную [роль](../../lockbox/security/index.md#lockbox-payloadViewer) `lockbox.payloadViewer` на каталог или на определенные секреты.