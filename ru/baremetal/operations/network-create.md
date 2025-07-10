---
title: Как создать VRF в {{ baremetal-full-name }}
description: Следуя данной инструкции, вы сможете создать виртуальный сегмент сети (VRF) в {{ baremetal-full-name }}.
---

# Создать VRF

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать [виртуальный сегмент сети (VRF)](../concepts/network.md#vrf-segment).
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. На панели слева выберите ![icon](../../_assets/console-icons/vector-square.svg) **{{ ui-key.yacloud.baremetal.label_networks }}**.
  1. Справа вверху нажмите кнопку **{{ ui-key.yacloud.baremetal.label_create-network }}**.
  1. В поле **{{ ui-key.yacloud.baremetal.field_name }}** укажите имя VRF. Требования к имени:

     {% include [name-format](../../_includes/name-format.md) %}

  1. (Опционально) Добавьте **{{ ui-key.yacloud.baremetal.field_description }}** VRF.
  1. (Опционально) Добавьте метки.
  1. Нажмите кнопку **{{ ui-key.yacloud.baremetal.label_create-network }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды для создания [виртуального сегмента сети (VRF)](../concepts/network.md#vrf-segment):

     ```bash
     yc baremetal vrf create --help
     ```
  
  1. Создайте VRF:
     
     ```bash
     yc baremetal vrf create \
       --name <имя_VRF> \
       --description "<описание_VRF>" \
       --labels <ключ>=<значение>
     ```

     Где:
     * `--name` — имя VRF. Требования к имени:
       
       {% include [name-format](../../_includes/name-format.md) %}

     * `--description` — описание VRF. Необязательный параметр.
     * `--labels` — метки VRF. Необязательный параметр.

{% endlist %}

## Пример {#examples}

Создайте виртуальный сегмент сети с именем, описанием и меткой:

{% list tabs group=instructions %}

- CLI {#cli}

  ```bash
  yc baremetal vrf create \
    --name demo-vrf \
    --description "My first VRF" \
    --labels env=test
  ```

  Результат:  
  
  ```text
  id: ly52l2lzaq5uw********
  cloud_id: b1gia87mbaom********
  folder_id: b1g0ijbfaqsn********
  name: demo-vrf
  description: My first VRF
  created_at: "2025-07-01T21:37:08.740581Z"
  labels:
    env: test
  ```

{% endlist %}