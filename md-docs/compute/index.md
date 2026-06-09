# Yandex Compute Cloud

Сервис Yandex Compute Cloud предоставляет масштабируемые вычислительные мощности для создания виртуальных машин и управления ими.  Сервис поддерживает <a href="concepts/preemptible-vm.md">прерываемые</a> виртуальные машины, а также отказоустойчивые <a href="concepts/instance-groups/index.md">группы виртуальных машин</a>.

Вы можете подключать к виртуальным машинам диски с образами на базе OC Linux, доступные в <a href="https://yandex.cloud/ru/marketplace">Marketplace</a>. Каждый диск автоматически реплицируется внутри своей зоны доступности, что обеспечивает надежное хранение данных. Также, для удобного переноса данных с одного диска на другой, Compute Cloud поддерживает <a href="concepts/snapshot.md">снимки дисков</a>.

Инфраструктура Yandex Cloud <a href="https://storage.yandexcloud.net/yc-compliance/conformance_ru_pdp.pdf">защищена</a> в соответствии с Федеральным законом Российской Федерации «О персональных данных» № 152-ФЗ.

Для сервиса действует <a href="https://yandex.ru/legal/cloud_sla">соглашение об уровне обслуживания</a>.  Уровень обслуживания сервиса определен в документе <a href="https://yandex.ru/legal/cloud_sla_compute">Уровень обслуживания Yandex Compute Cloud</a>.

# Yandex Compute Cloud

## Начало работы

 - [Обзор](quickstart/index.md)

 - [Создание виртуальной машины Linux](quickstart/quick-create-linux.md)

 - [Создание группы виртуальных машин](quickstart/ig.md)

## Пошаговые инструкции

 - [Все инструкции](operations/index.md)

### Создание виртуальной машины

 - [Создать ВМ Linux](operations/vm-create/create-linux-vm.md)

 - [Создать ВМ из набора дисков](operations/vm-create/create-from-disks.md)

 - [Создать ВМ с дисками из снимков](operations/vm-create/create-from-snapshots.md)

 - [Создать ВМ из пользовательского образа](operations/vm-create/create-from-user-image.md)

 - [Создать ВМ с пользовательским скриптом конфигурации](operations/vm-create/create-with-cloud-init-scripts.md)

 - [Создать ВМ с метаданными из переменных окружения](operations/vm-create/create-with-env-variables.md)

 - [Создать ВМ с доступом к секрету Yandex Lockbox](operations/vm-create/create-with-lockbox-secret.md)

 - [Создать ВМ с GPU](operations/vm-create/create-vm-with-gpu.md)

 - [Создать ВМ с оборудованием поколения Gen 2](operations/vm-create/create-gen2-vm.md)

 - [Сделать ВМ прерываемой](operations/vm-create/create-preemptible-vm.md)

### DSVM

 - [Обзор](operations/dsvm/index.md)

 - [Создать ВМ из публичного образа DSVM](operations/dsvm/quickstart.md)

### Группы размещения

 - [Создать группу размещения](operations/placement-groups/create.md)

 - [Удалить группу размещения](operations/placement-groups/delete.md)

 - [Создать ВМ в группе размещения](operations/placement-groups/create-vm-in-pg.md)

 - [Создать группу виртуальных машин в группе размещения](operations/placement-groups/create-ig-in-pg.md)

 - [Добавить ВМ в группу размещения](operations/placement-groups/add-vm.md)

 - [Исключить ВМ из группы размещения](operations/placement-groups/delete-vm.md)

 - [Получить информацию о группе размещения](operations/placement-groups/placement-groups-get-info.md)

 - [Исключить группу виртуальных машин из группы размещения](operations/placement-groups/delete-ig-from-pg.md)

 - [Настроить права доступа к группе размещения ВМ](operations/placement-groups/access.md)

### Образы с предустановленным ПО

 - [Создать ВМ из публичного образа](operations/images-with-pre-installed-software/create.md)

 - [Настроить ПО](operations/images-with-pre-installed-software/setup.md)

 - [Работа с ВМ на базе публичного образа](operations/images-with-pre-installed-software/operate.md)

 - [Получить список публичных образов](operations/images-with-pre-installed-software/get-list.md)

 - [Получить информацию о публичном образе](operations/images-with-pre-installed-software/get-info.md)

### Получение информации о виртуальной машине

 - [Получить информацию о ВМ](operations/vm-info/get-info.md)

 - [Получить вывод последовательного порта](operations/vm-info/get-serial-port-output.md)

### Управление виртуальной машиной

 - [Остановить и запустить ВМ](operations/vm-control/vm-stop-and-start.md)

 - [Сбросить пароль пользователя ВМ Windows Server](operations/vm-control/vm-reset-password.md)

 - [Подключить диск к ВМ](operations/vm-control/vm-attach-disk.md)

 - [Отключить диск от ВМ](operations/vm-control/vm-detach-disk.md)

 - [Перенести ВМ в другую зону доступности](operations/vm-control/vm-change-zone.md)

 - [Перенести ВМ в другой каталог](operations/vm-control/vm-change-folder.md)

 - [Перенести ВМ в другое облако](operations/vm-control/vm-change-cloud.md)

 - [Добавить на ВМ дополнительный сетевой интерфейс](operations/vm-control/attach-network-interface.md)

 - [Удалить сетевой интерфейс на ВМ](operations/vm-control/detach-network-interface.md)

 - [Привязать к ВМ публичный IP-адрес](operations/vm-control/vm-attach-public-ip.md)

 - [Отвязать от ВМ публичный IP-адрес](operations/vm-control/vm-detach-public-ip.md)

 - [Сделать публичный IP-адрес ВМ статическим](operations/vm-control/vm-set-static-ip.md)

 - [Перенести публичный IP-адрес от одной ВМ на другую](operations/vm-control/vm-transferring-public-ip.md)

 - [Изменить внутренний IP-адрес ВМ](operations/vm-control/internal-ip-update.md)

 - [Изменить ВМ](operations/vm-control/vm-update.md)

 - [Изменить вычислительные ресурсы ВМ](operations/vm-control/vm-update-resources.md)

 - [Изменить группы безопасности ВМ](operations/vm-control/vm-change-security-groups-set.md)

 - [Управление политикой обслуживания ВМ](operations/vm-control/vm-update-policies.md)

 - [Настроить права доступа к ВМ](operations/vm-control/vm-access.md)

 - [Подключить сервисный аккаунт к ВМ](operations/vm-control/vm-connect-sa.md)

 - [Управлять техническим обслуживанием ВМ с GPU](operations/vm-control/gpus-maintenance.md)

 - [Удалить ВМ](operations/vm-control/vm-delete.md)

### Работа с метаданными ВМ

 - [Настроить параметры сервиса метаданных](operations/vm-metadata/setup-metadata-service.md)

 - [Получить метаданные ВМ](operations/vm-metadata/get-vm-metadata.md)

 - [Получить идентификационный документ ВМ](operations/vm-metadata/get-identity-document.md)

 - [Изменить метаданные ВМ](operations/vm-metadata/update-vm-metadata.md)

 - [Создать ВМ с пользовательским скриптом конфигурации](operations/vm-create/create-with-cloud-init-scripts.md)

 - [Создать ВМ с метаданными из переменных окружения](operations/vm-create/create-with-env-variables.md)

 - [Создать ВМ с доступом к секрету Yandex Lockbox](operations/vm-create/create-with-lockbox-secret.md)

### Работа на виртуальной машине

 - [Подключиться к ВМ по SSH](operations/vm-connect/ssh.md)

 - [Подключиться к ВМ по SSH с помощью Cloud Shell](operations/vm-connect/cloud-shell.md)

 - [Обмен файлами с ВМ](operations/vm-connect/scp-sftp.md)

 - [Подключиться к ВМ по RDP](operations/vm-connect/rdp.md)

 - [Подключиться к ВМ через PowerShell](operations/vm-connect/powershell.md)

#### OS Login

 - [Создать ВМ с OS Login](operations/vm-connect/os-login-create-vm.md)

 - [Настроить OS Login на существующей ВМ](operations/vm-connect/enable-os-login.md)

 - [Экспортировать SSH-сертификат](operations/vm-connect/os-login-export-certificate.md)

 - [Подключиться к ВМ по OS Login](operations/vm-connect/os-login.md)

 - [Работа с Yandex Cloud изнутри ВМ](operations/vm-connect/auth-inside-vm.md)

 - [Установить NVIDIA-драйверы](operations/vm-operate/install-nvidia-drivers.md)

 - [Восстановить доступ к ВМ](operations/vm-connect/recovery-access.md)

### Управление агентом для сброса паролей

 - [Проверить работу агента](operations/vm-guest-agent/check.md)

 - [Установить агент](operations/vm-guest-agent/install.md)

 - [Сбросить пароль администратора](operations/vm-guest-agent/reset-password.md)

 - [Удалить агент](operations/vm-guest-agent/uninstall.md)

### Создание диска

 - [Создать пустой диск](operations/disk-create/empty.md)

 - [Создать пустой диск с блоком большого размера](operations/disk-create/empty-disk-blocksize.md)

 - [Создать нереплицируемый диск](operations/disk-create/nonreplicated.md)

 - [Создать высокопроизводительный SSD-диск](operations/disk-create/ssd-io.md)

 - [Восстановить диск с помощью снимка](operations/disk-create/from-snapshot.md)

 - [Восстановить диск с помощью образа](operations/disk-create/from-image.md)

### Управление диском

 - [Изменить диск](operations/disk-control/update.md)

 - [Настроить создание снимков диска по расписаниям](operations/disk-control/configure-schedule.md)

 - [Перенести диск в другой каталог](operations/disk-control/disk-change-folder.md)

 - [Перенести диск в другую зону доступности](operations/disk-control/disk-change-zone.md)

 - [Зашифровать диск](operations/disk-control/disk-encrypt.md)

 - [Получить информацию о диске](operations/disk-control/get-info.md)

 - [Настроить права доступа к диску](operations/disk-control/disk-access.md)

 - [Удалить диск](operations/disk-control/delete.md)

### Снимки дисков

 - [Создать снимок](operations/disk-control/create-snapshot.md)

 - [Получить информацию о снимке диска](operations/snapshot-control/get-snapshot.md)

 - [Удалить снимок](operations/snapshot-control/delete.md)

 - [Создать расписание снимков](operations/snapshot-control/create-schedule.md)

 - [Получить информацию о расписании, по которому создаются снимки дисков](operations/snapshot-control/get-snapshot-schedule.md)

 - [Изменить расписание снимков](operations/snapshot-control/update-schedule.md)

 - [Остановить и запустить расписание снимков](operations/snapshot-control/stop-and-start-schedule.md)

 - [Зашифровать снимок](operations/snapshot-control/snapshot-encrypt.md)

 - [Настроить права доступа к снимку диска](operations/snapshot-control/snapshot-access.md)

 - [Настроить права доступа к расписанию снимков](operations/snapshot-control/snapshot-schedule-access.md)

 - [Удалить расписание снимков](operations/snapshot-control/delete-schedule.md)

### Группы размещения дисков

 - [Создать группу размещения дисков](operations/disk-placement-groups/create.md)

 - [Добавить диск в группу размещения](operations/disk-placement-groups/add-disk.md)

 - [Получить информацию о группе размещения дисков](operations/disk-placement-groups/get-info.md)

 - [Настроить права доступа к группе размещения дисков](operations/disk-placement-groups/access.md)

 - [Удалить диск из группы размещения](operations/disk-placement-groups/remove-disk.md)

