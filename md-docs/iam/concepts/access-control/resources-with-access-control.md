# Ресурсы, на которые можно назначать роли


Для управления правами доступа в Yandex Cloud используются [роли](roles.md).

Пользователь Yandex Cloud может выполнять только те операции над ресурсами, которые разрешены назначенными ему [ролями](roles.md). Пока у пользователя нет никаких ролей, почти все операции ему запрещены.

## Наследование прав доступа {#permission-inheritance}

Роли [назначаются](../../operations/roles/grant.md) на [ресурсы](../../../resource-manager/concepts/resources-hierarchy.md) Yandex Cloud. Для ресурсов большинства [сервисов](../../../overview/concepts/services.md) Yandex Cloud действует стандартный механизм [наследования](../../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) прав доступа:

* Права на организацию распространяются на ресурсы [организации](../../../organization/concepts/organization.md):
  * [Федерации](../federations.md).
  * [Группы пользователей](../../../organization/concepts/groups.md).
  * [Облака](../../../resource-manager/concepts/resources-hierarchy.md#cloud) организации.
* Права на облако распространяются на все [каталоги](../../../resource-manager/concepts/resources-hierarchy.md#folder) внутри облака.
* Права на каталог распространяются на все ресурсы каталога.

### Исключения из правил наследования прав доступа {#inheritance-exceptions}

Несколько сервисов Yandex Cloud не подчиняются стандартному механизму наследования ролей. Для этих сервисов роли должны быть назначены пользователям отдельно:

* [Yandex Cloud Billing](../../../billing/security/index.md);
* [Яндекс Трекер](https://yandex.ru/support/tracker/ru/access);
* [Yandex DataLens](../../../datalens/security/index.md);
* [Яндекс Вики](https://yandex.ru/support/wiki/ru/page-management/access-setup);
* [Яндекс Формы](https://yandex.ru/support/forms/ru/access);
* [Yandex DataSphere](../../../datasphere/security/index.md);
* [Yandex SpeechSense](../../../speechsense/security/index.md).

## Гранулярное назначение ролей {#granular-assignment}

Некоторые сервисы Yandex Cloud позволяют назначать роли более гранулярно — на отдельные ресурсы сервиса. Например, в [Yandex Compute Cloud](../../../compute/index.md) роли можно назначать на такие ресурсы:

# Ресурсы в Compute Cloud, на которые можно назначать роли

* [Виртуальная машина](../../../compute/operations/vm-control/vm-access.md)
* [Группа виртуальных машин](../../../compute/operations/instance-groups/access.md)
* [Группа выделенных хостов](../../../compute/operations/dedicated-host/access.md)
* [Группа размещения виртуальных машин](../../../compute/operations/placement-groups/access.md)
* [Группа размещения нереплицируемых дисков](../../../compute/operations/disk-placement-groups/access.md)
* [Диск виртуальной машины](../../../compute/operations/disk-control/disk-access.md)
* [Кластер GPU](../../../compute/operations/gpu-cluster/access.md)
* [Образ](../../../compute/operations/image-control/access.md)
* [Расписание снимков](../../../compute/operations/snapshot-control/snapshot-schedule-access.md)
* [Снимок диска](../../../compute/operations/snapshot-control/snapshot-access.md)
* [Файловое хранилище](../../../compute/operations/filesystem/filesystem-access.md)

При этом в некоторых случаях гранулярное назначение ролей на ресурсы может быть недоступно для некоторых [интерфейсов](../../../overview/concepts/interfaces.md). Например, роль на [группу виртуальных машин](../../../compute/concepts/instance-groups/index.md) в Compute Cloud можно назначить с помощью [консоли управления](https://console.yandex.cloud), [Yandex Cloud CLI](../../../cli/index.md) и [API](../../../api-design-guide/index.md), но нельзя с помощью [Terraform](../../../terraform/index.md).

Подробную информацию о ресурсах, на которые можно назначить роли, доступных ролях и особенностях их назначения смотрите на странице **Управление доступом** в документации нужного сервиса. Например: [Управление доступом в Compute Cloud](../../../compute/security/index.md).