# Изменение пула резервов виртуальных машин

{% note warning %}

Пулы резервов ВМ тарифицируются: взимается плата за весь свободный объем зарезервированных вычислительных ресурсов ВМ, кластеров GPU и программно ускоренных сетей согласно [правилам тарификации Yandex Compute Cloud](../../pricing.md). Подробнее в разделе [Использование пулов резервов ВМ](../../pricing.md#pool).

{% endnote %}

_Функциональность пулов резервов ВМ находится на [стадии Preview](../../../overview/concepts/launch-stages.md)._

{% note info %}

Изменить конфигурацию виртуальных машин пула нельзя.

{% endnote %}

Чтобы изменить [пул резервов ВМ](../../concepts/reserved-pools.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится пул резервов ВМ.
  1. Перейдите в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/folder-lock.svg) **Пулы резервов ВМ**.
  1. В строке с нужным пулом нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../_assets/console-icons/pencil.svg) **Редактировать**.
  1. Измените параметры ВМ:

       * Тип пула.
       * Размер пула.
       * Если нужно расширить пул, даже когда свободных ресурсов в зоне доступности недостаточно, включите опцию **При отсутствии ресурсов**. Подробнее см. [Опция ожидания ресурсов](../../concepts/reserved-pools.md#pending-slots).
       * В блоке **Общая информация о пуле** измените имя, описание пула, добавьте или удалите [метки](../../../resource-manager/concepts/labels.md) пула.

  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды [Yandex Cloud CLI](../../../cli/index.md) для изменения пула резервов ВМ:

      ```bash
      yc compute reserved-instance-pool update --help
      ```
  1. Получите список пулов резервов ВМ в каталоге по умолчанию:
     
     ```bash
     yc compute reserved-instance-pool list
     ```
     
     Результат:
     
     ```text
     +----------------------+------------+---------------+------+
     |          ID          |    NAME    |    ZONE ID    | SIZE |
     +----------------------+------------+---------------+------+
     | fv48qa9iiq19******** | test-pool1 | ru-central1-a |    1 |
     | fv42fbsrso94******** | test-pool2 | ru-central1-a |    1 |
     +----------------------+------------+---------------+------+
     ```
  1. Получите подробную информацию о пуле резервов ВМ в каталоге по умолчанию, указав имя или идентификатор нужного пула:

      ```bash
      yc compute reserved-instance-pool get <имя_или_идентификатор_пула>
      ```

      Результат:

      ```text
      id: fv4vnl1ncbja********
      zone_id: ru-central1-a
      cloud_id: b1gia87mbaom********
      folder_id: b1gt6g8ht345********
      name: test-pool
      description: sample description
      created_at: "2025-08-12T07:58:57Z"
      platform_id: standard-v2
      resources_spec:
        memory: "2147483648"
        cores: "2"
        core_fraction: "100"
      gpu_settings: {}
      network_settings:
        type: STANDARD
      size: "2"
      committed_size: "2"
      slot_stats:
        total: "2"
        used: "1"
        available: "1"
      instance_stats:
        total: "1"
      ```
  1. Измените пул резервов ВМ в каталоге по умолчанию, указав имя или идентификатор нужного пула:

      ```bash
      yc compute reserved-instance-pool update <имя_или_идентификатор_пула> \
        --new-name <новое_имя_пула> \
        --description <описание_пула> \
        --size <размер_пула> \
        --allow-oversubscription \
        --allow-pending-slots
      ```

      Где:
      * `--new-name` — новое имя пула. Необязательный параметр. Требования к имени:

          * длина — от 3 до 63 символов;
          * может содержать строчные буквы латинского алфавита, цифры и дефисы;
          * первый символ — буква, последний — не дефис.

      * `--description` — описание пула. Необязательный параметр.
      * `--size` — новое количество слотов в пуле. Необязательный параметр.
      * `--allow-oversubscription` — параметр, включающий и выключающий для пула [режим переподписки](../../concepts/reserved-pools.md#oversubscription), при котором к пулу можно привязывать ВМ в количестве, превышающем размер пула. Необязательный параметр.

          Чтобы включить режим переподписки, передайте в команде параметр `--allow-oversubscription`.

          Чтобы выключить включенный ранее режим переподписки, передайте в команде параметр `--allow-oversubscription=false`.
      * `--allow-pending-slots` — параметр, включающий [опцию ожидания ресурсов](../../concepts/reserved-pools.md#pending-slots) при изменении размера пула. Необязательный параметр. По умолчанию опция ожидания ресурсов для операции изменения размера пула выключена.

      Результат:

      ```text
      done (8s)
      id: fv4vnl1ncbja********
      zone_id: ru-central1-a
      cloud_id: b1gia87mbaom********
      folder_id: b1gt6g8ht345********
      name: new-pool
      description: the new description
      created_at: "2025-08-12T07:58:57Z"
      platform_id: standard-v2
      resources_spec:
        memory: "2147483648"
        cores: "2"
        core_fraction: "100"
      gpu_settings: {}
      network_settings:
        type: STANDARD
      size: "3"
      committed_size: "3"
      slot_stats:
        total: "3"
        used: "1"
        available: "2"
      instance_stats:
        total: "1"
      ```

      Подробнее о команде `yc compute reserved-instance-pool update` читайте в [справочнике Yandex Cloud CLI](../../../cli/cli-ref/compute/cli-ref/reserved-instance-pool/update.md).

- API {#api}

  Воспользуйтесь методом REST API [update](../../api-ref/ReservedInstancePool/update.md) для ресурса [ReservedInstancePool](../../api-ref/ReservedInstancePool/index.md) или вызовом gRPC API [ReservedInstancePoolService/Update](../../api-ref/grpc/ReservedInstancePool/update.md).

{% endlist %}

#### См. также {#see-also}

* [Управление виртуальными машинами пула резервов ВМ](manage-pool-vms.md)
* [Пулы резервов виртуальных машин в Compute Cloud](../../concepts/reserved-pools.md)