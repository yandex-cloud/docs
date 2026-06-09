# Получить информацию о подсети

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [подсеть](../concepts/network.md#subnet).
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.vpc.network.overview.section_subnetworks }}**.
  1. Выберите нужную подсеть.
  1. На странице **{{ ui-key.yacloud.common.overview }}** отобразится подробная информация о подсети.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для получения информации о [подсети](../concepts/network.md#subnet):

      ```bash
      yc vpc subnet get --help
      ```

  1. Получите информацию о подсети, указав ее имя или идентификатор:

      ```bash
      yc vpc subnet get <имя_подсети>
      ```

      Результат:

      ```text
      id: 5ubne7r188b7********
      folder_id: f01derqpemb4********
      created_at: "2023-10-25T14:59:49Z"
      name: my-network-{{ region-id }}-a
      description: Auto-created default subnet for zone {{ region-id }}-a in my-network
      network_id: ne7w0rkfj75j********
      zone_id: {{ region-id }}-a
      v4_cidr_blocks:
        - 10.130.0.0/24
      ```

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  Чтобы получить информацию о [подсети](../concepts/network.md#subnet) с помощью {{ TF }}:

  1. Добавьте в конфигурационный файл {{ TF }} блоки `data` и `output`:

     ```hcl
     data "yandex_vpc_subnet" "my_subnet" {
       subnet_id = "<идентификатор_подсети>"
     }

     output "subnet" {
       value = data.yandex_vpc_subnet.my_subnet.zone
     }
     ```

     Где:
     * `data "yandex_vpc_subnet"` — описание подсети в качестве источника данных:
       * `subnet_id` — идентификатор подсети.
     * `output "subnet"` — выходная переменная, которая содержит название зоны доступности подсети:
       * `value` — возвращаемое значение.

     Вместо `zone` вы можете выбрать любой другой параметр для получения информации. Более подробно о параметрах источника данных `yandex_vpc_subnet` см. в [документации провайдера]({{ tf-provider-datasources-link }}/vpc_subnet).
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

     {{ TF }} создаст все требуемые ресурсы и отобразит значения выходных переменных в терминале. Чтобы проверить результат, выполните команду:

     ```bash
     terraform output
     ```

     Результат:

     ```text
     subnet = "ru-central1-a"
     ```

- API {#api}

  Чтобы получить подробную информацию о [подсети](../concepts/network.md#subnet), воспользуйтесь методом REST API [get](../api-ref/Subnet/get.md) для ресурса [Subnet](../api-ref/Subnet/index.md), или вызовом gRPC API [SubnetService/Get](../api-ref/grpc/Subnet/get.md).

{% endlist %}

#### См. также {#see-also}

* [{#T}](network-get-info.md)