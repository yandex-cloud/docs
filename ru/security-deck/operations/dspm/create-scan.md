---
title: Создание сканирования в {{ dspm-name }}
description: Следуя данной инструкции, вы узнаете как создавать сканирования в модуле {{ dspm-name }} сервиса {{ sd-full-name }}.
---

# Создать сканирование {{ dspm-name }}

{% include [note-preview-by-request](../../../_includes/note-preview-by-request.md) %}

[Модуль контроля данных](../../concepts/dspm.md) (Data Security Posture Management) находит чувствительную информацию в хранилищах с помощью сканирования [источников данных](../../concepts/dspm.md#data-source) — [бакетов](../../../storage/concepts/bucket.md) {{ objstorage-full-name }} и [Яндекс Дисков]({{ link-yandex }}/support/yandex-360/business/disk/web/{{ lang }}/index.html) в {{ yandex-360 }}.

Прежде чем начать работать с {{ dspm-name }}, [настройте](../../quickstart-overview.md#configure-sd) каталог по умолчанию для хранения данных сервиса {{ sd-name }}.


## Создать сканирование для {{ objstorage-name }} {#object-storage}

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![Database-Magnifier](../../../_assets/console-icons/database-magnifier.svg) **Контроль данных** и перейдите на вкладку **Регулярные сканирования**.
  1. В правом верхнем углу экрана нажмите **Новое сканирование**.
  1. В блоке **Источники данных** выберите нужный источник данных с бакетами [{{ objstorage-name }}](../../../storage/).

      При необходимости [создайте](./create-data-source.md) новый источник данных.

  1. В блоке **Доступ к данным в источниках** выберите [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md), от имени которого будет выполняться сканирование. При необходимости нажмите **Создать новый**, чтобы создать новый сервисный аккаунт.

      {% include [sa-scan-roles-warning](../../../_includes/security-deck/sa-scan-roles-warning.md) %}

  1. В блоке **Категории данных для поиска** выберите [категории данных](../../concepts/dspm.md#data-source), которые необходимо искать при сканировании:

      {% include [scan-data-types](../../../_includes/security-deck/scan-data-types.md) %}

      Вы можете выбрать все доступные категории одновременно и любую их комбинацию.

  1. {% include [scan-settings](../../../_includes/security-deck/scan-settings.md) %}
  1. Нажмите **Создать сканирование**.

  В результате в списке сканирований появится вновь созданное сканирование, которое вы сможете запускать.

{% endlist %}


## Создать сканирование для {{ yandex-360 }} {#yandex-360}

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![Database-Magnifier](../../../_assets/console-icons/database-magnifier.svg) **Контроль данных** и перейдите на вкладку **Регулярные сканирования**.
  1. В правом верхнем углу экрана нажмите **Новое сканирование**.
  1. В блоке **Источники данных** выберите нужный источник данных с ресурсами [{{ yandex-360 }}]({{ link-yandex }}/support/yandex-360/business/admin/{{ lang }}/).

      При необходимости [создайте](./create-data-source.md) новый источник данных.

  1. В блоке **Категории данных для поиска** выберите [категории данных](../../concepts/dspm.md#data-source), которые необходимо искать при сканировании:

      {% include [scan-data-types](../../../_includes/security-deck/scan-data-types.md) %}

      Вы можете выбрать все доступные категории одновременно и любую их комбинацию.

  1. {% include [scan-settings](../../../_includes/security-deck/scan-settings.md) %}
  1. Нажмите **Создать сканирование**.

  В результате в списке сканирований появится вновь созданное сканирование, которое вы сможете запускать.

{% endlist %}


#### См. также {#see-also}

* [{#T}](./create-data-source.md)
* [{#T}](../../concepts/dspm.md)
* [{#T}](../../security/index.md)