# Изменить HTTP-роутер

{% list tabs %}

- Консоль управления

  Чтобы изменить HTTP-роутер:
  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит HTTP-роутер.
  1. Выберите сервис **{{ alb-name }}**.
  1. Откройте раздел **HTTP-роутеры**.
  1. Нажмите на имя нужного роутера.
  1. Нажмите **Редактировать**.
  1. Измените параметры роутера.
  1. Внизу страницы нажмите кнопку **Сохранить изменения**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для изменения балансировщиков:

     ```
     yc alb http-router update --help
     ```

  1. Выполните команду, указав новые параметры роутера:
  
     ```
     yc alb http-router update router-1 --new-name router-1-new
     ```

{% endlist %}

## Добавить маршрут в виртуальный хост {#add-virtual-host}

{% list tabs %}

- Консоль управления

  Чтобы добавить новый маршрут в виртуальный хост HTTP-роутера:
  
  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит HTTP-роутер.
  1. Выберите сервис **{{ alb-name }}**.
  1. Откройте раздел **HTTP-роутеры**.
  1. Нажмите на имя нужного роутера.
  1. Нажмите **Редактировать**.
  1. Нажмите кнопку **Добавить маршрут**.
  1. Задайте параметры параметры маршрута и нажмите **Сохранить**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для работы с виртуальными хостами:

     ```
     yc alb virtual-host --help
     ```

  1. Вы можете добавить новый маршрут в начало, в конец или в определенное место списка маршрутов хоста.
  
     Чтобы добавить маршрут в конец списка:

     ```
     yc alb virtual-host append-http-route <имя маршрута> \
     --virtual-host-name <имя виртуального хоста> \
     --http-router-name <имя HTTP-роутера> \
     --match-http-method GET \
     --exact-path-match / \
     --backend-group-name <имя группы бэкендов> \
     --request-timeout 2s \
     --request-idle-timeout 3s
     ```

     Чтобы добавить маршрут в начало списка:

     ```
     yc alb virtual-host prepend-http-route <имя маршрута> \
     --virtual-host-name <имя виртуального хоста> \
     --http-router-name <имя HTTP-роутера> \
     --match-http-method GET \
     --exact-path-match / \
     --backend-group-name <имя группы бэкендов> \
     --request-timeout 2s \
     --request-idle-timeout 3s
     ```

     Чтобы добавить новый маршрут перед определенным маршрутом:

     ```
     yc alb virtual-host insert-http-route new-route \
     --virtual-host-name <имя виртуального хоста> \
     --before <имя маршрута, перед которым надо поставить новый маршрут> \
     --http-router-name router-1 \
     --match-http-method GET \
     --exact-path-match / \
     --backend-group-name <имя группы бэкендов> \
     --request-timeout 2s \
     --request-idle-timeout 3s
     ```

     Чтобы добавить маршрут после определенного маршрута:

     ```
     yc alb virtual-host insert-http-route new-route \
     --virtual-host-name <имя виртуального хоста> \
     --after <имя маршрута, после которого надо поставить новый маршрут> \
     --http-router-name <имя HTTP-роутера> \
     --match-http-method GET \
     --exact-path-match / \
     --backend-group-name <имя группы бэкендов> \
     --request-timeout 2s \
     --request-idle-timeout 3s
     ```

{% endlist %}