### Создание образа

 - [Подготовить образ диска](operations/image-create/custom-image.md)

 - [Загрузить свой образ](operations/image-create/upload.md)

 - [Создать образ из диска](operations/image-create/create-from-disk.md)

 - [Создать образ из снимка диска](operations/image-create/create-from-snapshot.md)

 - [Создать образ из другого пользовательского образа](operations/image-create/create-from-image.md)

### Управление образом

 - [Получить список образов](operations/image-control/get-list.md)

 - [Получить информацию об образе](operations/image-control/image-control-get-info.md)

 - [Импортировать образ из другого облака или каталога](operations/image-control/import.md)

 - [Зашифровать образ](operations/image-control/encrypt.md)

 - [Настроить права доступа к образу](operations/image-control/access.md)

 - [Удалить образ](operations/image-control/delete.md)

### Файловые хранилища

 - [Создать файловое хранилище](operations/filesystem/create.md)

 - [Подключить файловое хранилище к ВМ](operations/filesystem/attach-to-vm.md)

 - [Отключить файловое хранилище от ВМ](operations/filesystem/detach-from-vm.md)

 - [Изменить файловое хранилище](operations/filesystem/update.md)

 - [Получить информацию о файловом хранилище](operations/filesystem/get-info.md)

 - [Настроить права доступа к файловому хранилищу](operations/filesystem/filesystem-access.md)

 - [Удалить файловое хранилище](operations/filesystem/delete.md)

### Серийная консоль

 - [Управлять доступом к серийной консоли](operations/serial-console/index.md)

 - [Подключиться к серийной консоли ВМ с ОС Linux](operations/serial-console/connect-ssh.md)

 - [Подключиться к серийной консоли ВМ с ОС Windows](operations/serial-console/windows-sac.md)

### Создание группы виртуальных машин

 - [Создать группу ВМ фиксированного размера](operations/instance-groups/create-fixed-group.md)

 - [Создать группу ВМ фиксированного размера с сетевым балансировщиком](operations/instance-groups/create-with-balancer.md)

 - [Создать группу ВМ фиксированного размера с L7-балансировщиком](operations/instance-groups/create-with-load-balancer.md)

 - [Создать автоматически масштабируемую группу ВМ](operations/instance-groups/create-autoscaled-group.md)

 - [Создать группу ВМ с Container Optimized Image](operations/instance-groups/create-with-coi.md)

 - [Создать группу ВМ по YAML-спецификации](operations/instance-groups/create-from-yaml.md)

 - [Создать группу ВМ с привязкой к пулу резервов ВМ](operations/instance-groups/create-group-with-pool.md)

 - [Создать группу ВМ в группе размещения](operations/placement-groups/create-ig-in-pg.md)

 - [Создать группу ВМ с фиксированными IP-адресами](operations/instance-groups/create-with-fixed-ip.md)

 - [Создать группу ВМ с подключением к файловому хранилищу](operations/instance-groups/create-with-filesystem.md)

 - [Создать группу ВМ с подключением к Object Storage](operations/instance-groups/create-with-bucket.md)

### Получение информации о группе виртуальных машин

 - [Получить список групп ВМ](operations/instance-groups/get-list.md)

 - [Получить информацию о группе ВМ](operations/instance-groups/get-info.md)

 - [Получить список ВМ в группе](operations/instance-groups/get-list-instances.md)

### Управление группой виртуальных машин

 - [Изменить группу ВМ](operations/instance-groups/update.md)

 - [Изменить группу ВМ по YAML-спецификации](operations/instance-groups/update-from-yaml.md)

 - [Включить защиту от удаления](operations/instance-groups/enable-deletion-protection.md)

 - [Отключить и включить зоны доступности для группы ВМ](operations/instance-groups/disable-enable-zone.md)

 - [Перенести группу ВМ в другую зону доступности](operations/instance-groups/move-group.md)

 - [Перенести группу ВМ с сетевым балансировщиком в другую зону доступности](operations/instance-groups/move-group-with-nlb.md)

 - [Перенести группу ВМ с L7-балансировщиком в другую зону доступности](operations/instance-groups/move-group-with-alb.md)

 - [Настроить проверку состояния приложения на ВМ](operations/instance-groups/enable-autohealing.md)

#### Обновить группу

 - [Постепенное обновление](operations/instance-groups/deploy/rolling-update.md)

 - [Обновление без простоя](operations/instance-groups/deploy/zero-downtime.md)

 - [Приостановить процессы в группе ВМ](operations/instance-groups/pause-processes.md)

 - [Возобновить процессы в группе ВМ](operations/instance-groups/resume-processes.md)

 - [Поочередно перезагрузить ВМ в группе](operations/instance-groups/rolling-restart.md)

 - [Поочередно пересоздать ВМ в группе](operations/instance-groups/rolling-recreate.md)

 - [Остановить группу ВМ](operations/instance-groups/stop.md)

 - [Запустить группу ВМ](operations/instance-groups/start.md)

 - [Настроить права доступа к группе ВМ](operations/instance-groups/access.md)

 - [Исключить группу виртуальных машин из группы размещения](operations/placement-groups/delete-ig-from-pg.md)

 - [Удалить группу ВМ](operations/instance-groups/delete.md)

### Выделенные хосты

 - [Создать группу выделенных хостов](operations/dedicated-host/create-host-group.md)

 - [Создать ВМ в группе выделенных хостов](operations/dedicated-host/running-host-group-vms.md)

 - [Создать ВМ на выделенном хосте](operations/dedicated-host/running-host-vms.md)

 - [Настроить права доступа к группе выделенных хостов](operations/dedicated-host/access.md)

### Пулы резервов ВМ

 - [Создать пул резервов ВМ](operations/reserved-pools/create-reserved-pool.md)

 - [Изменить пул резервов ВМ](operations/reserved-pools/update-reserved-pool.md)

 - [Удалить пул резервов ВМ](operations/reserved-pools/delete-reserved-pool.md)

 - [Управлять виртуальными машинами пула](operations/reserved-pools/manage-pool-vms.md)

### Кластеры GPU

 - [Создать кластер GPU](operations/gpu-cluster/gpu-cluster-create.md)

 - [Добавить ВМ в кластер GPU](operations/gpu-cluster/gpu-add-to-cluster.md)

 - [Изменить кластер GPU](operations/gpu-cluster/gpu-cluster-update.md)

 - [Получить информацию о кластере GPU](operations/gpu-cluster/gpu-cluster-get-info.md)

 - [Настроить права доступа к кластеру GPU](operations/gpu-cluster/access.md)

 - [Удалить кластер GPU](operations/gpu-cluster/gpu-cluster-delete.md)

 - [Проверить физическое состояние кластера GPU](operations/gpu-cluster/gpu-cluster-test-physical-state.md)

 - [Запустить параллельные задачи в кластере GPU](operations/gpu-cluster/gpu-cluster-mpirun-parallel.md)

 - [Проверить пропускную способность InfiniBand](operations/gpu-cluster/test-infiniband-bandwidth.md)

 - [Включить программно ускоренную сеть](operations/enable-software-accelerated-network.md)

 - [Посмотреть операции с ресурсами сервиса](operations/operation-logs.md)

 - [Посмотреть метрики в Monitoring](operations/metrics-pull.md)

 - [Рекомендации по обновлению драйверов NVIDIA](operations/gpu-driver-update.md)

 - [Yandex Container Solution](../cos/index.md)

## Практические руководства

 - [Все руководства](tutorials/index.md)

 - [Настройка синхронизации часов с помощью NTP](tutorials/ntp.md)

### Работа с группой ВМ с автоматическим масштабированием

 - [Обзор](tutorials/vm-autoscale/index.md)

 - [Консоль управления](tutorials/vm-autoscale/console.md)

 - [Terraform](tutorials/vm-autoscale/terraform.md)

### Масштабирование группы виртуальных машин по расписанию

 - [Обзор](tutorials/vm-scale-scheduled/index.md)

 - [Консоль управления, CLI и API](tutorials/vm-scale-scheduled/console.md)

 - [Terraform](tutorials/vm-scale-scheduled/terraform.md)

 - [Автомасштабирование группы ВМ для обработки сообщений из очереди](tutorials/autoscale-monitoring.md)

 - [Обновление группы ВМ под нагрузкой](tutorials/updating-under-load.md)

 - [Развертывание Remote Desktop Gateway](tutorials/rds-gw.md)

 - [Начало работы с Packer](tutorials/packer-quickstart.md)

 - [Передача логов с ВМ в Yandex Cloud Logging](tutorials/vm-fluent-bit-logging.md)

 - [Сборка образа ВМ с набором инфраструктурных инструментов с помощью Packer](tutorials/packer-custom-image.md)

 - [Миграция в Yandex Cloud с помощью Хайстекс Акура](tutorials/hystax-migration.md)

 - [Защита от сбоев с помощью Хайстекс Акура](tutorials/hystax-disaster-recovery.md)

 - [Резервное копирование ВМ с помощью Хайстекс Акура](tutorials/hystax-backup.md)

 - [Развертывание отказоустойчивой архитектуры с прерываемыми ВМ](tutorials/nodejs-cron-restart-vm.md)

### Привязка доменного имени к ВМ с веб-сервером

 - [Обзор](tutorials/bind-domain-vm/index.md)

 - [Консоль управления, CLI и API](tutorials/bind-domain-vm/console.md)

 - [Terraform](tutorials/bind-domain-vm/terraform.md)

 - [Настройка отказоустойчивой архитектуры в Yandex Cloud](tutorials/fault-tolerance.md)

### Маршрутизация через NAT-инстанс

 - [Обзор](tutorials/nat-instance/index.md)

 - [Консоль управления](tutorials/nat-instance/console.md)

 - [Terraform](tutorials/nat-instance/terraform.md)

 - [Создание триггера для бюджетов, который вызывает функцию для остановки ВМ](tutorials/serverless-trigger-budget-vm.md)

 - [Создание триггеров, которые вызывают функции для остановки ВМ и отправки уведомлений в Telegram](tutorials/serverless-trigger-budget-queue-vm-tg.md)

### Интернет-магазин на платформе OpenCart

 - [Обзор](tutorials/opencart/index.md)

 - [Консоль управления](tutorials/opencart/console.md)

 - [Terraform](tutorials/opencart/terraform.md)

 - [Создание веб-приложения на Python с использованием фреймворка Flask](tutorials/flask.md)

 - [Создание SAP-программы в Yandex Cloud](tutorials/sap.md)

 - [Развертывание сервера Minecraft в Yandex Cloud](tutorials/minecraft-server.md)

 - [Автоматизация сборки образов с помощью Jenkins и Packer](tutorials/jenkins.md)

 - [Создание тестовых виртуальных машин через GitLab CI](tutorials/test-vms-creation-via-gitlab-ci.md)

 - [Высокопроизводительные вычисления (HPC) на прерываемых ВМ](tutorials/hpc-on-preemptible.md)

### Однонодовый файловый сервер

 - [Обзор](tutorials/single-node-file-server/index.md)

 - [Консоль управления](tutorials/single-node-file-server/console.md)

 - [Terraform](tutorials/single-node-file-server/terraform.md)

 - [Настройка SFTP-сервера на Centos 7](tutorials/backup-and-archive-to-sftp.md)

 - [Развертывание параллельной файловой системы GlusterFS в высокодоступном режиме](tutorials/ha-regional-glusterfs.md)

 - [Развертывание параллельной файловой системы GlusterFS в высокопроизводительном режиме](tutorials/ha-regional-glusterfs-high-performance.md)

 - [Резервное копирование в Object Storage с помощью Bacula](tutorials/backup-with-bacula.md)

