# Решение проблем в {{ backup-name }}

В этом разделе описаны типичные проблемы, которые могут возникать при работе {{ backup-name }}, и методы их решения.

#### Почему ВМ не добавляется в {{ backup-name }}? {#cannot-add-vm}

Убедитесь, что:

* Операционная система ВМ [поддерживается {{ backup-name }}](../../backup/concepts/vm-connection.md#os).
* Сервисному аккаунту, привязанному к ВМ, назначена [роль](../../backup/security/index.md#backup-editor) `backup.editor`.
* Для ВМ [корректно](../../backup/concepts/vm-connection.md#vm-network-access) настроена [группа безопасности](../../vpc/concepts/security-groups.md).

Подробнее в статье [Подключение виртуальных машин Compute Cloud к {{ backup-name }}](../../backup/concepts/vm-connection.md).

#### Как заново подключить к сервису ВМ, удаленную из {{ backup-name }}? {#reconnect-deleted-vm}

Если вы [удалили](../../backup/operations/delete-vm.md) ВМ из {{ backup-name }} и хотите подключить ее к сервису заново, воспользуйтесь инструкциями:

* [Подключить виртуальную машину на Linux](../../backup/operations/connect-vm-linux.md)
* [Подключить виртуальную машину на Windows](../../backup/operations/connect-vm-windows.md)

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

#### Ошибка при подключении ВМ на Windows {#windows-connection-issue}

Текст ошибки:

```text
Fetching agent id from config
Iteration 0: The term 'acropsh' is not recognized as the name of a cmdlet, function, script file, or operable program. Check the spelling of the name, or if a path was included, verify that the path is correct and try again.
```

Убедитесь, что:

* Операционная система ВМ [поддерживается {{ backup-name }}](../../backup/concepts/vm-connection.md#os).
* Сервисному аккаунту, привязанному к ВМ, назначена [роль](../../backup/security/index.md#backup-editor) `backup.editor`.
* Разрешен [сетевой доступ для ВМ](../../backup/concepts/vm-connection.md#vm-network-access).
* В политиках выполнения PowerShell разрешен запуск скриптов. Если запуск запрещен, разрешите его и перезапустите PowerShell. Подробнее см. в [документации Microsoft](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_execution_policies).

#### Как обновить агент резервного копирования {{ backup-name }} на ВМ? {#update-backup-agent}

См. инструкцию [Обновить агент резервного копирования {{ backup-name }} на ВМ](../../backup/operations/update-backup-agent.md).