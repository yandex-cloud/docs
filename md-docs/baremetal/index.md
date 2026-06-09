# Yandex BareMetal

Yandex BareMetal предоставляет возможность арендовать физические серверы на срок от одного дня и более, где все вычислительные ресурсы находятся полностью в вашем распоряжении.

Для создания единой инфраструктуры все арендованные физические серверы можно связывать по сети между собой, с облачной или on-premises инфраструктурой, а также с другими сервисами Yandex Cloud с помощью сервиса Cloud Interconnect.

Для заказа доступны серверы разной производительности и конфигурации: <br> <br>         <b>Готовые конфигурации</b>         <br> Выбирайте подходящий по параметрам сервер из уже собранных фиксированных конфигураций, и через несколько минут после заказа сервер будет готов к работе. Посмотреть готовые конфигурации и подобрать сервер по параметрам можно на странице сервиса Yandex BareMetal или в консоли управления. <br> <br> <b>Своя конфигурация</b> <br> Создайте собственную конфигурацию из северных компонентов, которые есть в наличии, и через несколько дней ваш сервер уже будет готов для эксплуатации. Воспользоваться конструктором для заказа такого сервера можно в консоли управления. <br> <br> <b>Конфигурация по запросу</b> <br> Если среди доступных к заказу серверов нет подходящей конфигурации, <a href="https://yandex.cloud/ru/services/baremetal#contact-form">свяжитесь с нами</a>, и мы подберем индивидуальную конфигурацию под вашу задачу.</li>

В стоимость всех серверов входят: <ul> <li>Безлимитный интернет-трафик — 1 Гбит/с.</li> <li>Автоустановка ОС и загрузка своих ISO-образов.</li> <li>Доступ по iKVM к серверу.</li> <li>Публичный IPv4-адрес.</li> <li>Подключение сервера к приватной сети — без ограничения.</li> <li>Техподдержка — 24/7.</li> <li>Замена комплектующих сервера — 24/7.</li> </ul>  

Все возможности сервиса более детально описаны в разделе <a href="concepts/index.md">Концепции</a>.

Инфраструктура Yandex Cloud <a href="https://yandex.cloud/ru/security/standards/152-fz">защищена</a> в соответствии с Федеральным законом Российской Федерации «О персональных данных» № 152-ФЗ.

Для сервиса действует <a href="https://yandex.ru/legal/cloud_sla">соглашение об уровне обслуживания</a>. 

Уровень обслуживания сервиса определен в документе <a href="https://yandex.ru/legal/cloud_sla_baremetal/ru/">Уровень обслуживания Yandex BareMetal</a>.

# Yandex BareMetal

## Начало работы

 - [Арендовать сервер готовой конфигурации](quickstart.md)

 - [Арендовать сервер в своей конфигурации](operations/servers/custom-server-lease.md)

## Пошаговые инструкции

 - [Все инструкции](operations/index.md)

### Серверы

 - [Арендовать сервер в стандартной конфигурации](operations/servers/server-lease.md)

 - [Арендовать сервер в своей конфигурации](operations/servers/custom-server-lease.md)

 - [Получить информацию о сервере](operations/servers/get-info.md)

 - [Изменить сервер](operations/servers/server-update.md)

 - [Подключиться к KVM-консоли](operations/servers/server-kvm.md)

 - [Остановить и запустить сервер](operations/servers/server-stop-and-start.md)

 - [Отказаться от аренды сервера](operations/servers/server-lease-cancel.md)

 - [Восстановить сервер из карантина](operations/servers/restore-from-quarantine.md)

 - [Загрузить свой образ ОС](operations/image-upload.md)

 - [Подключить существующий сервер BareMetal к Cloud Backup](operations/backup-baremetal.md)

 - [Воспользоваться Rescue-CD](operations/servers/rescue-boot.md)

