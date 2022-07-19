# Создать HTTP-роутер для gRPC-трафика

Чтобы создать HTTP-роутер и добавить в него маршрут:

{% list tabs %}

- Консоль управления

  1. В меню слева выберите **HTTP-роутеры**.
  1. Нажмите кнопку **Создать HTTP-роутер**.
  1. Введите имя роутера: `test-grpc-router`.
  1. В блоке **Виртуальные хосты** нажмите кнопку **Добавить виртуальный хост**.
  1. Введите **Имя**: `test-virtual-host`.
  1. В поле **Authority** введите: `*` или IP-адрес балансировщика.
  1. Нажмите кнопку **Добавить маршрут** и выбирете **Тип**: `gRPC`.
     1. Введите **Имя**: `grpc-route`.
     1. В блоке **FQMN** выбирете `Начинается с` и в поле ввода укажите `/<первое слово названия сервиса>`, например: `/helloworld`.
      
     {% note warning %}

     FQMN должно начинаться с косой черты `/` и содержать часть полного названия сервиса, на который перенаправляется вызов процедуры.

     {% endnote %}
     
     1. В поле **Действие** оставьте `Маршрутизация`.
     1. В списке **Группа бэкендов** выберите имя группы бэкендов из того же каталога, в котором создаете роутер. 
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
     name: <имя HTTP-роутера>
     folder_id: aoerb349v3h4bupphtaf
     created_at: "2022-06-16T21:04:59.438292069Z"
     ```

  1. Посмотрите описание команды CLI для создания виртуального хоста:
     ```
     yc alb virtual-host create --help
     ```

  1. Создайте виртуальный хост, указав имя HTTP-роутера и настройки виртуального хоста:
     ```
     yc alb virtual-host create <имя виртуального хоста> \
       --http-router-name <имя HTTP-роутера> \
       --authority *
     ```

     Где `--authority` — домены для заголовков `:authority`, которые будут связаны с этим виртуальным хостом. Поддерживаются символы подстановки, например `*.foo.com` или `*-bar.foo.com`.

     Результат:
     ```
     done (1s)
     name: <имя виртуального хоста>
     authority:
     - *
     ```

  1. Посмотрите описание команды CLI для добавления маршрута:
     ```
     yc alb virtual-host append-grpc-route --help
     ```

  1. Добавьте маршрут, указав идентификатор или имя роутера и параметры маршрутизации:
     ```
     yc alb virtual-host append-grpc-route <имя маршрута> \
       --virtual-host-name <имя виртуального хоста> \
       --http-router-name <имя HTTP-роутера> \
       --prefix-fqmn-match "/helloworld" \
       --backend-group-name <имя группы бэкендов> \
       --request-max-timeout 60s \
     ```

     Результат:
     ```
     done (1s)
     name: <имя виртуального хоста>
     authority:
     - *
     routes:
     - name: <имя маршрута>
       grpc:
        match:
          fqmn:
           prefix_match: /helloworld
        route:
          backend_group_id: ds7snban2dvnedokp6kc
          max_timeout: 60s
     
     ```

{% endlist %}