### Создание L7-балансировщика с защитой от DDoS

 - [Обзор](tutorials/alb-with-ddos-protection/index.md)

 - [Консоль управления, CLI](tutorials/alb-with-ddos-protection/console.md)

 - [Terraform](tutorials/alb-with-ddos-protection/terraform.md)

 - [Построение пайплайна CI/CD в GitLab с использованием serverless-продуктов](tutorials/ci-cd-serverless.md)

 - [Реализация защищенной высокодоступной сетевой инфраструктуры с выделением DMZ на основе Check Point NGFW](tutorials/high-accessible-dmz.md)

 - [Сегментация облачной инфраструктуры с помощью решения Check Point Next-Generation Firewall](tutorials/network-segmentation-checkpoint.md)

 - [Настройка защищенного туннеля GRE поверх IPsec](tutorials/gre-over-ipsec.md)

 - [Создание бастионного хоста](tutorials/bastion.md)

 - [Реализация отказоустойчивых сценариев для сетевых виртуальных машин](tutorials/route-switcher.md)

 - [Создание туннеля между двумя подсетями при помощи OpenVPN Access Server](tutorials/site-to-site-openvpn.md)

 - [ViPNet Coordinator в Yandex Cloud](tutorials/vipnet-to-yc.md)

 - [Создание внешней таблицы на базе таблицы из бакета Object Storage с помощью конфигурационного файла](tutorials/mgp-config-server-for-s3.md)

 - [Настройка сетевой связности между подсетями BareMetal и Virtual Private Cloud](tutorials/bm-vrf-and-vpc-interconnect.md)

 - [Работа со снапшотами в Managed Service for Kubernetes](tutorials/pvc-snapshot-restore.md)

### Container Optimized Image

 - [Создать ВМ с Container Optimized Image](tutorials/vm-create.md)

 - [Создать ВМ с Container Optimized Image и дополнительным томом для Docker-контейнера](tutorials/vm-create-with-second-disk.md)

 - [Создать ВМ с Container Optimized Image и несколькими Docker-контейнерами](tutorials/docker-compose.md)

 - [Создать группу ВМ с Container Optimized Image](tutorials/ig-create.md)

 - [Создать группу ВМ с Container Optimized Image и несколькими Docker-контейнерами](tutorials/ig-with-containers.md)

 - [Изменить ВМ с Container Optimized Image](tutorials/vm-update.md)

 - [Создать ВМ и группу ВМ с Container Optimized Image с помощью Terraform](tutorials/coi-with-terraform.md)

### Продукты Microsoft в Yandex Cloud

#### Безопасная передача пароля в скрипт инициализации

 - [Обзор](tutorials/secure-password-script/index.md)

 - [Консоль управления, CLI, API](tutorials/secure-password-script/console.md)

 - [Terraform](tutorials/secure-password-script/terraform.md)

 - [Развертывание Active Directory](tutorials/active-directory.md)

 - [Развертывание Microsoft Exchange](tutorials/exchange.md)

 - [Развертывание Remote Desktop Services](tutorials/rds.md)

 - [Развертывание группы доступности Always On с внутренним сетевым балансировщиком](tutorials/mssql-alwayson-lb.md)

 - [Развертывание Remote Desktop Gateway](tutorials/rds-gw.md)

 - [Создание сервера MLFlow для логирования экспериментов и артефактов](tutorials/mlflow-datasphere.md)

 - [Развертывание GitLab Runner на виртуальной машине](tutorials/install-gitlab-runner.md)

 - [Запуск языковой модели DeepSeek-R1 в кластере GPU](tutorials/gpu-cluster-deepseek.md)

 - [Запуск библиотеки vLLM с языковой моделью Gemma 3 на ВМ с GPU](tutorials/vllm-gemma-gpu.md)

 - [Доставка USB-устройств на виртуальную машину или сервер BareMetal](tutorials/usb-over-ip.md)

### Развертывание Nextcloud в интеграции с Object Storage

 - [Обзор](tutorials/integrate-nextcloud/index.md)

 - [Развертывание Nextcloud на ВМ из образа Container Optimized Image](tutorials/integrate-nextcloud/coi-based.md)

 - [Развертывание Nextcloud на ВМ или в группе ВМ вручную](tutorials/integrate-nextcloud/fault-tolerant.md)

 - [Развертывание Nextcloud на ВМ или в группе ВМ с помощью Terraform](tutorials/integrate-nextcloud/terraform.md)

 - [Запуск Docker-образа на ВМ с помощью Cloud Registry](tutorials/docker-cloud-registry.md)

 - [Развертывание воркера SourceCraft на ВМ](tutorials/self-hosted-worker-sourcecraft.md)

## Концепции

 - [Взаимосвязь ресурсов](concepts/index.md)

### Виртуальные машины

 - [Обзор](concepts/vm.md)

 - [Платформы](concepts/vm-platforms.md)

 - [Уровни производительности vCPU](concepts/performance-levels.md)

 - [Поколения оборудования](concepts/hardware-generations.md)

 - [Прерываемые виртуальные машины](concepts/preemptible-vm.md)

 - [Сетевые интерфейсы виртуальных машин](concepts/network.md)

 - [Программно ускоренная сеть](concepts/software-accelerated-network.md)

 - [Динамическая миграция](concepts/live-migration.md)

 - [Группы размещения](concepts/placement-groups.md)

 - [Статусы](concepts/vm-statuses.md)

 - [Политики обслуживания ВМ](concepts/maintenance-policies.md)

 - [Серийная консоль](concepts/serial-console.md)

 - [Сброс паролей на ВМ Windows](concepts/guest-agent.md)

### Метаданные виртуальных машин

 - [Обзор](concepts/vm-metadata.md)

 - [Каталоги метаданных](concepts/metadata/directories.md)

 - [Ключи, обрабатываемые в публичных образах](concepts/metadata/public-image-keys.md)

 - [Передача метаданных в ВМ](concepts/metadata/sending-metadata.md)

 - [Доступ к метаданным](concepts/metadata/accessing-metadata.md)

 - [Идентификационный документ](concepts/metadata/identity-document.md)

 - [Графические ускорители GPU](concepts/gpus.md)

 - [Техническое обслуживание ВМ с GPU](concepts/gpus-maintenance.md)

### Диски и файловые хранилища

 - [Обзор](concepts/storage-overview.md)

 - [Диски](concepts/disk.md)

 - [Снимки дисков](concepts/snapshot.md)

 - [Создание снимков по расписаниям](concepts/snapshot-schedule.md)

 - [Группы размещения нереплицируемых дисков](concepts/disk-placement-group.md)

 - [Файловые хранилища](concepts/filesystem.md)

 - [Операции чтения и записи](concepts/storage-read-write.md)

 - [Образы](concepts/image.md)

### Группы виртуальных машин

 - [Обзор](concepts/instance-groups/index.md)

#### Группы ВМ при зональном инциденте

 - [Обзор](concepts/instance-groups/zonal-inc/overview.md)

 - [Мультизональная группа с ВМ в зоне инцидента](concepts/instance-groups/zonal-inc/multi-zonal.md)

 - [Временное отключение зон доступности](concepts/instance-groups/disable-enable-zone.md)

 - [Доступ](concepts/instance-groups/access.md)

 - [YAML-спецификация](concepts/instance-groups/specification.md)

 - [Шаблон виртуальной машины](concepts/instance-groups/instance-template.md)

 - [Переменные в шаблоне виртуальной машины](concepts/instance-groups/variables-in-the-template.md)

#### Политики

 - [Обзор](concepts/instance-groups/policies/index.md)

 - [Политика распределения](concepts/instance-groups/policies/allocation-policy.md)

 - [Политика развертывания](concepts/instance-groups/policies/deploy-policy.md)

 - [Политика масштабирования](concepts/instance-groups/policies/scale-policy.md)

 - [Политика восстановления](concepts/instance-groups/policies/healing-policy.md)

 - [Типы масштабирования](concepts/instance-groups/scale.md)

 - [Проверки и автовосстановление ВМ](concepts/instance-groups/autohealing.md)

#### Обновление

 - [Обзор](concepts/instance-groups/deploy/index.md)

 - [Распределение виртуальных машин по зонам](concepts/instance-groups/deploy/zones.md)

 - [Алгоритм развертывания](concepts/instance-groups/deploy/deploy.md)

 - [Правила обновления виртуальных машин](concepts/instance-groups/deploy/instance.md)

 - [Изменение дополнительных дисков в шаблоне виртуальной машины](concepts/instance-groups/deploy/secondary-disk.md)

 - [Интеграция с сетевыми и L7-балансировщиками](concepts/instance-groups/balancers.md)

 - [Работа со Stateful-нагрузкой](concepts/instance-groups/stateful-workload.md)

 - [Остановка группы и приостановка процессов](concepts/instance-groups/stopping-pausing.md)

 - [Поочередные перезагрузка и пересоздание ВМ в группе](concepts/instance-groups/rolling-actions.md)

 - [Статусы](concepts/instance-groups/statuses.md)

 - [Выделенный хост](concepts/dedicated-host.md)

 - [Пулы резервов ВМ](concepts/reserved-pools.md)

 - [Шифрование](concepts/encryption.md)

 - [Резервное копирование](concepts/backups.md)

 - [Квоты и лимиты](concepts/limits.md)

 - [Управление доступом](security/index.md)

 - [Правила тарификации](pricing.md)

## Справочник CLI (англ.)

 - [Overview](cli-ref/index.md)

 - [connect-to-serial-port](cli-ref/connect-to-serial-port.md)

### disk

 - [Overview](cli-ref/disk/index.md)

 - [add-access-binding](cli-ref/disk/add-access-binding.md)

 - [add-labels](cli-ref/disk/add-labels.md)

 - [create](cli-ref/disk/create.md)

 - [delete](cli-ref/disk/delete.md)

 - [get](cli-ref/disk/get.md)

 - [list](cli-ref/disk/list.md)

 - [list-access-bindings](cli-ref/disk/list-access-bindings.md)

 - [list-operations](cli-ref/disk/list-operations.md)

 - [move](cli-ref/disk/move.md)

 - [relocate](cli-ref/disk/relocate.md)

 - [remove-access-binding](cli-ref/disk/remove-access-binding.md)

 - [remove-labels](cli-ref/disk/remove-labels.md)

 - [resize](cli-ref/disk/resize.md)

 - [set-access-bindings](cli-ref/disk/set-access-bindings.md)

 - [update](cli-ref/disk/update.md)

### disk-placement-group

 - [Overview](cli-ref/disk-placement-group/index.md)

 - [add-access-binding](cli-ref/disk-placement-group/add-access-binding.md)

 - [add-labels](cli-ref/disk-placement-group/add-labels.md)

 - [create](cli-ref/disk-placement-group/create.md)

 - [delete](cli-ref/disk-placement-group/delete.md)

 - [get](cli-ref/disk-placement-group/get.md)

 - [list](cli-ref/disk-placement-group/list.md)

 - [list-access-bindings](cli-ref/disk-placement-group/list-access-bindings.md)

 - [list-disks](cli-ref/disk-placement-group/list-disks.md)

 - [list-operations](cli-ref/disk-placement-group/list-operations.md)

 - [remove-access-binding](cli-ref/disk-placement-group/remove-access-binding.md)

 - [remove-labels](cli-ref/disk-placement-group/remove-labels.md)

 - [set-access-bindings](cli-ref/disk-placement-group/set-access-bindings.md)

 - [update](cli-ref/disk-placement-group/update.md)