#### Переустановить ОС сервера

 - [Переустановить ОС из образа Marketplace](operations/servers/reinstall-os-from-marketplace.md)

 - [Переустановить ОС из своего ISO-образа](operations/servers/reinstall-os-from-own-image.md)

 - [Настроить дополнительную приватную подсеть](operations/servers/set-up-tagged-vlan.md)

 - [Изменить тип сети, подключенной к сетевому интерфейсу](operations/servers/switch-network-type.md)

 - [Настроить группу агрегирования MC-LAG](operations/servers/set-up-mc-lag.md)

 - [Сбросить пароль на сервере](operations/servers/reset-password.md)

 - [Заменить диск в RAID-массиве](operations/servers/switch-raid-member.md)

 - [Добавить новый SSH-ключ пользователя](operations/servers/add-new-ssh-key.md)

 - [Восстановить загрузчик ОС](operations/servers/restore-grub.md)

 - [Проанализировать состояние сервера с помощью HWCheck](operations/servers/use-hwatcher.md)

### Сеть

 - [Создать VRF](operations/network-create.md)

 - [Создать приватную подсеть](operations/subnet-create.md)

 - [Заказать выделенную публичную подсеть](operations/reserve-public-subnet.md)

 - [Удалить выделенную публичную подсеть](operations/delete-public-subnet.md)

 - [Создать приватное соединение с облачными сетями](operations/create-vpc-connection.md)

 - [Создать статический маршрут](operations/create-static-route.md)

## Концепции

 - [Обзор сервиса](concepts/index.md)

### Серверы

 - [Обзор](concepts/servers.md)

 - [Готовые конфигурации серверов](concepts/server-configurations.md)

 - [Своя конфигурация сервера](concepts/server-custom-configurations.md)

 - [Конфигурация сервера по запросу](concepts/server-individual-configurations.md)

#### Диски и RAID

 - [Типы дисков](concepts/disks/disk-types.md)

 - [Оценка состояния дисков](concepts/smart-disk-analysis.md)

 - [RAID](concepts/disks/raid.md)

### Сеть

 - [Обзор](concepts/network.md)

 - [Публичная сеть](concepts/public-network.md)

 - [Приватная сеть](concepts/private-network.md)

 - [DHCP](concepts/dhcp.md)

 - [MC-LAG](concepts/mc-lag.md)

 - [Ограничения в сетях BareMetal](concepts/network-restrictions.md)

### Настройка и управление

 - [Обзор](concepts/control.md)

 - [Образы](concepts/images.md)

#### Аудитные логи Audit Trails

 - [Обзор](at-ref.md)

##### Справочник аудитных логов

 - [ApplyUpdatePrivateCloudConnection](events-ref/ApplyUpdatePrivateCloudConnection.md)

 - [BatchCreateServer](events-ref/BatchCreateServer.md)

 - [CreateImage](events-ref/CreateImage.md)

 - [CreatePrivateCloudConnection](events-ref/CreatePrivateCloudConnection.md)

 - [CreatePrivateSubnet](events-ref/CreatePrivateSubnet.md)

 - [CreatePublicPrefixPool](events-ref/CreatePublicPrefixPool.md)

 - [CreatePublicSubnet](events-ref/CreatePublicSubnet.md)

 - [CreateServer](events-ref/CreateServer.md)

 - [CreateVRF](events-ref/CreateVRF.md)

 - [DeleteImage](events-ref/DeleteImage.md)

 - [DeletePrivateCloudConnection](events-ref/DeletePrivateCloudConnection.md)

 - [DeletePrivateSubnet](events-ref/DeletePrivateSubnet.md)

 - [DeletePublicPrefixPool](events-ref/DeletePublicPrefixPool.md)

 - [DeletePublicSubnet](events-ref/DeletePublicSubnet.md)

 - [DeleteServer](events-ref/DeleteServer.md)

 - [DeleteVRF](events-ref/DeleteVRF.md)

 - [ExternalFlow](events-ref/ExternalFlow.md)

 - [PowerOffServer](events-ref/PowerOffServer.md)

 - [PowerOnServer](events-ref/PowerOnServer.md)

 - [RebootServer](events-ref/RebootServer.md)

 - [RegisterServerBackupAgent](events-ref/RegisterServerBackupAgent.md)

 - [ReinstallServer](events-ref/ReinstallServer.md)

 - [StartServerProlongation](events-ref/StartServerProlongation.md)

 - [StopServerProlongation](events-ref/StopServerProlongation.md)

 - [UpdateImage](events-ref/UpdateImage.md)

 - [UpdatePrivateCloudConnection](events-ref/UpdatePrivateCloudConnection.md)

 - [UpdatePrivateSubnet](events-ref/UpdatePrivateSubnet.md)

 - [UpdatePublicPrefixPool](events-ref/UpdatePublicPrefixPool.md)

 - [UpdatePublicSubnet](events-ref/UpdatePublicSubnet.md)

 - [UpdateServer](events-ref/UpdateServer.md)

 - [UpdateVRF](events-ref/UpdateVRF.md)

 - [Управление доступом](security/index.md)

 - [Дополнительные настройки серверов](concepts/server-advanced-settings.md)

 - [Консоль управления](concepts/console.md)

