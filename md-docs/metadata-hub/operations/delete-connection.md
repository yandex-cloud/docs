# Удаление подключения


Подключение, [созданное вручную](../quickstart/connection-manager.md#database-connections), нельзя удалить пока у него есть хотя бы одна [зависимость](../concepts/connection-manager.md#dependencies). 

Подключение, [созданное автоматически](../quickstart/connection-manager.md#mdb-integration) при создании кластера управляемой базы данных, вручную удалить нельзя. Такие подключения удаляются автоматически при удалении кластера MDB, но будут сохраняться пока есть хотя бы одна резервная копия, ссылающаяся на них. Поскольку после удаления кластера, создавшего подключение, его автоматические резервные копии хранятся еще неделю, подключение не удаляется сразу вместе с кластером.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно удалить подключение.
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ metadata-hub-full-name }}**.
    1. На панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
    1. В списке подключений нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) справа в строке подключения, которое вы хотите удалить.
    1. Выберите пункт **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.
  
  Чтобы удалить подключение:

  1. Посмотрите описание команды CLI для удаления подключения:

      ```bash
      yc metadata-hub connection-manager connection delete --help
      ```

  1. Удалите подключение, выполнив команду:
      
      ```bash
      yc metadata-hub connection-manager connection delete <идентификатор_подключения>
      ```

      Идентификатор подключения можно получить со [списком подключений](view-connection.md#connection-list) в каталоге.


- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  Чтобы удалить подключение, созданное с помощью {{ TF }}:

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.
  1. Удалите описание подключения.
  1. Проверьте корректность настроек.

      1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы {{ TF }} с планом инфраструктуры.
      1. Выполните команду:
      
         ```bash
         terraform validate
         ```
      
         Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Подтвердите изменение ресурсов.

      1. Выполните команду для просмотра планируемых изменений:
      
         ```bash
         terraform plan
         ```
      
         Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
      
      1. Если вас устраивают планируемые изменения, внесите их:
         1. Выполните команду:
      
            ```bash
            terraform apply
            ```
      
         1. Подтвердите изменение ресурсов.
         1. Дождитесь завершения операции.


- API {#api}
  
  Чтобы удалить подключение {{ connection-manager-name }}, воспользуйтесь методом REST API [Connection.Delete](../connection-manager/api-ref/Connection/delete.md) или методом gRPC API [ConnectionService.Delete](../connection-manager/api-ref/grpc/Connection/delete.md) и передайте в запросе идентификатор подключения.

   Чтобы удалить подключение {{ connection-manager-name }}, воспользуйтесь методом REST API [Connection.Delete](../connection-manager/api-ref/Connection/delete.md) или методом gRPC API [ConnectionService.Delete](../connection-manager/api-ref/grpc/Connection/delete.md) и передайте в запросе идентификатор подключения.

{% endlist %}