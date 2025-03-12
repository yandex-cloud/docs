# Агент {{ backup-name }}

Агент {{ backup-name }} обеспечивает взаимодействие защищаемых ресурсов с сервисом и провайдером резервного копирования. Он устанавливается на виртуальные машины в [{{ compute-full-name }}](../../compute/index.yaml) или на серверы [{{ baremetal-full-name }}](../../baremetal/index.yaml).

Подробнее о провайдере резервного копирования и передаваемых ему данных см. в [{#T}](index.md#providers).

Агент {{ backup-name }} выполняет на защищаемом ресурсе следующие действия:

* регистрирует защищаемый ресурс в сервисе от имени [сервисного аккаунта](vm-connection.md#sa);
* отправляет в сервис данные о статусе подключения ресурса;
* создает резервные копии ресурса согласно [политике резервного копирования](policy.md);
* восстанавливает резервную копию на ресурсе;
* отключает ресурс от сервиса.

{% note info %}

Чтобы выполнять операции в сервисе, в том числе удалять резервные копии, в [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder) должен быть хотя бы один активный защищаемый ресурс (ВМ в статусе `RUNNING` или сервер {{ baremetal-name }} в статусе `READY`) с установленным агентом {{ backup-name }}. Если таких ВМ или серверов нет, на время [создайте](../operations/create-vm.md) новую ВМ с подключением к {{ backup-name }} и выполните необходимые действия.

{% endnote %}

Вы можете установить агент {{ backup-name }} на ВМ [вручную](vm-connection.md#self-install) или создать ВМ из [образов](vm-connection.md#os) {{ marketplace-full-name }} с предустановленным агентом {{ backup-name }}.

Серверы {{ baremetal-name }} поддерживают только ручную установку агента {{ backup-name }}. Подробнее см. раздел [Подключить сервер {{ baremetal-name }} к {{ backup-name }}](../operations/backup-baremetal/backup-baremetal.md).


## Примеры использования {#examples}

* [{#T}](../tutorials/backup-baremetal.md)
* [{#T}](../tutorials/vm-with-backup-policy/index.md)


#### См. также {#see-also}

* [{#T}](../operations/connect-vm-linux.md)
* [{#T}](../operations/connect-vm-oslogin-linux.md)
* [{#T}](../operations/connect-vm-windows.md)
* [{#T}](../operations/refresh-connection.md)
* [{#T}](../operations/update-backup-agent.md)
* [{#T}](../operations/refresh-connection-oslogin-linux.md)
* [{#T}](../operations/backup-baremetal/backup-baremetal.md)
* [{#T}](../operations/backup-baremetal/refresh-connection.md)