#### Справочник CLI (англ.)

 - [Overview](cli-ref/index.md)

##### boot-image

 - [Overview](cli-ref/boot-image/index.md)

 - [add-labels](cli-ref/boot-image/add-labels.md)

 - [create](cli-ref/boot-image/create.md)

 - [delete](cli-ref/boot-image/delete.md)

 - [get](cli-ref/boot-image/get.md)

 - [list](cli-ref/boot-image/list.md)

 - [list-operations](cli-ref/boot-image/list-operations.md)

 - [remove-labels](cli-ref/boot-image/remove-labels.md)

 - [update](cli-ref/boot-image/update.md)

##### configuration

 - [Overview](cli-ref/configuration/index.md)

 - [get](cli-ref/configuration/get.md)

 - [list](cli-ref/configuration/list.md)

##### hardware-pool

 - [Overview](cli-ref/hardware-pool/index.md)

 - [get](cli-ref/hardware-pool/get.md)

 - [list](cli-ref/hardware-pool/list.md)

##### image

 - [Overview](cli-ref/image/index.md)

 - [get](cli-ref/image/get.md)

 - [list](cli-ref/image/list.md)

##### private-cloud-connection

 - [Overview](cli-ref/private-cloud-connection/index.md)

 - [create](cli-ref/private-cloud-connection/create.md)

 - [delete](cli-ref/private-cloud-connection/delete.md)

 - [get](cli-ref/private-cloud-connection/get.md)

 - [list](cli-ref/private-cloud-connection/list.md)

 - [update](cli-ref/private-cloud-connection/update.md)

##### private-subnet

 - [Overview](cli-ref/private-subnet/index.md)

 - [add-labels](cli-ref/private-subnet/add-labels.md)

 - [create](cli-ref/private-subnet/create.md)

 - [delete](cli-ref/private-subnet/delete.md)

 - [get](cli-ref/private-subnet/get.md)

 - [list](cli-ref/private-subnet/list.md)

 - [list-operations](cli-ref/private-subnet/list-operations.md)

 - [remove-labels](cli-ref/private-subnet/remove-labels.md)

 - [update](cli-ref/private-subnet/update.md)

##### public-prefix-pool

 - [Overview](cli-ref/public-prefix-pool/index.md)

 - [get](cli-ref/public-prefix-pool/get.md)

 - [list](cli-ref/public-prefix-pool/list.md)

 - [list-operations](cli-ref/public-prefix-pool/list-operations.md)

 - [update](cli-ref/public-prefix-pool/update.md)

##### public-subnet

 - [Overview](cli-ref/public-subnet/index.md)

 - [add-labels](cli-ref/public-subnet/add-labels.md)

 - [create](cli-ref/public-subnet/create.md)

 - [delete](cli-ref/public-subnet/delete.md)

 - [get](cli-ref/public-subnet/get.md)

 - [list](cli-ref/public-subnet/list.md)

 - [list-operations](cli-ref/public-subnet/list-operations.md)

 - [remove-labels](cli-ref/public-subnet/remove-labels.md)

 - [update](cli-ref/public-subnet/update.md)

##### rental-period

 - [Overview](cli-ref/rental-period/index.md)

 - [list](cli-ref/rental-period/list.md)

##### server

 - [Overview](cli-ref/server/index.md)

 - [add-labels](cli-ref/server/add-labels.md)

 - [create](cli-ref/server/create.md)

 - [get](cli-ref/server/get.md)

 - [list](cli-ref/server/list.md)

 - [list-operations](cli-ref/server/list-operations.md)

 - [power-off](cli-ref/server/power-off.md)

 - [power-on](cli-ref/server/power-on.md)

 - [reboot](cli-ref/server/reboot.md)

 - [reinstall](cli-ref/server/reinstall.md)

 - [remove-labels](cli-ref/server/remove-labels.md)

 - [update](cli-ref/server/update.md)

