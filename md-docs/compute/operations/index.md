# Пошаговые инструкции для Compute Cloud

## Создание виртуальной машины {#vm-create}

* [Создать виртуальную машину из публичного образа Linux](vm-create/create-linux-vm.md)
* [Создать виртуальную машину из набора дисков](vm-create/create-from-disks.md)
* [Создать виртуальную машину с дисками из снимков](vm-create/create-from-snapshots.md)
* [Создать виртуальную машину из пользовательского образа](vm-create/create-from-user-image.md)
* [Создать виртуальную машину с пользовательским скриптом конфигурации](vm-create/create-with-cloud-init-scripts.md)
* [Создать виртуальную машину с метаданными из переменных окружения](vm-create/create-with-env-variables.md)
* [Создать ВМ с доступом к секрету Yandex Lockbox](vm-create/create-with-lockbox-secret.md)
* [Создание виртуальной машины с GPU](vm-create/create-vm-with-gpu.md)
* [Создать виртуальную машину с оборудованием поколения Gen 2](vm-create/create-gen2-vm.md)
* [Сделать виртуальную машину прерываемой](vm-create/create-preemptible-vm.md)

## DSVM {#dsvm}

* [Yandex Data Science Virtual Machine](dsvm/index.md)
* [Создание виртуальной машины из публичного образа DSVM](dsvm/quickstart.md)

## Группы размещений {#placement-groups}

* [Создать группу размещения](placement-groups/create.md)
* [Удалить группу размещения](placement-groups/delete.md)
* [Создать виртуальную машину в группе размещения](placement-groups/create-vm-in-pg.md)
* [Создать группу виртуальных машин в группе размещения](placement-groups/create-ig-in-pg.md)
* [Добавить виртуальную машину в группу размещения](placement-groups/add-vm.md)
* [Исключить виртуальную машину из группы размещения](placement-groups/delete-vm.md)
* [Получить информацию о группе размещения](placement-groups/placement-groups-get-info.md)
* [Исключить группу виртуальных машин из группы размещения](placement-groups/delete-ig-from-pg.md)
* [Настроить права доступа к группе размещения ВМ](placement-groups/access.md)

## Образы с предустановленным программным обеспечением {#images-with-pre-installed-software}

* [Создать виртуальную машину из публичного образа](images-with-pre-installed-software/create.md)
* [Настройка программного обеспечения](images-with-pre-installed-software/setup.md)
* [Работа с виртуальной машиной на базе публичного образа](images-with-pre-installed-software/operate.md)
* [Получить список публичных образов](images-with-pre-installed-software/get-list.md)
* [Получить информацию о публичном образе](images-with-pre-installed-software/get-info.md)

## Получение информации о виртуальных машинах {#vm-info}

* [Получить информацию о виртуальной машине](vm-info/get-info.md)
* [Получить вывод последовательного порта](vm-info/get-serial-port-output.md)

## Управление виртуальной машиной {#vm-control}

* [Остановить, запустить или перезапустить виртуальную машину](vm-control/vm-stop-and-start.md)
* [Сбросить пароль пользователя на виртуальной машине Windows Server](vm-control/vm-reset-password.md)
* [Подключить диск к виртуальной машине](vm-control/vm-attach-disk.md)
* [Отключить диск от виртуальной машины](vm-control/vm-detach-disk.md)
* [Перенести виртуальную машину в другую зону доступности](vm-control/vm-change-zone.md)
* [Перенести виртуальную машину в другой каталог](vm-control/vm-change-folder.md)
* [Перенести виртуальную машину в другое облако](vm-control/vm-change-cloud.md)
* [Добавить дополнительный сетевой интерфейс на виртуальную машину](vm-control/attach-network-interface.md)
* [Удалить сетевой интерфейс на виртуальной машине](vm-control/detach-network-interface.md)
* [Привязать к виртуальной машине публичный IP-адрес](vm-control/vm-attach-public-ip.md)
* [Перенести публичный IP-адрес от одной ВМ на другую](vm-control/vm-transferring-public-ip.md)
* [Отвязать публичный IP-адрес от виртуальной машины](vm-control/vm-detach-public-ip.md)
* [Сделать публичный IP-адрес виртуальной машины статическим](vm-control/vm-set-static-ip.md)
* [Изменить виртуальную машину](vm-control/vm-update.md)
* [Изменить вычислительные ресурсы виртуальной машины](vm-control/vm-update-resources.md)
* [Изменить группы безопасности сетевого интерфейса виртуальной машины](vm-control/vm-change-security-groups-set.md)
* [Подключить сервисный аккаунт к ВМ](vm-control/vm-connect-sa.md)
* [Настроить права доступа к виртуальной машине](vm-control/vm-access.md)
* [Удалить виртуальную машину](vm-control/vm-delete.md)
* [Управлять техническим обслуживанием виртуальных машин с GPU](vm-control/gpus-maintenance.md)

