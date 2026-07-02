[Документация Yandex Cloud](../../index.md) > [Yandex Cloud Backup](../index.md) > [Концепции](index.md) > Агент Cloud Backup

# Агент Cloud Backup


Агент Cloud Backup обеспечивает взаимодействие защищаемых ресурсов с сервисом и провайдером резервного копирования. Он устанавливается на виртуальные машины в [Yandex Compute Cloud](../../compute/index.md) или на серверы [Yandex BareMetal](../../baremetal/index.md).

Подробнее о провайдере резервного копирования и передаваемых ему данных в разделе [Активация сервиса и провайдер резервного копирования](index.md#providers).

Агент Cloud Backup выполняет на защищаемом ресурсе следующие действия:

* регистрирует защищаемый ресурс в сервисе от имени [сервисного аккаунта](vm-connection.md#sa);
* отправляет в сервис данные о статусе подключения ресурса;
* создает резервные копии ресурса согласно [политике резервного копирования](policy.md);
* восстанавливает резервную копию на ресурсе;
* отключает ресурс от сервиса.

{% note info %}

Чтобы выполнять операции в сервисе, в том числе удалять резервные копии, в [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder) должен быть хотя бы один активный защищаемый ресурс (ВМ в статусе `RUNNING` или сервер BareMetal в статусе `READY`) с установленным агентом Cloud Backup. Если таких ВМ или серверов нет, на время [создайте](../operations/create-vm.md) новую ВМ с подключением к Cloud Backup и выполните необходимые действия.

{% endnote %}

Вы можете установить агент Cloud Backup на ВМ [вручную](vm-connection.md#self-install) или создать ВМ из [образов](vm-connection.md#os) Yandex Cloud Marketplace с предустановленным агентом Cloud Backup.

Серверы BareMetal поддерживают только ручную установку агента Cloud Backup. Подробнее в разделе [Подключить сервер BareMetal к Cloud Backup](../operations/backup-baremetal/backup-baremetal.md).


## Примеры использования {#examples}

* [Подключить сервер Yandex BareMetal к Cloud Backup](../tutorials/backup-baremetal.md)
* [Автоматическая привязка политики резервного копирования Yandex Cloud Backup к ВМ](../tutorials/vm-with-backup-policy/index.md)


#### Полезные ссылки {#see-also}

* [Подключить существующую виртуальную машину на Linux к Cloud Backup](../operations/connect-vm-linux.md)
* [Подключить существующую виртуальную машину на Linux с OS Login к Cloud Backup](../operations/connect-vm-oslogin-linux.md)
* [Подключить существующую виртуальную машину на Windows Server к Cloud Backup](../operations/connect-vm-windows.md)
* [Переподключить виртуальную машину к Cloud Backup](../operations/refresh-connection.md)
* [Обновить или восстановить агент Yandex Cloud Backup на виртуальной машине](../operations/update-backup-agent.md)
* [Переподключить виртуальную машину на Linux с OS Login к Cloud Backup](../operations/refresh-connection-oslogin-linux.md)
* [Подключить существующий сервер Yandex BareMetal к Yandex Cloud Backup](../operations/backup-baremetal/backup-baremetal.md)
* [Переподключить сервер Yandex BareMetal к Cloud Backup](../operations/backup-baremetal/refresh-connection.md)
* [Ограничить использование оперативной памяти агентом Cloud Backup](../operations/limit-agent-memory-usage.md)