##### v0

 - [Overview](cli-ref/v0/index.md)

###### boot-image

 - [Overview](cli-ref/v0/boot-image/index.md)

 - [add-labels](cli-ref/v0/boot-image/add-labels.md)

 - [create](cli-ref/v0/boot-image/create.md)

 - [delete](cli-ref/v0/boot-image/delete.md)

 - [get](cli-ref/v0/boot-image/get.md)

 - [list](cli-ref/v0/boot-image/list.md)

 - [list-operations](cli-ref/v0/boot-image/list-operations.md)

 - [remove-labels](cli-ref/v0/boot-image/remove-labels.md)

 - [update](cli-ref/v0/boot-image/update.md)

###### configuration

 - [Overview](cli-ref/v0/configuration/index.md)

 - [get](cli-ref/v0/configuration/get.md)

 - [list](cli-ref/v0/configuration/list.md)

###### hardware-pool

 - [Overview](cli-ref/v0/hardware-pool/index.md)

 - [get](cli-ref/v0/hardware-pool/get.md)

 - [list](cli-ref/v0/hardware-pool/list.md)

###### image

 - [Overview](cli-ref/v0/image/index.md)

 - [get](cli-ref/v0/image/get.md)

 - [list](cli-ref/v0/image/list.md)

###### private-cloud-connection

 - [Overview](cli-ref/v0/private-cloud-connection/index.md)

 - [create](cli-ref/v0/private-cloud-connection/create.md)

 - [delete](cli-ref/v0/private-cloud-connection/delete.md)

 - [get](cli-ref/v0/private-cloud-connection/get.md)

 - [list](cli-ref/v0/private-cloud-connection/list.md)

 - [update](cli-ref/v0/private-cloud-connection/update.md)

###### private-subnet

 - [Overview](cli-ref/v0/private-subnet/index.md)

 - [add-labels](cli-ref/v0/private-subnet/add-labels.md)

 - [create](cli-ref/v0/private-subnet/create.md)

 - [delete](cli-ref/v0/private-subnet/delete.md)

 - [get](cli-ref/v0/private-subnet/get.md)

 - [list](cli-ref/v0/private-subnet/list.md)

 - [list-operations](cli-ref/v0/private-subnet/list-operations.md)

 - [remove-labels](cli-ref/v0/private-subnet/remove-labels.md)

 - [update](cli-ref/v0/private-subnet/update.md)

###### public-prefix-pool

 - [Overview](cli-ref/v0/public-prefix-pool/index.md)

 - [get](cli-ref/v0/public-prefix-pool/get.md)

 - [list](cli-ref/v0/public-prefix-pool/list.md)

 - [list-operations](cli-ref/v0/public-prefix-pool/list-operations.md)

 - [update](cli-ref/v0/public-prefix-pool/update.md)

###### public-subnet

 - [Overview](cli-ref/v0/public-subnet/index.md)

 - [add-labels](cli-ref/v0/public-subnet/add-labels.md)

 - [create](cli-ref/v0/public-subnet/create.md)

 - [delete](cli-ref/v0/public-subnet/delete.md)

 - [get](cli-ref/v0/public-subnet/get.md)

 - [list](cli-ref/v0/public-subnet/list.md)

 - [list-operations](cli-ref/v0/public-subnet/list-operations.md)

 - [remove-labels](cli-ref/v0/public-subnet/remove-labels.md)

 - [update](cli-ref/v0/public-subnet/update.md)

###### rental-period

 - [Overview](cli-ref/v0/rental-period/index.md)

 - [list](cli-ref/v0/rental-period/list.md)

###### server

 - [Overview](cli-ref/v0/server/index.md)

 - [add-labels](cli-ref/v0/server/add-labels.md)

 - [create](cli-ref/v0/server/create.md)

 - [get](cli-ref/v0/server/get.md)

 - [list](cli-ref/v0/server/list.md)

 - [list-operations](cli-ref/v0/server/list-operations.md)

 - [power-off](cli-ref/v0/server/power-off.md)

 - [power-on](cli-ref/v0/server/power-on.md)

 - [reboot](cli-ref/v0/server/reboot.md)

 - [reinstall](cli-ref/v0/server/reinstall.md)

 - [remove-labels](cli-ref/v0/server/remove-labels.md)

 - [update](cli-ref/v0/server/update.md)

