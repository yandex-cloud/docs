[Документация Yandex Cloud](../../../index.md) > [On-premises Yandex Object Storage](../../index.md) > Версия 26.3 > Установка и настройка > Общее описание процесса установки

# Общее описание процесса установки

Для установки On-premises Yandex Object Storage используются:

* Каталог `ansible` с установочными скриптами, плейбуками и шаблоном конфигурации.
* Архив `yc-storage-<версия>.tar.zst` с On-premises Yandex Object Storage, где `<версия>` — номер версии.

Также на этапе конфигурации понадобятся следующие значения:

* размер квоты хранилища;
* номера версий `yc-storage-operator` и On-premises Yandex Object Storage из архива.

Для выполнения установки необходим установочный хост, соответствующий [минимальным требованиям](environment-preparation.md#installation-host).

Установку выполняет Ansible с помощью плейбука `playbooks/install.yaml`. Плейбук последовательно генерирует секреты, настраивает хосты, подготавливает диски, создает кластер Kubernetes и запускает установку Object Storage в кластере.

Чтобы установить On-premises Yandex Object Storage:

1. [Подготовьте окружение](environment-preparation.md): установите ОС, настройте сеть и SSH-доступ, выделите место для метаданных.
1. [Настройте параметры инсталляции](setup-install-params.md): опишите хосты в `inventory.ini` и заполните конфигурацию стенда в `group_vars/<имя_стенда>/main.yaml`.
1. [Запустите установку](installation-steps.md): проверьте план подготовки дисков, выполните плейбук и создайте DNS-записи.
1. [Проверьте результат](getting-started.md) и создайте первые тенанты и ключи доступа.

При повторном запуске можно выбрать отдельные шаги или пропустить уже выполненные с помощью [тегов](installation-steps.md#tags).

## Подробности об установке и настройке {#see-also}

* [Подготовка окружения](environment-preparation.md)
* [Настройка параметров инсталляции](setup-install-params.md)
* [Шаги установки](installation-steps.md)
* [Устранение неисправностей при установке](../troubleshooting/installation-errors.md)
* [После установки](getting-started.md)