## Работа с метаданными виртуальной машины {#use-metadata}

* [Настроить параметры сервиса метаданных ВМ](vm-metadata/setup-metadata-service.md)
* [Получить метаданные виртуальной машины](vm-metadata/get-vm-metadata.md)
* [Получить идентификационный документ виртуальной машины](vm-metadata/get-identity-document.md)
* [Изменить метаданные виртуальной машины](vm-metadata/update-vm-metadata.md)
* [Создать виртуальную машину с пользовательским скриптом конфигурации](vm-create/create-with-cloud-init-scripts.md)
* [Создать виртуальную машину с метаданными из переменных окружения](vm-create/create-with-env-variables.md)
* [Создать ВМ с доступом к секрету Yandex Lockbox](vm-create/create-with-lockbox-secret.md)

## Работа на виртуальной машине {#vm-use}

* [Подключиться к виртуальной машине Linux по SSH](vm-connect/ssh.md)
* [Подключиться к виртуальной машине Linux по SSH с помощью Yandex Cloud Shell](vm-connect/cloud-shell.md)
* [Подключиться к виртуальной машине Windows по RDP](vm-connect/rdp.md)
* [Подключиться к виртуальной машине Windows через PowerShell](vm-connect/powershell.md)
* [Создать виртуальную машину с OS Login](vm-connect/os-login-create-vm.md)
* [Настроить доступ по OS Login на существующей ВМ](vm-connect/enable-os-login.md)
* [Экспортировать SSH-сертификат](vm-connect/os-login-export-certificate.md)
* [Подключиться к виртуальной машине по OS Login](vm-connect/os-login.md)
* [Работа с Yandex Cloud изнутри виртуальной машины](vm-connect/auth-inside-vm.md)
* [Установка NVIDIA-драйверов](vm-operate/install-nvidia-drivers.md)
* [Восстановление доступа к виртуальной машине](vm-connect/recovery-access.md)

## Управление агентом для сброса паролей {#guest-agent}

* [Проверить работу агента для сброса паролей на виртуальной машине Windows Server](vm-guest-agent/check.md)
* [Установить агент для сброса паролей на виртуальную машину Windows Server](vm-guest-agent/install.md)
* [Сбросить пароль администратора Windows Server](vm-guest-agent/reset-password.md)
* [Удалить агент для сброса паролей с виртуальной машины Windows Server](vm-guest-agent/uninstall.md)

## Создание диска {#disk-create}

* [Создать пустой диск](disk-create/empty.md)
* [Создать пустой диск с блоком большого размера](disk-create/empty-disk-blocksize.md)
* [Создать нереплицируемый диск](disk-create/nonreplicated.md)
* [Создать сверхбыстрое сетевое хранилище с тремя репликами (SSD)](disk-create/ssd-io.md)
* [Восстановить диск с помощью снимка](disk-create/from-snapshot.md)
* [Восстановить диск с помощью образа](disk-create/from-image.md)

## Управление диском {#disk-control}

* [Изменить диск](disk-control/update.md)
* [Настроить создание снимков диска по расписаниям](disk-control/configure-schedule.md)
* [Перенести диск в другой каталог](disk-control/disk-change-folder.md)
* [Перенести диск в другую зону доступности](disk-control/disk-change-zone.md)
* [Зашифровать диск](disk-control/disk-encrypt.md)
* [Получить информацию о диске](disk-control/get-info.md)
* [Настроить права доступа к диску](disk-control/disk-access.md)
* [Удалить диск](disk-control/delete.md)

## Снимки дисков {#snapshots}

