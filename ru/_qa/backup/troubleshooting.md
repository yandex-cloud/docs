# Решение проблем в {{ backup-name }}

В этом разделе описаны типичные проблемы, которые могут возникать при работе {{ backup-name }}, и методы их решения.

#### Почему ВМ не добавляется в {{ backup-name }}? {#cannot-add-vm}

Убедитесь, что:

* Операционная система ВМ [поддерживается {{ backup-name }}](../../backup/concepts/vm-connection.md#os).
* Сервисному аккаунту, привязанному к ВМ, назначена [роль](../../backup/security/index.md#backup-editor) `backup.editor`.
* Для ВМ [корректно](../../backup/concepts/vm-connection.md#vm-network-access) настроена [группа безопасности](../../vpc/concepts/security-groups.md).

Подробнее в статье [Подключение виртуальных машин Compute Cloud к {{ backup-name }}](../../backup/concepts/vm-connection.md).

#### Как заново подключить ВМ к {{ backup-name }} после восстановления ее копии в другую ВМ? {#how-to-renew-connection}

Виртуальная машина, после [восстановления ее копии в другую ВМ](../../backup/operations/backup-vm/non-native-recovery.md), становится неактуальной. Чтобы избежать конфликтов между исходной и целевой ВМ при резервном копировании, [обновите](../../backup/operations/refresh-connection.md) подключение неактуальной ВМ к {{ backup-name }}.

#### Ошибка при попытке восстановить ВМ из резервной копии {#recovery-error}

Текст ошибки:

```text
Not all of the items are mapped. Please, check your goal instance and its volumes.
```

Ошибка возникает из-за того, что {{ backup-name }} не может найти подходящий по размеру диск на целевой ВМ.

Размер загрузочного диска целевой ВМ должен быть не меньше размера загрузочного диска исходной ВМ.

Проверьте диски на целевой ВМ и при необходимости [увеличьте](../../compute/operations/disk-control/update.md#change-disk-size) их размер. Для восстановления также можно [использовать другую ВМ](../../backup/operations/backup-vm/non-native-recovery.md) с подходящими параметрами.