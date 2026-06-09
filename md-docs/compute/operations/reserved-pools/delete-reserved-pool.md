# Удаление пула резервов виртуальных машин

{% note warning %}

Пулы резервов ВМ тарифицируются: взимается плата за весь свободный объем зарезервированных вычислительных ресурсов ВМ, кластеров GPU и программно ускоренных сетей согласно [правилам тарификации {{ compute-full-name }}](../../pricing.md). Подробнее см. в разделе [{#T}](../../pricing.md#pool).

{% endnote %}

_Функциональность пулов резервов ВМ находится на [стадии Preview](../../../overview/concepts/launch-stages.md)._

Чтобы удалить [пул резервов ВМ](../../concepts/reserved-pools.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится пул резервов ВМ.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/folder-lock.svg) **{{ ui-key.yacloud.compute.reserved-instance-pool.reserved-instance-pools_m8sWW }}**.
  1. В строке с нужным пулом нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. Подтвердите удаление.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды [{{ yandex-cloud }} CLI](../../../cli/index.md) для удаления пула резервов ВМ:

      ```bash
      yc compute reserved-instance-pool delete --help
      ```
  1. Получите список пулов резервов ВМ в каталоге по умолчанию:
     
     ```bash
     yc compute reserved-instance-pool list
     ```
     
     Результат:
     
     ```text
     +----------------------+------------+---------------+------+
     |          ID          |    NAME    |    ZONE ID    | SIZE |
     +----------------------+------------+---------------+------+
     | fv48qa9iiq19******** | test-pool1 | {{ region-id }}-a |    1 |
     | fv42fbsrso94******** | test-pool2 | {{ region-id }}-a |    1 |
     +----------------------+------------+---------------+------+
     ```
  1. Удалите пул резервов ВМ в каталоге по умолчанию, указав имя или идентификатор нужного пула:

      ```bash
      yc compute reserved-instance-pool delete <имя_или_идентификатор_пула>
      ```

      Результат:

      ```text
      done (15s)
      {}
      ```

      Подробнее о команде `yc compute reserved-instance-pool delete` читайте в [справочнике {{ yandex-cloud }} CLI](../../../cli/cli-ref/compute/cli-ref/reserved-instance-pool/delete.md).

- API {#api}

  Воспользуйтесь методом REST API [delete](../../api-ref/ReservedInstancePool/delete.md) для ресурса [ReservedInstancePool](../../api-ref/ReservedInstancePool/index.md) или вызовом gRPC API [ReservedInstancePoolService/Delete](../../api-ref/grpc/ReservedInstancePool/delete.md).

{% endlist %}

{% note info %}

При удалении пула резервов ВМ все привязанные к пулу виртуальные машины будут от него отвязаны, а запущенные ВМ продолжат работать.

{% endnote %}

#### См. также {#see-also}

* [{#T}](manage-pool-vms.md)
* [{#T}](../../concepts/reserved-pools.md)