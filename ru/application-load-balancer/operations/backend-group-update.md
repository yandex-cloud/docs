# Изменить группу бэкендов

Чтобы изменить параметры группы бэкендов:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит группа бэкендов.
  1. Выберите сервис **{{ alb-name }}**.
  1. На панели слева выберите ![image](../../_assets/backgrs.svg) **Группы бэкендов**.
  1. Нажмите на имя нужной группы.
  1. Нажмите **Редактировать**.
  1. Измените параметры группы.
  1. Внизу страницы нажмите кнопку **Сохранить**.

- CLI

  1. Посмотрите описание команды CLI для изменения параметров группы бэкендов:

     ```
     yc alb backend-group update-http-backend --help
     ```

  1. Выполните команду:
     ```
     yc alb backend-group update-http-backend \
       --backend-group-name <имя группы бэкендов> \
       --name <имя бэкенда> \
       --weight <вес бэкенда>
     ```

     Результат:

     ```
     done (1s)
     id: a5d3e9ko2qf0tbk0s27b
     name: test-backend-group
     folder_id: aoe197919j8elpeg1lkp
     http:
       backends:
       - name: backend1
         backend_weight: "2"
         load_balancing_config:
           panic_threshold: "90"
         port: "80"
         target_groups:
           target_group_ids:
           - a5dvd82vl14khpjdv87d
         healthchecks:
         - timeout: 10s
           interval: 2s
           healthy_threshold: "10"
           unhealthy_threshold: "15"
           healthcheck_port: "80"
           http:
             host: your-host.com
             path: /ping
     created_at: "2021-02-14T13:37:17.846064589Z"
     ```

{% endlist %}

## Удалить бэкенд из группы {#delete-backend}

Чтобы удалить бэкенд из группы:

{% list tabs %}

- Консоль управления

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит бэкенд.
   1. Выберите сервис **{{ alb-name }}**.
   1. На панели слева выберите ![image](../../_assets/backgrs.svg) **Группы бэкендов**.
   1. Нажмите на имя нужной группы.
   1. Выберите нужный бэкенд и нажмите значок ![image](../../_assets/horizontal-ellipsis.svg).
   1. В открывшемся меню выберите пункт **Удалить**.
   1. Подтвердите удаление.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления бэкенда из группы:
     ```
     yc application-load-balancer delete-http-backend --help
     ```

  1. Выполните команду:
     ```
     yc alb backend-group delete-http-backend --backend-group-name=<имя группы бэкендов> \
       --name=<имя удаляемого бэкенда>
     ```

     Результат:

     ```
     id: a5dqkr2mk3rr799f1npa
     name: test-backend-group
     folder_id: aoe197919j8elpeg1lkp
     created_at: "2021-02-11T20:46:21.688940670Z"
     ```

{% endlist %}