### disk-type

 - [Overview](cli-ref/disk-type/index.md)

 - [get](cli-ref/disk-type/get.md)

 - [list](cli-ref/disk-type/list.md)

### filesystem

 - [Overview](cli-ref/filesystem/index.md)

 - [add-access-binding](cli-ref/filesystem/add-access-binding.md)

 - [add-labels](cli-ref/filesystem/add-labels.md)

 - [create](cli-ref/filesystem/create.md)

 - [delete](cli-ref/filesystem/delete.md)

 - [get](cli-ref/filesystem/get.md)

 - [list](cli-ref/filesystem/list.md)

 - [list-access-bindings](cli-ref/filesystem/list-access-bindings.md)

 - [list-operations](cli-ref/filesystem/list-operations.md)

 - [remove-access-binding](cli-ref/filesystem/remove-access-binding.md)

 - [remove-labels](cli-ref/filesystem/remove-labels.md)

 - [resize](cli-ref/filesystem/resize.md)

 - [set-access-bindings](cli-ref/filesystem/set-access-bindings.md)

 - [update](cli-ref/filesystem/update.md)

### gpu-cluster

 - [Overview](cli-ref/gpu-cluster/index.md)

 - [add-access-binding](cli-ref/gpu-cluster/add-access-binding.md)

 - [add-labels](cli-ref/gpu-cluster/add-labels.md)

 - [create](cli-ref/gpu-cluster/create.md)

 - [delete](cli-ref/gpu-cluster/delete.md)

 - [get](cli-ref/gpu-cluster/get.md)

 - [list](cli-ref/gpu-cluster/list.md)

 - [list-access-bindings](cli-ref/gpu-cluster/list-access-bindings.md)

 - [list-instances](cli-ref/gpu-cluster/list-instances.md)

 - [list-operations](cli-ref/gpu-cluster/list-operations.md)

 - [remove-access-binding](cli-ref/gpu-cluster/remove-access-binding.md)

 - [remove-labels](cli-ref/gpu-cluster/remove-labels.md)

 - [set-access-bindings](cli-ref/gpu-cluster/set-access-bindings.md)

 - [update](cli-ref/gpu-cluster/update.md)

### host-group

 - [Overview](cli-ref/host-group/index.md)

 - [add-access-binding](cli-ref/host-group/add-access-binding.md)

 - [add-labels](cli-ref/host-group/add-labels.md)

 - [create](cli-ref/host-group/create.md)

 - [delete](cli-ref/host-group/delete.md)

 - [get](cli-ref/host-group/get.md)

 - [list](cli-ref/host-group/list.md)

 - [list-access-bindings](cli-ref/host-group/list-access-bindings.md)

 - [list-hosts](cli-ref/host-group/list-hosts.md)

 - [list-instances](cli-ref/host-group/list-instances.md)

 - [list-operations](cli-ref/host-group/list-operations.md)

 - [remove-access-binding](cli-ref/host-group/remove-access-binding.md)

 - [remove-labels](cli-ref/host-group/remove-labels.md)

 - [set-access-bindings](cli-ref/host-group/set-access-bindings.md)

 - [update](cli-ref/host-group/update.md)

 - [update-host](cli-ref/host-group/update-host.md)

### host-type

 - [Overview](cli-ref/host-type/index.md)

 - [get](cli-ref/host-type/get.md)

 - [list](cli-ref/host-type/list.md)

### image

 - [Overview](cli-ref/image/index.md)

 - [add-access-binding](cli-ref/image/add-access-binding.md)

 - [add-labels](cli-ref/image/add-labels.md)

 - [create](cli-ref/image/create.md)

 - [delete](cli-ref/image/delete.md)

 - [get](cli-ref/image/get.md)

 - [get-latest-from-family](cli-ref/image/get-latest-from-family.md)

 - [list](cli-ref/image/list.md)

 - [list-access-bindings](cli-ref/image/list-access-bindings.md)

 - [list-operations](cli-ref/image/list-operations.md)

 - [remove-access-binding](cli-ref/image/remove-access-binding.md)

 - [remove-labels](cli-ref/image/remove-labels.md)

 - [set-access-bindings](cli-ref/image/set-access-bindings.md)

 - [update](cli-ref/image/update.md)

### instance

 - [Overview](cli-ref/instance/index.md)

 - [add-access-binding](cli-ref/instance/add-access-binding.md)

 - [add-labels](cli-ref/instance/add-labels.md)

 - [add-metadata](cli-ref/instance/add-metadata.md)

 - [add-one-to-one-nat](cli-ref/instance/add-one-to-one-nat.md)

 - [attach-disk](cli-ref/instance/attach-disk.md)

 - [attach-filesystem](cli-ref/instance/attach-filesystem.md)

 - [attach-network-interface](cli-ref/instance/attach-network-interface.md)

 - [create](cli-ref/instance/create.md)

 - [create-with-container](cli-ref/instance/create-with-container.md)

 - [delete](cli-ref/instance/delete.md)

 - [detach-disk](cli-ref/instance/detach-disk.md)

 - [detach-filesystem](cli-ref/instance/detach-filesystem.md)

 - [detach-network-interface](cli-ref/instance/detach-network-interface.md)

 - [get](cli-ref/instance/get.md)

 - [get-serial-port-output](cli-ref/instance/get-serial-port-output.md)

 - [list](cli-ref/instance/list.md)

 - [list-access-bindings](cli-ref/instance/list-access-bindings.md)

 - [list-operations](cli-ref/instance/list-operations.md)

 - [move](cli-ref/instance/move.md)

 - [relocate](cli-ref/instance/relocate.md)

 - [remove-access-binding](cli-ref/instance/remove-access-binding.md)

 - [remove-labels](cli-ref/instance/remove-labels.md)

 - [remove-metadata](cli-ref/instance/remove-metadata.md)

 - [remove-one-to-one-nat](cli-ref/instance/remove-one-to-one-nat.md)

 - [restart](cli-ref/instance/restart.md)

 - [set-access-bindings](cli-ref/instance/set-access-bindings.md)

 - [simulate-maintenance-event](cli-ref/instance/simulate-maintenance-event.md)

 - [start](cli-ref/instance/start.md)

 - [stop](cli-ref/instance/stop.md)

 - [update](cli-ref/instance/update.md)

 - [update-container](cli-ref/instance/update-container.md)

 - [update-network-interface](cli-ref/instance/update-network-interface.md)

### instance-group

 - [Overview](cli-ref/instance-group/index.md)

 - [add-access-binding](cli-ref/instance-group/add-access-binding.md)

 - [add-labels](cli-ref/instance-group/add-labels.md)

 - [add-metadata](cli-ref/instance-group/add-metadata.md)

 - [create](cli-ref/instance-group/create.md)

 - [delete](cli-ref/instance-group/delete.md)

 - [delete-instances](cli-ref/instance-group/delete-instances.md)

 - [disable-zones](cli-ref/instance-group/disable-zones.md)

 - [enable-zones](cli-ref/instance-group/enable-zones.md)

 - [get](cli-ref/instance-group/get.md)

 - [list](cli-ref/instance-group/list.md)

 - [list-access-bindings](cli-ref/instance-group/list-access-bindings.md)

 - [list-instances](cli-ref/instance-group/list-instances.md)

 - [list-logs](cli-ref/instance-group/list-logs.md)

 - [list-operations](cli-ref/instance-group/list-operations.md)

 - [remove-access-binding](cli-ref/instance-group/remove-access-binding.md)

 - [remove-labels](cli-ref/instance-group/remove-labels.md)

 - [remove-metadata](cli-ref/instance-group/remove-metadata.md)

 - [rolling-recreate](cli-ref/instance-group/rolling-recreate.md)

 - [rolling-restart](cli-ref/instance-group/rolling-restart.md)

 - [set-access-bindings](cli-ref/instance-group/set-access-bindings.md)

 - [start](cli-ref/instance-group/start.md)

 - [stop](cli-ref/instance-group/stop.md)

 - [stop-instances](cli-ref/instance-group/stop-instances.md)

 - [update](cli-ref/instance-group/update.md)

### maintenance

 - [Overview](cli-ref/maintenance/index.md)

 - [get](cli-ref/maintenance/get.md)

 - [list](cli-ref/maintenance/list.md)

 - [reschedule](cli-ref/maintenance/reschedule.md)

### placement-group

 - [Overview](cli-ref/placement-group/index.md)

 - [add-access-binding](cli-ref/placement-group/add-access-binding.md)

 - [add-labels](cli-ref/placement-group/add-labels.md)

 - [create](cli-ref/placement-group/create.md)

 - [delete](cli-ref/placement-group/delete.md)

 - [get](cli-ref/placement-group/get.md)

 - [list](cli-ref/placement-group/list.md)

 - [list-access-bindings](cli-ref/placement-group/list-access-bindings.md)

 - [list-instances](cli-ref/placement-group/list-instances.md)

 - [list-operations](cli-ref/placement-group/list-operations.md)

 - [remove-access-binding](cli-ref/placement-group/remove-access-binding.md)

 - [remove-labels](cli-ref/placement-group/remove-labels.md)

 - [set-access-bindings](cli-ref/placement-group/set-access-bindings.md)

 - [update](cli-ref/placement-group/update.md)

### reserved-instance-pool

 - [Overview](cli-ref/reserved-instance-pool/index.md)

 - [create](cli-ref/reserved-instance-pool/create.md)

 - [delete](cli-ref/reserved-instance-pool/delete.md)

 - [get](cli-ref/reserved-instance-pool/get.md)

 - [list](cli-ref/reserved-instance-pool/list.md)

 - [list-instances](cli-ref/reserved-instance-pool/list-instances.md)

 - [list-operations](cli-ref/reserved-instance-pool/list-operations.md)

 - [update](cli-ref/reserved-instance-pool/update.md)

### snapshot

 - [Overview](cli-ref/snapshot/index.md)

 - [add-access-binding](cli-ref/snapshot/add-access-binding.md)

 - [add-labels](cli-ref/snapshot/add-labels.md)

 - [create](cli-ref/snapshot/create.md)

 - [delete](cli-ref/snapshot/delete.md)

 - [get](cli-ref/snapshot/get.md)

 - [list](cli-ref/snapshot/list.md)

 - [list-access-bindings](cli-ref/snapshot/list-access-bindings.md)

 - [list-operations](cli-ref/snapshot/list-operations.md)

 - [remove-access-binding](cli-ref/snapshot/remove-access-binding.md)

 - [remove-labels](cli-ref/snapshot/remove-labels.md)

 - [set-access-bindings](cli-ref/snapshot/set-access-bindings.md)

 - [update](cli-ref/snapshot/update.md)

