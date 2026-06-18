# Получить информацию о кластере GPU


{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [кластер GPU](../../concepts/gpus.md#gpu-clusters).
  1. Перейдите в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/cpus.svg) **Кластеры GPU**.
  1. Выберите нужный кластер.
  1. На странице **Обзор** отобразится подробная информация о кластере GPU.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для получения информации о [кластере GPU](../../concepts/gpus.md#gpu-clusters):

      ```bash
      yc compute gpu-cluster get --help
      ```

  1. Получите информацию о кластере GPU, указав его имя или идентификатор:

      ```bash
      yc compute gpu-cluster get <имя_кластера_GPU>
      ```

      Результат:

      ```text
      id: fhm6cnc4kpp8********
      folder_id: b1gqs1teo2q2********
      created_at: "2024-02-14T15:10:21Z"
      name: test-cluster
      status: READY
      zone_id: ru-central1-a
      interconnect_type: INFINIBAND
      ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  Чтобы получить информацию о [кластере GPU](../../concepts/gpus.md#gpu-clusters) с помощью Terraform:

  1. Добавьте в конфигурационный файл Terraform блоки `data` и `output`:

      ```hcl
      data "yandex_compute_gpu_cluster" "my_gpu_cluster" {
        gpu_cluster_id = "<идентификатор_кластера_GPU>"
      }

      output "gpu_cluster" {
        value = data.yandex_compute_gpu_cluster.my_gpu_cluster.zone
      }
      ```

      Где:

      * `data "yandex_compute_gpu_cluster"` — описание кластера GPU в качестве источника данных:
        * `gpu_cluster_id` — идентификатор кластера GPU.
      * `output "gpu_cluster"` — выходная переменная, которая содержит информацию о зоне доступности кластера GPU:
        * `value` — возвращаемое значение.

     Вместо `zone` вы можете выбрать любой другой параметр для получения информации. Более подробно о параметрах источника данных `yandex_compute_gpu_cluster` читайте в [документации провайдера](../../../terraform/data-sources/compute_gpu_cluster.md).

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
      
         В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
      1. Примените изменения конфигурации:
      
         ```bash
         terraform apply
         ```
      
      1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      Terraform создаст все требуемые ресурсы и отобразит значения выходных переменных в терминале. Чтобы проверить результат, выполните команду:

      ```bash
      terraform output
      ```

      Результат:

      ```text
      zone = ru-central1-a
      ```

- API {#api}

  Чтобы получить подробную информацию о [кластере GPU](../../concepts/gpus.md#gpu-clusters), воспользуйтесь методом REST API [get](../../api-ref/GpuCluster/get.md) для ресурса [GpuCluster](../../api-ref/GpuCluster/index.md), или вызовом gRPC API [GpuClusterService/Get](../../api-ref/grpc/GpuCluster/get.md).

{% endlist %}