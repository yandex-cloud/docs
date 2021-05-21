# Использование Docker-контейнера YDB

Для отладки или тестирования вы можете запустить {{ ydb-full-name }} в Docker-контейнере. Docker-контейнер содержит актуальную версию сборки {{ ydb-short-name }}, ревизия сборки может отличаться.

В режиме локального запуска для работы с базой данных предоставляется только {{ ydb-short-name }} API. API доступен на эндпоинте `grpcs://localhost:2135`, имя базы данных `/local`. Работа с базой выполняется с помощью консольного клиента {{ ydb-short-name }} ([YDB CLI](../quickstart/examples-ydb-cli.md)), предустановленного внутри Docker-образа. Посмотрите [примеры запросов](../quickstart/examples-ydb-cli.md#examples) к базе данных с помощью YDB CLI.

{{ ydb-full-name }} в Docker-контейнере принимает входящие соединения, защищённые TLS. Сертификаты генерируются автоматически. Для использования сертификатов необходимо смонтировать на хост-системе директорию `/ydb_cert` Docker-контейнера.

Для локального сохранения состояния базы данных на хост-системе монтируется директория `/ydb_data` Docker-контейнера.

{% note warning %}

При работе локальной базы данных, в зависимости от задач, может использоваться значительная часть вычислительных ресурсов хост-системы.

{% endnote %}



## Выгрузите Docker-образ {{ ydb-short-name }} {#install}

Выгрузите актуальную версию Docker-образа:

```bash
docker pull cr.yandex/yc/yandex-docker-local-ydb:latest
```

Проверьте, что Docker-образ успешно выгружен:

```bash
docker image list
```

Результат выполнения:

```bash
REPOSITORY                             TAG       IMAGE ID       CREATED        SIZE
cr.yandex/yc/yandex-docker-local-ydb   latest    b73c5c1441af   2 months ago   793MB
```

## Запустите Docker-контейнер YDB {#start}

Запустите {{ ydb-short-name }} Docker-контейнер и смонтируйте нужные директории:

```bash
docker run -d \
  --rm \
  --name ydb-local \
  -h localhost \
  -p 2135:2135 -p 8765:8765 \
  -v $(pwd)/ydb_certs:/ydb_certs -v $(pwd)/ydb_data:/ydb_data \
  -e YDB_LOCAL_SURVIVE_RESTART=true \
  cr.yandex/yc/yandex-docker-local-ydb:latest
```

Где:

* `-d` — запустить Docker-контейнер в фоновом режиме.
* `--rm` — удалить контейнер после завершения его работы.
* `--name` — имя контейнера.
* `-h` — имя хоста контейнера.
* `-p` — опубликовать порты контейнера на хост-системе.
* `-v` — монтировать директории хост-системы в контейнер.
* `-e` — задать переменные окружения.

{% note info %}

Инициализация Docker-контейнера, в зависимости от мощности хост-системы, может занять несколько минут. До окончания инициализации база данных будет недоступна.

{% endnote %}

Docker-контейнер {{ ydb-short-name }} поддерживает дополнительные опции, которые можно задать через переменные окружения:

* `YDB_LOCAL_SURVIVE_RESTART=true` — задает перезапуск контейнера без потери данных.
* `YDB_USE_IN_MEMORY_PDISKS=true` — включает возможность хранения данных целиком в памяти. В случае если данная опция включена, рестарт контейнера с локальной {{ ydb-short-name }} приведет к полной потери данных.
* `YDB_DEFAULT_LOG_LEVEL=<уровень>` — задает уровень логирования. Доступные значения уровней: `CRIT`, `ERROR`, `WARN`, `NOTICE`, `INFO`.

## Выполните запрос к базе данных {#request}

Выполните запрос к базе данных {{ ydb-short-name }} в Docker-контейнере:

```bash
ydb \
  -e grpcs://localhost:2135 \
  --ca-file $(pwd)/ydb_certs/ca.pem \
  -d /local table query execute -q 'select 1;'
```

Где:

* `-e` — эндпоинт базы данных.
* `--ca-file` — путь к TLS-сертификату.
* `-d` — имя базы данных и параметры запроса.

Результат выполнения:

```text
┌─────────┐
| column0 |
├─────────┤
| 1       |
└─────────┘
```

## Остановите Docker-контейнер { #stop }

По окончании работы остановите Doker-контейнер:

```bash
docker kill ydb-local
```

## Лицензия и используемые компоненты { #license }

В корне Docker-контейнера расположены файл с текстом лицензионного соглашения (`LICENSE`) и список используемых компонентов и их лицензии (`THIRD_PARTY_LICENSES`).

Просмотрите текст лицензионного соглашения:

```bash
sudo docker run --rm -it --entrypoint cat cr.yandex/yc/yandex-docker-local-ydb LICENSE
```

Просмотрите все использованные при создании компоненты и их лицензии:

```bash
sudo docker run --rm -it --entrypoint cat cr.yandex/yc/yandex-docker-local-ydb THIRD_PARTY_LICENSES
```
