# Посмотреть группы пользователя

{% note info %}

Для данной инструкции необходимо использовать [CLI](../../cli/index.md), если выполнено одно или более из следующих условий:
* в настройках организации [включена](hide-user-info.md) опция **Запретить пользователям просматривать список членов организации и информацию о них**;
* применяется [политика авторизации](../../iam/concepts/access-control/access-policies.md) `organization.denyUserListing`, которая запрещает просматривать список пользователей организации.

{% endnote %}

Чтобы посмотреть, в какие [группы](../concepts/groups.md) входит конкретный [пользователь](../../overview/roles-and-resources.md#users):

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Перейдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
  1. На панели слева выберите ![icon-users](../../_assets/console-icons/person.svg) **Пользователи** и в открывшемся списке выберите нужного пользователя.

      При необходимости воспользуйтесь строкой поиска или фильтром вверху страницы.
  1. Перейдите на вкладку **Группы**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для просмотра групп пользователя:

     ```bash
     yc organization-manager group list-effective --help
     ```

  1. [Получите идентификатор пользователя](users-get.md).
  
  1. Выполните команду:

     ```bash
     yc organization-manager group list-effective --subject_id <идентификатор_пользователя>
     ```

     Где `--subject_id` — идентификатор нужного пользователя, полученный на предыдущем шаге.

- API {#api}

  Воспользуйтесь методом REST API [Group.ListEffective](../api-ref/Group/listEffective.md) для ресурса [Group](../api-ref/Group/index.md) или вызовом gRPC API [GroupService/ListEffective](../api-ref/grpc/Group/listEffective.md).

{% endlist %}