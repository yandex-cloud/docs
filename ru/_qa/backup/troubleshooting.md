#### Почему ВМ или сервер {{ baremetal-full-name }} не добавляются в {{ backup-name }}? {#cannot-add-vm}

Убедитесь, что:

{% list tabs group=backup_resource_type %}

- Виртуальная машина {#vm}

  * Виртуальная машина создана из [поддерживаемого образа](../../backup/concepts/vm-connection.md#os) или (при установке агента {{ backup-name }} вручную) операционная система ВМ [поддерживается {{ backup-name }}](../../backup/concepts/vm-connection.md#self-install).
  * Сервисному аккаунту, привязанному к ВМ, назначена [роль](../../backup/security/index.md#backup-editor) `backup.editor`.
  * Для ВМ [корректно](../../backup/concepts/vm-connection.md#vm-network-access) настроена [группа безопасности](../../vpc/concepts/security-groups.md).

  Подробнее в статье [Подключение виртуальных машин Compute Cloud к {{ backup-name }}](../../backup/concepts/vm-connection.md).

- Сервер {{ baremetal-name }} {#baremetal-server}

  * На сервере установлена [поддерживаемая операционная система](../../backup/concepts/vm-connection.md#self-install).
  * Сервисному аккаунту, IAM-токен которого используется при [установке](../../backup/operations/backup-baremetal/backup-baremetal.md#agent-install) агента {{ backup-name }}, назначена [роль](../../backup/security/index.md#backup-editor) `backup.editor`.
  * Серверу [назначен публичный IP-адрес](../../backup/concepts/vm-connection.md#provide-access).

  Подробнее в статье [Подключение сервера {{ baremetal-name }} к {{ backup-name }}](../../backup/operations/backup-baremetal/backup-baremetal.md).

{% endlist %}


#### Как заново подключить к сервису ВМ или сервер {{ baremetal-name }}, удаленные из {{ backup-name }}? {#reconnect-deleted-vm}

Если вы [удалили ВМ](../../backup/operations/delete-vm.md) или сервер {{ baremetal-name }} из {{ backup-name }} и хотите подключить их к сервису заново, воспользуйтесь инструкциями:

{% list tabs group=backup_resource_type %}

- Виртуальная машина {#vm}

  * [Подключить виртуальную машину на Linux](../../backup/operations/connect-vm-linux.md)
  * [Подключить виртуальную машину на Windows](../../backup/operations/connect-vm-windows.md)

- Сервер {{ baremetal-name }} {#baremetal-server}

  * Заново установите агента {{ backup-name }}, воспользовавшись [инструкцией](../../backup/operations/backup-baremetal/backup-baremetal.md#agent-install).

{% endlist %}


#### Как заново подключить ВМ или сервер {{ baremetal-name }} к {{ backup-name }} после восстановления резервной копии в другую ВМ или другой сервер? {#how-to-renew-connection}

{% list tabs group=backup_resource_type %}

- Виртуальная машина {#vm}

  Виртуальная машина, после [восстановления ее копии в другую ВМ](../../backup/operations/backup-vm/non-native-recovery.md), становится неактуальной. Чтобы избежать конфликтов между исходной и целевой ВМ при резервном копировании, [обновите](../../backup/operations/refresh-connection.md) подключение неактуальной ВМ к {{ backup-name }}.

- Сервер {{ baremetal-name }} {#baremetal-server}

  Сервер {{ baremetal-name }}, после восстановления его копии на другой сервер, становится неактуальным. Чтобы избежать конфликтов между исходным и целевым сервером {{ baremetal-name }} при резервном копировании, [обновите](../../backup/operations/backup-baremetal/refresh-connection.md) подключение неактуального сервера к {{ backup-name }}.

{% endlist %}


#### Ошибка при попытке восстановить ВМ или сервер {{ baremetal-name }} из резервной копии {#recovery-error}

Текст ошибки:

```text
Not all of the items are mapped. Please, check your goal instance and its volumes.
```

Ошибка возникает из-за того, что {{ backup-name }} не может найти подходящий по размеру диск на целевой машине.

Размер загрузочного диска целевой ВМ или сервере {{ baremetal-name }} должен быть не меньше размера загрузочного диска исходной машины.

Проверьте диски на целевой машине и при необходимости [увеличьте](../../compute/operations/disk-control/update.md#change-disk-size) их размер. Для восстановления также можно [использовать другую ВМ](../../backup/operations/backup-vm/non-native-recovery.md) или сервер {{ baremetal-name }} с подходящими параметрами.

{% note info %}

{% include [avoid-errors-when-restoring-from-backup.md](../../_includes/backup/avoid-errors-when-restoring-from-backup.md) %}

{% endnote %}


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


#### Как обновить агент {{ backup-name }} на ВМ? {#update-backup-agent}

См. инструкцию [Обновить агент {{ backup-name }} на ВМ](../../backup/operations/update-backup-agent.md).

#### Почему после обновления ОС перестало работать резервное копирование? {#kernel-update-consequences}

{% include [update-kernel-headers-description](../../_includes/backup/operations/update-kernel-headers-description.md) %}

Чтобы обновить версии заголовков ядра Linux, воспользуйтесь инструкциями [Восстановить работоспособность агента {{ backup-name }} на ВМ](../../backup/operations/update-backup-agent.md#restore-agent) и [Восстановить работоспособность агента {{ backup-name }} на сервере {{ baremetal-name }}](../../backup/operations/backup-baremetal/restore-agent.md).

#### Создание инкрементальных резервных копий ВМ или сервера {{ baremetal-name }} занимает больше времени, чем обычно {#av-interaction}

На время создания [инкрементальных копий](../../backup/concepts/backup.md#types) в рамках политики с включенной [опцией](../../backup/concepts/policy.md#specification) быстрого резервного копирования `fastBackupEnabled` может влиять работа антивируса. Подробнее см. в [{#T}](../../backup/concepts/av-interaction.md).