* [Создать снимок диска](disk-control/create-snapshot.md)
* [Получить информацию о снимке диска](snapshot-control/get-snapshot.md)
* [Удалить снимок диска](snapshot-control/delete.md)
* [Создать расписание, по которому будут создаваться снимки дисков](snapshot-control/create-schedule.md)
* [Получить информацию о расписании, по которому создаются снимки дисков](snapshot-control/get-snapshot-schedule.md)
* [Изменить расписание, по которому создаются снимки дисков](snapshot-control/update-schedule.md)
* [Остановить и запустить расписание, по которому создаются снимки дисков](snapshot-control/stop-and-start-schedule.md)
* [Зашифровать снимок](snapshot-control/snapshot-encrypt.md)
* [Настроить права доступа к снимку диска](snapshot-control/snapshot-access.md)
* [Настроить права доступа к расписанию снимков диска](snapshot-control/snapshot-schedule-access.md)
* [Удалить расписание, по которому создаются снимки дисков](snapshot-control/delete-schedule.md)

## Группы размещения дисков {#placement-groups}

* [Создать группу размещения дисков](disk-placement-groups/create.md)
* [Добавить диск в группу размещения](disk-placement-groups/add-disk.md)
* [Получить информацию о группе размещения дисков](disk-placement-groups/get-info.md)
* [Настроить права доступа к группе размещения нереплицируемых дисков](disk-placement-groups/access.md)
* [Удалить диск из группы размещения](disk-placement-groups/remove-disk.md)

## Создание образа {#image-create}

* [Подготовить свой образ диска](image-create/custom-image.md)
* [Загрузить свой образ диска в Yandex Cloud](image-create/upload.md)
* [Создать образ из диска](image-create/create-from-disk.md)
* [Создать образ из снимка диска](image-create/create-from-snapshot.md)
* [Создать образ из другого пользовательского образа](image-create/create-from-image.md)

## Управление образом {#image-control}

* [Получить список образов дисков](image-control/get-list.md)
* [Получить информацию об образе диска](image-control/image-control-get-info.md)
* [Импортировать образ из другого облака или каталога](image-control/import.md)
* [Зашифровать образ](image-control/encrypt.md)
* [Настроить права доступа к образу](image-control/access.md)
* [Удалить образ диска](image-control/delete.md)

## Файловые хранилища {#filesystem}

* [Создать файловое хранилище](filesystem/create.md)
* [Подключить файловое хранилище к виртуальной машине](filesystem/attach-to-vm.md)
* [Отключить файловое хранилище от виртуальной машины](filesystem/detach-from-vm.md)
* [Изменить файловое хранилище](filesystem/update.md)
* [Получить информацию о файловом хранилище](filesystem/get-info.md)
* [Настроить права доступа к файловому хранилищу](filesystem/filesystem-access.md)
* [Удалить файловое хранилище](filesystem/delete.md)

## Управление серийной консолью {#serial-console}

* [Управлять доступом к серийной консоли](serial-console/index.md)
* [Подключиться к серийной консоли виртуальной машины с ОС Linux](serial-console/connect-ssh.md)
* [Подключиться к серийной консоли виртуальной машины с ОС Windows](serial-console/windows-sac.md)

## Создание группы виртуальных машин {#ig-create}

* [Создать группу виртуальных машин фиксированного размера](instance-groups/create-fixed-group.md)
* [Создать группу виртуальных машин фиксированного размера с сетевым балансировщиком нагрузки](instance-groups/create-with-balancer.md)
* [Создать группу виртуальных машин фиксированного размера с L7-балансировщиком](instance-groups/create-with-load-balancer.md)
* [Создать автоматически масштабируемую группу виртуальных машин](instance-groups/create-autoscaled-group.md)
* [Создать группу ВМ с Container Optimized Image в Compute Cloud](instance-groups/create-with-coi.md)
* [Создать группу виртуальных машин по спецификации в формате YAML](instance-groups/create-from-yaml.md)
* [Создать группу виртуальных машин в группе размещения](placement-groups/create-ig-in-pg.md)
* [Создать группу виртуальных машин с фиксированными IP-адресами](instance-groups/create-with-fixed-ip.md)
* [Создать группу виртуальных машин с подключением к файловому хранилищу](instance-groups/create-with-filesystem.md)
* [Создать группу виртуальных машин с подключением к Yandex Object Storage](instance-groups/create-with-bucket.md)