### snapshot-schedule

 - [Overview](cli-ref/snapshot-schedule/index.md)

 - [add-access-binding](cli-ref/snapshot-schedule/add-access-binding.md)

 - [add-disks](cli-ref/snapshot-schedule/add-disks.md)

 - [add-labels](cli-ref/snapshot-schedule/add-labels.md)

 - [add-snapshot-labels](cli-ref/snapshot-schedule/add-snapshot-labels.md)

 - [create](cli-ref/snapshot-schedule/create.md)

 - [delete](cli-ref/snapshot-schedule/delete.md)

 - [disable](cli-ref/snapshot-schedule/disable.md)

 - [enable](cli-ref/snapshot-schedule/enable.md)

 - [get](cli-ref/snapshot-schedule/get.md)

 - [list](cli-ref/snapshot-schedule/list.md)

 - [list-access-bindings](cli-ref/snapshot-schedule/list-access-bindings.md)

 - [list-disks](cli-ref/snapshot-schedule/list-disks.md)

 - [list-operations](cli-ref/snapshot-schedule/list-operations.md)

 - [list-snapshots](cli-ref/snapshot-schedule/list-snapshots.md)

 - [remove-access-binding](cli-ref/snapshot-schedule/remove-access-binding.md)

 - [remove-disks](cli-ref/snapshot-schedule/remove-disks.md)

 - [remove-labels](cli-ref/snapshot-schedule/remove-labels.md)

 - [remove-snapshot-labels](cli-ref/snapshot-schedule/remove-snapshot-labels.md)

 - [set-access-bindings](cli-ref/snapshot-schedule/set-access-bindings.md)

 - [update](cli-ref/snapshot-schedule/update.md)

### ssh

 - [Overview](cli-ref/ssh/index.md)

#### certificate

 - [Overview](cli-ref/ssh/certificate/index.md)

 - [export](cli-ref/ssh/certificate/export.md)

### v0

 - [Overview](cli-ref/v0/index.md)

 - [connect-to-serial-port](cli-ref/v0/connect-to-serial-port.md)

#### disk

 - [Overview](cli-ref/v0/disk/index.md)

 - [add-access-binding](cli-ref/v0/disk/add-access-binding.md)

 - [add-labels](cli-ref/v0/disk/add-labels.md)

 - [create](cli-ref/v0/disk/create.md)

 - [delete](cli-ref/v0/disk/delete.md)

 - [get](cli-ref/v0/disk/get.md)

 - [list](cli-ref/v0/disk/list.md)

 - [list-access-bindings](cli-ref/v0/disk/list-access-bindings.md)

 - [list-operations](cli-ref/v0/disk/list-operations.md)

 - [move](cli-ref/v0/disk/move.md)

 - [relocate](cli-ref/v0/disk/relocate.md)

 - [remove-access-binding](cli-ref/v0/disk/remove-access-binding.md)

 - [remove-labels](cli-ref/v0/disk/remove-labels.md)

 - [resize](cli-ref/v0/disk/resize.md)

 - [set-access-bindings](cli-ref/v0/disk/set-access-bindings.md)

 - [update](cli-ref/v0/disk/update.md)

#### disk-placement-group

 - [Overview](cli-ref/v0/disk-placement-group/index.md)

 - [add-access-binding](cli-ref/v0/disk-placement-group/add-access-binding.md)

 - [add-labels](cli-ref/v0/disk-placement-group/add-labels.md)

 - [create](cli-ref/v0/disk-placement-group/create.md)

 - [delete](cli-ref/v0/disk-placement-group/delete.md)

 - [get](cli-ref/v0/disk-placement-group/get.md)

 - [list](cli-ref/v0/disk-placement-group/list.md)

 - [list-access-bindings](cli-ref/v0/disk-placement-group/list-access-bindings.md)

 - [list-disks](cli-ref/v0/disk-placement-group/list-disks.md)

 - [list-operations](cli-ref/v0/disk-placement-group/list-operations.md)

 - [remove-access-binding](cli-ref/v0/disk-placement-group/remove-access-binding.md)

 - [remove-labels](cli-ref/v0/disk-placement-group/remove-labels.md)

 - [set-access-bindings](cli-ref/v0/disk-placement-group/set-access-bindings.md)

 - [update](cli-ref/v0/disk-placement-group/update.md)

#### disk-type

 - [Overview](cli-ref/v0/disk-type/index.md)

 - [get](cli-ref/v0/disk-type/get.md)

 - [list](cli-ref/v0/disk-type/list.md)

#### filesystem

 - [Overview](cli-ref/v0/filesystem/index.md)

 - [add-access-binding](cli-ref/v0/filesystem/add-access-binding.md)

 - [add-labels](cli-ref/v0/filesystem/add-labels.md)

 - [create](cli-ref/v0/filesystem/create.md)

 - [delete](cli-ref/v0/filesystem/delete.md)

 - [get](cli-ref/v0/filesystem/get.md)

 - [list](cli-ref/v0/filesystem/list.md)

 - [list-access-bindings](cli-ref/v0/filesystem/list-access-bindings.md)

 - [list-operations](cli-ref/v0/filesystem/list-operations.md)

 - [remove-access-binding](cli-ref/v0/filesystem/remove-access-binding.md)

 - [remove-labels](cli-ref/v0/filesystem/remove-labels.md)

 - [resize](cli-ref/v0/filesystem/resize.md)

 - [set-access-bindings](cli-ref/v0/filesystem/set-access-bindings.md)

 - [update](cli-ref/v0/filesystem/update.md)

#### gpu-cluster

 - [Overview](cli-ref/v0/gpu-cluster/index.md)

 - [add-access-binding](cli-ref/v0/gpu-cluster/add-access-binding.md)

 - [add-labels](cli-ref/v0/gpu-cluster/add-labels.md)

 - [create](cli-ref/v0/gpu-cluster/create.md)

 - [delete](cli-ref/v0/gpu-cluster/delete.md)

 - [get](cli-ref/v0/gpu-cluster/get.md)

 - [list](cli-ref/v0/gpu-cluster/list.md)

 - [list-access-bindings](cli-ref/v0/gpu-cluster/list-access-bindings.md)

 - [list-instances](cli-ref/v0/gpu-cluster/list-instances.md)

 - [list-operations](cli-ref/v0/gpu-cluster/list-operations.md)

 - [remove-access-binding](cli-ref/v0/gpu-cluster/remove-access-binding.md)

 - [remove-labels](cli-ref/v0/gpu-cluster/remove-labels.md)

 - [set-access-bindings](cli-ref/v0/gpu-cluster/set-access-bindings.md)

 - [update](cli-ref/v0/gpu-cluster/update.md)

#### host-group

 - [Overview](cli-ref/v0/host-group/index.md)

 - [add-access-binding](cli-ref/v0/host-group/add-access-binding.md)

 - [add-labels](cli-ref/v0/host-group/add-labels.md)

 - [create](cli-ref/v0/host-group/create.md)

 - [delete](cli-ref/v0/host-group/delete.md)

 - [get](cli-ref/v0/host-group/get.md)

 - [list](cli-ref/v0/host-group/list.md)

 - [list-access-bindings](cli-ref/v0/host-group/list-access-bindings.md)

 - [list-hosts](cli-ref/v0/host-group/list-hosts.md)

 - [list-instances](cli-ref/v0/host-group/list-instances.md)

 - [list-operations](cli-ref/v0/host-group/list-operations.md)

 - [remove-access-binding](cli-ref/v0/host-group/remove-access-binding.md)

 - [remove-labels](cli-ref/v0/host-group/remove-labels.md)

 - [set-access-bindings](cli-ref/v0/host-group/set-access-bindings.md)

 - [update](cli-ref/v0/host-group/update.md)

 - [update-host](cli-ref/v0/host-group/update-host.md)

#### host-type

 - [Overview](cli-ref/v0/host-type/index.md)

 - [get](cli-ref/v0/host-type/get.md)

 - [list](cli-ref/v0/host-type/list.md)

#### image

 - [Overview](cli-ref/v0/image/index.md)

 - [add-access-binding](cli-ref/v0/image/add-access-binding.md)

 - [add-labels](cli-ref/v0/image/add-labels.md)

 - [create](cli-ref/v0/image/create.md)

 - [delete](cli-ref/v0/image/delete.md)

 - [get](cli-ref/v0/image/get.md)

 - [get-latest-from-family](cli-ref/v0/image/get-latest-from-family.md)

 - [list](cli-ref/v0/image/list.md)

 - [list-access-bindings](cli-ref/v0/image/list-access-bindings.md)

 - [list-operations](cli-ref/v0/image/list-operations.md)

 - [remove-access-binding](cli-ref/v0/image/remove-access-binding.md)

 - [remove-labels](cli-ref/v0/image/remove-labels.md)

 - [set-access-bindings](cli-ref/v0/image/set-access-bindings.md)

 - [update](cli-ref/v0/image/update.md)

#### instance

 - [Overview](cli-ref/v0/instance/index.md)

 - [add-access-binding](cli-ref/v0/instance/add-access-binding.md)

 - [add-labels](cli-ref/v0/instance/add-labels.md)

 - [add-metadata](cli-ref/v0/instance/add-metadata.md)

 - [add-one-to-one-nat](cli-ref/v0/instance/add-one-to-one-nat.md)

 - [attach-disk](cli-ref/v0/instance/attach-disk.md)

 - [attach-filesystem](cli-ref/v0/instance/attach-filesystem.md)

 - [attach-network-interface](cli-ref/v0/instance/attach-network-interface.md)

 - [create](cli-ref/v0/instance/create.md)

 - [create-with-container](cli-ref/v0/instance/create-with-container.md)

 - [delete](cli-ref/v0/instance/delete.md)

 - [detach-disk](cli-ref/v0/instance/detach-disk.md)

 - [detach-filesystem](cli-ref/v0/instance/detach-filesystem.md)

 - [detach-network-interface](cli-ref/v0/instance/detach-network-interface.md)

 - [get](cli-ref/v0/instance/get.md)

 - [get-serial-port-output](cli-ref/v0/instance/get-serial-port-output.md)

 - [list](cli-ref/v0/instance/list.md)

 - [list-access-bindings](cli-ref/v0/instance/list-access-bindings.md)

 - [list-operations](cli-ref/v0/instance/list-operations.md)

 - [move](cli-ref/v0/instance/move.md)

 - [relocate](cli-ref/v0/instance/relocate.md)

 - [remove-access-binding](cli-ref/v0/instance/remove-access-binding.md)

 - [remove-labels](cli-ref/v0/instance/remove-labels.md)

 - [remove-metadata](cli-ref/v0/instance/remove-metadata.md)

 - [remove-one-to-one-nat](cli-ref/v0/instance/remove-one-to-one-nat.md)

 - [restart](cli-ref/v0/instance/restart.md)

 - [set-access-bindings](cli-ref/v0/instance/set-access-bindings.md)

 - [simulate-maintenance-event](cli-ref/v0/instance/simulate-maintenance-event.md)

 - [start](cli-ref/v0/instance/start.md)

 - [stop](cli-ref/v0/instance/stop.md)

 - [update](cli-ref/v0/instance/update.md)

 - [update-container](cli-ref/v0/instance/update-container.md)

 - [update-network-interface](cli-ref/v0/instance/update-network-interface.md)

