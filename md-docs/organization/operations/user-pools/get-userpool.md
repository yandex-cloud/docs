# Получить информацию о пуле пользователей


{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization) с учетной записью администратора или владельца организации.
  1. На панели слева нажмите ![userpool](../../../_assets/organization/userpool.svg) **Пулы пользователей**.
  1. В списке [пулов пользователей](../../concepts/user-pools.md) выберите нужный пул.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для получения информации о [пуле пользователей](../../concepts/user-pools.md):

     ```bash
     yc organization-manager idp userpool get --help
     ```

  1. Выполните команду:

     ```bash
     yc organization-manager idp userpool get <идентификатор_пула>
     ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  Чтобы получить список [доменов](../../concepts/domains.md) в [пуле пользователей](../../concepts/user-pools.md):

  1. Добавьте в конфигурационный файл Terraform блоки `data` и `output`:

     ```hcl
     data "yandex_organizationmanager_idp_userpool" "userpool" {
       userpool_id = "<идентификатор_пула>"
     }
     
     output "my_userpool-domains" {
       value = data.yandex_organizationmanager_idp_userpool.userpool.domains
     }
     ```

     Где:

     * `data "yandex_organizationmanager_idp_userpool"` — описание пула пользователей в качестве источника данных:
       * `userpool_id` — идентификатор пула.
     * `output "image"` — выходная переменная, которая содержит информацию о доменах пула:
       * `value` — возвращаемое значение.

     Вместо `domains` вы можете выбрать любой другой параметр для получения информации. Более подробно о параметрах источника данных `yandex_organizationmanager_idp_userpool` см. в [документации провайдера](../../../terraform/data-sources/organizationmanager_idp_userpool.md).

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
      my_userpool-domains = tolist([
        "domain.example1.net",
        "domain-example2.ru"
      ])
      ```

- API {#api}

  Воспользуйтесь методом REST API [Userpool.Get](../../idp/api-ref/Userpool/get.md) для ресурса [Userpool](../../idp/api-ref/Userpool/index.md) или вызовом gRPC API [UserpoolService/Get](../../idp/api-ref/grpc/Userpool/get.md).

{% endlist %}