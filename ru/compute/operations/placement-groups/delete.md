# Удалить группу размещения

Удалите [группу размещения](../../concepts/placement-groups.md).

{% list tabs %}

- CLI

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}
  
  1. Посмотрите список виртуальных машин в группе размещения:
  
     ```bash
     yc compute placement-group list-instances --name my-group
     ```

     Результат:

     ```bash
     +----------------------+---------------------+---------------+---------+-------------+-------------+
     |          ID          |        NAME         |    ZONE ID    | STATUS  | EXTERNAL IP | INTERNAL IP |
     +----------------------+---------------------+---------------+---------+-------------+-------------+
     | epdep2kq6dt5uekuhcrd | instance-in-group-1 | {{ region-id }}-b | RUNNING |             | 10.129.0.5  |
     | epdlv1pp54019j09fhue | instance-in-group-2 | {{ region-id }}-b | RUNNING |             | 10.129.0.30 |
     +----------------------+---------------------+---------------+---------+-------------+-------------+
     ```
  
  1. Удалите виртуальные машины в группе:
  
     ```bash
     yc compute instance delete --name instance-in-group-1
     yc compute instance delete --name instance-in-group-2
     ```     
  
  1. Удалите группу размещения:

     ```bash
     yc compute placement-group delete --name my-group
     ```
  
  1. Проверьте, что группа размещения удалена:
     
     ```bash
     yc compute placement-group list
     ```

     Результат:

     ```bash
     +----+------+----------+
     | ID | NAME | STRATEGY |
     +----+------+----------+
     +----+------+----------+
     ```

- API

  Воспользуйтесь методом API [delete](../../api-ref/PlacementGroup/delete.md).

- {{ TF }}

  {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

  Подробнее о {{ TF }} [читайте в документации](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы удалить группу размещения, созданную с помощью {{ TF }}:

  1. Откройте файл конфигураций {{ TF }} и удалите фрагмент с описанием группы размещения.
     
     Пример описания группы размещения в конфигурации {{ TF }}:

     ```hcl
     ...
     resource "yandex_compute_placement_group" "group1" {
       name        = "test-pg"
       folder_id   = "abc*********123"
       description = "my description"
     }
     ...
     ```

  1. В командной строке перейдите в папку, где расположен файл конфигурации {{ TF }}.

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
  
     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Примените изменения конфигурации:

     ```
     terraform apply
     ```

  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить изменения можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

     ```bash
     yc compute placement-group list
     ```

{% endlist %}
