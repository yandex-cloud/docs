# Отвязать виртуальную машину или сервер {{ baremetal-full-name }} от политики резервного копирования


Чтобы отвязать виртуальную машину или сервер {{ baremetal-name }} от политики резервного копирования:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите отвязать ВМ или сервер {{ baremetal-name }} от политики.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. Перейдите на вкладку ![policies](../../../_assets/console-icons/calendar.svg) **{{ ui-key.yacloud_billing.backup.label_policies }}**.
  1. Выберите политику, от которой вы хотите отвязать ВМ или сервер {{ baremetal-name }}.
  1. В зависимости от того, какой ресурс вы хотите отвязать от политики резервного копирования, в блоке **{{ ui-key.yacloud.backup.title_linked-recourses }}** выберите вкладку **{{ ui-key.yacloud.backup.value_vm-recourses }}** или **{{ ui-key.yacloud.backup.value_bms-recourses }}**.
  1. В строке с ВМ или сервером {{ baremetal-name }}, которые нужно отвязать от политики, нажмите ![options](../../../_assets/console-icons/ellipsis.svg) и выберите соответственно **{{ ui-key.yacloud.backup.action_detach-vm-instance }}** или **{{ ui-key.yacloud.backup.action_detach-baremetal-instance }}**.
  1. В открывшемся окне подтвердите это действие.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для удаления ВМ или сервера {{ baremetal-name }} из политики: 

      ```bash
      yc backup policy revoke --help
      ```

  1. Узнайте идентификатор политики, от которой вы хотите отвязать ВМ или сервер {{ baremetal-name }}:

      ```bash
      yc backup policy list
      ```
      
      Результат:
      
      ```text
      +----------------------+----------------------+---------+---------+---------------------+---------------------+
      |          ID          |      FOLDER ID       |  NAME   | ENABLED |     CREATED AT      |     UPDATED AT      |
      +----------------------+----------------------+---------+---------+---------------------+---------------------+
      | abc7n3wln123******** | ghi681qpe789******** | policy1 | true    | 2023-07-03 09:12:02 | 2023-07-03 09:12:43 |
      | deflqbiwc456******** | ghi681qpe789******** | policy2 | true    | 2023-07-07 14:58:23 | 2023-07-07 14:58:23 |
      +----------------------+----------------------+---------+---------+---------------------+---------------------+
      ```

  1. Узнайте идентификатор ВМ, которую вы хотите отвязать:

      ```bash
      yc compute instance list
      ```
      
      Результат:
      
      ```text
      +----------------------+---------+---------------+---------+--------------+-------------+
      |          ID          |  NAME   |    ZONE ID    | STATUS  | EXTERNAL IP  | INTERNAL IP |
      +----------------------+---------+---------------+---------+--------------+-------------+
      | jklp0o9i8012******** | my-vm-1 | {{ region-id }}-b | RUNNING | 51.250.**.** | 192.168.*.* |
      | mnoa5s6d8345******** | my-vm-2 | {{ region-id }}-b | RUNNING | 84.201.**.** | 192.168.*.* |
      +----------------------+---------+---------------+---------+--------------+-------------+
      ```

      Чтобы узнать идентификаторы серверов {{ baremetal-name }}, в [консоли управления]({{ link-console-main }}) в списке сервисов нужного [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder) выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**. Идентификаторы указаны в списке серверов в поле **{{ ui-key.yacloud.common.id }}**.

  1. Отвяжите ВМ или сервер {{ baremetal-name }}, указав идентификатор политики:

      ```bash
      yc backup policy revoke <идентификатор_политики> \
        --instance-ids <идентификаторы_ВМ_или_серверов_{{ baremetal-name }}>
      ```

      Где `--instance-ids` — идентификаторы ВМ или серверов {{ baremetal-name }}, которые нужно отвязать от политики резервного копирования. Несколько идентификаторов указываются через запятую.

  Подробнее о команде читайте в [справочнике CLI](../../../cli/cli-ref/backup/cli-ref/policy/revoke.md).

- API {#api}

  Воспользуйтесь методом REST API [revoke](../../backup/api-ref/Policy/revoke.md) для ресурса [Policy](../../backup/api-ref/Policy/index.md) или вызовом gRPC API [PolicyService/Revoke](../../backup/api-ref/grpc/Policy/revoke.md).

{% endlist %}

#### См. также {#see-also}

* [{#T}](attach-and-detach-vm.md)