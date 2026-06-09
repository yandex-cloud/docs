# Удалить группу виртуальных машин

{% note warning %}

Отменить удаление группы ВМ или восстановить ее невозможно. Вместе с группой удаляются целевая группа {{ network-load-balancer-name }} или {{ alb-name }}, ВМ и диски. Вы не сможете удалить группу ВМ, если она является целевой группой для балансировщика ({{ network-load-balancer-name }}) или группы бэкендов ({{ alb-name }}).

{% endnote %}

Чтобы удалить группу ВМ:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) откройте каталог, в котором находится нужная группа ВМ.
  1. Перейдите в сервис **{{ compute-name }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.instance-groups_hx3kX }}**.
  1. В строке с нужной группой ВМ нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.compute.groups.popup-confirm_button_delete }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для удаления группы ВМ:

     ```bash
     {{ yc-compute-ig }} delete --help
     ```

  1. Получите список групп ВМ в каталоге по умолчанию:

     ```bash
     {{ yc-compute-ig }} list
     ```
     
     Результат:
     
     ```text
     +----------------------+----------------------+--------+------+
     |          ID          |          NAME        | STATUS | SIZE |
     +----------------------+----------------------+--------+------+
     | cl15b3mrkk88******** | first-instance-group | ACTIVE |    3 |
     +----------------------+----------------------+--------+------+
     ```

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной группы, например `first-instance-group`.
  1. Удалите группу ВМ:

     ```bash
     {{ yc-compute-ig }} delete --name first-instance-group
     ```

     {{ ig-name }} запустит операцию удаления группы ВМ.

- {{ TF }} {#tf}

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  Если вы создавали группу ВМ с помощью {{ TF }}, вы можете удалить ее:
  1. В командной строке перейдите в папку, где расположен конфигурационный файл {{ TF }}.
  1. Удалите ресурсы с помощью команды:

     ```bash
     terraform destroy
     ```

     {% note alert %}

     {{ TF }} удалит все ресурсы, созданные в текущей конфигурации: кластеры, сети, подсети, ВМ и т. д.

     {% endnote %}

  1. Введите слово `yes` и нажмите **Enter**.

- API {#api}

  Воспользуйтесь методом REST API [delete](../../instancegroup/api-ref/InstanceGroup/delete.md) для ресурса [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/index.md) или вызовом gRPC API [InstanceGroupService/Delete](../../instancegroup/api-ref/grpc/InstanceGroup/delete.md).

  Список доступных групп запрашивайте методом REST API [listInstances](../../instancegroup/api-ref/InstanceGroup/listInstances.md) или вызовом gRPC API [InstanceGroupService/ListInstances](../../instancegroup/api-ref/grpc/InstanceGroup/listInstances.md).

{% endlist %}

{% note tip %}

Чтобы защитить группу ВМ от случайного удаления, [включите защиту от удаления](enable-deletion-protection.md). Пока защита включена, удалить группу невозможно.

{% endnote %}