## Получение информации о группе виртуальных машин {#ig-info}

* [Получить список групп виртуальных машин](instance-groups/get-list.md)
* [Получить информацию о группе виртуальных машин](instance-groups/get-info.md)
* [Получить список виртуальных машин в группе](instance-groups/get-list-instances.md)

## Управление группой виртуальных машин {#ig-control}

* [Изменить группу виртуальных машин](instance-groups/update.md)
* [Изменить группу виртуальных машин по спецификации в формате YAML](instance-groups/update-from-yaml.md)
* [Отключить и включить зоны доступности для группы ВМ Yandex Compute Cloud](instance-groups/disable-enable-zone.md)
* [Перенести группу виртуальных машин в другую зону доступности](instance-groups/move-group.md)
* [Перенести группу виртуальных машин с сетевым балансировщиком нагрузки в другую зону доступности](instance-groups/move-group-with-nlb.md)
* [Перенести группу виртуальных машин с L7-балансировщиком в другую зону доступности](instance-groups/move-group-with-alb.md)
* [Настроить проверку состояния приложения на ВМ](instance-groups/enable-autohealing.md)
* [Постепенное обновление](instance-groups/deploy/rolling-update.md)
* [Обновление без простоя](instance-groups/deploy/zero-downtime.md)
* [Приостановка процессов в группе виртуальных машин](instance-groups/pause-processes.md)
* [Возобновление процессов в группе виртуальных машин](instance-groups/resume-processes.md)
* [Поочередно перезагрузить виртуальные машины в группе](instance-groups/rolling-restart.md)
* [Поочередно пересоздать виртуальные машины в группе](instance-groups/rolling-recreate.md)
* [Включить защиту от удаления для группы виртуальных машин Compute Cloud](instance-groups/enable-deletion-protection.md)
* [Остановить группу виртуальных машин](instance-groups/stop.md)
* [Запустить группу виртуальных машин](instance-groups/start.md)
* [Настроить права доступа к группе виртуальных машин](instance-groups/access.md)
* [Удалить группу виртуальных машин](instance-groups/delete.md)
* [Исключить группу виртуальных машин из группы размещения](placement-groups/delete-ig-from-pg.md)

## Выделенные хосты {#dedicated-host}

* [Создание группы выделенных хостов](dedicated-host/create-host-group.md)
* [Создание виртуальной машины в группе выделенных хостов](dedicated-host/running-host-group-vms.md)
* [Создание виртуальной машины на выделенном хосте](dedicated-host/running-host-vms.md)
* [Настроить права доступа к группе выделенных хостов](dedicated-host/access.md)

## Пулы резервов ВМ {#reserved-pools}

* [Создание пула резервов виртуальных машин](reserved-pools/create-reserved-pool.md)
* [Изменение пула резервов виртуальных машин](reserved-pools/update-reserved-pool.md)
* [Удаление пула резервов виртуальных машин](reserved-pools/delete-reserved-pool.md)
* [Управление виртуальными машинами пула резервов ВМ](reserved-pools/manage-pool-vms.md)


## Кластеры GPU {#gpu-cluster}

* [Создать кластер GPU](gpu-cluster/gpu-cluster-create.md)
* [Добавить виртуальную машину в кластер GPU](gpu-cluster/gpu-add-to-cluster.md)
* [Изменить кластер GPU](gpu-cluster/gpu-cluster-update.md)
* [Удалить кластер GPU](gpu-cluster/gpu-cluster-delete.md)
* [Получить информацию о кластере GPU](gpu-cluster/gpu-cluster-get-info.md)
* [Настроить права доступа к кластеру GPU](gpu-cluster/access.md)
* [Проверить физическое состояние кластера GPU](gpu-cluster/gpu-cluster-test-physical-state.md)
* [Запустить параллельные задачи в кластере GPU](gpu-cluster/gpu-cluster-mpirun-parallel.md)
* [Проверить пропускную способность InfiniBand](gpu-cluster/test-infiniband-bandwidth.md)


## Получение дополнительной информации {#get-additional-info}

* [Посмотреть операции с ресурсами сервиса Compute Cloud](operation-logs.md)
* [Посмотреть метрики в Yandex Monitoring](metrics-pull.md)
* [Рекомендации по обновлению драйверов NVIDIA](gpu-driver-update.md)