[Документация Yandex Cloud](../../index.md) > [Yandex Cloud Backup](../index.md) > Пошаговые инструкции > Все инструкции

# Пошаговые инструкции для Cloud Backup


## Управление виртуальными машинами в Cloud Backup {#connect-vm}

* [Создать виртуальную машину на Linux с подключением к Cloud Backup](create-vm.md)
* [Создать виртуальную машину Windows Server с подключением к Cloud Backup](create-vm-windows.md)
* [Переподключить виртуальную машину к Cloud Backup](refresh-connection.md)
* [Переподключить виртуальную машину на Linux с OS Login к Cloud Backup](refresh-connection-oslogin-linux.md)
* [Обновить или восстановить агент Yandex Cloud Backup на виртуальной машине](update-backup-agent.md)
* [Посмотреть статус подключения ВМ](get-connection-status.md)
* [Посмотреть журнал резервного копирования](get-journal.md)
* [Удалить виртуальную машину из Cloud Backup](delete-vm.md)

### Подключение уже существующих виртуальных машин к Cloud Backup {#connect-running-vm}

* [Подключить существующую виртуальную машину на Linux к Cloud Backup](connect-vm-linux.md)
* [Подключить существующую виртуальную машину на Linux с OS Login к Cloud Backup](connect-vm-oslogin-linux.md)
* [Подключить существующую виртуальную машину на Windows Server к Cloud Backup](connect-vm-windows.md)

## Управление серверами BareMetal в Cloud Backup {#connect-baremetal}

* [Арендовать сервер Yandex BareMetal с подключением к Cloud Backup](backup-baremetal/lease-server-with-backup.md)
* [Подключить существующий сервер Yandex BareMetal к Yandex Cloud Backup](backup-baremetal/backup-baremetal.md)
* [Переподключить сервер Yandex BareMetal к Cloud Backup](backup-baremetal/refresh-connection.md)
* [Восстановить работоспособность агента Cloud Backup после обновления ядра Linux](backup-baremetal/restore-agent.md)

## Управление политиками резервного копирования {#policy-vm}

* [Создать политику резервного копирования](policy-vm/create.md)
* [Изменить политику резервного копирования](policy-vm/update.md)
* [Привязать виртуальную машину или сервер Yandex BareMetal к политике резервного копирования](policy-vm/attach-and-detach-vm.md)
* [Получить информацию о политике резервного копирования](policy-vm/get-info.md)
* [Отвязать виртуальную машину или сервер Yandex BareMetal от политики резервного копирования](policy-vm/detach-vm.md)
* [Удалить политику резервного копирования](policy-vm/delete.md)

## Управление резервными копиями {#backup-vm}

* [Создать резервную копию виртуальной машины или сервера Yandex BareMetal](backup-vm/create.md)
* [Восстановить виртуальную машину или сервер Yandex BareMetal из резервной копии](backup-vm/recover.md)
* [Восстановить виртуальную машину или сервер BareMetal из резервной копии другой виртуальной машины или сервера BareMetal](backup-vm/non-native-recovery.md)
* [Восстановить на виртуальной машине или сервере BareMetal отдельные директории и файлы](backup-vm/recover-file-by-file.md)
* [Посмотреть параметры дисков и разделов в резервной копии](backup-vm/view-disk-layout.md)
* [Удалить резервную копию](backup-vm/delete.md)
* [Удалить все резервные копии ВМ или сервера BareMetal](backup-vm/batch-delete.md)

## Сервисные операции {#service-operations}

* [Активировать сервис](activate-service.md)
* [Ограничить использование оперативной памяти агентом Cloud Backup](limit-agent-memory-usage.md)
* [Посмотреть статистику резервного копирования](get-stats.md)
* [Настроить алерты Yandex Monium для ресурсов Yandex Cloud Backup](configure-alerts.md)

## Получение дополнительной информации {#get-additional-info}

* [Посмотреть операции с ресурсами сервиса Cloud Backup](operation-logs.md)