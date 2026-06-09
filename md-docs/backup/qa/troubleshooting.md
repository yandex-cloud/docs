# Решение проблем в {{ backup-name }}

В этом разделе описаны типичные проблемы, которые могут возникать при работе {{ backup-name }}, и методы их решения.

* [Почему ВМ или сервер {{ baremetal-full-name }} не добавляются в {{ backup-name }}?](#cannot-add-vm)

* [Как заново подключить к сервису ВМ или сервер {{ baremetal-name }}, удаленные из {{ backup-name }}?](#reconnect-deleted-vm)

* [Как заново подключить ВМ или сервер {{ baremetal-name }} к {{ backup-name }} после восстановления резервной копии в другую ВМ или другой сервер?](#how-to-renew-connection)

* [Почему не удаляются старые резервные копии после переподключения ВМ к {{ backup-name }}?](#old-backups-not-deleted)

* [Ошибка при попытке восстановить ВМ или сервер {{ baremetal-name }} из резервной копии](#recovery-error)

* [Ошибка при подключении ВМ на Windows](#windows-connection-issue)

* [Ошибка авторизации при установке агента {{ backup-name }} на ВМ Linux](#install-auth-error)

* [Как обновить агент {{ backup-name }} на ВМ?](#update-backup-agent)

* [Почему после обновления ОС перестало работать резервное копирование?](#kernel-update-consequences)

* [Создание инкрементальных резервных копий занимает больше времени, чем обычно](#av-interaction)

* [Out-Of-Memory Killer (OOM Killer) в Linux завершает процесс агента {{ backup-name }}](#oom-solution)

* [Как восстановить ВМ или сервер {{ baremetal-name }} с LVM из резервной копии?](#restore-lvm)

* [Если удалить ВМ, ее резервные копии останутся?](#backup-after-delete-vm)

#### Почему ВМ или сервер {{ baremetal-full-name }} не добавляются в {{ backup-name }}? {#cannot-add-vm}

Убедитесь, что:

{% list tabs group=backup_resource_type %}

- Виртуальная машина {#vm}

  * Виртуальная машина создана из [поддерживаемого образа](../concepts/vm-connection.md#os) или (при установке агента {{ backup-name }} вручную) операционная система ВМ [поддерживается {{ backup-name }}](../concepts/vm-connection.md#self-install).
  * Сервисному аккаунту, привязанному к ВМ, назначена [роль](../security/index.md#backup-editor) `backup.editor`.
  * Для ВМ [корректно](../concepts/vm-connection.md#vm-network-access) настроена [группа безопасности](../../vpc/concepts/security-groups.md).

  Подробнее в статье [Подключение виртуальных машин Compute Cloud к {{ backup-name }}](../concepts/vm-connection.md).

- Сервер {{ baremetal-name }} {#baremetal-server}

  * На сервере установлена [поддерживаемая операционная система](../concepts/vm-connection.md#self-install).
  * Сервисному аккаунту, IAM-токен которого используется при [установке](../operations/backup-baremetal/backup-baremetal.md#agent-install) агента {{ backup-name }}, назначена [роль](../security/index.md#backup-editor) `backup.editor`.
  * Серверу [назначен публичный IP-адрес](../concepts/vm-connection.md#provide-access).

  Подробнее в статье [Подключение сервера {{ baremetal-name }} к {{ backup-name }}](../operations/backup-baremetal/backup-baremetal.md).

{% endlist %}


#### Как заново подключить к сервису ВМ или сервер {{ baremetal-name }}, удаленные из {{ backup-name }}? {#reconnect-deleted-vm}

Если вы [удалили ВМ](../operations/delete-vm.md) или сервер {{ baremetal-name }} из {{ backup-name }} и хотите подключить их к сервису заново, воспользуйтесь инструкциями:

{% list tabs group=backup_resource_type %}

- Виртуальная машина {#vm}

  * [Подключить виртуальную машину на Linux](../operations/connect-vm-linux.md)
  * [Подключить виртуальную машину на Windows](../operations/connect-vm-windows.md)

- Сервер {{ baremetal-name }} {#baremetal-server}

  * Заново установите агента {{ backup-name }}, воспользовавшись [инструкцией](../operations/backup-baremetal/backup-baremetal.md#agent-install).

{% endlist %}


#### Как заново подключить ВМ или сервер {{ baremetal-name }} к {{ backup-name }} после восстановления резервной копии в другую ВМ или другой сервер? {#how-to-renew-connection}

{% list tabs group=backup_resource_type %}

- Виртуальная машина {#vm}

  Виртуальная машина, после [восстановления ее копии в другую ВМ](../operations/backup-vm/non-native-recovery.md), становится неактуальной. Чтобы избежать конфликтов между исходной и целевой ВМ при резервном копировании, [обновите](../operations/refresh-connection.md) подключение неактуальной ВМ к {{ backup-name }}.

- Сервер {{ baremetal-name }} {#baremetal-server}

  Сервер {{ baremetal-name }}, после восстановления его копии на другой сервер, становится неактуальным. Чтобы избежать конфликтов между исходным и целевым сервером {{ baremetal-name }} при резервном копировании, [обновите](../operations/backup-baremetal/refresh-connection.md) подключение неактуального сервера к {{ backup-name }}.

{% endlist %}

#### Почему не удаляются старые резервные копии после переподключения ВМ к {{ backup-name }}? {#old-backups-not-deleted}

При переподключении ВМ добавляется в {{ backup-name }} как новый ресурс. Резервные копии новой ВМ хранятся согласно привязанной [политике резервного копирования](../concepts/policy.md#retention).

Правила политики резервного копирования не действуют на резервные копии старой ВМ. Их хранение тарифицируется в соответствии с [правилами тарификации](../pricing.md#backups). Если резервные копии вам не нужны, [удалите](../operations/backup-vm/delete.md) их вручную или воспользуйтесь [массовым удалением](../operations/backup-vm/batch-delete.md).


#### Ошибка при попытке восстановить ВМ или сервер {{ baremetal-name }} из резервной копии {#recovery-error}

Текст ошибки:

```text
Not all of the items are mapped. Please, check your goal instance and its volumes.
```

Ошибка возникает из-за того, что {{ backup-name }} не может найти подходящий по размеру диск на целевой машине.

Размер загрузочного диска целевой ВМ или сервере {{ baremetal-name }} должен быть не меньше размера загрузочного диска исходной машины.

Проверьте диски на целевой машине и при необходимости [увеличьте](../../compute/operations/disk-control/update.md#change-disk-size) их размер. Для восстановления также можно [использовать другую ВМ](../operations/backup-vm/non-native-recovery.md) или сервер {{ baremetal-name }} с подходящими параметрами.

{% note info %}

Чтобы избежать ошибок при восстановлении из резервной копии, перед восстановлением рекомендуется сопоставить параметры дисков и разделов резервной копии с параметрами дисков и разделов [ВМ](../../compute/concepts/vm.md) или [сервера](../../baremetal/concepts/servers.md) {{ baremetal-full-name }}. Подробнее см. в разделе [{#T}](../operations/backup-vm/view-disk-layout.md).

{% endnote %}


#### Ошибка при подключении ВМ на Windows {#windows-connection-issue}

Текст ошибки:

```text
Fetching agent id from config
Iteration 0: The term 'acropsh' is not recognized as the name of a cmdlet, function, script file, or operable program. Check the spelling of the name, or if a path was included, verify that the path is correct and try again.
```

Убедитесь, что:

* Операционная система ВМ [поддерживается {{ backup-name }}](../concepts/vm-connection.md#os).
* Сервисному аккаунту, привязанному к ВМ, назначена [роль](../security/index.md#backup-editor) `backup.editor`.
* Разрешен [сетевой доступ для ВМ](../concepts/vm-connection.md#vm-network-access).
* В политиках выполнения PowerShell разрешен запуск скриптов. Если запуск запрещен, разрешите его и перезапустите PowerShell. Подробнее см. в [документации Microsoft](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_execution_policies).


#### Ошибка авторизации при установке агента {{ backup-name }} на ВМ Linux {#install-auth-error}

Текст ошибки:

```text
Failed to parse cloudbackup from instance attributes IAM token and instance registration id are empty, unable to provide authorization
```

Ошибка возникает при отсутствии или неправильной настройке сервисного аккаунта для виртуальной машины.

Убедитесь, что:
* К виртуальной машине [привязан](../../compute/operations/vm-connect/auth-inside-vm.md#link-sa-with-instance) сервисный аккаунт.
* Сервисному аккаунту назначена [роль](../security/index.md#backup-editor) `backup.editor`.

#### Как обновить агент {{ backup-name }} на ВМ? {#update-backup-agent}

См. инструкцию [Обновить агент {{ backup-name }} на ВМ](../operations/update-backup-agent.md).

#### Почему после обновления ОС перестало работать резервное копирование? {#kernel-update-consequences}

При обновлении [ядра](https://ru.wikipedia.org/wiki/Ядро_Linux) операционной системы Linux виртуальной машины или сервера {{ baremetal-name }}, подключенных к {{ backup-name }}, работоспособность агента {{ backup-name }} может оказаться нарушена: будет невозможно создать резервную копию ВМ/сервера или восстановить ВМ/сервер из резервной копии.

Функционирование агента может нарушиться, потому что модуль SnapAPI, разработанный [провайдером резервного копирования](../concepts/index.md#providers) для работы агента с дисками и собираемый [фреймворком DKMS](https://ru.wikipedia.org/wiki/Dynamic_Kernel_Module_Support) под конкретное ядро Linux, после обновления ядра может не обновиться и перестать соответствовать версии ядра. 

Чтобы восстановить работоспособность агента {{ backup-name }}, нарушенную после обновления ядра ОС, необходимо обновить версию заголовков ядра Linux, на которую ориентируется DKMS при сборке модуля SnapAPI. Как только версия заголовков ядра станет соответствовать версии ядра, DKMS пересоберет модуль SnapAPI под нужную версию ядра Linux при следующем запуске ВМ или сервера {{ baremetal-name }}.

Чтобы обновить версии заголовков ядра Linux, воспользуйтесь инструкциями [Восстановить работоспособность агента {{ backup-name }} на ВМ](../operations/update-backup-agent.md#restore-agent) и [Восстановить работоспособность агента {{ backup-name }} на сервере {{ baremetal-name }}](../operations/backup-baremetal/restore-agent.md).

#### Создание инкрементальных резервных копий ВМ или сервера {{ baremetal-name }} занимает больше времени, чем обычно {#av-interaction}

На время создания [инкрементальных копий](../concepts/backup.md#types) в рамках политики с включенной [опцией](../concepts/policy.md#specification) быстрого резервного копирования `fastBackupEnabled` может влиять работа антивируса. Подробнее см. в [{#T}](../concepts/av-interaction.md).

#### Out-Of-Memory Killer (OOM Killer) в Linux завершает процесс агента {{ backup-name }} {#oom-solution}

Для ускорения [резервного копирования](../operations/backup-vm/create.md) данных и их [восстановления](../operations/backup-vm/recover.md) из резервных копий [агент {{ backup-name }}](../concepts/agent.md) может потреблять значительные объемы оперативной памяти (RAM) защищаемого ресурса — [виртуальной машины](../../compute/concepts/vm.md) или [сервера {{ baremetal-name }}](../../baremetal/concepts/servers.md). При этом агент может использовать всю доступную память, что в некоторых случаях приводит к сбоям в работе других служб защищаемого ресурса и невозможности завершить процесс резервного копирования или восстановления данных.

Чтобы предотвратить возникновение таких сбоев, [ограничьте](../operations/limit-agent-memory-usage.md) объем данных, кешируемых агентом в оперативной памяти.

{% note info %}

Ограничение использования оперативной памяти агентом {{ backup-name }} может привести к снижению скорости выполнения операций резервного копирования и восстановления данных.

{% endnote %}

#### Как восстановить ВМ или сервер {{ baremetal-name }} с LVM из резервной копии? {#restore-lvm}

Если для организации дискового пространства защищаемого ресурса вы используете [LVM](https://ru.wikipedia.org/wiki/LVM), ознакомьтесь с [особенностями](../concepts/backup.md#lvm) восстановления ресурсов с LVM в {{ backup-name }}.

#### Проблемы с установкой агента {{ backup-name }} на ВМ с низкими вычислительными ресурсами {#low-resources-installation}

Установка агента {{ backup-name }} является ресурсоемкой операцией. Если вы хотите использовать ВМ в минимально возможной конфигурации или, например, ВМ с [уровнем производительности vCPU](../../compute/concepts/performance-levels.md) ниже 100%, рекомендуем на время установки агента {{ backup-name }} увеличить ресурсы ВМ.

#### Если удалить ВМ, ее резервные копии останутся? {#backup-after-delete-vm}

Да, резервные копии останутся после удаления ВМ. Резервные копии привязаны к [политике резервного копирования](../concepts/policy.md), а не к ВМ.