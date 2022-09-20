---
title: Инструкции по работе с {{ ml-platform-full-name }}
description: "Страница содержит все инструкции для работы с {{ ml-platform-full-name }} в Yandex Cloud. Рассказываем о том, как создать проект, установить зависимости, запустить примеры кода в ноутбуке, работать с контрольными точками, управлять вычислительными ресурсами, публиковать ноутбук, работать с Git, загрузить данные из различных источников и развернуть обученную модель как микросервис."
---

# Пошаговые инструкции для {{ ml-platform-name }}

## Управление сообществом {#community}

* [{#T}](community/create.md)
* [{#T}](community/add-user.md)
* [{#T}](community/link-channel.md)
* [{#T}](community/delete.md)

## Управление проектом {#project}

* [{#T}](projects/create.md)
* [{#T}](projects/storage-resize.md)
* [{#T}](projects/add-user.md)
* [{#T}](projects/update.md)
* [{#T}](projects/python-version.md)
* [{#T}](projects/delete.md)
{% if product == "yandex-cloud" %}
* [{#T}](data-proc-integration.md)
{% endif %}

## Работа в ноутбуке {#notebook}

* [{#T}](projects/control-compute-resources.md)
* [{#T}](projects/install-dependencies.md)
* [{#T}](projects/clear-kernel-state.md)
* [{#T}](projects/work-with-git.md)
* [{#T}](user-images-cell.md)

## Работа с ресурсами {#resources}

* [{#T}](data/secrets.md)
* [{#T}](projects/checkpoints.md)
* [{#T}](user-images.md)

## Подключение к источникам данных {#connections-to-data-sources}

* [{#T}](data/connect-to-s3.md)
* [{#T}](data/connect-to-google-drive.md)
* [{#T}](data/connect-to-clickhouse.md)
* [{#T}](data/connect-to-postgresql.md)
* [{#T}](data/connect-to-ya-disk.md)

## Развертывание эксплуатации моделей {#deploy}

* [{#T}](deploy/node-create.md)
* [{#T}](deploy/node-update.md)
* [{#T}](deploy/node-delete.md)
* [{#T}](deploy/node-customization.md)
* [{#T}](deploy/node-api.md)
* [{#T}](deploy/alias-create.md)
* [{#T}](deploy/alias-update.md)
* [{#T}](deploy/alias-delete.md)

## Совместный доступ к ресурсам, проектам и результатам вычислений {#share}

* [{#T}](projects/publication.md)
* [{#T}](projects/export.md)

{% if product == "yandex-cloud" %}

## Дополнительные возможности {{ ml-platform-name }}

* [{#T}](taas-run.md)
* [{#T}](migration.md)

{% endif %}