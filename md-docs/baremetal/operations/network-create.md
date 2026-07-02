[Документация Yandex Cloud](../../index.md) > [Yandex BareMetal](../index.md) > [Пошаговые инструкции](index.md) > Сеть > Создать VRF

# Создать VRF

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором хотите создать [виртуальный сегмент сети (VRF)](../concepts/private-network.md#vrf-segment).
  1. Перейдите в сервис **BareMetal**.
  1. На панели слева выберите ![icon](../../_assets/console-icons/vector-square.svg) **VRF**.
  1. Справа вверху нажмите кнопку **Создать VRF**.
  1. В поле **Имя** укажите имя VRF. Требования к имени:

     * длина — от 3 до 63 символов;
     * может содержать строчные буквы латинского алфавита, цифры и дефисы;
     * первый символ — буква, последний — не дефис.

  1. (Опционально) Добавьте **Описание** VRF.
  1. (Опционально) Добавьте метки.
  1. Нажмите кнопку **Создать VRF**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды для создания [виртуального сегмента сети (VRF)](../concepts/private-network.md#vrf-segment):

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
       
       * длина — от 3 до 63 символов;
       * может содержать строчные буквы латинского алфавита, цифры и дефисы;
       * первый символ — буква, последний — не дефис.

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

    * длина — от 3 до 63 символов;
    * может содержать строчные буквы латинского алфавита, цифры и дефисы;
    * первый символ — буква, последний — не дефис.
  
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