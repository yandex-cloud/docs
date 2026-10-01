---
title: Установка {{ objstorage-onprem-name }} с помощью Ansible
description: Порядок подготовки, установки и проверки {{ objstorage-onprem-name }}.
---

# Общее описание процесса установки

Для установки {{ objstorage-onprem-name }} используются:

* Каталог `ansible` с установочными скриптами, плейбуками и шаблоном конфигурации.
* Архив `yc-storage-<версия>.tar.zst` с {{ objstorage-onprem-name }}, где `<версия>` — номер версии.

Также на этапе конфигурации понадобятся следующие значения:

* размер квоты хранилища;
* номера версий `yc-storage-operator` и {{ objstorage-onprem-name }} из архива.

Для выполнения установки необходим установочный хост, соответствующий [минимальным требованиям](environment-preparation.md#installation-host).

Установку выполняет Ansible с помощью плейбука `playbooks/install.yaml`. Плейбук последовательно генерирует секреты, настраивает хосты, подготавливает диски, создает кластер {{ k8s }} и запускает установку {{ objstorage-name }} в кластере.

Чтобы установить {{ objstorage-onprem-name }}:

1. [Подготовьте окружение](environment-preparation.md): установите ОС, настройте сеть и SSH-доступ, выделите место для метаданных.
1. [Настройте параметры инсталляции](setup-install-params.md): опишите хосты в `inventory.ini` и заполните конфигурацию стенда в `group_vars/<имя_стенда>/main.yaml`.
1. [Запустите установку](installation-steps.md): проверьте план подготовки дисков, выполните плейбук и создайте DNS-записи.
1. [Проверьте результат](getting-started.md) и создайте первые тенанты и ключи доступа.

При повторном запуске можно выбрать отдельные шаги или пропустить уже выполненные с помощью [тегов](installation-steps.md#tags).

## Подробности об установке и настройке {#see-also}

* [{#T}](environment-preparation.md)
* [{#T}](setup-install-params.md)
* [{#T}](installation-steps.md)
* [{#T}](../troubleshooting/installation-errors.md)
* [{#T}](getting-started.md)
