[Документация Yandex Cloud](../../index.md) > [Yandex Smart Web Security](../index.md) > [Пошаговые инструкции](index.md) > Списки адресов

# Управление списками

Вы можете управлять только [пользовательскими списками](../concepts/lists.md#user-rules). Предустановленные [списки Yandex Cloud](../concepts/lists.md#yc-rules) изменять нельзя.


## Создать список {#create}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Перейдите](https://console.yandex.cloud/link/smartwebsecurity) в сервис **Smart Web Security**.
  1. На панели слева выберите ![image](../../_assets/console-icons/files.svg) **Списки** и нажмите **Создать список**.
  1. Выберите тип списка:

      * `IP-адреса` — IP-адреса, диапазоны адресов или префиксы в формате [CIDR](https://ru.wikipedia.org/wiki/Бесклассовая_адресация). Примеры:

          ```text
          111.222.33.44
          2001:0db8:85a3:0000:0000:8a2e:5678:1234
          10.123.1.1/32
          10::1234:1abc:1/64
          1.2.0.0-1.2.1.1
          ```

      * `Номера ASN` — номера [автономных систем](https://ru.wikipedia.org/wiki/Автономная_система_(Интернет)). Примеры:

          ```text
          AS64512
          AS4294967294
          15169
          1.10
          ```

      * `Регулярные выражения` — [регулярные выражения](../concepts/conditions.md#regular-expressions), например для анализа заголовка `User-Agent` или для объединения нескольких путей запроса через `|`. Примеры:

          ```text
          User-Agent:\s*
          \\[\'\"\.\;]
          a{100,}
          --.*
          /api/v[12]/users
          /promo/(sale|discount)/?
          /assets/.*\.(css|js)
          ```

          Где:

          - `/api/v[12]/users` — пути `/api/v1/users` и `/api/v2/users`.
          - `/promo/(sale|discount)/?` — страницы `/promo/sale` и `/promo/discount` с необязательной завершающей косой чертой.
          - `/assets/.*\.(css|js)` — пути к CSS- и JS-файлам в каталоге `/assets/`.

          В регулярном выражении можно объединять несколько вариантов (разные пути запроса, версии API или значения заголовка) с помощью оператора `|`. Специальные символы необходимо экранировать. Например, точка в имени файла записывается как `\.`.

          В списках регулярных выражений проверяется совпадение всей строки. Не добавляйте якоря `^` и `$`.

      * `Строковые значения` — текстовые строки, например идентификаторы или пути запроса. Примеры:

          ```text
          fev4ct8l9infabcd1234
          id345678
          /api/v1/users
          /promo/sale
          /assets/logo.svg
          ```

      Для фильтрации по пути запроса подключите список к условию `Request URI`. В списке указывайте пути без схемы, домена и query-параметров.

      Чтобы фильтровать запросы к статическим файлам на домене `static.example.com`, подключите к условию `Request URI` список с регулярным выражением `/assets/.*\.(css|js)`. Добавьте отдельное условие `Host = static.example.com` и объедините оба условия логическим оператором «И».

  1. Введите имя и описание списка.
  1. При необходимости добавьте метку.
  1. Нажмите **Создать список** и затем **Добавить в список**.
  1. Введите значения в список вручную или загрузите их из файла TXT или CSV.

     В списке или в файле каждое значение указывайте с новой строки. Дополнительно можно добавить описание через запятую без пробела:

     ```text
     <значение_1>,<описание_1>
     <значение_2>,<описание_2>
     <значение_3>
     <значение_4>
     ```

     При загрузке файла прежний список не сохранится, а будет заменен на новый.

  1. Нажмите **Сохранить изменения**.


- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды:

     ```bash
     yc smartwebsecurity match-list match-list create --help
     ```

  1. Создайте пользовательский список. Укажите тип элементов в параметре `--item-type`:

     * `ip` — IP-адреса, диапазоны адресов или префиксы CIDR:

       ```bash
       yc smartwebsecurity match-list match-list create <идентификатор_каталога> \
         --name <имя_списка> \
         --list-type custom \
         --item-type ip \
         --items '[{value="192.0.2.1",description="Описание IP-адреса"}]'
       ```

     * `asn` — номера автономных систем:

       ```bash
       yc smartwebsecurity match-list match-list create <идентификатор_каталога> \
         --name <имя_списка> \
         --list-type custom \
         --item-type asn \
         --items '[{value="AS64512",description="Описание номера ASN"}]'
       ```

     * `reg-exp` — регулярные выражения:

       ```bash
       yc smartwebsecurity match-list match-list create <идентификатор_каталога> \
         --name <имя_списка> \
         --list-type custom \
         --item-type reg-exp \
         --items '[{value="User-Agent:\\s*",description="Описание регулярного выражения"}]'
       ```

     * `str` — текстовые строки:

       ```bash
       yc smartwebsecurity match-list match-list create <идентификатор_каталога> \
         --name <имя_списка> \
         --list-type custom \
         --item-type str \
         --items '[{value="fev4ct8l9infabcd1234",description="Описание строкового значения"}]'
       ```

     Где:

     * `<идентификатор_каталога>` — идентификатор каталога, в котором будет создан список.
     * `--name` — имя списка.
     * `--list-type` — тип списка, укажите значение `custom` ([пользовательский список](../concepts/lists.md#user-rules)). Значение `managed` используется для предустановленных списков.
     * `--item-type` — [тип элементов](../concepts/lists.md#list-item-types) списка: `ip`, `asn`, `str`, `reg-exp`. У предустановленных списков могут быть типы `ip`, `bot-name`, `bot-category`.
     * `--items` — элементы списка в shorthand-синтаксисе. Строковые значения указывайте в двойных кавычках.

  1. Чтобы не создавать файл запроса вручную, сформируйте и отредактируйте его шаблон.
  
     Для JSON-файла выполните команду:

     ```bash
     yc smartwebsecurity match-list match-list create --example-json > request.json
     ```

     Для YAML-файла выполните команду:

     ```bash
     yc smartwebsecurity match-list match-list create --example-yaml > request.yaml
     ```

     Отредактируйте созданный файл и передайте его в команде создания списка:

     ```bash
     yc smartwebsecurity match-list match-list create \
       --request-file request.yaml
     ```

- API {#api}

    Воспользуйтесь методом REST API [create](../match_list/api-ref/MatchList/create.md) для ресурса [MatchList](../match_list/api-ref/MatchList/index.md) или вызовом gRPC API [MatchListService/Create](../match_list/api-ref/grpc/MatchList/create.md).

{% endlist %}

Теперь при добавлении правила в [профиле безопасности](rule-add.md), [профиле ARL](arl-rule-add.md) или [правила-исключения](exclusion-rule-add.md) в профиле WAF вы можете выбрать созданный список.

## Скачать список {#download}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Перейдите](https://console.yandex.cloud/link/smartwebsecurity) в сервис **Smart Web Security**.
  1. На панели слева выберите ![image](../../_assets/console-icons/files.svg) **Списки**.
  1. Нажмите строку с нужным списком.
  1. Перейдите на вкладку **IP-адреса**.
  1. Нажмите ![image](../../_assets/console-icons/arrow-down-to-line.svg) **Скачать список**.

      Список будет сохранен в формате CSV.

- CLI {#cli}

  1. Посмотрите описание команды:

     ```bash
     yc smartwebsecurity match-list match-list get --help
     ```

  1. Сохраните список в файл:

     ```bash
     yc smartwebsecurity match-list match-list get \
       --list-id <идентификатор_списка> \
       --format json > list.json
     ```

     Файл `list.json` содержит JSON-представление ресурса с метаданными и элементами списка. Без `> list.json` команда выводит результат в терминал.

- API {#api}

    Воспользуйтесь методом REST API [get](../match_list/api-ref/MatchList/get.md) для ресурса [MatchList](../match_list/api-ref/MatchList/index.md) или вызовом gRPC API [MatchListService/Get](../match_list/api-ref/grpc/MatchList/get.md).

    Метод возвращает ресурс с метаданными и элементами списка. Ответ REST API можно сохранить в JSON-файл.

{% endlist %}


## Изменить параметры списка {#update-params}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Перейдите](https://console.yandex.cloud/link/smartwebsecurity) в сервис **Smart Web Security**.
  1. На панели слева выберите ![image](../../_assets/console-icons/files.svg) **Списки**.
  1. В строке с нужным списком нажмите ![options](../../_assets/console-icons/ellipsis.svg) и выберите ![pencil-to-line](../../_assets/console-icons/pencil-to-line.svg) **Переименовать**.
  1. Измените имя и описание списка, добавьте или удалите метки.
  1. Нажмите **Сохранить изменения**.

- CLI {#cli}

  1. Посмотрите описание команды:

     ```bash
     yc smartwebsecurity match-list match-list update --help
     ```

  1. Измените параметры списка:

     ```bash
     yc smartwebsecurity match-list match-list update \
       --list-id <идентификатор_списка> \
       --name <имя_списка> \
       --description <описание_списка>
     ```

     Где:

     * `--list-id` — идентификатор списка.
     * `--name` — имя списка.
     * (Опционально) `--description` — описание списка.

- API {#api}

    Воспользуйтесь методом REST API [update](../match_list/api-ref/MatchList/update.md) для ресурса [MatchList](../match_list/api-ref/MatchList/index.md) или вызовом gRPC API [MatchListService/Update](../match_list/api-ref/grpc/MatchList/update.md).

    Передайте новые значения полей `name`, `description` или `labels`. Чтобы сохранить остальные поля, перечислите изменяемые поля в маске обновления: `updateMask` для REST API или `update_mask` для gRPC API.

{% endlist %}

## Изменить список значений {#update-values}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Перейдите](https://console.yandex.cloud/link/smartwebsecurity) в сервис **Smart Web Security**.
  1. На панели слева выберите ![image](../../_assets/console-icons/files.svg) **Списки**.
  1. Нажмите строку с нужным списком.
  1. Перейдите на вкладку **IP-адреса**.

      * Чтобы изменить описание для одного или нескольких значений, выберите их и на панели внизу нажмите ![image](../../_assets/console-icons/pencil-to-line.svg) **Изменить описание**.
      * Чтобы удалить одно или несколько значений, выберите их и нажмите ![image](../../_assets/console-icons/trash-bin.svg) **Удалить**.
      * Чтобы отредактировать список в текстовом формате или загрузить новый файл со списком:

          1. Нажмите ![pencil-to-square](../../_assets/console-icons/pencil-to-square.svg) **Изменить список**.
          1. Отредактируйте список или загрузите новый файл.
          1. Нажмите **Сохранить изменения**.

- CLI {#cli}

  1. Посмотрите описание команды:

     ```bash
     yc smartwebsecurity match-list match-list update --help
     ```

  1. Измените значения списка:

     {% note warning %}

     Команда полностью заменяет содержимое списка: прежние элементы, не указанные в `--items`, будут удалены. Перед обновлением [скачайте текущий список в формате JSON](#download), отредактируйте массив `items` и передайте его в параметре `--items`.

     {% endnote %}

     ```bash
     yc smartwebsecurity match-list match-list update \
       --list-id <идентификатор_списка> \
       --items '[{"value":"192.0.2.1","description":"Описание IP-адреса"}]'
     ```

     Где:

     * `--list-id` — идентификатор списка.
     * `--items` — полный список значений в формате JSON, которым будет заменен существующий список.

- API {#api}

    Воспользуйтесь методом REST API [update](../match_list/api-ref/MatchList/update.md) для ресурса [MatchList](../match_list/api-ref/MatchList/index.md) или вызовом gRPC API [MatchListService/Update](../match_list/api-ref/grpc/MatchList/update.md).

    Передайте полный массив элементов в поле `items`. Чтобы изменить только содержимое списка, укажите `items` в маске обновления: `updateMask` для REST API или `update_mask` для gRPC API.

    {% note warning %}

    Массив `items` полностью заменяет содержимое списка. Прежние элементы, не включенные в массив, будут удалены.

    {% endnote %}

{% endlist %}

## Удалить список {#delete}

Перед удалением уберите ссылки на список из [правил профилей безопасности](rule-update.md), [правил ARL](arl-rule-update.md) и [правил-исключений WAF](exclusion-rule-update.md). Пока список используется, удалить его нельзя, в CLI и API будет возвращаться ошибка `FailedPrecondition`.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Перейдите](https://console.yandex.cloud/link/smartwebsecurity) в сервис **Smart Web Security**.
  1. На панели слева выберите ![image](../../_assets/console-icons/files.svg) **Списки**
  1. В строке с нужным списком нажмите ![options](../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../_assets/console-icons/trash-bin.svg) **Удалить**.

- CLI {#cli}

  1. Посмотрите описание команды:

     ```bash
     yc smartwebsecurity match-list match-list delete --help
     ```

  1. Удалите список:

     ```bash
     yc smartwebsecurity match-list match-list delete --list-id <идентификатор_списка>
     ```

- API {#api}

    Воспользуйтесь вызовом gRPC API [MatchListService/Delete](../match_list/api-ref/grpc/MatchList/delete.md).

{% endlist %}

#### Полезные ссылки {#see-also}

* [Списки](../concepts/lists.md)
* [Условия](../concepts/conditions.md)
* [Добавить правило в профиль безопасности](rule-add.md)
* [Добавить правило в профиль ARL](arl-rule-add.md)