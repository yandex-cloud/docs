[Документация Yandex Cloud](../../../index.md) > [Yandex Resource Manager](../../index.md) > [Пошаговые инструкции](../index.md) > Каталог > Управление политиками авторизации

# Управлять политиками авторизации каталога

{% note info %}

Функциональность находится на стадии [Preview](../../../overview/concepts/launch-stages.md). Чтобы получить доступ, обратитесь в [техническую поддержку](https://center.yandex.cloud/support) или к вашему аккаунт-менеджеру.

{% endnote %}

[Политики авторизации](../../../iam/concepts/access-control/access-policies.md) — это механизм контроля доступа Yandex Identity and Access Management, который позволяет управлять разрешениями на выполнение определенных операций с [ресурсами Yandex Cloud](../../../overview/roles-and-resources.md). Политики авторизации создаются на основе [шаблонов](../../../iam/concepts/access-control/access-policies.md#supported-policies) и дополняют систему [ролей](../../../iam/concepts/access-control/roles.md), делая [управление доступом](../../../iam/concepts/access-control/index.md) более гибким.

Управлять политиками авторизации [каталога](../../concepts/resources-hierarchy.md#folder) может пользователь, которому назначена роль [`resource-manager.admin`](../../security/index.md#resource-manager-admin) или [`admin`](../../../iam/roles-reference.md#admin) на этот каталог.

## Создать политику авторизации для каталога {#assign}

Чтобы создать для [каталога](../../concepts/resources-hierarchy.md#folder) политику авторизации на основе [шаблона без параметров](../../../iam/concepts/access-control/access-policies.md#fixed):

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  1. [Получите](../../../iam/operations/access-policies/list.md) список поддерживаемых шаблонов политик авторизации с идентификаторами.
  1. Выполните команду:

      ```bash
      yc resource-manager folder bind-access-policy \
        --name <имя_каталога> \
        --access-policy-template-id=<идентификатор_шаблона_политики>
      ```

      Где:

      * `--name` — имя каталога, для которого вы хотите создать политику. Вместо имени каталога вы можете указать его [идентификатор](get-id.md) в параметре `--id`.
      * `--access-policy-template-id` — идентификатор шаблона, на основе которого вы хотите создать политику авторизации для указанного каталога.
  1. [Убедитесь](manage-access-policies.md#view-assigned), что политика была создана.

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. [Получите](../../../iam/operations/access-policies/list.md) идентификатор шаблона политики авторизации без параметров.
  1. Добавьте в конфигурацию ресурс `yandex_resource_manager_folder_iam_policy_binding`:

      ```hcl
      resource "yandex_resource_manager_folder_iam_policy_binding" "policy" {
        folder_id = "<идентификатор_каталога>"
        access_policy_template_id = "<идентификатор_шаблона_политики>"
      }
      ```

      Где `folder_id` — идентификатор каталога, а `access_policy_template_id` — идентификатор шаблона политики авторизации. Этот ресурс создает привязку шаблона политики, а не назначает роль субъекту.

      Подробнее см. в [документации провайдера](../../../terraform/resources/resource_manager_folder_iam_policy_binding.md).
  1. Примените конфигурацию:

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

- API {#api}

  Воспользуйтесь методом REST API [bindAccessPolicy](../../api-ref/Folder/bindAccessPolicy.md) для ресурса [Folder](../../api-ref/Folder/index.md) или вызовом gRPC API [FolderService/BindAccessPolicy](../../api-ref/grpc/Folder/bindAccessPolicy.md).

{% endlist %}

Созданная политика авторизации будет применяться ко всем ресурсам в заданном каталоге.

## Посмотреть список политик авторизации каталога {#view-assigned}

Чтобы посмотреть список политик авторизации, созданных для [каталога](../../concepts/resources-hierarchy.md#folder):

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  Выполните команду, указав имя или [идентификатор](get-id.md) каталога, для которого вы хотите посмотреть созданные политики:

  ```bash
  yc resource-manager folder list-access-policy-bindings <имя_или_идентификатор_каталога>
  ```

  Результат:

  ```
  +---------------------------------------------+-------------------------------------------------+
  |          ACCESS POLICY TEMPLATE ID          |                   PARAMETERS                    |
  +---------------------------------------------+-------------------------------------------------+
  | backup.denyRemoveProtection                 |                                                 |
  | serverless.containers.restrictNetworkAccess | allowed_vpc_network_ids=[enphfcfseu9i********], |
  |                                             | allowed_src_ips=[192.168.1.12/24]               |
  +---------------------------------------------+-------------------------------------------------+
  ```

- API {#api}

  Воспользуйтесь методом REST API [listAccessPolicyBindings](../../api-ref/Folder/listAccessPolicyBindings.md) для ресурса [Folder](../../api-ref/Folder/index.md) или вызовом gRPC API [FolderService/ListAccessPolicyBindings](../../api-ref/grpc/Folder/listAccessPolicyBindings.md).

{% endlist %}

## Удалить политику авторизации, созданную для каталога {#revoke}

Чтобы удалить политику авторизации, созданную для [каталога](../../concepts/resources-hierarchy.md#folder):

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  1. [Получите](manage-access-policies.md#view-assigned) список идентификаторов шаблонов политик авторизации, назначенных на каталог.
  1. Выполните команду:

      ```bash
      yc resource-manager folder unbind-access-policy \
        --name <имя_каталога> \
        --access-policy-template-id=<идентификатор_шаблона_политики>
      ```

      Где:

      * `--name` — имя каталога, для которого вы хотите удалить политику. Вместо имени каталога вы можете указать его [идентификатор](get-id.md) в параметре `--id`.
      * `--access-policy-template-id` — идентификатор шаблона политики авторизации, которую вы хотите удалить для указанного каталога.
  1. [Убедитесь](manage-access-policies.md#view-assigned), что политика была удалена.

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. В конфигурации найдите ресурс `yandex_resource_manager_folder_iam_policy_binding` с идентификаторами нужного шаблона политики в `access_policy_template_id` и каталога в `folder_id`.
  1. Удалите блок этого ресурса. Сам ресурс каталога удалять не нужно.
  1. Примените конфигурацию:

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

      Убедитесь, что план удаляет только нужную привязку политики. Эти инструкции применимы к привязке, которой управляет текущая конфигурация { TF }.

- API {#api}

  Воспользуйтесь методом REST API [unbindAccessPolicy](../../api-ref/Folder/unbindAccessPolicy.md) для ресурса [Folder](../../api-ref/Folder/index.md) или вызовом gRPC API [FolderService/UnbindAccessPolicy](../../api-ref/grpc/Folder/unbindAccessPolicy.md).

{% endlist %}

Указанная политика авторизации перестанет применяться к ресурсам в заданном каталоге.

#### Полезные ссылки {#see-also}

* [Политики авторизации](../../../iam/concepts/access-control/access-policies.md)