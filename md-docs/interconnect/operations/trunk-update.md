# Изменить параметры транкового подключения

В настоящее время пользователь самостоятельно может выполнить только ряд операций по изменению транкового подключения:
* Изменить имя транка — `new-name`.
* Изменить описание транка — `description`.
* Изменить [метки](../../resource-manager/concepts/labels.md), назначенные транку.
* Установить или снять флаг защиты транка от удаления `deletion-protection`.

Все остальные действия по изменению параметров транкового подключения, в том числе [изменение емкости транкового подключения](../tutorials/trunk-capacity-change.md), по-прежнему выполняются только через обращение в техническую поддержку.

Например, для изменения имени транкового подключения необходимо выполнить следующие шаги.

{% note info %}

Для выполнения операции необходима роль [cic.editor](../security/index.md#cic-editor).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) на панели сверху нажмите ![layout-side-content-left](../../_assets/console-icons/layout-side-content-left.svg) или ![chevron-down](../../_assets/console-icons/chevron-down.svg) и выберите нужный [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Cloud Interconnect**.
  1. На панели слева выберите ![pipeline](../../_assets/console-icons/pipeline.svg) **Транковые подключения**.
  1. В строке с нужным транковым подключением нажмите значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите ![pencil](../../_assets/console-icons/pencil.svg) **Редактировать**. В открывшемся окне:

      1. (Опционально) Измените **Имя** подключения. Требования к имени:

          * длина — от 3 до 63 символов;
          * может содержать строчные буквы латинского алфавита, цифры и дефисы;
          * первый символ — буква, последний — не дефис.

          Если не указать имя, подключению будет присвоено имя, идентичное [идентификатору](../../api-design-guide/concepts/resources-identification.md) этого подключения.

      1. (Опционально) Измените **Описание** подключения.
      1. (Опционально) Измените [**Метки**](../../resource-manager/concepts/labels.md), назначенные подключению.
      1. (Опционально) Включите или отключите опцию **Защита от удаления**, чтобы защитить подключение или снять защиту подключения от случайного удаления.
      1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  1. Посмотрите описание команды CLI для изменения параметров [транкового подключения](../concepts/trunk.md):

      ```bash
      yc cic trunk-connection update --help
      ```

  1. Измените имя транкового подключения:

      ```bash
      yc cic trunk-connection update cf3dcodot14p******** \
        --new-name my-new-trunk-name \
        --async
      ```

      Результат:

      
      ```text
      id: cf3dcodot14p********
      description: Trunk via M9
      created_at: "2025-03-27T09:43:00.880696489Z"
      created_by: ajeol2afu1js********
      modified_at: "2025-03-27T09:43:00.969837738Z"
      done: true
      metadata:
        '@type': type.googleapis.com/yandex.cloud.cic.v1.UpdateTrunkConnectionMetadata
        trunk_connection_id: cf3dcodot14p********
      response:
        '@type': type.googleapis.com/yandex.cloud.cic.v1.TrunkConnection
        id: cf3dcodot14p********
        name: my-new-trunk-name
        description: Trunk via M9
        folder_id: b1gt6g8ht345******** 
        region_id: ru-central1
        single_port_direct_joint:
          transceiver_type: TRANSCEIVER_TYPE_10GBASE_LR
          port_name: 25GE1/0/12
        point_of_presence_id: ru-msk-m9-0
        capacity: CAPACITY_10_GBPS
        status: ACTIVE
      ```



{% endlist %}