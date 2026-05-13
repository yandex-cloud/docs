# Удалить группу безопасности

{% note warning %}

Нельзя удалить группу безопасности, по умолчанию созданную в сети.

{% endnote %}

Чтобы удалить [группу безопасности](../concepts/security-groups.md): 

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, где требуется удалить группу безопасности.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Virtual Private Cloud**.
  1. На панели слева выберите ![image](../../_assets/console-icons/shield.svg) **Группы безопасности**. 
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) в строке группы, которую требуется удалить.
  1. В открывшемся меню нажмите кнопку **Удалить**.
  1. В открывшемся окне нажмите кнопку **Удалить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для удаления групп безопасности:

      ```
      yc vpc security-group delete --help
      ```

  1. Получите список всех групп безопасности в каталоге по умолчанию:

      ```
      yc vpc security-group list
      ```
	    
      Результат:
      ```
      +----------------------+-------------+-------------+----------------------+
      |          ID          |    NAME     | DESCRIPTION |      NETWORK-ID      |
      +----------------------+-------------+-------------+----------------------+
      | enpkf7dbjonf******** | test-sg-cli |             | enpgkbe17td8******** |
      +----------------------+-------------+-------------+----------------------+
      ```

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной сети.
  1. Удалите сеть:

      ```
      yc vpc security-group delete test-sg-cli
      ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы удалить группу безопасности, созданную с помощью Terraform:

  1. Откройте файл конфигурации Terraform и удалите фрагмент с описанием группы безопасности.
     
     {% cut "Пример описания группы безопасности в конфигурации Terraform" %}

     ```hcl
     ...
     resource "yandex_vpc_security_group" "test-sg" {
       name        = "Test security group"
       description = "Description for security group"
       network_id  = "${yandex_vpc_network.lab-net.id}"

       ingress {
         protocol       = "TCP"
         description    = "Rule description 1"
         v4_cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24"]
         port           = 8080
       }

       egress {
         protocol       = "ANY"
         description    = "Rule description 2"
         v4_cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24"]
         from_port      = 8090
         to_port        = 8099
       }
     }
     ...
     ```

     {% endcut %}

  1. В командной строке перейдите в папку, где расположен файл конфигурации Terraform.

  1. Проверьте конфигурацию командой:

     ```
     terraform validate
     ```
     
     Если конфигурация является корректной, появится сообщение:
     
     ```
     Success! The configuration is valid.
     ```

  1. Выполните команду:

     ```
     terraform plan
     ```
  
     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.

  1. Примените изменения конфигурации:

     ```
     terraform apply
     ```

  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить изменения можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../cli/quickstart.md):

     ```
     yc vpc security-group list
     ```

- API {#api}

  Воспользуйтесь методом REST API [delete](../api-ref/SecurityGroup/delete.md) для ресурса [SecurityGroup](../api-ref/SecurityGroup/index.md) или вызовом gRPC API [SecurityGroupService/Delete](../api-ref/grpc/SecurityGroup/delete.md) и передайте в запросе идентификатор удаляемой группы безопасности в параметре `securityGroupId`.

  Чтобы узнать идентификатор группы безопасности, воспользуйтесь методом REST API [list](../api-ref/SecurityGroup/list.md) для ресурса [SecurityGroup](../api-ref/SecurityGroup/index.md) или вызовом gRPC API [SecurityGroupService/List](../api-ref/grpc/SecurityGroup/list.md) и передайте в запросе идентификатор каталога в параметре `folderId`.

  О том, как узнать идентификатор каталога, читайте в разделе [Получение идентификатора каталога](../../resource-manager/operations/folder/get-id.md).

{% endlist %}