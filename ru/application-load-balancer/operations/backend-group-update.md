# Изменить группу бэкендов

## Изменить базовые параметры группы {#update-group}

Чтобы изменить параметры группы бэкендов:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создана группа бэкендов.
  1. Выберите сервис **{{ alb-name }}**.
  1. На панели слева выберите ![image](../../_assets/backgrs.svg) **Группы бэкендов**.
  1. Нажмите на имя нужной группы.
  1. Нажмите ![image](../../_assets/pencil.svg) **Редактировать**.
  1. Измените параметры группы.
  1. Внизу страницы нажмите кнопку **Сохранить**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для изменения базовых параметров группы бэкендов:

     ```
     yc alb backend-group update --help
     ```

  1. Выполните команду:

     ```
     yc alb backend-group update \
       --name <имя группы бэкендов> \
       --new-name <новое имя группы бэкендов> \
       --description <описание группы бэкендов> \
       --labels key=value[,<ключ>=<значение метки>]
     ```

     Где:

     * `--name` — имя группы бэкендов.
     * `--new-name` — новое имя группы бэкендов. Требования к имени:

       {% include [name-format-2](../../_includes/name-format-2.md) %}

     * `--description` — описание группы бэкендов. Необязательный параметр.
     * `-labels key=value` — список меток в формате `ключ=значение`. Необязательный параметр.

     Результат:

     ```
     id: ds77tero4f5h46l4e2gl
     name: test-backend-group
     description: update
     folder_id: b1gu6g9ielh690at5bm7
     stream:
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

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}
  
  Подробнее о {{ TF }} [читайте в документации](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  1. Откройте конфигурационный файл {{ TF }} и измените фрагмент с описанием группы бэкендов:
  
      ```hcl
      resource "yandex_alb_backend_group" "test-backend-group" {
        name        = "<имя группы бэкендов>"
        description = "<описание группы бэкендов>"
        labels      = {
          new-label = "test-label"
        }
      ...
      }
      ```

      Где `yandex_alb_backend_group` — параметры группы бэкендов:
      * `name` — имя группы бэкендов.
      * `description` — описание группы бэкендов. Необязательный параметр.
      * `labels` — список меток в формате `ключ=значение`. Необязательный параметр.

      Подробную информацию о параметрах ресурса `yandex_alb_backend_group` см. в [документации провайдера {{ TF }}]({{ tf-provider-alb-backendgroup }}).
  1. Примените изменения:
  
      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

      Проверить изменения группы бэкендов можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

      ```bash
      yc alb backend-group get --name <имя группы бэкендов>
      ```

{% endlist %}

## Добавить бэкенд в группу {#add-backend}

{% list tabs %}

- Консоль управления

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создан бэкенд.
   1. Выберите сервис **{{ alb-name }}**.
   1. На панели слева выберите ![image](../../_assets/backgrs.svg) **Группы бэкендов**.
   1. Нажмите на имя нужной группы.
   1. Нажмите кнопку ![image](../../_assets/plus.svg) **Добавить бэкенд**.
   1. В открывшемся окне задайте настройки бэкенда:
      * Введите имя бэкенда: `test-backend-1`.
      * Задайте вес бэкенда: `1`.
      * Выберите тип бэкенда `Целевая группа` для группы бэкендов типа `HTTP`. В группе бэкендов типа `gRPC` или `Stream` бэкендами могут быть только целевые группы и их наборы.
      * В списке **Целевые группы** выберите `test-target-group` и укажите **Порт**: `80`.
   1. Разверните поле **Настройки балансировки** и задайте их параметры:
      * **Порог для режима паники**: `90`.
      * **Локализация трафика**: `90`.
   1. Разверните поле **Настройки протокола** и выберите тип `HTTP`. По умолчанию для группы бэкендов типа `HTTP` используется протокол версии 1.1. Чтобы использовать протокол версии 2, включите опцию **HTTP/2**. Группы бэкендов типа `gRPC` поддерживают только HTTP/2-соединения.
   1. Нажмите кнопку **Добавить проверку состояния** и задайте настройки проверки:
      * **Таймаут**: `1`.
      * **Интервал**: `1`.
      * **Порог работоспособности**: `3`.
      * **Порог неработоспособности**: `10`.
      * **Тип**: `HTTP`.

         {% note info %}

         Поддерживаются проверки типов `HTTP`, `gRPC` и `Stream`. Они соответствуют типам групп бэкендов, но тип проверки не обязательно должен совпадать с типом группы. 

         {% endnote %}

      * **Путь**: `/`.
   1. Нажмите кнопку **Добавить**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Добавьте в группу бэкенд и проверку состояния. Внутри группы все бэкенды должны быть одного [типа](../concepts/backend-group.md#group-types) — HTTP или Stream.

    {% cut "HTTP-бэкенд" %}

    Выполните команду:

    ```
    yc alb backend-group add-http-backend \
      --backend-group-name <имя бэкенд группы> \
      --name <имя добавляемого бэкенда> \
      --weight <вес бэкенда> \
      --port <порт бэкенда> \
      --target-group-id=<идентификатор целевой группы> \
      --panic-threshold 90 \
      --http-healthcheck port=80,healthy-threshold=10,unhealthy-threshold=15, \
    timeout=10s,interval=2s,host=your-host.com,path=/ping
    ```

    Где:

    * `--panic-threshold` — порог для режима паники.
    * `--http-healthcheck` — параметры проверки состояния ресурсов:
        * `port` — порт.
        * `healthy-threshold` — порог работоспособности.
        * `unhealthy-threshold` — порог неработоспособности.
        * `timeout` — таймаут.
        * `interval` — интервал.
        * `host` — адрес хоста.
        * `path` — путь.

    Результат:

    ```
    id: a5dqkr2mk3rr799f1npa
    name: test-backend-group
    folder_id: aoe197919j8elpeg1lkp
    http:
      backends:
      - name: backend1
        backend_weight: "1"
        load_balancing_config:
          panic_threshold: "90"
        port: "80"
        target_groups:
          target_group_ids:
          - a5d2iap3nue9s3anblu6
        healthchecks:
        - timeout: 10s
          interval: 2s
          healthy_threshold: "10"
          unhealthy_threshold: "15"
          healthcheck_port: "80"
          http:
            host: your-host.com
            path: /ping
    created_at: "2021-02-11T20:46:21.688940670Z"
    ```

    {% endcut %}


    {% cut "Stream-бэкенд" %}

    Выполните команду:

    ```
    yc alb backend-group add-stream-backend \
      --backend-group-name <имя бэкенд группы> \
      --name <имя добавляемого бэкенда> \
      --weight <вес бэкенда> \
      --port <порт бэкенда> \
      --target-group-id=<идентификатор целевой группы> \
      --panic-threshold 90 \
      --http-healthcheck port=80,healthy-threshold=10,unhealthy-threshold=15, \
    timeout=10s,interval=2s,host=your-host.com,path=/ping
    ```

    Где:

    * `--panic-threshold` — порог для режима паники.
    * `--http-healthcheck` — параметры проверки состояния ресурсов:
        * `port` — порт.
        * `healthy-threshold` — порог работоспособности.
        * `unhealthy-threshold` — порог неработоспособности.
        * `timeout` — таймаут.
        * `interval` — интервал.
        * `host` — адрес хоста.
        * `path` — путь.

    Результат:

    ```
    id: ds77tero4f5h46l4e2gl
    name: test-backend-group
    folder_id: b1gu6g9ielh690at5bm7
    stream:
      backends:
      - name: stream-backend
    backend_weight: "1"
        port: "80"
        target_groups:
         target_group_ids:
          - ds7eof3r2cte9u069p97
        healthchecks:
        - timeout: 10s
          interval: 2s
          healthy_threshold: "10"
          unhealthy_threshold: "15"
          healthcheck_port: "80"
          http:
            host: your-host.com
            path: /ping
    created_at: "2022-04-06T09:17:57.104324513Z"
    ```

    {% endcut %}

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}
  
  Подробнее о {{ TF }} [читайте в документации](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  1. Откройте конфигурационный файл {{ TF }} и добавьте блок с описанием бэкенда (`http_backend`, `grpc_backend` или `stream_backend`) во фрагмент с описанием группы бэкендов:
  
      ```hcl
      resource "yandex_alb_backend_group" "test-backend-group" {
        name                     = "<имя группы бэкендов>"

        http_backend {
          name                   = "<имя бэкенда>"
          weight                 = 1
          port                   = 80
          target_group_ids       = ["<идентификатор целевой группы>"]
          load_balancing_config {
            panic_threshold      = 90
          }    
          healthcheck {
            timeout              = "10s"
            interval             = "2s"
            healthy_threshold    = 10
            unhealthy_threshold  = 15 
            http_healthcheck {
              path               = "/"
            }
          }
        }
      }
      ```

      Где `yandex_alb_backend_group` — параметры группы бэкендов:
      * `name` — имя группы бэкендов.
      * `http_backend`, `grpc_backend` и `stream_backend` — [тип бэкенда](../concepts/backend-group.md#group-types). Внутри группы все бэкенды должны быть одного типа — HTTP, gRPC или Stream.
        
      Параметры бэкенда:
      * `name` — имя бэкенда.
      * `port` — порт бэкенда.
      * `weight` — вес бэкенда.
      * `target_group_ids` — идентификатор целевой группы. Получить список доступных целевых групп можно с помощью команды [CLI](../../cli/quickstart.md): `yc alb target-group list`.
      * `load_balancing_config` — параметры балансировки:
        * `panic_threshold` — порог для режима паники.
      * `healthcheck` — параметры проверки состояния:
        * `timeout` — таймаут.
        * `interval` — интервал.
        * `healthy_threshold` — порог работоспособности.
        * `unhealthy_threshold` — порог неработоспособности.
        * `http_healthcheck` — параметры проверки состояния типа HTTP: 
          * `path` — путь.

      Подробную информацию о параметрах ресурса `yandex_alb_backend_group` см. в [документации провайдера {{ TF }}]({{ tf-provider-alb-backendgroup }}).
  1. Примените изменения:
      
      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

      Проверить изменения группы бэкендов можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

      ```bash
      yc alb backend-group get --name <имя группы бэкендов>
      ```

{% endlist %}

## Изменить параметры бэкенда в группе {#update-backend}

{% list tabs %}

- Консоль управления

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создан бэкенд.
   1. Выберите сервис **{{ alb-name }}**.
   1. На панели слева выберите ![image](../../_assets/backgrs.svg) **Группы бэкендов**.
   1. Нажмите на имя нужной группы.
   1. Напротив имени бэкенда нажмите значок ![image](../../_assets/horizontal-ellipsis.svg) и выберите **Редактировать**.
   1. В открывшемся окне задайте настройки бэкенда:
      * Включите опцию **Вес** и задайте вес бэкенда: `1`.
      * Выберите тип бэкенда `Целевая группа` для группы бэкендов типа `HTTP`. В группе бэкендов типа `gRPC` или `Stream` бэкендами могут быть только целевые группы и их наборы.
      * В списке **Целевые группы** выберите `test-target-group` и укажите **Порт**: `80`.
   1. Разверните поле **Настройки балансировки** и задайте их параметры:
      * **Порог для режима паники**: `90`.
      * **Локализация трафика**: `90`.  
   1. Разверните поле **Настройки протокола** и выберите тип `HTTP`. По умолчанию для группы бэкендов типа `HTTP` используется протокол версии 1.1. Чтобы использовать протокол версии 2, включите опцию **HTTP/2**. Группы бэкендов типа `gRPC` поддерживают только HTTP/2-соединения.
   1. Нажмите кнопку **Добавить проверку состояния** и задайте настройки проверки:
      * **Таймаут**: `1`.
      * **Интервал**: `1`.
      * **Порог работоспособности**: `3`.
      * **Порог неработоспособности**: `10`.
      * **Тип**: `HTTP`.

         {% note info %}

         Поддерживаются проверки типов `HTTP`, `gRPC` и `Stream`. Они соответствуют типам групп бэкендов, но тип проверки не обязательно должен совпадать с типом группы. 

         {% endnote %}

      * **Путь**: `/`.
   1. Нажмите кнопку **Сохранить**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для изменения параметров бэкенда:

     ```
     yc alb backend-group update-<тип бэкенда>-backend --help
     ```

  1. Укажите новые параметры бэкенда в зависимости от его типа:

     {% cut "HTTP-бэкенд" %}

     Выполните команду:

     ```
     yc alb backend-group update-http-backend \
       --backend-group-name <имя бэкенд группы> \
       --name <имя бэкенда> \
       --weight <вес бэкенда> \
       --port <порт бэкенда> \
       --target-group-id=<идентификатор целевой группы> \
       --panic-threshold 90 \
       --http-healthcheck port=80,healthy-threshold=10,unhealthy-threshold=15,\
     timeout=10s,interval=2s,host=your-host.com,path=/ping
     ```

     Где:

     * `--panic-threshold` — порог для режима паники.
     * `--http-healthcheck` — параметры проверки состояния ресурсов:
       * `port` — порт.
       * `healthy-threshold` — порог работоспособности.
       * `unhealthy-threshold` — порог неработоспособности.
       * `timeout` — таймаут.
       * `interval` — интервал.
       * `host` — адрес хоста.
       * `path` — путь.

     Результат:

     ```
     id: a5dqkr2mk3rr799f1npa
     name: test-backend-group
     folder_id: aoe197919j8elpeg1lkp
     http:
       backends:
       - name: backend1
         backend_weight: "1"
         load_balancing_config:
           panic_threshold: "90"
         port: "80"
         target_groups:
           target_group_ids:
           - a5d2iap3nue9s3anblu6
         healthchecks:
         - timeout: 10s
           interval: 2s
           healthy_threshold: "10"
           unhealthy_threshold: "15"
           healthcheck_port: "80"
           http:
             host: your-host.com
             path: /ping
     created_at: "2021-02-11T20:46:21.688940670Z"
     ```

     {% endcut %}


     {% cut "Stream-бэкенд" %}

     Выполните команду:

     ```
     yc alb backend-group update-stream-backend \
       --backend-group-name <имя бэкенд группы> \
       --name <имя бэкенда> \
       --weight <вес бэкенда> \
       --port <порт бэкенда> \
       --target-group-id=<идентификатор целевой группы> \
       --panic-threshold 90 \
       --http-healthcheck port=80,healthy-threshold=10,unhealthy-threshold=15,\
     timeout=10s,interval=2s,host=your-host.com,path=/ping
     ```

     Где:

     * `--panic-threshold` — порог для режима паники.
     * `--http-healthcheck` — параметры проверки состояния ресурсов:
       * `port` — порт.
       * `healthy-threshold` — порог работоспособности.
       * `unhealthy-threshold` — порог неработоспособности.
       * `timeout` — таймаут.
       * `interval` — интервал.
       * `host` — адрес хоста.
       * `path` — путь.

     Результат:

     ```
     id: ds77tero4f5h46l4e2gl
     name: test-backend-group
     folder_id: b1gu6g9ielh690at5bm7
     stream:
       backends:
       - name: stream-backend
     backend_weight: "1"
         port: "80"
         target_groups:
           target_group_ids:
           - ds7eof3r2cte9u069p97
         healthchecks:
         - timeout: 10s
           interval: 2s
           healthy_threshold: "10"
           unhealthy_threshold: "15"
           healthcheck_port: "80"
           http:
             host: your-host.com
             path: /ping
     created_at: "2022-04-06T09:17:57.104324513Z"
     ```

     {% endcut %}

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}
  
  Подробнее о {{ TF }} [читайте в документации](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  1. Откройте конфигурационный файл {{ TF }} и измените параметры блока с описанием бэкенда (`http_backend`, `grpc_backend` или `stream_backend`) во фрагменте с описанием группы бэкендов:
  
      ```hcl
      resource "yandex_alb_backend_group" "test-backend-group" {
        name                     = "<имя группы бэкендов>"

        http_backend {
          name                   = "<имя бэкенда>"
          weight                 = 1
          port                   = 80
          target_group_ids       = ["<идентификатор целевой группы>"]
          load_balancing_config {
            panic_threshold      = 90
          }    
          healthcheck {
            timeout              = "10s"
            interval             = "2s"
            healthy_threshold    = 10
            unhealthy_threshold  = 15 
            http_healthcheck {
              path               = "/"
            }
          }
        }
      }
      ```

      Где `yandex_alb_backend_group` — параметры группы бэкендов:
      * `name` — имя группы бэкендов.
      * `http_backend`, `grpc_backend` и `stream_backend` — [тип бэкенда](../concepts/backend-group.md#group-types). Внутри группы все бэкенды должны быть одного типа — HTTP, gRPC или Stream.
        
      Параметры бэкенда:
      * `name` — имя бэкенда.
      * `port` — порт бэкенда.
      * `weight` — вес бэкенда.
      * `target_group_ids` — идентификатор целевой группы. Получить список доступных целевых групп можно с помощью команды [CLI](../../cli/quickstart.md): `yc alb target-group list`.
      * `load_balancing_config` — параметры балансировки:
        * `panic_threshold` — порог для режима паники.
      * `healthcheck` — параметры проверки состояния:
        * `timeout` — таймаут.
        * `interval` — интервал.
        * `healthy_threshold` — порог работоспособности.
        * `unhealthy_threshold` — порог неработоспособности.
        * `http_healthcheck` — параметры проверки состояния типа HTTP: 
          * `path` — путь.

      Подробную информацию о параметрах ресурса `yandex_alb_backend_group` см. в [документации провайдера {{ TF }}]({{ tf-provider-alb-backendgroup }}).
  1. Примените изменения:
  
      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

      Проверить изменения группы бэкендов можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

      ```bash
      yc alb backend-group get --name <имя группы бэкендов>
      ```

{% endlist %}

## Удалить бэкенд из группы {#delete-backend}

Чтобы удалить бэкенд из группы:

{% list tabs %}

- Консоль управления

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создан бэкенд.
   1. Выберите сервис **{{ alb-name }}**.
   1. На панели слева выберите ![image](../../_assets/backgrs.svg) **Группы бэкендов**.
   1. Нажмите на имя нужной группы.
   1. Напротив имени бэкенда нажмите значок ![image](../../_assets/horizontal-ellipsis.svg) и выберите **Удалить**.
   1. Подтвердите удаление.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления бэкенда из группы:
     ```
     yc application-load-balancer delete-<тип бэкенда>-backend --help
     ```

  1. В зависимости от типа бэкенда выполните команду для удаления:

      * HTTP-бэкенд:

        ```
        yc alb backend-group delete-http-backend \
          --backend-group-name=<имя группы бэкендов> \
          --name=<имя удаляемого бэкенда>
        ```

      * Stream-бэкенд:

        ```
        yc alb backend-group delete-stream-backend \
          --backend-group-name=<имя группы бэкендов> \
          --name=<имя удаляемого бэкенда>
        ```

     Результат:

     ```
     id: a5dqkr2mk3rr799f1npa
     name: test-backend-group
     folder_id: aoe197919j8elpeg1lkp
     created_at: "2021-02-11T20:46:21.688940670Z"
     ```

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}
  
  Подробнее о {{ TF }} [читайте в документации](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  1. Откройте конфигурационный файл {{ TF }} и удалите блок с описанием бэкенда (`http_backend`, `grpc_backend` или `stream_backend`) во фрагменте с описанием группы бэкендов.

      Пример описания группы бэкендов в конфигурации {{ TF }}:

      ```hcl
      resource "yandex_alb_backend_group" "test-backend-group" {
        name                     = "<имя группы бэкендов>"

        http_backend {
          name                   = "<имя бэкенда>"
          weight                 = 1
          port                   = 80
          target_group_ids       = ["<идентификатор целевой группы>"]
          load_balancing_config {
            panic_threshold      = 90
          }    
          healthcheck {
            timeout              = "10s"
            interval             = "2s"
            healthy_threshold    = 10
            unhealthy_threshold  = 15 
            http_healthcheck {
              path               = "/"
            }
          }
        }
      }
      ```

      Подробную информацию о параметрах ресурса `yandex_alb_backend_group` см. в [документации провайдера {{ TF }}]({{ tf-provider-alb-backendgroup }}).
  1. Примените изменения:
      
      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

      Проверить изменения группы бэкендов можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

      ```bash
      yc alb backend-group get --name <имя группы бэкендов>
      ```

{% endlist %}
