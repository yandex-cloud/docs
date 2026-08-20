[Документация Yandex Cloud](../../index.md) > [Yandex Cloud Backup](../index.md) > Решение проблем

# Решение проблем в Cloud Backup


В этом разделе описаны типичные проблемы, которые могут возникать при работе Cloud Backup, и методы их решения.

* [Почему ВМ или сервер BareMetal не добавляются в Cloud Backup?](#cannot-add-vm)

* [Как заново подключить к сервису ВМ или сервер BareMetal, удаленные из Cloud Backup?](#reconnect-deleted-vm)

* [Как заново подключить ВМ или сервер BareMetal к Cloud Backup после восстановления резервной копии в другую ВМ или другой сервер?](#how-to-renew-connection)

* [Почему не удаляются старые резервные копии после переподключения ВМ к Cloud Backup?](#old-backups-not-deleted)

* [Ошибка при попытке восстановить ВМ или сервер BareMetal из резервной копии](#recovery-error)

* [Ошибка при подключении ВМ на Windows](#windows-connection-issue)

* [Ошибка авторизации при установке агента Cloud Backup на ВМ Linux](#install-auth-error)

* [Как обновить агент Cloud Backup на ВМ?](#update-backup-agent)

* [Почему после обновления ОС перестало работать резервное копирование?](#kernel-update-consequences)

* [Почему создание резервной копии занимает так много времени?](#long-creation)

* [Создание инкрементальных резервных копий ВМ или сервера BareMetal занимает больше времени, чем обычно](#av-interaction)

* [Out-Of-Memory Killer (OOM Killer) в Linux завершает процесс агента Cloud Backup](#oom-solution)

* [Как восстановить ВМ или сервер BareMetal с LVM из резервной копии?](#restore-lvm)

* [Проблемы с установкой агента Cloud Backup на ВМ с низкими вычислительными ресурсами](#low-resources-installation)

* [Почему размер бэкапов Cloud Backup в консоли не совпадает с фактическим размером самих резервных копий?](#backup-size)

* [Если удалить ВМ, ее резервные копии останутся?](#backup-after-delete-vm)

* [Возникает ошибка с кодом 400 при установке агента](#agent-installation-error)

* [Как посмотреть журналы использования сервиса Cloud Backup?](#get-logs)

* [Возникает ошибка Unable to install agent при установке](#unable-to-install-agent)

* [ВМ Cloud Backup долго находится в статусе `Регистрируется`](#vm-long-register)

#### Почему ВМ или сервер BareMetal не добавляются в Cloud Backup? {#cannot-add-vm}

Убедитесь, что:

{% list tabs group=backup_resource_type %}

- Виртуальная машина {#vm}

  * Виртуальная машина создана из [поддерживаемого образа](../concepts/vm-connection/compute.md#os) или (при установке агента Cloud Backup вручную) операционная система ВМ [поддерживается Cloud Backup](../concepts/vm-connection/compute.md#self-install).
  * Сервисному аккаунту, привязанному к ВМ, назначена [роль](../security/index.md#backup-editor) `backup.editor`.
  * Для ВМ [корректно](../concepts/vm-connection/compute.md#vm-network-access) настроена [группа безопасности](../../vpc/concepts/security-groups.md).

  Подробнее в статье [Подключение виртуальных машин Compute Cloud к Cloud Backup](../concepts/vm-connection/compute.md).

- Сервер BareMetal {#baremetal-server}

  * На сервере установлена [поддерживаемая операционная система](../concepts/vm-connection/baremetal.md#self-install).
  * Сервисному аккаунту, IAM-токен которого используется при [установке](../operations/backup-baremetal/backup-baremetal.md#agent-install) агента Cloud Backup, назначена [роль](../security/index.md#backup-editor) `backup.editor`.
  * Серверу [назначен публичный IP-адрес](../concepts/vm-connection/baremetal.md#provide-access).

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

Чтобы избежать ошибок при восстановлении из резервной копии, перед восстановлением рекомендуется сопоставить параметры дисков и разделов резервной копии с параметрами дисков и разделов ВМ или сервера, на которые будет выполняться восстановление. Подробнее в разделе [Посмотреть параметры дисков и разделов в резервной копии](../operations/backup-vm/view-disk-layout.md).

{% endnote %}

#### Ошибка при подключении ВМ на Windows {#windows-connection-issue}

Текст ошибки:

```text
Fetching agent id from config
Iteration 0: The term 'acropsh' is not recognized as the name of a cmdlet, function, script file, or operable program. Check the spelling of the name, or if a path was included, verify that the path is correct and try again.
```

Убедитесь, что:
* Операционная система ВМ [поддерживается Cloud Backup](../concepts/vm-connection/compute.md#os).
* Сервисному аккаунту, привязанному к ВМ, назначена [роль](../security/index.md#backup-editor) `backup.editor`.
* Разрешен [сетевой доступ для ВМ](../concepts/vm-connection/compute.md#vm-network-access).
* В политиках выполнения PowerShell разрешен запуск скриптов. Если запуск запрещен, разрешите его и перезапустите PowerShell. Подробнее в [документации Microsoft](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_execution_policies).

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

Используйте инструкцию [Обновить агент Cloud Backup на ВМ](../operations/update-backup-agent.md).

#### Почему после обновления ОС перестало работать резервное копирование? {#kernel-update-consequences}

При обновлении [ядра](https://ru.wikipedia.org/wiki/Ядро_Linux) операционной системы Linux [защищаемого ресурса](../concepts/index.md#protected-resources), подключенного к Cloud Backup, работоспособность агента Cloud Backup может оказаться нарушена: будет невозможно создать резервную копию защищаемого ресурса или восстановить его из резервной копии.

Функционирование агента может нарушиться, потому что модуль SnapAPI, разработанный [провайдером резервного копирования](../concepts/index.md#providers) для работы агента с дисками и собираемый [фреймворком DKMS](https://ru.wikipedia.org/wiki/Dynamic_Kernel_Module_Support) под конкретное ядро Linux, после обновления ядра может не обновиться и перестать соответствовать версии ядра.

Чтобы восстановить работоспособность агента Cloud Backup, нарушенную после обновления ядра ОС, необходимо обновить версию заголовков ядра Linux, на которую ориентируется DKMS при сборке модуля SnapAPI. Как только версия заголовков ядра станет соответствовать версии ядра, DKMS пересоберет модуль SnapAPI под нужную версию ядра Linux при следующем запуске защищаемого ресурса.

Чтобы обновить версии заголовков ядра Linux, воспользуйтесь инструкцией [Восстановить работоспособность агента Cloud Backup после обновления ядра Linux](../operations/backup-baremetal/restore-agent.md).

#### Почему создание резервной копии занимает так много времени? {#long-creation}

Возможные причины:
* Высокая степень сжатия резервной копии.

  В [спецификации политики резервного копирования](../concepts/policy.md#specification) описаны степени сжатия:
  * `COMPRESSION_UNSPECIFIED` — не задано;
  * `NORMAL` — стандартное сжатие;
  * `HIGH` — сильное сжатие;
  * `MAX` — максимальное сжатие;
  * `OFF` — отключено.

  При повышении степени сжатия алгоритм тратит больше вычислительных ресурсов на поиск избыточности в данных, чтобы упаковать их плотнее. Использование высоких уровней сжатия (`HIGH`, `MAX`) приводит к увеличению времени создания резервной копии.

* Не используется отслеживание содержимого резервных копий (Changed Block Tracking).

  В сервисе Cloud Backup эта логика задается через параметр `cbt` в [спецификации политики резервного копирования](../concepts/policy.md#specification). У него есть несколько вариантов значений:
  * `CHANGED_BLOCK_TRACKING_UNSPECIFIED` — значение по умолчанию (не задано);
  * `USE_IF_ENABLED` — использовать, если функция включена;
  * `ENABLE_AND_USE` — явно включить и использовать;
  * `DO_NOT_USE` — не использовать вообще.

  Для ускорения создания резервной копии рекомендуется использовать значение `ENABLE_AND_USE`.

  Сама по себе настройка `cbt` задает стратегию, а реальное отслеживание изменений на диске настраивается через другой параметр — `fastBackupEnabled`.

* Параметр `fastBackupEnabled` в значении `false`.

  Параметр определяет, как именно сервис будет понимать, что файл изменился.
  * Если `fastBackupEnabled: true` — изменения определяют по размеру файла и его временной метке (timestamp). Это и есть суть «быстрого» резервного копирования.
  * Если `fastBackupEnabled: false` — сервис будет сравнивать все содержимое файла с тем, что уже есть в резервной копии, чтобы понять, есть ли изменения.

* Большой размер диска, над которым проводится резервное копирование.

#### Создание инкрементальных резервных копий ВМ или сервера BareMetal занимает больше времени, чем обычно {#av-interaction}

На время создания [инкрементальных копий](../concepts/backup.md#types) в рамках политики с включенной [опцией](../concepts/policy.md#specification) быстрого резервного копирования `fastBackupEnabled` может влиять работа антивируса. Подробнее в [Взаимодействие с антивирусом](../concepts/av-interaction.md).

#### Out-Of-Memory Killer (OOM Killer) в Linux завершает процесс агента Cloud Backup {#oom-solution}

Для ускорения [резервного копирования](../operations/backup-vm/create.md) данных и их [восстановления](../operations/backup-vm/recover.md) из резервных копий агент Cloud Backup может потреблять значительные объемы оперативной памяти (RAM) [защищаемого ресурса](../concepts/index.md#protected-resources). При этом агент может использовать всю доступную память, что в некоторых случаях приводит к сбоям в работе других служб защищаемого ресурса и невозможности завершить процесс резервного копирования или восстановления данных.

Чтобы предотвратить возникновение таких сбоев, [ограничьте](../operations/limit-agent-memory-usage.md) объем данных, кешируемых агентом в оперативной памяти.

{% note info %}

Ограничение использования оперативной памяти агентом Cloud Backup может привести к снижению скорости выполнения операций резервного копирования и восстановления данных.

{% endnote %}

#### Как восстановить ВМ или сервер BareMetal с LVM из резервной копии? {#restore-lvm}

Если для организации дискового пространства защищаемого ресурса вы используете [LVM](https://ru.wikipedia.org/wiki/LVM), ознакомьтесь с [особенностями](../concepts/backup.md#lvm) восстановления ресурсов с LVM в Cloud Backup.

#### Проблемы с установкой агента Cloud Backup на ВМ с низкими вычислительными ресурсами {#low-resources-installation}

Установка агента Cloud Backup является ресурсоемкой операцией. Если вы хотите использовать виртуальную машину в минимально возможной конфигурации или, например, ВМ с [уровнем производительности vCPU](../../compute/concepts/performance-levels.md) ниже 100%, рекомендуем на время установки агента Cloud Backup увеличить ресурсы ВМ.

#### Почему размер бэкапов Cloud Backup в консоли не совпадает с фактическим размером самих резервных копий? {#backup-size}

Разница в размере резервных копий вызвана внутренним устройством сервиса, так как подсчет ведется по архивам, а не по самим резервным копиям.

Размер каждого архива можно посмотреть с помощью [интерфейса командной строки Yandex Cloud](../../cli/quickstart.md) — командой `yc backup backup list-archives`.

Если сложить размеры каждого архива, то получится значение, которое отображается в консоли управления.

{% note info %}

Изменение общего размера после удаления резервных копий отображается не сразу, так как требуется время для внутренних изменений в архиве.

{% endnote %}

#### Если удалить ВМ, ее резервные копии останутся? {#backup-after-delete-vm}

Да, резервные копии останутся после удаления ВМ. Резервные копии привязаны к [политике резервного копирования](../concepts/policy.md), а не к ВМ.

#### Возникает ошибка с кодом 400 при установке агента {#agent-installation-error}

Полный текст ошибки: 

```text
Cloud backup service request for registering agent failed: unexpected status code: url=<https://backup.api.cloud.yandex.net/backup/agent/v1/api/registerAgent>, status=400
```

Вероятно, агент уже привязан к другой ВМ, созданной из образа с установленным агентом.

Для решения попробуйте [переподключить виртуальную машину к Cloud Backup](../operations/refresh-connection.md). 

Если переподключение не помогло, [создайте запрос в техническую поддержку](https://center.yandex.cloud/support).

#### Как посмотреть журналы использования сервиса Cloud Backup? {#get-logs}

В системах на базе ядра Linux, например Ubuntu, файлы журналов Cloud Backup можно найти по следующим путям:
* `/var/log/baas-agent-installer/log.txt`
* `/var/log/trueimage-setup.log`
* `/var/log/Acronis`

В Windows-системах журнал Cloud Backup находится в файле `%AppData%\BackupAgentInstaller*.log`.

Также можно собрать локальный системный отчет:
* Linux: запустите сценарий bash с привилегиями `root` для сбора отчета: `/usr/lib/Acronis/BackupAndRecovery/systeminfo`.
* Windows: запустите `C:\Program Files\Common Files\Acronis\AdvReport\systeminfo.exe`.

Более подробно об этом описано [в документации провайдера резервного копирования](https://kb.cyberprotect.ru/articles/sysinfo).

#### Возникает ошибка Unable to install agent при установке {#unable-to-install-agent}

Чаще всего ошибка возникает на этапе сборки модуля ядра `snapapi26`. Это происходит, когда версия устанавливаемого модуля не соответствует версии ядра вашей виртуальной машины.

Чтобы проверить статус агента и убедиться, что он действительно не зарегистрировался в сервисе, выполните в [Yandex Cloud CLI](../../cli/quickstart.md) команду:

```bash
yc backup vm get <идентификатор_ВМ> --folder-id <идентификатор_каталога>
```

Если агент не установлен или не зарегистрирован, команда вернет ошибку или пустой ответ.

Для решения проблемы:
1. Проверьте логи установки. Подключитесь к ВМ по SSH и изучите следующие файлы. Чаще всего корень проблемы кроется именно там:

    ```text
    /var/log/baas-agent-installer/log.txt
    /var/log/trueimage-setup.log (в этом файле обычно и видны ошибки сборки snapapi26)
    /var/log/Acronis
    ```

1. Соберите модуль ядра вручную. Если в логах вы видите ошибки, связанные с модулем `snapapi26`, следует собрать его самостоятельно под текущую версию ядра. Подробная инструкция по ручной сборке доступна в [базе знаний провайдера резервного копирования](https://kb.cyberprotect.ru/articles/snapapi-manual).

Если вышеописанные действия не помогли решить проблему, [создайте запрос в техническую поддержку](https://center.yandex.cloud/support). При создании запроса предоставьте следующую информацию:
* Идентификатор виртуальной машины.
* Перечисленные выше лог-файлы.

#### ВМ Cloud Backup долго находится в статусе «Регистрируется» {#vm-long-register}

Скорее всего, к виртуальной машине не прикреплен сервисный аккаунт. Для корректной работы Cloud Backup нужно [прикрепить](../operations/connect-vm-linux.md#create-sa) к виртуальной машине сервисный аккаунт с минимальной ролью `backup.user`. 

После добавления сервисного аккаунта нужно вручную [установить агент на ВМ](../operations/connect-vm-linux.md#connect-vm).