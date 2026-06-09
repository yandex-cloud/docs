# Включить программно ускоренную сеть

Вы можете включить [программно ускоренную сеть](../concepts/software-accelerated-network.md) при создании или изменении [виртуальной машины](../../glossary/vm.md).

{% note warning %}

Функциональность доступна только по согласованию с вашим аккаунт-менеджером и предоставляется по запросу в [техническую поддержку]({{ link-console-support }}).

{% endnote %}

Чтобы включить программно ускоренную сеть на существующей ВМ:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит ВМ.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}** и выберите нужную ВМ.
  1. На панели сверху нажмите ![image](../../_assets/console-icons/stop.svg) **{{ ui-key.yacloud.common.stop }}** и подтвердите остановку ВМ.
  1. Подождите, пока ВМ перейдет в статус `Stopped`, и на панели сверху нажмите ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}** выберите опцию **{{ ui-key.yacloud.component.compute.resources.field_sw-accelerated-net }}**.
  1. Нажмите **{{ ui-key.yacloud.compute.instance.edit.button_update }}**.
  1. На панели сверху нажмите ![image](../../_assets/console-icons/play.svg) **{{ ui-key.yacloud.common.start }}** и подтвердите запуск.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для обновления параметров ВМ:

      ```bash
      yc compute instance update --help
      ```

  1. Получите список ВМ в каталоге по умолчанию:

      ```bash
      yc compute instance list
      ```
      
      Результат:
      ```text
      +----------------------+-----------------+---------------+---------+----------------------+
      |          ID          |       NAME      |    ZONE ID    | STATUS  |     DESCRIPTION      |
      +----------------------+-----------------+---------------+---------+----------------------+
      | fhm0b28lgfp4******** | first-instance  | {{ region-id }}-a | RUNNING | my first vm via CLI  |
      | fhm9gk85nj7g******** | second-instance | {{ region-id }}-a | RUNNING | my second vm via CLI |
      +----------------------+-----------------+---------------+---------+----------------------+
      ```

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной ВМ и остановите ее. Например, чтобы остановить ВМ с именем `first-instance`, выполните команду:

      ```bash
      yc compute instance stop first-instance
      ```

  1. Включите программно ускоренную сеть:

      1. Выполните команду:

          ```bash
          yc compute instance update first-instance \
            --network-settings type=software-accelerated
          ```

          Где `--network-settings` — параметр, который переключает тип сети.

          Результат:

          ```text
          id: fhm0b28lgfp4********
          folder_id: b1gbnv36zqf5********
          created_at: "2023-05-24T09:28:11Z"
          name: first-instance
          zone_id: {{ region-id }}-a
          platform_id: standard-v3
          resources:
            memory: "2147483648"
            cores: "2"
            core_fraction: "100"
          status: STOPPED
          ...
          network_settings:
            type: SOFTWARE_ACCELERATED
          placement_policy: {}
          ```

      1. Запустите ВМ:

          ```bash
          yc compute instance start first-instance
          ```

  Чтобы выключить программно ускоренную сеть, остановите ВМ и выполните команду:

    ```bash
    yc compute instance update first-instance \
      --network-settings type=standard
    ```

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  Чтобы включить программно ускоренную сеть для ВМ:

  1. В конфигурационном файле в описании ресурса `yandex_compute_instance` добавьте параметр `network_acceleration_type`:

     ```hcl
     resource "yandex_compute_instance" "example" {
       ...
       network_acceleration_type = "software_accelerated"
       ...
     }
     ```

     Где `network_acceleration_type` — тип ускорения сети. Возможные значения:
     * `software_accelerated` — программно ускоренная сеть;
     * `standard` — обычная сеть. Укажите это значение, чтобы выключить программно ускоренную сеть.

     Более подробную информацию о параметрах ресурса `yandex_compute_instance` читайте в [документации провайдера]({{ tf-provider-resources-link }}/compute_instance).

  1. Создайте ресурсы:

     1. В терминале перейдите в директорию с конфигурационным файлом.
     1. Проверьте корректность конфигурации с помощью команды:
     
        ```bash
        terraform validate
        ```
     
        Если конфигурация является корректной, появится сообщение:
     
        ```bash
        Success! The configuration is valid.
        ```
     
     1. Выполните команду:
     
        ```bash
        terraform plan
        ```
     
        В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
     1. Примените изменения конфигурации:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

- API {#api}

    Воспользуйтесь методом REST API [update](../../compute/api-ref/Instance/update.md) для ресурса [Instance](../../compute/api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/Update](../../compute/api-ref/grpc/Instance/update.md).

    Для включения программно ускоренной сети передайте в теле запроса параметр `networkSettings.type` со значением `SOFTWARE_ACCELERATED`, для выключения — со значением `STANDARD`.

{% endlist %}