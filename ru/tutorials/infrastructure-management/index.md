# Руководства по работе с системами управления инфраструктурой

* [Начало работы с {{ TF }}](terraform-quickstart.md)
* [Загрузка состояний {{ TF }} в {{ objstorage-name }}](terraform-state-storage.md)
* [Начало работы с Packer](packer-quickstart.md)
* [Сборка образа ВМ с набором инфраструктурных инструментов с помощью Packer](packer-custom-image.md)
* [Автоматизация сборки образов с помощью Jenkins и Packer](jenkins.md)
* [Непрерывное развертывание контейнеризованных приложений с помощью GitLab](gitlab-containers.md)
* [Создание кластера Linux-серверов «1С:Предприятия» с кластером {{ mpg-name }}](1c-postgresql-linux.md)
{% if product == "cloud-il" %}
* [Создание кластера Windows-серверов «1С:Предприятия» с базой данных MS SQL Server](1c-mssql-windows.md)
{% endif %}
* [Миграция в {{ yandex-cloud }} с помощью Hystax Acura](hystax-migration.md)
{% if product == "yandex-cloud" %}
* [Аварийное восстановление в {{ yandex-cloud }} с помощью Hystax Acura](hystax-disaster-recovery.md)
{% endif %}
{% if product == "yandex-cloud" %}
* [Резервное копирование ВМ с помощью Hystax Acura Backup](hystax-backup.md)
* [Настройка отказоустойчивой архитектуры в {{ yandex-cloud }}](fault-tolerance.md)
* [Создание SAP-программы в {{ yandex-cloud }}](sap.md)
{% endif %}
* [Настройка синхронизации часов с помощью NTP](ntp.md)
{% if product == "yandex-cloud" %}
* [Работа с группой виртуальных машин с автоматическим масштабированием](vm-autoscale.md)
* [Масштабирование группы виртуальных машин по расписанию](vm-scale-scheduled.md)
{% endif %}
* [Автоматическое масштабирование группы виртуальных машин для обработки сообщений из очереди {{ message-queue-full-name }}](autoscale-monitoring.md)
{% if product == "yandex-cloud" %}
* [Обновление группы виртуальных машин под нагрузкой](updating-under-load.md)
{% endif %}
{% if product == "cloud-il" %}
* [Развертывание Remote Desktop Gateway](rds-gw.md)
{% endif %}
{% if product == "yandex-cloud" %}
* [Передача логов с ВМ в {{ cloud-logging-full-name }}](vm-fluent-bit-logging.md)
{% endif %}
* [Настройка локального кеширующего DNS-резолвера](local-dns-cache.md)
{% if product == "yandex-cloud" %}
* [Миграция DNS-зон из Яндекс 360 в {{ dns-full-name }}](connect-migration.md)
{% endif %}
* [Интеграция {{ dns-name }} и корпоративного сервиса DNS](dns-integration.md)
* [Создание веб-хука резолвера ACME для ответов на DNS01-проверки](cert-manager-webhook.md)
