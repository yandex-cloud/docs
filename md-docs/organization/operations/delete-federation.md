[Документация Yandex Cloud](../../index.md) > [Yandex Identity Hub](../index.md) > [Пошаговые инструкции](index.md) > Управление федерациями удостоверений > Удалить федерацию удостоверений

# Удалить федерацию удостоверений

{% note info %}

Удалить федерацию удостоверений может пользователь с [ролью](../security/index.md#organization-manager-organizations-owner) `organization-manager.organizations.owner`.

{% endnote %}

Чтобы удалить федерацию удостоверений:

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Cloud Center](https://center.yandex.cloud) с учетной записью администратора или владельца организации.
  1. На панели слева выберите ![VectorSquare](../../_assets/console-icons/vector-square.svg) **Федерации**.
  1. В строке с федерацией удостоверений нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../_assets/console-icons/trash-bin.svg) **Удалить**.
  1. В открывшемся окне подтвердите удаление.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды удаления группы пользователей Yandex Identity Hub:

      ```bash
      yc organization-manager federation saml delete --help
      ```

  1. Получите список федераций в организации:

     ```bash
     yc organization-manager federation saml list \
       --organization-id <идентификатор_организации>
     ```

     Где `--organization-id` — [идентификатор организации](organization-get-id.md), в которой нужно получить список федераций.
  
  1. Чтобы удалить федерацию удостоверений, выполните команду:

      ```bash
      yc organization-manager federation saml delete <имя_или_идентификатор_федерации>
      ```

- API {#api}

    Воспользуйтесь методом REST API [Federation.delete](../saml/api-ref/Federation/delete.md) для ресурса [Federation](../saml/api-ref/Federation/index.md) или вызовом gRPC API [FederationService/Delete](../saml/api-ref/grpc/Federation/delete.md).

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  1. В конфигурации, которая управляет федерацией, удалите блок ресурса `yandex_organizationmanager_saml_federation` для федерации и связанные с ним ссылки. Подробная информация о ресурсе приведена в [документации провайдера](../../terraform/resources/organizationmanager_saml_federation.md).
  1. Примените изменения:

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

      Перед подтверждением проверьте, что план удаляет федерацию и только ожидаемые связанные ресурсы.

{% endlist %}