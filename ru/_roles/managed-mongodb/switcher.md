Роль `managed-mongodb.switcher` позволяет переназначать хост-мастер в кластерах Yandex StoreDoc, просматривать информацию о кластерах, хостах, шардах, базах данных и пользователях Yandex StoreDoc, логи работы кластеров, а также данные о квотах и операциях с ресурсами сервиса.

Пользователи с этой ролью могут:
* переназначать хост-мастер в [кластерах Yandex StoreDoc](../../storedoc/concepts/index.md);
* просматривать информацию о кластерах Yandex StoreDoc и назначенных [правах доступа](../../iam/concepts/access-control/index.md) к ним;
* просматривать информацию о заданиях на [техническое обслуживание](../../storedoc/concepts/maintenance.md) кластеров Yandex StoreDoc;
* просматривать информацию о [хостах](../../storedoc/concepts/instance-types.md) кластеров Yandex StoreDoc;
* просматривать информацию о [шардах](../../storedoc/concepts/sharding.md) кластеров Yandex StoreDoc;
* просматривать информацию о базах данных Yandex StoreDoc;
* просматривать информацию о [пользователях](../../storedoc/concepts/users-and-roles.md) Yandex StoreDoc;
* просматривать информацию о [резервных копиях](../../storedoc/concepts/backup.md) кластеров Yandex StoreDoc;
* просматривать информацию об алертах Yandex StoreDoc;
* просматривать [логи](../../storedoc/operations/cluster-logs.md) работы кластеров Yandex StoreDoc;
* просматривать информацию о результатах диагностики производительности кластеров Yandex StoreDoc;
* просматривать информацию о [квотах](../../storedoc/concepts/limits.md#mmg-quotas) сервиса Yandex StoreDoc;
* просматривать информацию об операциях с ресурсами сервиса Yandex StoreDoc.

Включает разрешения, предоставляемые ролью `managed-mongodb.viewer`.