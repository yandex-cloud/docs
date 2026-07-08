[Документация Yandex Cloud](../../index.md) > [Yandex Cloud Backup](../index.md) > [Концепции](index.md) > Агент Cloud Backup

# Агент Cloud Backup


Агент Cloud Backup устанавливается на [защищаемые ресурсы](index.md#protected-resources) и обеспечивает их взаимодействие с сервисом Cloud Backup и провайдером резервного копирования.

Подробнее о провайдере резервного копирования и передаваемых ему данных читайте в разделе [Активация сервиса и провайдер резервного копирования](index.md#providers).

Агент Cloud Backup выполняет на защищаемом ресурсе следующие действия:

* регистрирует защищаемый ресурс в сервисе;
* отправляет в сервис данные о статусе подключения ресурса;
* создает резервные копии ресурса согласно [политике резервного копирования](policy.md);
* восстанавливает резервную копию на ресурсе;
* отключает ресурс от сервиса.

{% note info %}

Чтобы выполнять операции в сервисе, в том числе удалять резервные копии, в [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder) должен быть хотя бы один активный защищаемый ресурс с установленным агентом Cloud Backup. Если таких ресурсов нет, на время [создайте](../operations/create-vm.md) новую ВМ Yandex Compute Cloud с подключением к Cloud Backup и выполните необходимые действия.

{% endnote %}

В зависимости от типа защищаемого ресурса агент Cloud Backup может быть установлен автоматически или вручную.

Автоматически агент можно установить на виртуальную машину Compute Cloud или сервер BareMetal при их создании, если используемый образ операционной системы поддерживает автоматическую установку агента. Вручную агент Cloud Backup может быть установлен на все типы защищаемых ресурсов.

Подробнее об установке агента на защищаемые ресурсы читайте в разделе [Подключение защищаемых ресурсов к Cloud Backup](vm-connection/index.md).

## Примеры использования {#examples}

* [Подключить сервер Yandex BareMetal к Cloud Backup](../tutorials/backup-baremetal.md)
* [Автоматическая привязка политики резервного копирования Yandex Cloud Backup к ВМ](../tutorials/vm-with-backup-policy/index.md)

#### Полезные ссылки {#see-also}

* [Подключение виртуальных машин Yandex Compute Cloud к Cloud Backup](vm-connection/compute.md)
* [Подключение серверов Yandex BareMetal к Cloud Backup](vm-connection/baremetal.md)
* [Подключение к Cloud Backup виртуальных машин и серверов, расположенных за пределами Yandex Cloud](vm-connection/external-resources.md)
* [Подключить существующую виртуальную машину на Linux к Cloud Backup](../operations/connect-vm-linux.md)
* [Подключить существующую виртуальную машину на Linux с OS Login к Cloud Backup](../operations/connect-vm-oslogin-linux.md)
* [Подключить существующую виртуальную машину на Windows Server к Cloud Backup](../operations/connect-vm-windows.md)
* [Переподключить виртуальную машину к Cloud Backup](../operations/refresh-connection.md)
* [Обновить агент Yandex Cloud Backup на виртуальной машине Yandex Compute Cloud](../operations/update-backup-agent.md)
* [Переподключить виртуальную машину на Linux с OS Login к Cloud Backup](../operations/refresh-connection-oslogin-linux.md)
* [Подключить существующий сервер Yandex BareMetal к Yandex Cloud Backup](../operations/backup-baremetal/backup-baremetal.md)
* [Переподключить сервер Yandex BareMetal к Cloud Backup](../operations/backup-baremetal/refresh-connection.md)
* [Ограничить использование агентом Cloud Backup оперативной памяти защищаемого ресурса](../operations/limit-agent-memory-usage.md)