---
title: Как создать VRF в {{ baremetal-full-name }}
description: Следуя данной инструкции, вы сможете создать виртуальный сегмент сети (VRF) в {{ baremetal-full-name }}.
---

# Создать VRF

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать [виртуальный сегмент сети (VRF)](../concepts/network.md#vrf-segment).
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
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

- API {#api}

  Чтобы создать VRF, воспользуйтесь методом REST API [create](../api-ref/Vrf/create.md) для ресурса [Vrf](../api-ref/Vrf/index.md) или вызовом gRPC API [VrfService/Create](../api-ref/grpc/Vrf/create.md).
  
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

- API {#api}

  ```bash
  curl -X POST \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer <IAM-токен>" \
    -d '{
       "folderId": "b1g07hj5r6i4********",
       "name": "baremetal-vrf",
       "description": "Test baremetal VRF",
       "labels": {
         "key": "vrf"
       }
    }' \
    "https://baremetal.api.cloud.yandex.net/baremetal/v1alpha/vrfs"
  ```

  Где:

  * `<IAM-токен>` — IAM-токен для аутентификации.
  * `folderId` — идентификатор каталога.
  * `name` — имя образа. Требования к имени:

    {% include [name-format](../../_includes/name-format.md) %}
  
  * `description` — описание VRF. Необязательный параметр.
  * `labels` — метки VRF. Необязательный параметр.

  Результат:

  ```bash
  {
    "done": true,
    "metadata": {
      "@type": "type.googleapis.com/yandex.cloud.baremetal.v1alpha.CreateVrfMetadata",
      "vrfId": "ly5uyq2gbxu2********"
    },
    "response": {
      "@type": "type.googleapis.com/yandex.cloud.baremetal.v1alpha.Vrf",
      "labels": {
        "key": "vrf"
      },
      "id": "ly5uyq2gbxu2********",
      "cloudId": "b1gia87mbaom********",
      "folderId": "b1g07hj5r6i4********",
      "name": "baremetal-vrf",
      "description": "Test baremetal VRF",
      "createdAt": "2025-12-07T21:22:16.493703Z"
    },
    "id": "ly53ac2rdtrk********",
    "description": "VRF create",
    "createdAt": "2025-12-07T21:22:16.521291Z",
    "createdBy": "ajeb9l33h6mu********",
    "modifiedAt": "2025-12-07T21:22:16.521291Z"
  }
  ```

  Отслеживайте статус операции по полю `done`.
  
{% endlist %}