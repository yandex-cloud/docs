# Создать HTTP-роутер

Создайте группу бэкендов в этом же каталоге по [инструкции](backend-group-create.md).

Чтобы создать HTTP-роутер и добавить в него маршрут:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создаваться HTTP-роутер.
  1. В списке сервисов выберите **{{ alb-name }}**.
  1. На панели слева выберите ![image](../../_assets/router.svg) **HTTP-роутеры**.
  1. Нажмите кнопку **Создать HTTP-роутер**.
  1. Введите имя роутера: `test-router`.
  1. В блоке **Виртуальные хосты** нажмите кнопку **Добавить виртуальный хост**.
  1. Введите имя хоста: `test-host-1`.
  1. Нажмите кнопку **Добавить маршрут**.
  1. Введите **Имя**: `test-route`.
  1. В поле **Путь** выберите `Совпадает с` и укажите путь `/`.
  1. В списке **Методы HTTP** выберите `GET`.
  1. В поле **Действие** оставьте `Маршрутизация`.
  1. В списке **Группа бэкендов** выберите `test-backend-group`.
  1. Остальные настройки оставьте без изменений и нажмите кнопку **Создать**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания HTTP-роутера:
     ```
     yc alb http-router create --help
     ```

  1. Выполните команду:
     ```
     yc alb http-router create <имя HTTP-роутера>
     ```

     Результат:
     ```
     id: a5dcsselagj4o2v4a6e7
     name: test-http-router
     folder_id: aoerb349v3h4bupphtaf
     created_at: "2021-02-11T21:04:59.438292069Z"
     ```

  1. Посмотрите описание команды CLI для создания виртуального хоста:
     ```
     yc alb virtual-host create --help
     ```

  1. Создайте виртуальный хост, указав имя HTTP-роутера и настройки виртуального хоста:
     ```
     yc alb virtual-host create <имя виртуального хоста> \
       --http-router-name <имя HTTP-роутера> \
       --authority your-domain.foo.com \
       --modify-request-header name=Accept-Language,append=ru-RU
     ```

     Где:

     * `--authority` — домены для заголовков `Host` и `authority`, которые будут связаны с этим виртуальным хостом. Поддерживаются символы подстановки, например `*.foo.com` или `*-bar.foo.com`.
     * `--modify-request-header` — настройки модификации заголовка запроса:
       * `name` — имя модифицируемого заголовка.
       * `append` — строка, которая будет добавлена к значению заголовка.

     Результат:
     ```
     name: test-virtual-host
     authority:
     - your-domain.foo.com
     modify_request_headers:
     - name: Accept-Language
       append: ru-RU
     ```

  1. Посмотрите описание команды CLI для добавления маршрута:
     ```
     yc alb virtual-host append-http-route --help
     ```

  1. Добавьте маршрут, указав идентификатор или имя роутера и параметры маршрутизации:
     ```
     yc alb virtual-host append-http-route <имя маршрута> \
       --virtual-host-name <имя виртуального хоста> \
       --http-router-name <имя HTTP-роутера> \
       --prefix-path-match / \
       --backend-group-name <имя группы бэкендов> \
       --request-timeout <тайм-аут запроса>s \
       --request-idle-timeout <тайм-аут ожидания запроса>s
     ```

     Результат:
     ```
     done (1s)
     name: test-virtual-host
     authority:
     - your-domain.foo.com
     routes:
     - name: test-route
       http:
         match:
           path:
             prefix_match: /
         route:
           backend_group_id: a5d4db973944t2fh8gor
           timeout: 2s
           idle_timeout: 3s
     modify_request_headers:
     - name: Accept-Language
       append: ru-RU
     ```

{% endlist %}
