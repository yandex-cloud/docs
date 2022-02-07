# Создать группу бэкендов

При создании в [группу бэкендов](../concepts/backend-group.md) можно добавлять бэкенды двух [типов](../concepts/backend-group.md#types): с [целевыми группами](../concepts/target-group.md) и с [бакетами {{ objstorage-name }}](../../storage/concepts/bucket.md). 

## Создание группы бэкендов с целевой группой {#with-target-group}

{% list tabs %}

- Консоль управления
  
  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создаваться группа бэкендов.
  1. В списке сервисов выберите **{{ alb-name }}**.
  1. В меню слева выберите **Группы бэкендов**.
  1. Нажмите кнопку **Создать группу бэкендов**.
  1. Введите имя группы бэкендов: `test-backend-group`.
  1. В блоке **Бэкенды** нажмите кнопку **Добавить**. Задайте настройки бэкенда:
      1. Введите имя бэкенда: `test-backend-1`.
      1. Задайте вес бэкенда: `1`.
      1. Выберите тип бэкенда: **Целевые группы**.
      1. В списке **Целевые группы** выберите `test-target-group`.
      1. Укажите **Порт**: `80`.
  1. Разверните поле **Настройки балансировки** и задайте их параметры:
     1. **Порог для режима паники**: `90`.
     1. **Локализация трафика**: `90`.  
  1. Разверните поле **Настройки протокола** и задайте их параметры:
        1. Выберите тип `HTTP`.
  1. Нажмите кнопку **Добавить проверку состояния** и задайте настройки проверки:
     1. **Таймаут**: `1`.
     1. **Интервал**: `1`.
     1. **Порог работоспособности**: `3`.
     1. **Порог неработоспособности**: `10`.
     1. **Тип**: `HTTP`.
     1. **Путь**: `/`.
  1. Нажмите кнопку **Создать**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания группы бэкендов:
     ```
     yc alb backend-group create --help
     ```

  1. Создайте группу бэкендов, выполнив команду:
     ```
     yc alb backend-group create <имя группы бэкендов>
     ```

     Результат выполнения команды:

     ```
     id: a5dg2cv4ngne8575fb1p
     name: test-backend-group
     folder_id: aoerb349v3h4bupphtaf
     created_at: "2021-02-11T20:46:21.688940670Z"
     ```

  1. Добавьте в группу бэкенд и проверку состояния:
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

     Параметры команды:

     * `--panic-threshold` — порог для режима паники.
     * `--http-healthcheck` — параметры проверки состояния ресурсов.
       * `port` — порт.
       * `healthy-threshold` — порог работоспособности.
       * `unhealthy-threshold` — порог неработоспособности.
       * `timeout` — таймаут.
       * `interval` — интервал.
       * `host` — адрес хоста.
       * `path` — путь.

     Результат выполнения команды:

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

{% endlist %}

## Создание группы бэкендов с бакетом {#with-s3-bucket}

{% include [bucket-availability-note](../_includes_service/bucket-availability-note.md) %}

{% list tabs %}

- Консоль управления
  
  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создаваться группа бэкендов.
  1. В списке сервисов выберите **{{ alb-name }}**.
  1. В меню слева выберите **Группы бэкендов**.
  1. Нажмите кнопку **Создать группу бэкендов**.
  1. Введите имя группы бэкендов: `test-backend-group`.
  1. В блоке **Бэкенды** нажмите кнопку **Добавить**. Задайте настройки бэкенда:
  
      1. Введите имя бэкенда: `test-backend-1`.
      1. Задайте вес бэкенда: `1`.
      1. Выберите тип бэкенда: **Бакет**.
      1. Выберите бакет, который нужно использовать в качестве бэкенда.

  1. Нажмите кнопку **Создать**.

{% endlist %}
