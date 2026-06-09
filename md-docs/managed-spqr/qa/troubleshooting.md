# Устранение неполадок в {{ mspqr-name }}

* [Транзакция не применяется на всех шардах](#cross-shard-transaction-failure)

* [Запросы не направляются на новый шард](#queries-routing-fails-for-new-shard)

* [Ошибка `failed to get connection to any shard host within` при подключении к хостам кластера](#failed-to-get-connection)

* [Ошибка `error processing query ... : syntax error` при выполнении запроса](#error-processing-query)

* [Ошибка `permission denied for schema`](#permission-denied-for-schema)

* [Ошибка `failed to find primary within host`](#failed-to-find-primary)

* [Ошибка `failed to match any datashard` или блокировка запроса](#failed-to-match-any-datashard)

#### Транзакция не применяется на всех шардах {#cross-shard-transaction-failure}

**Причина:** для кросс-шардовых операций не включена двухфазная фиксация.
**Решение:** включите двухфазную фиксацию:

```sql
BEGIN;
SET __spqr__commit_strategy TO '2pc';
INSERT INTO orders ...; /* затрагивает несколько шардов */
COMMIT;
```

{% note warning %}

Параметр `max_prepared_transactions` должен быть строго больше нуля на всех шардах.

{% endnote %}

#### Запросы не направляются на новый шард {#queries-routing-fails-for-new-shard}

При добавлении нового шарда вы можете столкнуться с тем, что запросы не направляются на него. Чтобы отследить роутинг запросов, вы можете:

* Включить настройку `show_notice_message`.
* Использовать виртуальный параметр `/* __spqr__reply_notice: true */`.

  Виртуальные параметры можно задавать комментариями в SQL или через `SET`.

В обоих случаях роутер отправит приложению информационное сообщение с указанием шарда, на который был направлен запрос.

**Решение**:

* Проверьте, отображается ли новый шард в {{ SPQR }} (`SHOW shards`).
* Если вы используете шардированную таблицу, убедитесь, что данные должны быть именно на этом шарде (`SHOW key_ranges`).
* Если вы используете справочную таблицу, убедитесь, что таблица создана именно на этом шарде (`SHOW reference_relations`).

#### Ошибка failed to get connection to any shard host within при подключении к хостам кластера {#failed-to-get-connection}

Пример ошибки:

```bash
failed to get connection to any shard host within: host {rc1d-cofs7cre********.mdb.yandexcloud.net:6432 rc1d}: dial tcp 10.151.25.35:6432: i/o timeout, host {rc1b-49796b52********.mdb.yandexcloud.net:6432 rc1b}: dial tcp 10.149.25.23:6432: i/o timeout, host {rc1a-kdm7v4qm********.mdb.yandexcloud.net:6432 rc1a}: dial tcp 10.148.25.15:6432: i/o timeout
```

Ошибка появляется, если [роутер](../concepts/index.md#router) не может подключиться к хостам [шарда](../concepts/index.md#shard).

**Решение**:

1. Убедитесь, что кластер {{ mspqr-name }} и шарды находятся в одной сети и в одной [группе безопасности](../../vpc/concepts/security-groups.md).
1. В группу безопасности [добавьте правила](../../vpc/operations/security-group-add-rule.md) для входящего и исходящего трафика, разрешающие TCP-подключение на порт `6432`:

    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `6432`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — укажите CIDR кластера, например `10.96.0.0/16`.

#### Ошибка error processing query ... : syntax error при выполнении запроса {#error-processing-query}

Эта ошибка возникает из-за внутренних проблем {{ SPQR }}, а не из-за синтаксических ошибок в вашем SQL-запросе. {{ SPQR }} использует собственный парсер SQL, который может не поддерживать некоторые нюансы:

* специфические операторы {{ PG }};
* редкие варианты синтаксиса;
* нестандартные функции.

**Решение**: сообщите о проблеме разработчикам {{ SPQR }} — создайте issue в [репозитории проекта на Github](https://github.com/pg-sharding/spqr/issues), приложите полный текст запроса.

#### Ошибка permission denied for schema {#permission-denied-for-schema}

Ошибка возникает, если у пользователя недостаточно прав для работы со схемой.

**Решение**: Выдайте права на схему пользователю командой `GRANT ALL ON SCHEMA <имя_схемы> TO <имя_пользователя>;` на нужном шарде или на всех шардах.

#### Ошибка failed to find primary within host {#failed-to-find-primary}

Эта ошибка означает, что роутер не может подключиться к мастеру шарда в заданное время.

**Возможные причины**:

* Сетевые проблемы между роутером и шардом.
* Перегрузка шарда (например, высокий показатель CPU wait).
* Неверные настройки `target-session-attrs` (например, `read-only` при запросе на запись).

**Решение**:

* Убедитесь, что сетевая связность между роутером и шардом не нарушена.
* Увеличьте вычислительные ресурсы в кластере {{ PG }}, который является перегруженным шардом.
* Проверьте соответствие настроек `target-session-attrs` вашему запросу.

{% note info %}

Предположительно, проблема была исправлена в [релизе 2.9.0](https://github.com/pg-sharding/spqr/releases/tag/2.9.0). Если вы видите эту ошибку в логах, создайте issue в [репозитории проекта на Github](https://github.com/pg-sharding/spqr/issues).

{% endnote %}

#### Ошибка failed to match any datashard или блокировка запроса {#failed-to-match-any-datashard}

Ошибка возникает, если роутер не может соотнести запрос с конкретным диапазоном ключей шардирования. Например, если параметр конфигурации роутера `default_route_behaviour` имеет значение `BLOCK`, запросы без ключа шардирования блокируются.

**Решение**:

* Измените поведение роутера при сопоставлении запросов:

  * Перманентно — в конфигурации роутера установите для параметра `default_route_behaviour` значение `ALLOW`.
  * Временно — через виртуальный параметр `/* __spqr__default_route_behaviour: allow */`.
* Проверьте:
  * Корректность ключа шардирования в запросе: название ключа в запросе должно соответствовать названию ключа в метаданных {{ SPQR }}.
  * Наличие правил шардирования (`SHOW distributions`).
  * Наличие таблиц (`SHOW relations`).
  * Наличие диапазонов (`SHOW key_ranges`).
* Для мультишардовых запросов активируйте engine_v2 через виртуальный параметр `/* __spqr__engine_v2: true */`.

Виртуальные параметры можно задавать комментариями в SQL или через `SET`.