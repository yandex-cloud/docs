# Руководства по работе с системами управления инфраструктурой

* [Начало работы с {{ TF }}](terraform-quickstart.md)
* [Загрузка состояний {{ TF }} в {{ objstorage-name }}](terraform-state-storage.md)
* [Начало работы с Packer](packer-quickstart.md)
* [Сборка образа ВМ с набором инфраструктурных инструментов с помощью Packer](packer-custom-image.md)
* [Автоматизация сборки образов с помощью Jenkins и Packer](jenkins.md)
* [Непрерывное развертывание контейнеризованных приложений с помощью GitLab](gitlab-containers.md)
* [Создание кластера Linux-серверов «1С:Предприятия» с кластером {{ mpg-name }}](1c-postgresql-linux.md)
{% if product == "yandex-cloud" %}
* [Создание кластера Windows-серверов «1С:Предприятия» с базой данных MS SQL Server](1c-mssql-windows.md)
{% endif %}
* [Миграция в {{ yandex-cloud }} с помощью Hystax Acura](hystax-migration.md)
{% if product == "yandex-cloud" %}
* [Аварийное восстановление в {{ yandex-cloud }} с помощью Hystax Acura](hystax-disaster-recovery.md)
{% endif %}
{% if product == "yandex-cloud" %}
* [Резервное копирование ВМ с помощью Hystax Acura Backup](hystax-backup.md)
{% endif %}
{% if product == "yandex-cloud" %}
* [Настройка отказоустойчивой архитектуры в {{ yandex-cloud }}](fault-tolerance.md)
{% endif %}
{% if product == "yandex-cloud" %}
* [Создание SAP-программы в {{ yandex-cloud }}](sap.md)
{% endif %}
