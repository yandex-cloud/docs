# Руководства по работе с системами управления инфраструктурой

* [Начало работы с {{ TF }}](terraform-quickstart.md)
* [Загрузка состояний {{ TF }} в {{ objstorage-full-name }}](terraform-state-storage.md)
* [Начало работы с Packer](packer-quickstart.md)
* [Сборка образа ВМ с набором инфраструктурных инструментов с помощью Packer](packer-custom-image.md)
* [Автоматизация сборки образов с помощью Jenkins и Packer](jenkins.md)
* [{#T}](gitlab-containers.md)
* [Создание кластера Linux-серверов «1С:Предприятия» с кластером {{ mpg-full-name }}](1c-postgresql-linux.md)

{% if product == "cloud-il" %}

* [Создание кластера Windows-серверов «1С:Предприятия» с базой данных MS {{ MS }}](1c-mssql-windows.md)

{% endif %}

* [Миграция в {{ yandex-cloud }} с помощью Hystax Acura](hystax-migration.md)

{% if product == "yandex-cloud" %}

* [Защита от сбоев с помощью Hystax Acura](hystax-disaster-recovery.md)

{% endif %}

* [Настройка синхронизации часов с помощью NTP](ntp.md)

{% if product == "yandex-cloud" %}

* [Работа с группой виртуальных машин с автоматическим масштабированием](vm-autoscale.md)
* [Масштабирование группы виртуальных машин по расписанию](vm-scale-scheduled.md)
* [Автоматическое масштабирование группы виртуальных машин для обработки сообщений из очереди {{ message-queue-full-name }}](autoscale-monitoring.md)
* [Обновление группы виртуальных машин под нагрузкой](updating-under-load.md)
* [{#T}](vm-fluent-bit-logging.md)
* [Резервное копирование ВМ с помощью Hystax Acura Backup](hystax-backup.md)
* [Настройка отказоустойчивой архитектуры в {{ yandex-cloud }}](fault-tolerance.md)
* [{#T}](sap.md)

{% endif %}

* [Настройка локального кеширующего DNS-резолвера](local-dns-cache.md)

{% if product == "yandex-cloud" %}

* [Миграция DNS-зон из Яндекс 360 в {{ dns-full-name }}](connect-migration.md)

{% endif %}

* [{#T}](dns-integration.md)
* [Создание веб-хука резолвера ACME для ответов на DNS01-проверки](cert-manager-webhook.md)

{% if product == "yandex-cloud" %}

* [Запись логов балансировщика в {{ PG }}](logging.md)
* [Создание триггера для бюджетов, который вызывает функцию {{ sf-full-name }} для остановки ВМ](serverless-trigger-budget-vm.md)

{% endif %}