# Решение проблем в Cloud Backup

В этом разделе описаны типичные проблемы, которые могут возникать при работе Cloud Backup, и методы их решения.

* [Почему ВМ или сервер Yandex BareMetal не добавляются в Cloud Backup?](#cannot-add-vm)

* [Как заново подключить к сервису ВМ или сервер BareMetal, удаленные из Cloud Backup?](#reconnect-deleted-vm)

* [Как заново подключить ВМ или сервер BareMetal к Cloud Backup после восстановления резервной копии в другую ВМ или другой сервер?](#how-to-renew-connection)

* [Почему не удаляются старые резервные копии после переподключения ВМ к Cloud Backup?](#old-backups-not-deleted)

* [Ошибка при попытке восстановить ВМ или сервер BareMetal из резервной копии](#recovery-error)

* [Ошибка при подключении ВМ на Windows](#windows-connection-issue)

* [Ошибка авторизации при установке агента Cloud Backup на ВМ Linux](#install-auth-error)

* [Как обновить агент Cloud Backup на ВМ?](#update-backup-agent)

* [Почему после обновления ОС перестало работать резервное копирование?](#kernel-update-consequences)

* [Создание инкрементальных резервных копий занимает больше времени, чем обычно](#av-interaction)

* [Out-Of-Memory Killer (OOM Killer) в Linux завершает процесс агента Cloud Backup](#oom-solution)

* [Как восстановить ВМ или сервер BareMetal с LVM из резервной копии?](#restore-lvm)

* [Если удалить ВМ, ее резервные копии останутся?](#backup-after-delete-vm)

#### Почему ВМ или сервер Yandex BareMetal не добавляются в Cloud Backup? {#cannot-add-vm}

Убедитесь, что:

{% list tabs group=backup_resource_type %}

- Виртуальная машина {#vm}

  * Виртуальная машина создана из [поддерживаемого образа](../concepts/vm-connection.md#os) или (при установке агента Cloud Backup вручную) операционная система ВМ [поддерживается Cloud Backup](../concepts/vm-connection.md#self-install).
  * Сервисному аккаунту, привязанному к ВМ, назначена [роль](../security/index.md#backup-editor) `backup.editor`.
  * Для ВМ [корректно](../concepts/vm-connection.md#vm-network-access) настроена [группа безопасности](../../vpc/concepts/security-groups.md).

  Подробнее в статье [Подключение виртуальных машин Compute Cloud к Cloud Backup](../concepts/vm-connection.md).

- Сервер BareMetal {#baremetal-server}

  * На сервере установлена [поддерживаемая операционная система](../concepts/vm-connection.md#self-install).
  * Сервисному аккаунту, IAM-токен которого используется при [установке](../operations/backup-baremetal/backup-baremetal.md#agent-install) агента Cloud Backup, назначена [роль](../security/index.md#backup-editor) `backup.editor`.
  * Серверу [назначен публичный IP-адрес](../concepts/vm-connection.md#provide-access).

  Подробнее в статье [Подключение сервера BareMetal к Cloud Backup](../operations/backup-baremetal/backup-baremetal.md).

{% endlist %}


#### Как заново подключить к сервису ВМ или сервер BareMetal, удаленные из Cloud Backup? {#reconnect-deleted-vm}

Если вы [удалили ВМ](../operations/delete-vm.md) или сервер BareMetal из Cloud Backup и хотите подключить их к сервису заново, воспользуйтесь инструкциями:

{% list tabs group=backup_resource_type %}

- Виртуальная машина {#vm}

  * [Подключить виртуальную машину на Linux](../operations/connect-vm-linux.md)
  * [Подключить виртуальную машину на Windows](../operations/connect-vm-windows.md)

- Сервер BareMetal {#baremetal-server}

  * Заново установите агента Cloud Backup, воспользовавшись [инструкцией](../operations/backup-baremetal/backup-baremetal.md#agent-install).

{% endlist %}


#### Как заново подключить ВМ или сервер BareMetal к Cloud Backup после восстановления резервной копии в другую ВМ или другой сервер? {#how-to-renew-connection}

{% list tabs group=backup_resource_type %}

- Виртуальная машина {#vm}

  Виртуальная машина, после [восстановления ее копии в другую ВМ](../operations/backup-vm/non-native-recovery.md), становится неактуальной. Чтобы избежать конфликтов между исходной и целевой ВМ при резервном копировании, [обновите](../operations/refresh-connection.md) подключение неактуальной ВМ к Cloud Backup.

- Сервер BareMetal {#baremetal-server}

  Сервер BareMetal, после восстановления его копии на другой сервер, становится неактуальным. Чтобы избежать конфликтов между исходным и целевым сервером BareMetal при резервном копировании, [обновите](../operations/backup-baremetal/refresh-connection.md) подключение неактуального сервера к Cloud Backup.

{% endlist %}

#### Почему не удаляются старые резервные копии после переподключения ВМ к Cloud Backup? {#old-backups-not-deleted}

При переподключении ВМ добавляется в Cloud Backup как новый ресурс. Резервные копии новой ВМ хранятся согласно привязанной [политике резервного копирования](../concepts/policy.md#retention).

Правила политики резервного копирования не действуют на резервные копии старой ВМ. Их хранение тарифицируется в соответствии с [правилами тарификации](../pricing.md#backups). Если резервные копии вам не нужны, [удалите](../operations/backup-vm/delete.md) их вручную или воспользуйтесь [массовым удалением](../operations/backup-vm/batch-delete.md).


#### Ошибка при попытке восстановить ВМ или сервер BareMetal из резервной копии {#recovery-error}

Текст ошибки:

```text
Not all of the items are mapped. Please, check your goal instance and its volumes.
```

Ошибка возникает из-за того, что Cloud Backup не может найти подходящий по размеру диск на целевой машине.

Размер загрузочного диска целевой ВМ или сервере BareMetal должен быть не меньше размера загрузочного диска исходной машины.

Проверьте диски на целевой машине и при необходимости [увеличьте](../../compute/operations/disk-control/update.md#change-disk-size) их размер. Для восстановления также можно [использовать другую ВМ](../operations/backup-vm/non-native-recovery.md) или сервер BareMetal с подходящими параметрами.

{% note info %}

Чтобы избежать ошибок при восстановлении из резервной копии, перед восстановлением рекомендуется сопоставить параметры дисков и разделов резервной копии с параметрами дисков и разделов [ВМ](../../compute/concepts/vm.md) или [сервера](../../baremetal/concepts/servers.md) Yandex BareMetal. Подробнее в разделе [Посмотреть параметры дисков и разделов в резервной копии](../operations/backup-vm/view-disk-layout.md).

{% endnote %}


#### Ошибка при подключении ВМ на Windows {#windows-connection-issue}

Текст ошибки:

```text
Fetching agent id from config
Iteration 0: The term 'acropsh' is not recognized as the name of a cmdlet, function, script file, or operable program. Check the spelling of the name, or if a path was included, verify that the path is correct and try again.
```

Убедитесь, что:

* Операционная система ВМ [поддерживается Cloud Backup](../concepts/vm-connection.md#os).
* Сервисному аккаунту, привязанному к ВМ, назначена [роль](../security/index.md#backup-editor) `backup.editor`.
* Разрешен [сетевой доступ для ВМ](../concepts/vm-connection.md#vm-network-access).
* В политиках выполнения PowerShell разрешен запуск скриптов. Если запуск запрещен, разрешите его и перезапустите PowerShell. Подробнее см. в [документации Microsoft](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_execution_policies).


#### Ошибка авторизации при установке агента Cloud Backup на ВМ Linux {#install-auth-error}

Текст ошибки:

```text
Failed to parse cloudbackup from instance attributes IAM token and instance registration id are empty, unable to provide authorization
```

Ошибка возникает при отсутствии или неправильной настройке сервисного аккаунта для виртуальной машины.

Убедитесь, что:
* К виртуальной машине [привязан](../../compute/operations/vm-connect/auth-inside-vm.md#link-sa-with-instance) сервисный аккаунт.
* Сервисному аккаунту назначена [роль](../security/index.md#backup-editor) `backup.editor`.

#### Как обновить агент Cloud Backup на ВМ? {#update-backup-agent}

См. инструкцию [Обновить агент Cloud Backup на ВМ](../operations/update-backup-agent.md).

#### Почему после обновления ОС перестало работать резервное копирование? {#kernel-update-consequences}

При обновлении [ядра](https://ru.wikipedia.org/wiki/Ядро_Linux) операционной системы Linux виртуальной машины или сервера BareMetal, подключенных к Cloud Backup, работоспособность агента Cloud Backup может оказаться нарушена: будет невозможно создать резервную копию ВМ/сервера или восстановить ВМ/сервер из резервной копии.

Функционирование агента может нарушиться, потому что модуль SnapAPI, разработанный [провайдером резервного копирования](../concepts/index.md#providers) для работы агента с дисками и собираемый [фреймворком DKMS](https://ru.wikipedia.org/wiki/Dynamic_Kernel_Module_Support) под конкретное ядро Linux, после обновления ядра может не обновиться и перестать соответствовать версии ядра. 

Чтобы восстановить работоспособность агента Cloud Backup, нарушенную после обновления ядра ОС, необходимо обновить версию заголовков ядра Linux, на которую ориентируется DKMS при сборке модуля SnapAPI. Как только версия заголовков ядра станет соответствовать версии ядра, DKMS пересоберет модуль SnapAPI под нужную версию ядра Linux при следующем запуске ВМ или сервера BareMetal.

Чтобы обновить версии заголовков ядра Linux, воспользуйтесь инструкциями [Восстановить работоспособность агента Cloud Backup на ВМ](../operations/update-backup-agent.md#restore-agent) и [Восстановить работоспособность агента Cloud Backup на сервере BareMetal](../operations/backup-baremetal/restore-agent.md).

#### Создание инкрементальных резервных копий ВМ или сервера BareMetal занимает больше времени, чем обычно {#av-interaction}

На время создания [инкрементальных копий](../concepts/backup.md#types) в рамках политики с включенной [опцией](../concepts/policy.md#specification) быстрого резервного копирования `fastBackupEnabled` может влиять работа антивируса. Подробнее см. в [Взаимодействие с антивирусом](../concepts/av-interaction.md).

#### Out-Of-Memory Killer (OOM Killer) в Linux завершает процесс агента Cloud Backup {#oom-solution}

Для ускорения [резервного копирования](../operations/backup-vm/create.md) данных и их [восстановления](../operations/backup-vm/recover.md) из резервных копий [агент Cloud Backup](../concepts/agent.md) может потреблять значительные объемы оперативной памяти (RAM) защищаемого ресурса — [виртуальной машины](../../compute/concepts/vm.md) или [сервера BareMetal](../../baremetal/concepts/servers.md). При этом агент может использовать всю доступную память, что в некоторых случаях приводит к сбоям в работе других служб защищаемого ресурса и невозможности завершить процесс резервного копирования или восстановления данных.

Чтобы предотвратить возникновение таких сбоев, [ограничьте](../operations/limit-agent-memory-usage.md) объем данных, кешируемых агентом в оперативной памяти.

{% note info %}

Ограничение использования оперативной памяти агентом Cloud Backup может привести к снижению скорости выполнения операций резервного копирования и восстановления данных.

{% endnote %}

#### Как восстановить ВМ или сервер BareMetal с LVM из резервной копии? {#restore-lvm}

Если для организации дискового пространства защищаемого ресурса вы используете [LVM](https://ru.wikipedia.org/wiki/LVM), ознакомьтесь с [особенностями](../concepts/backup.md#lvm) восстановления ресурсов с LVM в Cloud Backup.

#### Проблемы с установкой агента Cloud Backup на ВМ с низкими вычислительными ресурсами {#low-resources-installation}

Установка агента Cloud Backup является ресурсоемкой операцией. Если вы хотите использовать ВМ в минимально возможной конфигурации или, например, ВМ с [уровнем производительности vCPU](../../compute/concepts/performance-levels.md) ниже 100%, рекомендуем на время установки агента Cloud Backup увеличить ресурсы ВМ.

#### Если удалить ВМ, ее резервные копии останутся? {#backup-after-delete-vm}

Да, резервные копии останутся после удаления ВМ. Резервные копии привязаны к [политике резервного копирования](../concepts/policy.md), а не к ВМ.