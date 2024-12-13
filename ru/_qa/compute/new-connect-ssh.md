Если вы устанавливали пароль для пользователя, [настройте](../../compute/operations/serial-console/index.md) серийную консоль ВМ и подключитесь к ней. Мы рекомендуем [подключаться с помощью CLI](../../compute/operations/serial-console/connect-cli.md).

Если пароля для пользователя нет, [сделайте](../../compute/operations/disk-control/create-snapshot.md) снимок диска ВМ и [создайте](../../compute/operations/vm-create/create-from-snapshots.md) новую ВМ из снимка.

Если проблему решить не удалось:

1. [Создайте](../../compute/operations/disk-create/from-snapshot.md) новый диск из снимка ВМ.
1. [Подключите](../../compute/operations/vm-control/vm-attach-disk.md) его в качестве дополнительного диска к другой ВМ.
1. Измените корневой каталог с помощью операции `сhroot`.
1. Измените файлы конфигураций, влияющие на недоступность ВМ.
1. [Отключите](../../compute/operations/vm-control/vm-detach-disk.md) диск от ВМ.
1. [Создайте](../../compute/operations/vm-create/create-from-snapshots.md) новую ВМ. В блоке **Выбор образа/загрузочного диска** перейдите на вкладку **Пользовательские** и выберите ваш диск в качестве загрузочного.
1. После восстановления доступа к ВМ не забудьте удалить неиспользуемые ресурсы: [виртуальные машины](../../compute/operations/vm-control/vm-delete.md), [диски](../../compute/operations/disk-control/delete.md) и [снимки дисков](../../compute/operations/snapshot-control/delete.md). Если их не удалить, они продолжат тарифицироваться, а {{ yandex-cloud }} продолжит брать за них плату.