#### instance-group

 - [Overview](cli-ref/v0/instance-group/index.md)

 - [add-access-binding](cli-ref/v0/instance-group/add-access-binding.md)

 - [add-labels](cli-ref/v0/instance-group/add-labels.md)

 - [add-metadata](cli-ref/v0/instance-group/add-metadata.md)

 - [create](cli-ref/v0/instance-group/create.md)

 - [delete](cli-ref/v0/instance-group/delete.md)

 - [delete-instances](cli-ref/v0/instance-group/delete-instances.md)

 - [disable-zones](cli-ref/v0/instance-group/disable-zones.md)

 - [enable-zones](cli-ref/v0/instance-group/enable-zones.md)

 - [get](cli-ref/v0/instance-group/get.md)

 - [list](cli-ref/v0/instance-group/list.md)

 - [list-access-bindings](cli-ref/v0/instance-group/list-access-bindings.md)

 - [list-instances](cli-ref/v0/instance-group/list-instances.md)

 - [list-logs](cli-ref/v0/instance-group/list-logs.md)

 - [list-operations](cli-ref/v0/instance-group/list-operations.md)

 - [remove-access-binding](cli-ref/v0/instance-group/remove-access-binding.md)

 - [remove-labels](cli-ref/v0/instance-group/remove-labels.md)

 - [remove-metadata](cli-ref/v0/instance-group/remove-metadata.md)

 - [rolling-recreate](cli-ref/v0/instance-group/rolling-recreate.md)

 - [rolling-restart](cli-ref/v0/instance-group/rolling-restart.md)

 - [set-access-bindings](cli-ref/v0/instance-group/set-access-bindings.md)

 - [start](cli-ref/v0/instance-group/start.md)

 - [stop](cli-ref/v0/instance-group/stop.md)

 - [stop-instances](cli-ref/v0/instance-group/stop-instances.md)

 - [update](cli-ref/v0/instance-group/update.md)

#### maintenance

 - [Overview](cli-ref/v0/maintenance/index.md)

 - [get](cli-ref/v0/maintenance/get.md)

 - [list](cli-ref/v0/maintenance/list.md)

 - [reschedule](cli-ref/v0/maintenance/reschedule.md)

#### placement-group

 - [Overview](cli-ref/v0/placement-group/index.md)

 - [add-access-binding](cli-ref/v0/placement-group/add-access-binding.md)

 - [add-labels](cli-ref/v0/placement-group/add-labels.md)

 - [create](cli-ref/v0/placement-group/create.md)

 - [delete](cli-ref/v0/placement-group/delete.md)

 - [get](cli-ref/v0/placement-group/get.md)

 - [list](cli-ref/v0/placement-group/list.md)

 - [list-access-bindings](cli-ref/v0/placement-group/list-access-bindings.md)

 - [list-instances](cli-ref/v0/placement-group/list-instances.md)

 - [list-operations](cli-ref/v0/placement-group/list-operations.md)

 - [remove-access-binding](cli-ref/v0/placement-group/remove-access-binding.md)

 - [remove-labels](cli-ref/v0/placement-group/remove-labels.md)

 - [set-access-bindings](cli-ref/v0/placement-group/set-access-bindings.md)

 - [update](cli-ref/v0/placement-group/update.md)

#### reserved-instance-pool

 - [Overview](cli-ref/v0/reserved-instance-pool/index.md)

 - [create](cli-ref/v0/reserved-instance-pool/create.md)

 - [delete](cli-ref/v0/reserved-instance-pool/delete.md)

 - [get](cli-ref/v0/reserved-instance-pool/get.md)

 - [list](cli-ref/v0/reserved-instance-pool/list.md)

 - [list-instances](cli-ref/v0/reserved-instance-pool/list-instances.md)

 - [list-operations](cli-ref/v0/reserved-instance-pool/list-operations.md)

 - [update](cli-ref/v0/reserved-instance-pool/update.md)

#### snapshot

 - [Overview](cli-ref/v0/snapshot/index.md)

 - [add-access-binding](cli-ref/v0/snapshot/add-access-binding.md)

 - [add-labels](cli-ref/v0/snapshot/add-labels.md)

 - [create](cli-ref/v0/snapshot/create.md)

 - [delete](cli-ref/v0/snapshot/delete.md)

 - [get](cli-ref/v0/snapshot/get.md)

 - [list](cli-ref/v0/snapshot/list.md)

 - [list-access-bindings](cli-ref/v0/snapshot/list-access-bindings.md)

 - [list-operations](cli-ref/v0/snapshot/list-operations.md)

 - [remove-access-binding](cli-ref/v0/snapshot/remove-access-binding.md)

 - [remove-labels](cli-ref/v0/snapshot/remove-labels.md)

 - [set-access-bindings](cli-ref/v0/snapshot/set-access-bindings.md)

 - [update](cli-ref/v0/snapshot/update.md)

#### snapshot-schedule

 - [Overview](cli-ref/v0/snapshot-schedule/index.md)

 - [add-access-binding](cli-ref/v0/snapshot-schedule/add-access-binding.md)

 - [add-disks](cli-ref/v0/snapshot-schedule/add-disks.md)

 - [add-labels](cli-ref/v0/snapshot-schedule/add-labels.md)

 - [add-snapshot-labels](cli-ref/v0/snapshot-schedule/add-snapshot-labels.md)

 - [create](cli-ref/v0/snapshot-schedule/create.md)

 - [delete](cli-ref/v0/snapshot-schedule/delete.md)

 - [disable](cli-ref/v0/snapshot-schedule/disable.md)

 - [enable](cli-ref/v0/snapshot-schedule/enable.md)

 - [get](cli-ref/v0/snapshot-schedule/get.md)

 - [list](cli-ref/v0/snapshot-schedule/list.md)

 - [list-access-bindings](cli-ref/v0/snapshot-schedule/list-access-bindings.md)

 - [list-disks](cli-ref/v0/snapshot-schedule/list-disks.md)

 - [list-operations](cli-ref/v0/snapshot-schedule/list-operations.md)

 - [list-snapshots](cli-ref/v0/snapshot-schedule/list-snapshots.md)

 - [remove-access-binding](cli-ref/v0/snapshot-schedule/remove-access-binding.md)

 - [remove-disks](cli-ref/v0/snapshot-schedule/remove-disks.md)

 - [remove-labels](cli-ref/v0/snapshot-schedule/remove-labels.md)

 - [remove-snapshot-labels](cli-ref/v0/snapshot-schedule/remove-snapshot-labels.md)

 - [set-access-bindings](cli-ref/v0/snapshot-schedule/set-access-bindings.md)

 - [update](cli-ref/v0/snapshot-schedule/update.md)

#### ssh

 - [Overview](cli-ref/v0/ssh/index.md)

##### certificate

 - [Overview](cli-ref/v0/ssh/certificate/index.md)

 - [export](cli-ref/v0/ssh/certificate/export.md)

#### zone

 - [Overview](cli-ref/v0/zone/index.md)

 - [get](cli-ref/v0/zone/get.md)

 - [list](cli-ref/v0/zone/list.md)

### zone

 - [Overview](cli-ref/zone/index.md)

 - [get](cli-ref/zone/get.md)

 - [list](cli-ref/zone/list.md)

 - [Справочник Terraform](tf-ref.md)

## Справочник API

 - [Аутентификация в API](api-ref/authentication.md)

### gRPC (англ.)

 - [Overview](api-ref/grpc/index.md)

#### DiskPlacementGroup

 - [Overview](api-ref/grpc/DiskPlacementGroup/index.md)

 - [Get](api-ref/grpc/DiskPlacementGroup/get.md)

 - [List](api-ref/grpc/DiskPlacementGroup/list.md)

 - [Create](api-ref/grpc/DiskPlacementGroup/create.md)

 - [Update](api-ref/grpc/DiskPlacementGroup/update.md)

 - [Delete](api-ref/grpc/DiskPlacementGroup/delete.md)

 - [ListDisks](api-ref/grpc/DiskPlacementGroup/listDisks.md)

 - [ListOperations](api-ref/grpc/DiskPlacementGroup/listOperations.md)

 - [ListAccessBindings](api-ref/grpc/DiskPlacementGroup/listAccessBindings.md)

 - [SetAccessBindings](api-ref/grpc/DiskPlacementGroup/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/grpc/DiskPlacementGroup/updateAccessBindings.md)

#### Disk

 - [Overview](api-ref/grpc/Disk/index.md)

 - [Get](api-ref/grpc/Disk/get.md)

 - [List](api-ref/grpc/Disk/list.md)

 - [Create](api-ref/grpc/Disk/create.md)

 - [Update](api-ref/grpc/Disk/update.md)

 - [Delete](api-ref/grpc/Disk/delete.md)

 - [ListOperations](api-ref/grpc/Disk/listOperations.md)

 - [Move](api-ref/grpc/Disk/move.md)

 - [Relocate](api-ref/grpc/Disk/relocate.md)

 - [ListSnapshotSchedules](api-ref/grpc/Disk/listSnapshotSchedules.md)

 - [ListAccessBindings](api-ref/grpc/Disk/listAccessBindings.md)

 - [SetAccessBindings](api-ref/grpc/Disk/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/grpc/Disk/updateAccessBindings.md)

#### DiskType

 - [Overview](api-ref/grpc/DiskType/index.md)

 - [Get](api-ref/grpc/DiskType/get.md)

 - [List](api-ref/grpc/DiskType/list.md)

#### Filesystem

 - [Overview](api-ref/grpc/Filesystem/index.md)

 - [Get](api-ref/grpc/Filesystem/get.md)

 - [List](api-ref/grpc/Filesystem/list.md)

 - [Create](api-ref/grpc/Filesystem/create.md)

 - [Update](api-ref/grpc/Filesystem/update.md)

 - [Delete](api-ref/grpc/Filesystem/delete.md)

 - [ListOperations](api-ref/grpc/Filesystem/listOperations.md)

 - [ListAccessBindings](api-ref/grpc/Filesystem/listAccessBindings.md)

 - [SetAccessBindings](api-ref/grpc/Filesystem/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/grpc/Filesystem/updateAccessBindings.md)

#### GpuCluster

 - [Overview](api-ref/grpc/GpuCluster/index.md)

 - [Get](api-ref/grpc/GpuCluster/get.md)

 - [List](api-ref/grpc/GpuCluster/list.md)

 - [Create](api-ref/grpc/GpuCluster/create.md)

 - [Update](api-ref/grpc/GpuCluster/update.md)

 - [Delete](api-ref/grpc/GpuCluster/delete.md)

 - [ListOperations](api-ref/grpc/GpuCluster/listOperations.md)

 - [ListInstances](api-ref/grpc/GpuCluster/listInstances.md)

 - [ListAccessBindings](api-ref/grpc/GpuCluster/listAccessBindings.md)

 - [SetAccessBindings](api-ref/grpc/GpuCluster/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/grpc/GpuCluster/updateAccessBindings.md)

#### HostGroup

 - [Overview](api-ref/grpc/HostGroup/index.md)

 - [Get](api-ref/grpc/HostGroup/get.md)

 - [List](api-ref/grpc/HostGroup/list.md)

 - [Create](api-ref/grpc/HostGroup/create.md)

 - [Update](api-ref/grpc/HostGroup/update.md)

 - [Delete](api-ref/grpc/HostGroup/delete.md)

 - [ListOperations](api-ref/grpc/HostGroup/listOperations.md)

 - [ListInstances](api-ref/grpc/HostGroup/listInstances.md)

 - [ListHosts](api-ref/grpc/HostGroup/listHosts.md)

 - [UpdateHost](api-ref/grpc/HostGroup/updateHost.md)

 - [ListAccessBindings](api-ref/grpc/HostGroup/listAccessBindings.md)

 - [SetAccessBindings](api-ref/grpc/HostGroup/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/grpc/HostGroup/updateAccessBindings.md)

#### HostType

 - [Overview](api-ref/grpc/HostType/index.md)

 - [Get](api-ref/grpc/HostType/get.md)

 - [List](api-ref/grpc/HostType/list.md)

