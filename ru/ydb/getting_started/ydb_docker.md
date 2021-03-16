# Использование Docker-контейнера YDB

Для отладки или тестов вы можете локально запустить {{ ydb-full-name }} в Docker-контейнере. В Docker-контейнере используется актуальная версия сборки {{ ydb-short-name }}, однако ревизия сборки может отличаться.

{% note warning %}

При работе локальной базы данных, в зависимости от задач, может использоваться значительная часть вычислительных ресурсов компьютера.

{% endnote %}

{% if audience != "external" %}

{% note info "Рецепт YDB" %}

Для тестов в Аркадии рекомендуется использовать [рецепт YDB](../getting_started/ydb_recipe.md)

{% endnote %}

{% endif %}

{% if audience == "external" %}

## Скачивание Docker-образа YDB {#install}
   
{% if deploy != "arc" %}

Перед скачиванием Docker-образа {{ ydb-short-name }} посмотрите, как можно [получить информацию об имеющихся Doker-образах](../../container-registry/operations/docker-image/docker-image-list.md) в реестре [Yandex Container Registry](../../container-registry/).

{% endif %}

1. Cкачайте Docker-образ, выполнив команду:

   ```bash
   sudo docker pull cr.yandex/yc/yandex-docker-local-ydb:latest
   ```
  
   Параметры команды:
   `cr.yandex/yc/yandex-docker-local-ydb:latest` — актуальная версия Docker-образа.

1. Проверьте, что Docker-образ скачался:
      
   ```bash
   docker image list
   ```

## Запуск Docker-контейнера YDB {#start}

В режиме локального запуска для работы с базой данных предоставляется только API.
API для работы с данными разворачивается на порту `2135`, имя предварительно созданной базы данных `/local`.

{{ ydb-full-name }} в Docker-контейнере принимает входящие соединения, защищённые TLS. Для установки соединения используются сертификаты, сгенерированные автоматически.
Для корректной работы сертификатов необходимо смонтировать из запущенного Docker-контейнера  директорию `/ydb_cert`.

Для сохранения состояния базы данных в локальной директории используется директория из Docker-контейнера `/ydb_data`.

Для запуска {{ ydb-short-name }} Docker-контейнера и монтирования нужных директорий выполните команду:

```bash
docker run --name ydb-local --rm --hostname localhost --rm -dp 2135:2135 -dp 8765:8765 -v $(pwd)/ydb_certs:/ydb_certs -v $(pwd)/ydb_data:/ydb_data -e YDB_LOCAL_SURVIVE_RESTART=true cr.yandex/yc/yandex-docker-local-ydb:latest
```

Параметры команды:
- `--name` — имя Docker-контейнера.
- `--hostname` — имя хоста контейнера.
   
{% note info %}

Инициализация Docker-контейнера, в зависимости от мощности компьютера, может занять до двух минут. До окончания инициализации база данных будет недоступна.

{% endnote %}

## Запросы к базе данных {#request}

Работа с локальной базой данных осуществляется с помощью консольного клиента {{ ydb-short-name }} ([YDB CLI](../quickstart/examples-ydb-cli.md)), предустановленного внутри Docker-образа. Посмотрите [примеры запросов](../quickstart/examples-ydb-cli.md#examples) к базе данных с помощью YDB CLI.

По аналогии с {{ ydb-full-name }} в {{ yandex-cloud }}, для взаимодействия с локальной базой используется защищённое TLS соединение.
Для работы с {{ ydb-full-name }} в Docker-контейнере необходимо использовать сертификат, размещённый в директории `/ydb_cert`, смонтированной из запущенного Docker-контейнера.

Пример запроса:

```bash
{{ ydb-cli }} -e grpcs://localhost:2135 --ca-file $(pwd)/ydb_certs/ca.pem -d /local table query execute -q 'select 1;'
```

Параметры команды:

- `-e` — эндпоинт.
- `--ca-file` — опция, через которую указывается путь к TLS-сертификату.
- `-d` — база данных.

Результат команды:

```bash
┌─────────┐
| column0 |
├─────────┤
| 1       |
└─────────┘
```

{% else %}

## Использование Docker образа { #docker-usage }

Образ контейнера публикуется Registry: ``registry.yandex.net/yandex-docker-local-ydb:stable``. Чтобы скачать самую актуальную версию образа,
выполните команду:

```bash
sudo docker pull registry.yandex.net/yandex-docker-local-ydb:stable
```

После чего можно поднять новый контейнер:

```bash
sudo docker run --hostname localhost -e YDB_LOCAL_SURVIVE_RESTART=true -dp 2135:2135 registry.yandex.net/yandex-docker-local-ydb:stable
```

Внутри образа доступна предсобранная версия [YDB CLI](../getting_started/ydb_cli.md), с помощью которой можно выполнять различные команды, например:

```bash
sudo docker exec <CONTAINER-ID> /ydb -e localhost:2135 -d /local table query execute -q 'select 1;'
┌─────────┐
| column0 |
├─────────┤
| 1       |
└─────────┘
```

Аналогичным образом можно использовать ``ya ydb`` для доступа к данным в контейнере, например:

```bash
ya ydb -e localhost:2135 -d /local  table query execute -q 'select 1;'
┌─────────┐
| column0 |
├─────────┤
| 1       |
└─────────┘
```

{% endif %}

## Остановка Docker-контейнера { #stop }

По ококнчании работы Doker-контейнер можно остановить командой:

```bash
docker kill ydb-local
```

## Дополнительные опции

Docker-контейнер {{ ydb-short-name }} поддерживает несколько дополнительных опций, которые можно задать через переменные окружения:

* `YDB_LOCAL_SURVIVE_RESTART=true` — позволяет выполнить перезапуск контейнера без потери данных.
* `YDB_USE_IN_MEMORY_PDISKS=true` — включает возможность хранения данных целиком в памяти. В случае если данная опция включена, рестарт контейнера с локальным {{ ydb-short-name }} приведет к полной потери данных.
* `YDB_DEFAULT_LOG_LEVEL=<уровень>` — позволяет настроить уровень логирования по умолчанию. Доступные значения уровней: `CRIT`, `ERROR`, `WARN`, `NOTICE`, `INFO`.

## Лицензия и используемые компоненты { #license }

В корне Docker-контейнера расположены файл с текстом лицензионного соглашения (`LICENSE`) и список используемых компонентов и их лицензии (`THIRD_PARTY_LICENSES`). 

Выведите текст лицензионного соглашения на экран командой: 

```
sudo docker run --rm -it --entrypoint cat cr.yandex/yc/yandex-docker-local-ydb LICENSE
```

Посмотрите все использованные при создании компоненты и их лицензии:

```
sudo docker run --rm -it --entrypoint cat cr.yandex/yc/yandex-docker-local-ydb THIRD_PARTY_LICENSES
```