# Создать группу бэкендов

Чтобы создать группу бэкендов, добавить в нее бэкенд и настроить проверку состояния:

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
      1. В списке **Целевая группа** выберите `test-target-group`.
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
     yc alb backend-group create test-backend-group
     ```
  
     Результат выполнения команды:

     ```
     id: a5dg2cv4ngne8575fb1p
     name: test-backend-group
     folder_id: aoerb349v3h4bupphtaf
     ```

  1. Добавьте в группу бэкенд и проверку состояния:

     ```
     yc application-load-balancer backend-group add-http-backend \
     --backend-group-name test-backend-group \
     --name backend1 \
     --weight 1 \
     --port 80 \
     --target-group-id=a5d751meibht4ev264pp \
     --panic-threshold 90
     --http-health-check port=80,healthy-threshold=10,unhealthy-threshold=15,timeout=10s,interval=2s,host=your-host.com,path=/ping
     ```

     Результат выполнения команды:

     ```
     id: a5dg2cv4ngne8575fb1p
     name: test-backend-group
     folder_id: aoerb349v3h4bupphtaf
     http:
       backends:
       - name: backend1
         backend_weight: "1"
         load_balancing_config:
           panic_threshold: "90"
         port: "80"
         target_groups:
           target_group_ids:
           - a5d751meibht4ev264pp
         healthchecks:
         - timeout: 10s
           interval: 2s
           healthy_threshold: "10"
           unhealthy_threshold: "15"
           healthcheck_port: "80"
           http:
             host: your-host.com
             path: /ping
     ```


{% endlist %}