###### vrf

 - [Overview](cli-ref/v0/vrf/index.md)

 - [add-labels](cli-ref/v0/vrf/add-labels.md)

 - [create](cli-ref/v0/vrf/create.md)

 - [delete](cli-ref/v0/vrf/delete.md)

 - [get](cli-ref/v0/vrf/get.md)

 - [list](cli-ref/v0/vrf/list.md)

 - [list-operations](cli-ref/v0/vrf/list-operations.md)

 - [remove-labels](cli-ref/v0/vrf/remove-labels.md)

 - [update](cli-ref/v0/vrf/update.md)

###### zone

 - [Overview](cli-ref/v0/zone/index.md)

 - [get](cli-ref/v0/zone/get.md)

 - [list](cli-ref/v0/zone/list.md)

##### vrf

 - [Overview](cli-ref/vrf/index.md)

 - [add-labels](cli-ref/vrf/add-labels.md)

 - [create](cli-ref/vrf/create.md)

 - [delete](cli-ref/vrf/delete.md)

 - [get](cli-ref/vrf/get.md)

 - [list](cli-ref/vrf/list.md)

 - [list-operations](cli-ref/vrf/list-operations.md)

 - [remove-labels](cli-ref/vrf/remove-labels.md)

 - [update](cli-ref/vrf/update.md)

##### zone

 - [Overview](cli-ref/zone/index.md)

 - [get](cli-ref/zone/get.md)

 - [list](cli-ref/zone/list.md)

#### Справочник API

 - [Аутентификация в API](api-ref/authentication.md)

##### gRPC (англ.)

 - [Overview](api-ref/grpc/index.md)

###### Configuration

 - [Overview](api-ref/grpc/Configuration/index.md)

 - [Get](api-ref/grpc/Configuration/get.md)

 - [List](api-ref/grpc/Configuration/list.md)

###### HardwarePool

 - [Overview](api-ref/grpc/HardwarePool/index.md)

 - [Get](api-ref/grpc/HardwarePool/get.md)

 - [List](api-ref/grpc/HardwarePool/list.md)

###### Image

 - [Overview](api-ref/grpc/Image/index.md)

 - [Get](api-ref/grpc/Image/get.md)

 - [List](api-ref/grpc/Image/list.md)

 - [Create](api-ref/grpc/Image/create.md)

 - [Update](api-ref/grpc/Image/update.md)

 - [Delete](api-ref/grpc/Image/delete.md)

 - [ListOperations](api-ref/grpc/Image/listOperations.md)

###### Operation

 - [Overview](api-ref/grpc/Operation/index.md)

 - [Get](api-ref/grpc/Operation/get.md)

 - [Cancel](api-ref/grpc/Operation/cancel.md)

###### PrivateCloudConnection

 - [Overview](api-ref/grpc/PrivateCloudConnection/index.md)

 - [Get](api-ref/grpc/PrivateCloudConnection/get.md)

 - [List](api-ref/grpc/PrivateCloudConnection/list.md)

 - [Create](api-ref/grpc/PrivateCloudConnection/create.md)

 - [Update](api-ref/grpc/PrivateCloudConnection/update.md)

 - [Delete](api-ref/grpc/PrivateCloudConnection/delete.md)

###### PrivateSubnet

 - [Overview](api-ref/grpc/PrivateSubnet/index.md)

 - [Get](api-ref/grpc/PrivateSubnet/get.md)

 - [List](api-ref/grpc/PrivateSubnet/list.md)

 - [Create](api-ref/grpc/PrivateSubnet/create.md)

 - [Update](api-ref/grpc/PrivateSubnet/update.md)

 - [Delete](api-ref/grpc/PrivateSubnet/delete.md)

 - [ListOperations](api-ref/grpc/PrivateSubnet/listOperations.md)

###### PublicPrefixPool

 - [Overview](api-ref/grpc/PublicPrefixPool/index.md)

 - [Get](api-ref/grpc/PublicPrefixPool/get.md)

 - [List](api-ref/grpc/PublicPrefixPool/list.md)

 - [Update](api-ref/grpc/PublicPrefixPool/update.md)

 - [ListOperations](api-ref/grpc/PublicPrefixPool/listOperations.md)

