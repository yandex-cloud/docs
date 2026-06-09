# Создать образ из снимка диска

Чтобы создать образ из [снимка](../../concepts/snapshot.md) диска:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать образ.
  1. Перейдите в сервис **{{ compute-name }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/picture.svg) **{{ ui-key.yacloud.compute.snapshots_81jHX }}**.
  1. В строке с нужным снимком нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.compute.snapshots.list.button_action-image }}**.
  1. Введите имя образа. Требования к имени:

      * длина — от 3 до 63 символов;
      * может содержать строчные буквы латинского алфавита, цифры и дефисы;
      * первый символ — буква, последний — не дефис.

  1. При необходимости укажите произвольное текстовое описание образа.
  1. Разверните блок **{{ ui-key.yacloud.compute.section_additional_7yvYG }}**.
  1. (Опционально) В поле **{{ ui-key.yacloud.compute.hardware-generation_1iEpT }}** выберите нужное [поколение](../../concepts/hardware-generations.md#configurations) виртуализированного оборудования, которое будет закреплено за создаваемым образом:

      * `{{ ui-key.yacloud.compute.hardware-gen1-v2-title_eSmBa }}` — поколение `Gen 1.2`.
      * `{{ ui-key.yacloud.compute.hardware-gen2-title_a2Gfq }}` — поколение `Gen 2`.
      * `{{ ui-key.yacloud.compute.hardware-gen1-v1-title_oK6qE }}` — поколение `Gen 1.1`.

      Если вы не зададите поколение оборудования, по умолчанию за создаваемым образом будет закреплено то же поколение, что и за снимком-источником.
  1. (Опционально) Чтобы создать [оптимизированный образ](../../concepts/image.md#images-optimized-for-deployment), включите опцию **{{ ui-key.yacloud.compute.images.popup-upload_field_pooled }}**.
  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для создания образа:

      ```
      yc compute image create --help
      ```
  1. Получите список снимков в каталоге по умолчанию:

      ```bash
      yc compute snapshot list
      ```
      
      Результат:
      
      ```text
      +----------------------+-----------------+----------------------+--------+----------------------------+
      |          ID          |       NAME      |     PRODUCT IDS      | STATUS |        DESCRIPTION         |
      +----------------------+-----------------+----------------------+--------+----------------------------+
      | fd8rlt1u2rf0l******* | first-snapshot  | f2ecl5vhsftd******** | READY  | my first snapshot via CLI  |
      | fhmolt1u2rf0******** | second-snapshot | f2eclmol5lps******** | READY  | my second snapshot via CLI |
      +----------------------+-----------------+----------------------+--------+----------------------------+
      ```

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужного снимка.
  1. Создайте образ в каталоге по умолчанию:

      ```
      yc compute image create \
        --name <имя_создаваемого_образа> \
        --source-snapshot-name <имя_снимка-источника> \
        --pooled \
        --hardware-generation-id <поколение_оборудования> \
        --hardware-features pci_topology=<топология_PCI>
      ```

      Где:
      * `--name` — имя создаваемого образа. Требования к имени:

          * длина — от 3 до 63 символов;
          * может содержать строчные буквы латинского алфавита, цифры и дефисы;
          * первый символ — буква, последний — не дефис.

      * `--source-snapshot-name` — имя снимка-источника. Вместо имени вы можете передать в команду идентификатор снимка-источника в параметре `--source-snapshot-id`.
      * `--pooled` — параметр, позволяющий создать [оптимизированный образ](../../concepts/image.md#images-optimized-for-deployment). Необязательный параметр.
      * `--hardware-generation-id` — [поколение](../../concepts/hardware-generations.md#configurations) виртуализированного оборудования, закрепляемое за образом. Необязательный параметр. Возможные значения:

          * `legacy` — поколение `Gen 1`. При выборе этого поколения вы также можете задать топологию PCI в параметре `--hardware-features`.
          * `generation2` — поколение `Gen 2`. При выборе этого поколения задавать параметр `--hardware-features` не нужно.

          Если параметр не задан, за созданным образом будет закреплено то же поколение оборудования, которое закреплено за снимком-источником.
      * `--hardware-features` — дополнительные настройки для поколения `Gen 1`. Необязательный параметр. Возможные значения:

          * `pci_topology=v1` — выбор топологии `PCI_TOPOLOGY_V1`.
          * `pci_topology=v2` — выбор топологии `PCI_TOPOLOGY_V2`.

          Если за снимком-источником закреплено поколение `Gen 2`, по умолчанию у создаваемого образа для параметра `--hardware-features` будет задано значение `pci_topology=v1`.

          Если за снимком-источником закреплено поколение `Gen 1`, по умолчанию у создаваемого образа для параметра `--hardware-features` будет задано то же значение, что и у снимка-источника.

      Результат:

      ```text
      done (5s)
      id: fd8lt5sskh12********
      folder_id: b1gt6g8ht345********
      created_at: "2025-06-23T19:26:46Z"
      name: my-first-image
      storage_size: "3116367872"
      min_disk_size: "21474836480"
      product_ids:
        - f2evcrm9ti79********
      status: READY
      os:
        type: LINUX
      hardware_generation:
        legacy_features:
          pci_topology: PCI_TOPOLOGY_V2
      ```

- {{ TF }} {#tf}

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. Опишите в конфигурационном файле параметры ресурса `yandex_compute_image`.

     Пример структуры конфигурационного файла:

     ```hcl
     resource "yandex_compute_image" "image-1" {
       name            = "<имя_образа>"
       source_snapshot = "<идентификатор_снимка-источника>"
       hardware_generation {
         legacy_features {
           pci_topology = "<топология_PCI>"
         }
       }
     }
     ```

      Где:
      * `name` — имя создаваемого образа. Требования к имени:

          * длина — от 3 до 63 символов;
          * может содержать строчные буквы латинского алфавита, цифры и дефисы;
          * первый символ — буква, последний — не дефис.

      * `source_snapshot` — идентификатор снимка-источника.
      * `hardware_generation` — блок настроек с описанием [поколения](../../concepts/hardware-generations.md#configurations) виртуализированного оборудования, закрепляемого за образом. Необязательный параметр. Включает в себя следующие блоки настроек:

          * `legacy_features` — блок настроек с описанием параметров при выборе поколения `Gen 1`:
          
              * `pci_topology` — выбор топологии PCI. Возможные значения:
          
                  * `PCI_TOPOLOGY_V1` — выбор топологии `PCI_TOPOLOGY_V1`.
                  * `PCI_TOPOLOGY_V2` — выбор топологии `PCI_TOPOLOGY_V2`.
          
              Использование блока `legacy_features` делает невозможным использование блока `generation2_features`.
          * `generation2_features` — блок настроек для выбора поколения `Gen 2`. При выборе поколения `Gen 2` задавать дополнительные настройки не требуется.
          
              Использование блока `generation2_features` делает невозможным использование блока `legacy_features`.

          {% note info %}

          Если блок `hardware_generation` не задан, за созданным образом будет закреплено то же поколение оборудования, которое закреплено за снимком-источником.

          {% endnote %}

     Более подробную информацию о ресурсе `yandex_compute_image` см. в [документации провайдера]({{ tf-provider-resources-link }}/compute_image).

  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

       Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Разверните облачные ресурсы.

     1. Выполните команду:

        ```bash
        terraform apply
        ```

     1. Подтвердите создание ресурсов.

     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

- API {#api}

  1. Получите список снимков с помощью метода REST API [list](../../api-ref/Snapshot/list.md) для ресурса [Snapshot](../../api-ref/Snapshot/index.md) или вызова gRPC API [SnapshotService/List](../../api-ref/grpc/Snapshot/list.md).
  1. Создайте образ с помощью метода REST API [create](../../api-ref/Image/create.md) для ресурса [Image](../../api-ref/Snapshot/index.md) или вызова gRPC API [ImageService/Create](../../api-ref/grpc/Image/create.md). В запросе укажите идентификатор снимка-источника, а также при необходимости задайте нужное [поколение](../../concepts/hardware-generations.md#configurations) виртуализированного оборудования в [объекте `hardwareGeneration`](../../api-ref/Image/create.md#yandex.cloud.compute.v1.HardwareGeneration) ([`hardware_generation`](../../api-ref/grpc/Image/create.md#yandex.cloud.compute.v1.HardwareGeneration) при использовании gRPC API).

{% endlist %}

После создания образ перейдет в статус `CREATING`. Дождитесь, когда образ перейдет в статус `READY`, прежде чем его использовать.