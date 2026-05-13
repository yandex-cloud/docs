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

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

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

{% endlist %}