###### PublicSubnet

 - [Overview](api-ref/grpc/PublicSubnet/index.md)

 - [Get](api-ref/grpc/PublicSubnet/get.md)

 - [List](api-ref/grpc/PublicSubnet/list.md)

 - [Create](api-ref/grpc/PublicSubnet/create.md)

 - [Update](api-ref/grpc/PublicSubnet/update.md)

 - [Delete](api-ref/grpc/PublicSubnet/delete.md)

 - [ListOperations](api-ref/grpc/PublicSubnet/listOperations.md)

###### RentalPeriod

 - [Overview](api-ref/grpc/RentalPeriod/index.md)

 - [List](api-ref/grpc/RentalPeriod/list.md)

###### Server

 - [Overview](api-ref/grpc/Server/index.md)

 - [Get](api-ref/grpc/Server/get.md)

 - [List](api-ref/grpc/Server/list.md)

 - [Create](api-ref/grpc/Server/create.md)

 - [BatchCreate](api-ref/grpc/Server/batchCreate.md)

 - [Update](api-ref/grpc/Server/update.md)

 - [PowerOff](api-ref/grpc/Server/powerOff.md)

 - [PowerOn](api-ref/grpc/Server/powerOn.md)

 - [Reboot](api-ref/grpc/Server/reboot.md)

 - [Reinstall](api-ref/grpc/Server/reinstall.md)

 - [ListOperations](api-ref/grpc/Server/listOperations.md)

 - [StartProlongation](api-ref/grpc/Server/startProlongation.md)

 - [StopProlongation](api-ref/grpc/Server/stopProlongation.md)

###### StandardImage

 - [Overview](api-ref/grpc/StandardImage/index.md)

 - [Get](api-ref/grpc/StandardImage/get.md)

 - [List](api-ref/grpc/StandardImage/list.md)

###### Storage

 - [Overview](api-ref/grpc/Storage/index.md)

 - [GetDefault](api-ref/grpc/Storage/getDefault.md)

 - [BatchGetDefault](api-ref/grpc/Storage/batchGetDefault.md)

###### Vrf

 - [Overview](api-ref/grpc/Vrf/index.md)

 - [Get](api-ref/grpc/Vrf/get.md)

 - [List](api-ref/grpc/Vrf/list.md)

 - [Create](api-ref/grpc/Vrf/create.md)

 - [Update](api-ref/grpc/Vrf/update.md)

 - [Delete](api-ref/grpc/Vrf/delete.md)

 - [ListOperations](api-ref/grpc/Vrf/listOperations.md)

###### Zone

 - [Overview](api-ref/grpc/Zone/index.md)

 - [Get](api-ref/grpc/Zone/get.md)

 - [List](api-ref/grpc/Zone/list.md)

##### REST (англ.)

 - [Overview](api-ref/index.md)

###### Configuration

 - [Overview](api-ref/Configuration/index.md)

 - [Get](api-ref/Configuration/get.md)

 - [List](api-ref/Configuration/list.md)

###### HardwarePool

 - [Overview](api-ref/HardwarePool/index.md)

 - [Get](api-ref/HardwarePool/get.md)

 - [List](api-ref/HardwarePool/list.md)

###### Image

 - [Overview](api-ref/Image/index.md)

 - [Get](api-ref/Image/get.md)

 - [List](api-ref/Image/list.md)

 - [Create](api-ref/Image/create.md)

 - [Update](api-ref/Image/update.md)

 - [Delete](api-ref/Image/delete.md)

 - [ListOperations](api-ref/Image/listOperations.md)

###### Operation

 - [Overview](api-ref/Operation/index.md)

 - [Get](api-ref/Operation/get.md)

 - [Cancel](api-ref/Operation/cancel.md)

###### PrivateCloudConnection

 - [Overview](api-ref/PrivateCloudConnection/index.md)

 - [Get](api-ref/PrivateCloudConnection/get.md)

 - [List](api-ref/PrivateCloudConnection/list.md)

 - [Create](api-ref/PrivateCloudConnection/create.md)

 - [Update](api-ref/PrivateCloudConnection/update.md)

 - [Delete](api-ref/PrivateCloudConnection/delete.md)

