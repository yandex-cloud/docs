# Миграция в {{ mes-full-name }} с помощью Reindex API

{% include [Elasticsearch-end-of-service](../../_includes/mdb/mes/note-end-of-service.md) %}

Кластеры {{ mes-name }} поддерживают механизм _переиндексации_ — [Reindex API]({{ links.es.reindex-api }}). В качестве источника данных для переиндексации можно указать другой кластер {{ ES }} — такую переиндексацию называют _удаленной_. С ее помощью можно перенести существующие индексы, псевдонимы (aliases) или потоки данных из стороннего _кластера-источника_ в _кластер-приемник_ {{ mes-name }}.

Чтобы мигрировать данные из кластера-источника {{ ES }} в кластер-приемник {{ mes-name }}:

1. [Настройте кластер-приемник](#configure-target).
1. [Запустите переиндексацию](#reindex).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

1. [Создайте кластер-приемник {{ mes-name }}](../../managed-elasticsearch/operations/cluster-create.md) любой подходящей [конфигурации](../../managed-elasticsearch/concepts/instance-types.md).

    Включите доступ к хостам кластера через публичные IP-адреса.

    {% note warning %}

    Версия {{ ES }} в кластере-приемнике должна быть не ниже чем в кластере-источнике.

    {% endnote %}

1. Убедитесь, что вы можете [подключиться к кластеру-приемнику](../../managed-elasticsearch/operations/cluster-connect.md) {{ mes-name }} с помощью {{ ES }} API и Kibana.

1. Убедитесь, что у кластера-источника {{ ES }} есть доступ в интернет.

1. Если кластер-источник использует для защиты соединения самоподписанный сертификат, [добавьте его в качестве расширения](../../managed-elasticsearch/operations/cluster-extensions.md#add) к кластеру-приемнику.

1. Создайте в кластере-источнике пользователя с ролями `monitoring_user` и `viewer`.

## Настройте кластер-приемник {#configure-target}

1. [Создайте роль](https://www.elastic.co/guide/en/kibana/current/xpack-security.html#_roles_2) с привилегиями `create_index` и `write` для всех индексов (`*`).

1. [Создайте пользователя](../../managed-elasticsearch/operations/cluster-users.md) и назначьте ему эту роль.

    {% note tip %}

    В кластерах {{ mes-name }} вы можете использовать Reindex API от имени пользователя `admin`, имеющего роль `superuser`, но безопаснее для каждой задачи создавать отдельных пользователей с ограниченными привилегиями. Подробнее см. в разделе [{#T}](../../managed-elasticsearch/operations/cluster-users.md).

    {% endnote %}

1. [Измените настройки СУБД](../../managed-elasticsearch/operations/cluster-update.md#change-elasticsearch-config):

    * **Reindex remote whitelist** — укажите IP-адрес или FQDN кластера-источника, например:

        ```ini
        192.168.0.1:9200, example.com:9200
        ```

    * (Опционально) **Reindex SSL CA path** — укажите локальный путь до загруженного сертификата `/etc/elasticsearch/extensions/<имя_расширения>/<имя_сертификата>`.

## Запустите переиндексацию {#reindex}

1. [Получите список хостов](../../managed-elasticsearch/operations/cluster-hosts.md#list-hosts) кластера-приемника.

1. Для запуска переиндексации выполните запрос к хосту с ролью _Master node_ в кластере-приемнике:

    ```bash
    curl --user <имя_пользователя_в_кластере-приемнике>:<пароль_пользователя_в_кластере-приемнике> \
         --request POST "https://<IP-адрес_или_FQDN_хоста_Master_node_в_кластере-приемнике>:9200/_reindex?pretty" \
         --header 'Content-Type: application/json' \
         --data '{
           "source": {
             "remote": {
               "host": "https://<IP-адрес_или_FQDN_хоста_Master_Node_в_кластере-источнике>:9200",
               "username": "<имя_пользователя_в_кластере-источнике>",
               "password": "<пароль_пользователя_в_кластере-источнике>"
             },
             "index": "<имя_индекса_псевдонима_или_потока_данных_в_кластере-источнике>"
           },
           "dest": {
             "index": "<имя_индекса_псевдонима_или_потока_данных_в_кластере-приемнике>"
           }
         }'
    ```

    Чтобы перенести несколько индексов, используйте цикл `for`:

    ```bash
    for index in <имена_индексов_псевдонимов_или_потоков_данных_разделенные_пробелами>; do
      curl --user <имя_пользователя_в_кластере-приемнике>:<пароль_пользователя_в_кластере-приемнике> \
           --request POST "https://<IP-адрес_или_FQDN_хоста_Master_Node_в_кластере-приемнике>:9200/_reindex?pretty" \
           --header 'Content-Type: application/json' \
           --data '{
             "source": {
               "remote": {
                 "host": "https://<IP-адрес_или_FQDN_хоста_Master_Node_в_кластере-источнике>:9200",
                 "username": "<имя_пользователя_в_кластере-источнике>",
                 "password": "<пароль_пользователя_в_кластере-источнике>"
               },
               "index": "'$index'"
             },
             "dest": {
               "index": "'$index'"
             }
           }'
    done
    ```

## Удалите неиспользуемые ресурсы {#clear-out}

Удалите ресурсы, которые вы больше не будете использовать, чтобы за них не списывалась плата:

* Если вы зарезервировали для доступа к кластеру публичные статические IP-адреса, освободите и [удалите их](../../vpc/operations/address-delete.md).
* Если для загрузки самоподписанного сертификата вы использовали бакет {{ objstorage-full-name }}, [очистите](../../storage/operations/objects/delete-all.md) и [удалите](../../storage/operations/buckets/delete.md) его.