#### Image

 - [Overview](api-ref/grpc/Image/index.md)

 - [Get](api-ref/grpc/Image/get.md)

 - [GetLatestByFamily](api-ref/grpc/Image/getLatestByFamily.md)

 - [List](api-ref/grpc/Image/list.md)

 - [Create](api-ref/grpc/Image/create.md)

 - [Update](api-ref/grpc/Image/update.md)

 - [Delete](api-ref/grpc/Image/delete.md)

 - [ListOperations](api-ref/grpc/Image/listOperations.md)

 - [ListAccessBindings](api-ref/grpc/Image/listAccessBindings.md)

 - [SetAccessBindings](api-ref/grpc/Image/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/grpc/Image/updateAccessBindings.md)

#### Instance

 - [Overview](api-ref/grpc/Instance/index.md)

 - [Get](api-ref/grpc/Instance/get.md)

 - [List](api-ref/grpc/Instance/list.md)

 - [Create](api-ref/grpc/Instance/create.md)

 - [Update](api-ref/grpc/Instance/update.md)

 - [Delete](api-ref/grpc/Instance/delete.md)

 - [UpdateMetadata](api-ref/grpc/Instance/updateMetadata.md)

 - [GetSerialPortOutput](api-ref/grpc/Instance/getSerialPortOutput.md)

 - [Stop](api-ref/grpc/Instance/stop.md)

 - [Start](api-ref/grpc/Instance/start.md)

 - [Restart](api-ref/grpc/Instance/restart.md)

 - [AttachDisk](api-ref/grpc/Instance/attachDisk.md)

 - [DetachDisk](api-ref/grpc/Instance/detachDisk.md)

 - [AttachFilesystem](api-ref/grpc/Instance/attachFilesystem.md)

 - [DetachFilesystem](api-ref/grpc/Instance/detachFilesystem.md)

 - [AddOneToOneNat](api-ref/grpc/Instance/addOneToOneNat.md)

 - [RemoveOneToOneNat](api-ref/grpc/Instance/removeOneToOneNat.md)

 - [UpdateNetworkInterface](api-ref/grpc/Instance/updateNetworkInterface.md)

 - [AttachNetworkInterface](api-ref/grpc/Instance/attachNetworkInterface.md)

 - [DetachNetworkInterface](api-ref/grpc/Instance/detachNetworkInterface.md)

 - [ListOperations](api-ref/grpc/Instance/listOperations.md)

 - [SimulateMaintenanceEvent](api-ref/grpc/Instance/simulateMaintenanceEvent.md)

 - [Move](api-ref/grpc/Instance/move.md)

 - [Relocate](api-ref/grpc/Instance/relocate.md)

 - [ListAccessBindings](api-ref/grpc/Instance/listAccessBindings.md)

 - [SetAccessBindings](api-ref/grpc/Instance/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/grpc/Instance/updateAccessBindings.md)

#### Maintenance

 - [Overview](api-ref/grpc/Maintenance/index.md)

 - [List](api-ref/grpc/Maintenance/list.md)

 - [Get](api-ref/grpc/Maintenance/get.md)

 - [Reschedule](api-ref/grpc/Maintenance/reschedule.md)

#### Operation

 - [Overview](api-ref/grpc/Operation/index.md)

 - [Get](api-ref/grpc/Operation/get.md)

 - [Cancel](api-ref/grpc/Operation/cancel.md)

#### PlacementGroup

 - [Overview](api-ref/grpc/PlacementGroup/index.md)

 - [Get](api-ref/grpc/PlacementGroup/get.md)

 - [List](api-ref/grpc/PlacementGroup/list.md)

 - [Create](api-ref/grpc/PlacementGroup/create.md)

 - [Update](api-ref/grpc/PlacementGroup/update.md)

 - [Delete](api-ref/grpc/PlacementGroup/delete.md)

 - [ListInstances](api-ref/grpc/PlacementGroup/listInstances.md)

 - [ListOperations](api-ref/grpc/PlacementGroup/listOperations.md)

 - [ListAccessBindings](api-ref/grpc/PlacementGroup/listAccessBindings.md)

 - [SetAccessBindings](api-ref/grpc/PlacementGroup/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/grpc/PlacementGroup/updateAccessBindings.md)

#### ReservedInstancePool

 - [Overview](api-ref/grpc/ReservedInstancePool/index.md)

 - [Get](api-ref/grpc/ReservedInstancePool/get.md)

 - [List](api-ref/grpc/ReservedInstancePool/list.md)

 - [Create](api-ref/grpc/ReservedInstancePool/create.md)

 - [Update](api-ref/grpc/ReservedInstancePool/update.md)

 - [Delete](api-ref/grpc/ReservedInstancePool/delete.md)

 - [ListOperations](api-ref/grpc/ReservedInstancePool/listOperations.md)

 - [ListInstances](api-ref/grpc/ReservedInstancePool/listInstances.md)

#### SnapshotSchedule

 - [Overview](api-ref/grpc/SnapshotSchedule/index.md)

 - [Get](api-ref/grpc/SnapshotSchedule/get.md)

 - [Create](api-ref/grpc/SnapshotSchedule/create.md)

 - [Update](api-ref/grpc/SnapshotSchedule/update.md)

 - [Delete](api-ref/grpc/SnapshotSchedule/delete.md)

 - [UpdateDisks](api-ref/grpc/SnapshotSchedule/updateDisks.md)

 - [Disable](api-ref/grpc/SnapshotSchedule/disable.md)

 - [Enable](api-ref/grpc/SnapshotSchedule/enable.md)

 - [List](api-ref/grpc/SnapshotSchedule/list.md)

 - [ListOperations](api-ref/grpc/SnapshotSchedule/listOperations.md)

 - [ListSnapshots](api-ref/grpc/SnapshotSchedule/listSnapshots.md)

 - [ListDisks](api-ref/grpc/SnapshotSchedule/listDisks.md)

 - [ListAccessBindings](api-ref/grpc/SnapshotSchedule/listAccessBindings.md)

 - [SetAccessBindings](api-ref/grpc/SnapshotSchedule/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/grpc/SnapshotSchedule/updateAccessBindings.md)

#### Snapshot

 - [Overview](api-ref/grpc/Snapshot/index.md)

 - [Get](api-ref/grpc/Snapshot/get.md)

 - [List](api-ref/grpc/Snapshot/list.md)

 - [Create](api-ref/grpc/Snapshot/create.md)

 - [Update](api-ref/grpc/Snapshot/update.md)

 - [Delete](api-ref/grpc/Snapshot/delete.md)

 - [ListOperations](api-ref/grpc/Snapshot/listOperations.md)

 - [ListAccessBindings](api-ref/grpc/Snapshot/listAccessBindings.md)

 - [SetAccessBindings](api-ref/grpc/Snapshot/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/grpc/Snapshot/updateAccessBindings.md)

#### Zone

 - [Overview](api-ref/grpc/Zone/index.md)

 - [Get](api-ref/grpc/Zone/get.md)

 - [List](api-ref/grpc/Zone/list.md)

#### Compute Cloud Instance Groups API

 - [Overview](instancegroup/api-ref/grpc/index.md)

##### InstanceGroup

 - [Overview](instancegroup/api-ref/grpc/InstanceGroup/index.md)

 - [Get](instancegroup/api-ref/grpc/InstanceGroup/get.md)

 - [List](instancegroup/api-ref/grpc/InstanceGroup/list.md)

 - [Create](instancegroup/api-ref/grpc/InstanceGroup/create.md)

 - [CreateFromYaml](instancegroup/api-ref/grpc/InstanceGroup/createFromYaml.md)

 - [Update](instancegroup/api-ref/grpc/InstanceGroup/update.md)

 - [UpdateFromYaml](instancegroup/api-ref/grpc/InstanceGroup/updateFromYaml.md)

 - [Delete](instancegroup/api-ref/grpc/InstanceGroup/delete.md)

 - [Start](instancegroup/api-ref/grpc/InstanceGroup/start.md)

 - [Stop](instancegroup/api-ref/grpc/InstanceGroup/stop.md)

 - [RollingRestart](instancegroup/api-ref/grpc/InstanceGroup/rollingRestart.md)

 - [RollingRecreate](instancegroup/api-ref/grpc/InstanceGroup/rollingRecreate.md)

 - [ListInstances](instancegroup/api-ref/grpc/InstanceGroup/listInstances.md)

 - [DeleteInstances](instancegroup/api-ref/grpc/InstanceGroup/deleteInstances.md)

 - [StopInstances](instancegroup/api-ref/grpc/InstanceGroup/stopInstances.md)

 - [ResumeProcesses](instancegroup/api-ref/grpc/InstanceGroup/resumeProcesses.md)

 - [PauseProcesses](instancegroup/api-ref/grpc/InstanceGroup/pauseProcesses.md)

 - [DisableZones](instancegroup/api-ref/grpc/InstanceGroup/disableZones.md)

 - [EnableZones](instancegroup/api-ref/grpc/InstanceGroup/enableZones.md)

 - [ListOperations](instancegroup/api-ref/grpc/InstanceGroup/listOperations.md)

 - [ListLogRecords](instancegroup/api-ref/grpc/InstanceGroup/listLogRecords.md)

 - [ListAccessBindings](instancegroup/api-ref/grpc/InstanceGroup/listAccessBindings.md)

 - [SetAccessBindings](instancegroup/api-ref/grpc/InstanceGroup/setAccessBindings.md)

 - [UpdateAccessBindings](instancegroup/api-ref/grpc/InstanceGroup/updateAccessBindings.md)

##### Operation

 - [Overview](instancegroup/api-ref/grpc/Operation/index.md)

 - [Get](instancegroup/api-ref/grpc/Operation/get.md)

 - [Cancel](instancegroup/api-ref/grpc/Operation/cancel.md)

### REST (англ.)

 - [Overview](api-ref/index.md)

#### DiskPlacementGroup

 - [Overview](api-ref/DiskPlacementGroup/index.md)

 - [Get](api-ref/DiskPlacementGroup/get.md)

 - [List](api-ref/DiskPlacementGroup/list.md)

 - [Create](api-ref/DiskPlacementGroup/create.md)

 - [Update](api-ref/DiskPlacementGroup/update.md)

 - [Delete](api-ref/DiskPlacementGroup/delete.md)

 - [ListDisks](api-ref/DiskPlacementGroup/listDisks.md)

 - [ListOperations](api-ref/DiskPlacementGroup/listOperations.md)

 - [ListAccessBindings](api-ref/DiskPlacementGroup/listAccessBindings.md)

 - [SetAccessBindings](api-ref/DiskPlacementGroup/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/DiskPlacementGroup/updateAccessBindings.md)

#### Disk

 - [Overview](api-ref/Disk/index.md)

 - [Get](api-ref/Disk/get.md)

 - [List](api-ref/Disk/list.md)

 - [Create](api-ref/Disk/create.md)

 - [Update](api-ref/Disk/update.md)

 - [Delete](api-ref/Disk/delete.md)

 - [ListOperations](api-ref/Disk/listOperations.md)

 - [Move](api-ref/Disk/move.md)

 - [Relocate](api-ref/Disk/relocate.md)

 - [ListAccessBindings](api-ref/Disk/listAccessBindings.md)

 - [SetAccessBindings](api-ref/Disk/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/Disk/updateAccessBindings.md)

#### DiskType

 - [Overview](api-ref/DiskType/index.md)

 - [Get](api-ref/DiskType/get.md)

 - [List](api-ref/DiskType/list.md)

