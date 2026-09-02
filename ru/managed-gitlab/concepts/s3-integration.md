---
title: Интеграция с хранилищем {{ objstorage-full-name }} в {{ mgl-full-name }}
description: Из статьи вы узнаете об интеграции с S3-хранилищем {{ objstorage-full-name }} в {{ mgl-full-name }}.
---

# Интеграция с хранилищем {{ objstorage-full-name }}

{% include [objstorage-pricing-warning](../../_includes/managed-gitlab/objstorage-pricing-warning.md) %}

{{ GL }} поддерживает использование S3-хранилища для хранения различных типов данных. Интеграция с S3-хранилищем позволяет уменьшить объем данных на дисках [инстанса](index.md#instance) и предотвратить их переполнение. Подробнее о хранении данных в [документации {{ GL }}](https://docs.gitlab.com/administration/object_storage/).

В {{ mgl-name }} можно [включить интеграцию с {{ objstorage-name }}](../operations/objstorage-integration.md), совместимым с S3, через [консоль управления]({{ link-console-main }}). При этом {{ mgl-name }} управляет созданием, использованием и масштабированием хранилища.

## Особенности и ограничения {#restrictions}

При включении интеграции с {{ objstorage-name }} выполняется реконфигурация инстанса. Если в этот момент потребуется перевыпустить сертификат {{ lets-encrypt }}, реконфигурация запустит проверку HTTP-01 Challenge и {{ lets-encrypt }} подключится к вашему домену на порт `80`. Если группа безопасности блокирует трафик на этот порт, сертификат не обновится, реконфигурация завершится ошибкой и миграция данных не запустится. Поэтому перед включением интеграции с {{ objstorage-name }} убедитесь, что группа безопасности инстанса {{ mgl-name }} [разрешает входящие подключения](../operations/configure-security-group.md) на порт `80` с внешних IP-адресов {{ lets-encrypt }}.

{% include [objstorage-disable-note](../../_includes/managed-gitlab/objstorage-disable-note.md) %}

## Доступные для хранения типы данных {#data-types}

Вы можете выбрать типы данных, которые будут храниться в {{ objstorage-name }}:

{% include [s3-object-type](../../_includes/managed-gitlab/s3-object-type.md) %}

Миграция файлов из больших репозиториев в {{ objstorage-name }} может занять более суток.
