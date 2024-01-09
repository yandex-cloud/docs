# Поочередно перезагрузить виртуальные машины в группе

Вы можете [поочередно перезагрузить](../../concepts/instance-groups/rolling-actions.md) ВМ в группе с учетом параметров, заданных в [политике развертывания](../../concepts/instance-groups/policies/deploy-policy.md).

Например, если в политике развертывания максимальное количество недоступных ВМ в группе равно `1`, то при поочередной перезагрузке в каждый момент времени недоступной будет только одна ВМ.

{% include [ig-opportunistic-warning](../../../_includes/compute/ig-opportunistic-warning.md) %}

Чтобы поочередно перезагрузить ВМ в группе:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для перезагрузки группы ВМ:

      ```bash
      {{ yc-compute-ig }} rolling-restart --help
      ```

  1. Получите список каталогов в облаке по умолчанию:

      ```bash
      yc resource-manager folder list
      ```

      Результат:

      ```text
      +----------------------+--------------------+------------------+--------+
      |          ID          |        NAME        |      LABELS      | STATUS |
      +----------------------+--------------------+------------------+--------+
      | b1gd129pp9ha******** | my-folder          |                  | ACTIVE |
      | b1g66mft1vop******** | default            |                  | ACTIVE |
      +----------------------+--------------------+------------------+--------+
      ```

  1. Получите список групп ВМ в выбранном каталоге, указав его имя:

      ```bash
      {{ yc-compute-ig }} list \
        --folder-name <имя_каталога>
      ```

      Результат:

      ```text
      +----------------------+-----------------------+--------+------+
      |          ID          |         NAME          | STATUS | SIZE |
      +----------------------+-----------------------+--------+------+
      | amc65sbgfqeq******** | first-instance-group  | ACTIVE |    4 |
      +----------------------+-----------------------+--------+------+
      ```

  1. Перезагрузите виртуальные машины в группе ВМ:

      ```bash
      {{ yc-compute-ig }} rolling-restart --all \
        --name <имя_группы_ВМ> \
        --folder-name <имя_каталога>
      ```

      Где:
      * `--name` — имя группы виртуальных машин.
      * `--folder-name` — имя каталога, которому принадлежит группа ВМ.

      {{ ig-name }} начнет по очереди перезагружать все ВМ в группе. Перезагруженные ВМ перейдут в статус `Running`.

      Результат:

      ```text
      done (2m43s)
      id: amc65sbgfqeq********
      ...
      status: ACTIVE
      application_load_balancer_state: {}
      ```

      Чтобы перезагрузить отдельные ВМ группы, [получите](./get-list-instances.md) список ВМ в этой группе:

      ```bash
      {{ yc-compute-ig }} list-instances \
        --name <имя_группы_ВМ> \
        --folder-name <имя_каталога>
      ```

      Где:
      * `--name` — имя группы виртуальных машин.
      * `--folder-name` — имя каталога, которому принадлежит группа ВМ.

      Результат:

      ```text
      +----------------------+---------------------------+----------------+--------------+------------------------+----------------+
      |     INSTANCE ID      |           NAME            |  EXTERNAL IP   | INTERNAL IP  |         STATUS         | STATUS MESSAGE |
      +----------------------+---------------------------+----------------+--------------+------------------------+----------------+
      | epdl7gdvb69f******** | cl17k72ehu54********-amyk | 130.193.**.*** | 192.168.0.33 | RUNNING_ACTUAL [8m]    |                |
      | epdjtb04efcf******** | cl17k72ehu54********-oper | 84.201.***.*** | 192.168.0.17 | RUNNING_ACTUAL [6m]    |                |
      | epd3anghn4vb******** | cl17k72ehu54********-axec | 84.201.***.*** | 192.168.0.14 | RUNNING_ACTUAL [1m50s] |                |
      | epdbt0c7o6d3******** | cl17k72ehu54********-ihez | 51.250.***.*** | 192.168.0.29 | RUNNING_ACTUAL [1m0s]  |                |
      +----------------------+---------------------------+----------------+--------------+------------------------+----------------+
      ```

      Перезагрузите нужные ВМ:

      ```bash
      {{ yc-compute-ig }} rolling-restart \
        --instance-ids <идентификаторы_ВМ> \
        --name <имя_группы_ВМ> \
        --folder-name <имя_каталога>
      ```

      Где:
      * `--instance-ids` — разделенный запятыми список идентификаторов виртуальных машин, которые необходимо перезагрузить. Например, чтобы перезагрузить первую и третью ВМ из списка выше, укажите `--instance-ids epdl7gdvb69f********,epd3anghn4vb********`.
      * `--name` — имя группы виртуальных машин.
      * `--folder-name` — имя каталога, которому принадлежит группа ВМ.
      
      {{ ig-name }} начнет по очереди перезагружать указанные ВМ в группе. Перезагруженные ВМ перейдут в статус `Running`.

  Подробную информацию о параметрах команды `{{ yc-compute-ig }} rolling-restart` см. в [справочнике CLI](../../../cli/cli-ref/managed-services/compute/instance-group/rolling-restart.md).

- API {#api}

  Воспользуйтесь методом REST API [rollingRestart](../../api-ref/InstanceGroup/rollingRestart.md) для ресурса [InstanceGroup](../../api-ref/InstanceGroup/index.md) или вызовом gRPC API [InstanceGroupService/RollingRestart](../../api-ref/grpc/instance_group_service.md#RollingRestart).

{% endlist %}