#### Filesystem

 - [Overview](api-ref/Filesystem/index.md)

 - [Get](api-ref/Filesystem/get.md)

 - [List](api-ref/Filesystem/list.md)

 - [Create](api-ref/Filesystem/create.md)

 - [Update](api-ref/Filesystem/update.md)

 - [Delete](api-ref/Filesystem/delete.md)

 - [ListOperations](api-ref/Filesystem/listOperations.md)

 - [ListAccessBindings](api-ref/Filesystem/listAccessBindings.md)

 - [SetAccessBindings](api-ref/Filesystem/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/Filesystem/updateAccessBindings.md)

#### GpuCluster

 - [Overview](api-ref/GpuCluster/index.md)

 - [Get](api-ref/GpuCluster/get.md)

 - [List](api-ref/GpuCluster/list.md)

 - [Create](api-ref/GpuCluster/create.md)

 - [Update](api-ref/GpuCluster/update.md)

 - [Delete](api-ref/GpuCluster/delete.md)

 - [ListOperations](api-ref/GpuCluster/listOperations.md)

 - [ListInstances](api-ref/GpuCluster/listInstances.md)

 - [ListAccessBindings](api-ref/GpuCluster/listAccessBindings.md)

 - [SetAccessBindings](api-ref/GpuCluster/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/GpuCluster/updateAccessBindings.md)

#### HostGroup

 - [Overview](api-ref/HostGroup/index.md)

 - [Get](api-ref/HostGroup/get.md)

 - [List](api-ref/HostGroup/list.md)

 - [Create](api-ref/HostGroup/create.md)

 - [Update](api-ref/HostGroup/update.md)

 - [Delete](api-ref/HostGroup/delete.md)

 - [ListOperations](api-ref/HostGroup/listOperations.md)

 - [ListInstances](api-ref/HostGroup/listInstances.md)

 - [ListHosts](api-ref/HostGroup/listHosts.md)

 - [UpdateHost](api-ref/HostGroup/updateHost.md)

 - [ListAccessBindings](api-ref/HostGroup/listAccessBindings.md)

 - [SetAccessBindings](api-ref/HostGroup/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/HostGroup/updateAccessBindings.md)

#### HostType

 - [Overview](api-ref/HostType/index.md)

 - [Get](api-ref/HostType/get.md)

 - [List](api-ref/HostType/list.md)

#### Image

 - [Overview](api-ref/Image/index.md)

 - [Get](api-ref/Image/get.md)

 - [GetLatestByFamily](api-ref/Image/getLatestByFamily.md)

 - [List](api-ref/Image/list.md)

 - [Create](api-ref/Image/create.md)

 - [Update](api-ref/Image/update.md)

 - [Delete](api-ref/Image/delete.md)

 - [ListOperations](api-ref/Image/listOperations.md)

 - [ListAccessBindings](api-ref/Image/listAccessBindings.md)

 - [SetAccessBindings](api-ref/Image/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/Image/updateAccessBindings.md)

#### Instance

 - [Overview](api-ref/Instance/index.md)

 - [Get](api-ref/Instance/get.md)

 - [List](api-ref/Instance/list.md)

 - [Create](api-ref/Instance/create.md)

 - [Update](api-ref/Instance/update.md)

 - [Delete](api-ref/Instance/delete.md)

 - [UpdateMetadata](api-ref/Instance/updateMetadata.md)

 - [GetSerialPortOutput](api-ref/Instance/getSerialPortOutput.md)

 - [Stop](api-ref/Instance/stop.md)

 - [Start](api-ref/Instance/start.md)

 - [Restart](api-ref/Instance/restart.md)

 - [AttachDisk](api-ref/Instance/attachDisk.md)

 - [DetachDisk](api-ref/Instance/detachDisk.md)

 - [AttachFilesystem](api-ref/Instance/attachFilesystem.md)

 - [DetachFilesystem](api-ref/Instance/detachFilesystem.md)

 - [AddOneToOneNat](api-ref/Instance/addOneToOneNat.md)

 - [RemoveOneToOneNat](api-ref/Instance/removeOneToOneNat.md)

 - [UpdateNetworkInterface](api-ref/Instance/updateNetworkInterface.md)

 - [AttachNetworkInterface](api-ref/Instance/attachNetworkInterface.md)

 - [DetachNetworkInterface](api-ref/Instance/detachNetworkInterface.md)

 - [ListOperations](api-ref/Instance/listOperations.md)

 - [SimulateMaintenanceEvent](api-ref/Instance/simulateMaintenanceEvent.md)

 - [Move](api-ref/Instance/move.md)

 - [Relocate](api-ref/Instance/relocate.md)

 - [ListAccessBindings](api-ref/Instance/listAccessBindings.md)

 - [SetAccessBindings](api-ref/Instance/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/Instance/updateAccessBindings.md)

#### Maintenance

 - [Overview](api-ref/Maintenance/index.md)

 - [List](api-ref/Maintenance/list.md)

 - [Get](api-ref/Maintenance/get.md)

 - [Reschedule](api-ref/Maintenance/reschedule.md)

#### Operation

 - [Overview](api-ref/Operation/index.md)

 - [Get](api-ref/Operation/get.md)

 - [Cancel](api-ref/Operation/cancel.md)

#### PlacementGroup

 - [Overview](api-ref/PlacementGroup/index.md)

 - [Get](api-ref/PlacementGroup/get.md)

 - [List](api-ref/PlacementGroup/list.md)

 - [Create](api-ref/PlacementGroup/create.md)

 - [Update](api-ref/PlacementGroup/update.md)

 - [Delete](api-ref/PlacementGroup/delete.md)

 - [ListInstances](api-ref/PlacementGroup/listInstances.md)

 - [ListOperations](api-ref/PlacementGroup/listOperations.md)

 - [ListAccessBindings](api-ref/PlacementGroup/listAccessBindings.md)

 - [SetAccessBindings](api-ref/PlacementGroup/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/PlacementGroup/updateAccessBindings.md)

#### ReservedInstancePool

 - [Overview](api-ref/ReservedInstancePool/index.md)

 - [Get](api-ref/ReservedInstancePool/get.md)

 - [List](api-ref/ReservedInstancePool/list.md)

 - [Create](api-ref/ReservedInstancePool/create.md)

 - [Update](api-ref/ReservedInstancePool/update.md)

 - [Delete](api-ref/ReservedInstancePool/delete.md)

 - [ListOperations](api-ref/ReservedInstancePool/listOperations.md)

 - [ListInstances](api-ref/ReservedInstancePool/listInstances.md)

#### SnapshotSchedule

 - [Overview](api-ref/SnapshotSchedule/index.md)

 - [Get](api-ref/SnapshotSchedule/get.md)

 - [Create](api-ref/SnapshotSchedule/create.md)

 - [Update](api-ref/SnapshotSchedule/update.md)

 - [Delete](api-ref/SnapshotSchedule/delete.md)

 - [UpdateDisks](api-ref/SnapshotSchedule/updateDisks.md)

 - [Disable](api-ref/SnapshotSchedule/disable.md)

 - [Enable](api-ref/SnapshotSchedule/enable.md)

 - [List](api-ref/SnapshotSchedule/list.md)

 - [ListOperations](api-ref/SnapshotSchedule/listOperations.md)

 - [ListSnapshots](api-ref/SnapshotSchedule/listSnapshots.md)

 - [ListDisks](api-ref/SnapshotSchedule/listDisks.md)

 - [ListAccessBindings](api-ref/SnapshotSchedule/listAccessBindings.md)

 - [SetAccessBindings](api-ref/SnapshotSchedule/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/SnapshotSchedule/updateAccessBindings.md)

#### Snapshot

 - [Overview](api-ref/Snapshot/index.md)

 - [Get](api-ref/Snapshot/get.md)

 - [List](api-ref/Snapshot/list.md)

 - [Create](api-ref/Snapshot/create.md)

 - [Update](api-ref/Snapshot/update.md)

 - [Delete](api-ref/Snapshot/delete.md)

 - [ListOperations](api-ref/Snapshot/listOperations.md)

 - [ListAccessBindings](api-ref/Snapshot/listAccessBindings.md)

 - [SetAccessBindings](api-ref/Snapshot/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/Snapshot/updateAccessBindings.md)

#### Zone

 - [Overview](api-ref/Zone/index.md)

 - [Get](api-ref/Zone/get.md)

 - [List](api-ref/Zone/list.md)

#### Compute Cloud Instance Groups API

 - [Overview](instancegroup/api-ref/index.md)

##### InstanceGroup

 - [Overview](instancegroup/api-ref/InstanceGroup/index.md)

 - [Get](instancegroup/api-ref/InstanceGroup/get.md)

 - [List](instancegroup/api-ref/InstanceGroup/list.md)

 - [Create](instancegroup/api-ref/InstanceGroup/create.md)

 - [CreateFromYaml](instancegroup/api-ref/InstanceGroup/createFromYaml.md)

 - [Update](instancegroup/api-ref/InstanceGroup/update.md)

 - [UpdateFromYaml](instancegroup/api-ref/InstanceGroup/updateFromYaml.md)

 - [Delete](instancegroup/api-ref/InstanceGroup/delete.md)

 - [Start](instancegroup/api-ref/InstanceGroup/start.md)

 - [Stop](instancegroup/api-ref/InstanceGroup/stop.md)

 - [RollingRestart](instancegroup/api-ref/InstanceGroup/rollingRestart.md)

 - [RollingRecreate](instancegroup/api-ref/InstanceGroup/rollingRecreate.md)

 - [ListInstances](instancegroup/api-ref/InstanceGroup/listInstances.md)

 - [DeleteInstances](instancegroup/api-ref/InstanceGroup/deleteInstances.md)

 - [StopInstances](instancegroup/api-ref/InstanceGroup/stopInstances.md)

 - [ResumeProcesses](instancegroup/api-ref/InstanceGroup/resumeProcesses.md)

 - [PauseProcesses](instancegroup/api-ref/InstanceGroup/pauseProcesses.md)

 - [ListOperations](instancegroup/api-ref/InstanceGroup/listOperations.md)

 - [ListLogRecords](instancegroup/api-ref/InstanceGroup/listLogRecords.md)

 - [ListAccessBindings](instancegroup/api-ref/InstanceGroup/listAccessBindings.md)

 - [SetAccessBindings](instancegroup/api-ref/InstanceGroup/setAccessBindings.md)

 - [UpdateAccessBindings](instancegroup/api-ref/InstanceGroup/updateAccessBindings.md)

##### Operation

 - [Overview](instancegroup/api-ref/Operation/index.md)

 - [Get](instancegroup/api-ref/Operation/get.md)

 - [Cancel](instancegroup/api-ref/Operation/cancel.md)

 - [Метрики Monitoring](metrics.md)

 - [Аудитные логи Audit Trails](at-ref.md)

 - [История изменений](release-notes.md)

## Вопросы и ответы

 - [Общие вопросы](qa/general.md)

 - [Виртуальные машины](qa/vm.md)

 - [Ошибка Not enough resources](qa/not-enough-resources.md)

 - [Подключение](qa/connection.md)

 - [Диски, снимки, образы](qa/disks.md)

 - [Группы виртуальных машин](qa/instance-groups.md)

 - [Графические ускорители GPU](qa/gpu.md)

 - [Мониторинг](qa/monitoring.md)

 - [Лицензирование](qa/licensing.md)

 - [Решение проблем](qa/troubleshooting.md)

 - [Все вопросы на одной странице](qa/all.md)

 - [Обучающие курсы](training.md)