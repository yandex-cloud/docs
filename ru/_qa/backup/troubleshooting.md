#### Почему ВМ или сервер {{ baremetal-name }} не добавляются в {{ backup-name }}? {#cannot-add-vm}

Убедитесь, что:

{% list tabs group=backup_resource_type %}

- Виртуальная машина {#vm}

  * Виртуальная машина создана из [поддерживаемого образа](../../backup/concepts/vm-connection/compute.md#os) или (при установке агента {{ backup-name }} вручную) операционная система ВМ [поддерживается {{ backup-name }}](../../backup/concepts/vm-connection/compute.md#self-install).
  * Сервисному аккаунту, привязанному к ВМ, назначена [роль](../../backup/security/index.md#backup-editor) `backup.editor`.
  * Для ВМ [корректно](../../backup/concepts/vm-connection/compute.md#vm-network-access) настроена [группа безопасности](../../vpc/concepts/security-groups.md).

  Подробнее в статье [Подключение виртуальных машин {{ compute-name }} к {{ backup-name }}](../../backup/concepts/vm-connection/compute.md).

- Сервер {{ baremetal-name }} {#baremetal-server}

  * На сервере установлена [поддерживаемая операционная система](../../backup/concepts/vm-connection/baremetal.md#self-install).
  * Сервисному аккаунту, IAM-токен которого используется при [установке](../../backup/operations/backup-baremetal/backup-baremetal.md#agent-install) агента {{ backup-name }}, назначена [роль](../../backup/security/index.md#backup-editor) `backup.editor`.
  * Серверу [назначен публичный IP-адрес](../../backup/concepts/vm-connection/baremetal.md#provide-access).

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

#### Почему не удаляются старые резервные копии после переподключения ВМ к {{ backup-name }}? {#old-backups-not-deleted}

{% include [old-backup](../../_includes/backup/old-backups.md) %}

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
* Операционная система ВМ [поддерживается {{ backup-name }}](../../backup/concepts/vm-connection/compute.md#os).
* Сервисному аккаунту, привязанному к ВМ, назначена [роль](../../backup/security/index.md#backup-editor) `backup.editor`.
* Разрешен [сетевой доступ для ВМ](../../backup/concepts/vm-connection/compute.md#vm-network-access).
* В политиках выполнения PowerShell разрешен запуск скриптов. Если запуск запрещен, разрешите его и перезапустите PowerShell. Подробнее в [документации Microsoft](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_execution_policies).

#### Ошибка авторизации при установке агента {{ backup-name }} на ВМ Linux {#install-auth-error}

Текст ошибки:

```text
Failed to parse cloudbackup from instance attributes IAM token and instance registration id are empty, unable to provide authorization
```

Ошибка возникает при отсутствии или неправильной настройке сервисного аккаунта для виртуальной машины.

Убедитесь, что:
* К виртуальной машине [привязан](../../compute/operations/vm-connect/auth-inside-vm.md#link-sa-with-instance) сервисный аккаунт.
* Сервисному аккаунту назначена [роль](../../backup/security/index.md#backup-editor) `backup.editor`.

#### Как обновить агент {{ backup-name }} на ВМ? {#update-backup-agent}

Используйте инструкцию [Обновить агент {{ backup-name }} на ВМ](../../backup/operations/update-backup-agent.md).

#### Почему после обновления ОС перестало работать резервное копирование? {#kernel-update-consequences}

{% include [update-kernel-headers-description](../../_includes/backup/operations/update-kernel-headers-description.md) %}

Чтобы обновить версии заголовков ядра Linux, воспользуйтесь инструкцией [{#T}](../../backup/operations/backup-baremetal/restore-agent.md).

#### Почему создание резервной копии занимает так много времени? {#long-creation}

Возможные причины:
* Высокая степень сжатия резервной копии.

  В [спецификации политики резервного копирования](../../backup/concepts/policy.md#specification) описаны степени сжатия:
  * `COMPRESSION_UNSPECIFIED` — не задано;
  * `NORMAL` — стандартное сжатие;
  * `HIGH` — сильное сжатие;
  * `MAX` — максимальное сжатие;
  * `OFF` — отключено.

  При повышении степени сжатия алгоритм тратит больше вычислительных ресурсов на поиск избыточности в данных, чтобы упаковать их плотнее. Использование высоких уровней сжатия (`HIGH`, `MAX`) приводит к увеличению времени создания резервной копии.

* Не используется отслеживание содержимого резервных копий (Changed Block Tracking).

  В сервисе {{ backup-name }} эта логика задается через параметр `cbt` в [спецификации политики резервного копирования](../../backup/concepts/policy.md#specification). У него есть несколько вариантов значений:
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

#### Создание инкрементальных резервных копий ВМ или сервера {{ baremetal-name }} занимает больше времени, чем обычно {#av-interaction}

На время создания [инкрементальных копий](../../backup/concepts/backup.md#types) в рамках политики с включенной [опцией](../../backup/concepts/policy.md#specification) быстрого резервного копирования `fastBackupEnabled` может влиять работа антивируса. Подробнее в [{#T}](../../backup/concepts/av-interaction.md).

#### Out-Of-Memory Killer (OOM Killer) в Linux завершает процесс агента {{ backup-name }} {#oom-solution}

{% include [agent-ram-usage-paragraph](../../_includes/backup/operations/agent-ram-usage-paragraph.md) %}

{% include [agent-ram-usage-second-paragraph](../../_includes/backup/operations/agent-ram-usage-second-paragraph.md) %}

{% include [agent-ram-usage-notice](../../_includes/backup/operations/agent-ram-usage-notice.md) %}

#### Как восстановить ВМ или сервер {{ baremetal-name }} с LVM из резервной копии? {#restore-lvm}

{% include [lvm-restoration-notice](../../_includes/backup/lvm-restoration-notice.md) %}

#### Проблемы с установкой агента {{ backup-name }} на ВМ с низкими вычислительными ресурсами {#low-resources-installation}

{% include [cloud-backup-resources-note](../../_includes/backup/cloud-backup-resources-note.md) %}

#### Почему размер бэкапов {{ backup-name }} в консоли не совпадает с фактическим размером самих резервных копий? {#backup-size}

Разница в размере резервных копий вызвана внутренним устройством сервиса, так как подсчет ведется по архивам, а не по самим резервным копиям.

Размер каждого архива можно посмотреть с помощью [интерфейса командной строки {{ yandex-cloud }}](../../cli/quickstart.md) — командой `yc backup backup list-archives`.

Если сложить размеры каждого архива, то получится значение, которое отображается в консоли управления.

{% note info %}

Изменение общего размера после удаления резервных копий отображается не сразу, так как требуется время для внутренних изменений в архиве.

{% endnote %}

#### Если удалить ВМ, ее резервные копии останутся? {#backup-after-delete-vm}

Да, резервные копии останутся после удаления ВМ. Резервные копии привязаны к [политике резервного копирования](../../backup/concepts/policy.md), а не к ВМ.

#### Возникает ошибка с кодом 400 при установке агента {#agent-installation-error}

Полный текст ошибки: 

```text
Cloud backup service request for registering agent failed: unexpected status code: url=<https://backup.api.cloud.yandex.net/backup/agent/v1/api/registerAgent>, status=400
```

Вероятно, агент уже привязан к другой ВМ, созданной из образа с установленным агентом.

Для решения попробуйте [переподключить виртуальную машину к {{ backup-name }}](../../backup/operations/refresh-connection.md). 

Если переподключение не помогло, [создайте запрос в техническую поддержку]({{ link-console-support }}).

#### Как посмотреть журналы использования сервиса {{ backup-name }}? {#get-logs}

В системах на базе ядра Linux, например Ubuntu, файлы журналов {{ backup-name }} можно найти по следующим путям:
* `/var/log/baas-agent-installer/log.txt`
* `/var/log/trueimage-setup.log`
* `/var/log/Acronis`

В Windows-системах журнал {{ backup-name }} находится в файле `%AppData%\BackupAgentInstaller*.log`.

Также можно собрать локальный системный отчет:
* Linux: запустите сценарий bash с привилегиями `root` для сбора отчета: `/usr/lib/Acronis/BackupAndRecovery/systeminfo`.
* Windows: запустите `C:\Program Files\Common Files\Acronis\AdvReport\systeminfo.exe`.

Более подробно об этом описано [в документации провайдера резервного копирования](https://kb.cyberprotect.ru/articles/sysinfo).

#### Возникает ошибка Unable to install agent при установке {#unable-to-install-agent}

Чаще всего ошибка возникает на этапе сборки модуля ядра `snapapi26`. Это происходит, когда версия устанавливаемого модуля не соответствует версии ядра вашей виртуальной машины.

Чтобы проверить статус агента и убедиться, что он действительно не зарегистрировался в сервисе, выполните в [{{ yandex-cloud }} CLI](../../cli/quickstart.md) команду:

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

Если вышеописанные действия не помогли решить проблему, [создайте запрос в техническую поддержку]({{ link-console-support }}). При создании запроса предоставьте следующую информацию:
* Идентификатор виртуальной машины.
* Перечисленные выше лог-файлы.

#### ВМ {{ backup-name }} долго находится в статусе «Регистрируется» {#vm-long-register}

Скорее всего, к виртуальной машине не прикреплен сервисный аккаунт. Для корректной работы {{ backup-name }} нужно [прикрепить](../../backup/operations/connect-vm-linux.md#create-sa) к виртуальной машине сервисный аккаунт с минимальной ролью `backup.user`. 

После добавления сервисного аккаунта нужно вручную [установить агент на ВМ](../../backup/operations/connect-vm-linux.md#connect-vm).