###### PrivateSubnet

 - [Overview](api-ref/PrivateSubnet/index.md)

 - [Get](api-ref/PrivateSubnet/get.md)

 - [List](api-ref/PrivateSubnet/list.md)

 - [Create](api-ref/PrivateSubnet/create.md)

 - [Update](api-ref/PrivateSubnet/update.md)

 - [Delete](api-ref/PrivateSubnet/delete.md)

 - [ListOperations](api-ref/PrivateSubnet/listOperations.md)

###### PublicSubnet

 - [Overview](api-ref/PublicSubnet/index.md)

 - [Get](api-ref/PublicSubnet/get.md)

 - [List](api-ref/PublicSubnet/list.md)

 - [Create](api-ref/PublicSubnet/create.md)

 - [Update](api-ref/PublicSubnet/update.md)

 - [Delete](api-ref/PublicSubnet/delete.md)

 - [ListOperations](api-ref/PublicSubnet/listOperations.md)

###### RentalPeriod

 - [Overview](api-ref/RentalPeriod/index.md)

 - [List](api-ref/RentalPeriod/list.md)

###### Server

 - [Overview](api-ref/Server/index.md)

 - [Get](api-ref/Server/get.md)

 - [List](api-ref/Server/list.md)

 - [Create](api-ref/Server/create.md)

 - [BatchCreate](api-ref/Server/batchCreate.md)

 - [Update](api-ref/Server/update.md)

 - [PowerOff](api-ref/Server/powerOff.md)

 - [PowerOn](api-ref/Server/powerOn.md)

 - [Reboot](api-ref/Server/reboot.md)

 - [Reinstall](api-ref/Server/reinstall.md)

 - [ListOperations](api-ref/Server/listOperations.md)

 - [StartProlongation](api-ref/Server/startProlongation.md)

 - [StopProlongation](api-ref/Server/stopProlongation.md)

###### StandardImage

 - [Overview](api-ref/StandardImage/index.md)

 - [Get](api-ref/StandardImage/get.md)

 - [List](api-ref/StandardImage/list.md)

###### Storage

 - [Overview](api-ref/Storage/index.md)

 - [GetDefault](api-ref/Storage/getDefault.md)

 - [BatchGetDefault](api-ref/Storage/batchGetDefault.md)

###### Vrf

 - [Overview](api-ref/Vrf/index.md)

 - [Get](api-ref/Vrf/get.md)

 - [List](api-ref/Vrf/list.md)

 - [Create](api-ref/Vrf/create.md)

 - [Update](api-ref/Vrf/update.md)

 - [Delete](api-ref/Vrf/delete.md)

 - [ListOperations](api-ref/Vrf/listOperations.md)

###### Zone

 - [Overview](api-ref/Zone/index.md)

 - [Get](api-ref/Zone/get.md)

 - [List](api-ref/Zone/list.md)

 - [Метрики Monitoring](metrics.md)

 - [Квоты и лимиты](concepts/limits.md)

## Практические руководства

 - [Все руководства](tutorials/index.md)

 - [Подключение существующего сервера BareMetal к Cloud Backup](tutorials/backup-baremetal.md)

 - [Настройка VRRP для кластера серверов BareMetal](tutorials/bms-vrf-routing.md)

 - [Организация сетевой связности в приватной подсети BareMetal](tutorials/bms-simple-subnet.md)

 - [Организация сетевой связности между приватными подсетями BareMetal и Virtual Private Cloud](tutorials/bm-vrf-and-vpc-interconnect.md)

 - [Организация сетевой связности между приватной подсетью BareMetal и on-premise-ресурсами](tutorials/bms-cic-onprem.md)

 - [Доставка USB-устройств на сервер BareMetal или виртуальную машину](tutorials/usb-over-ip.md)

 - [Настройка межсетевого экрана OPNsense в режиме кластера высокой доступности](tutorials/opnsense-failover-cluster.md)

 - [Развертывание веб-приложения на серверах BareMetal с L7-балансировщиком и защитой Smart Web Security](tutorials/webapp-on-bms-behind-sws.md)

 - [Подключение сервера BareMetal как внешнего узла к кластеру Managed Service for Kubernetes](tutorials/k8s-connect-bms-as-node.md)

 - [Настройка DNS-связности между сегментами Yandex BareMetal и Yandex Virtual Private Cloud для доступа к Managed Service for PostgreSQL по FQDN](tutorials/bm-vpc-dns-forwarder.md)

 - [Правила тарификации](pricing.md)

 - [Вопросы и ответы](qa/all.md)