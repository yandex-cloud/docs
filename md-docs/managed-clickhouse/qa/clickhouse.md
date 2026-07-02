[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for ClickHouse®](../index.md) > Вопросы и ответы > Вопросы о ClickHouse®

# Вопросы о ClickHouse®

* [Почему стоит использовать ClickHouse® в Managed Service for ClickHouse®, а не собственную установку на виртуальной машине?](#clickhouse-advantages-vm)

* [Когда стоит использовать ClickHouse® вместо PostgreSQL?](#clickhouse-advantages-pg)

* [Как загружать данные в ClickHouse®?](#load-data)

* [Как загрузить в ClickHouse® очень большое количество данных?](#loadalot)

* [Что случится с кластером, если выйдет из строя одна из нод?](#node-out)

* [Можно ли развернуть кластер БД ClickHouse® в нескольких зонах доступности?](#multiple-az)

* [Как устроена репликация для ClickHouse®?](#zookeeper-access)

* [Почему кластер ClickHouse® занимает на 3 хоста больше, чем должен?](#why-does-a-cluster-take-up-3-hosts-more-than-it-should)

* [Как происходит удаление данных по TTL в ClickHouse®?](#how-ttl-data-processing-works)

* [Могу ли я использовать тип данных JSON для таблиц в ClickHouse®?](#how-to-use-json)

* [Почему кластер работает медленно, хотя вычислительные ресурсы использованы не до предела?](#throttling)

#### Почему стоит использовать ClickHouse® в Managed Service for ClickHouse®, а не собственную установку на виртуальной машине? {#clickhouse-advantages-vm}

Managed Service for ClickHouse® автоматизирует рутинное обслуживание БД:

* быстрое развертывание БД с необходимыми доступными ресурсами;

* резервное копирование данных;

* регулярное обновление ПО;

* обеспечение [высокой доступности](../concepts/high-availability.md) кластеров БД;

* мониторинг и статистика использования БД.

#### Когда стоит использовать ClickHouse® вместо PostgreSQL? {#clickhouse-advantages-pg}

ClickHouse® поддерживает только добавление и чтение данных, так как предназначен прежде всего для [аналитики](../../glossary/data-analytics.md) (OLAP). В остальных случаях, скорее всего, удобнее использовать PostgreSQL.

#### Как загружать данные в ClickHouse®? {#load-data}

Используйте запрос `INSERT`, описанный в [документации ClickHouse®](https://clickhouse.com/docs/ru/sql-reference/statements/insert-into).

#### Как загрузить в ClickHouse® очень большое количество данных? {#loadalot}

Используйте [CLI](https://clickhouse.com/docs/ru/interfaces/cli) для эффективного сжатия данных при передаче (рекомендуемая частота — не больше 1 команды `INSERT` в секунду).

Перенос данных с физических носителей пока не поддерживается.

#### Что случится с кластером, если выйдет из строя одна из нод? {#node-out}

Кластеры БД состоят минимум из 2 реплик, поэтому при потере одной ноды кластер продолжит работу.

Данные могут потеряться только если вышла из строя нода с [нереплицируемой таблицей](https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/replication).

#### Можно ли развернуть кластер БД ClickHouse® в нескольких зонах доступности? {#multiple-az}

Да. Кластер БД может состоять из хостов, расположенных как в разных [зонах](../../overview/concepts/geo-scope.md), так и в разных регионах доступности.

#### Как устроена репликация для ClickHouse®? {#zookeeper-access}

Кластеры Managed Service for ClickHouse® используют репликацию с помощью ClickHouse® Keeper или ZooKeeper. В обоих случаях для обеспечения репликации и [высокой доступности](../concepts/high-availability.md) в кластере создается минимум три хоста ClickHouse® Keeper или ZooKeeper.

#### Почему кластер ClickHouse® занимает на 3 хоста больше, чем должен? {#why-does-a-cluster-take-up-3-hosts-more-than-it-should}

Когда вы создаете кластер ClickHouse® из 2 и более хостов, Managed Service for ClickHouse® автоматически создает 3 хоста сервиса координации (ClickHouse® Keeper или ZooKeeper, в зависимости от выбора пользователя) для управления репликацией и высокой доступностью. Эти хосты учитываются в расчете использованной [квоты ресурсов](https://console.yandex.cloud/cloud?section=quotas) в облаке и в расчете стоимости кластера. По умолчанию хосты ClickHouse® Keeper или ZooKeeper создаются с минимальным [классом хостов](../concepts/instance-types.md).

Подробнее об использовании ZooKeeper в [документации ClickHouse®](https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/replication).

#### Как происходит удаление данных по TTL в ClickHouse®? {#how-ttl-data-processing-works}

Удаление данных по [TTL](https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/mergetree#mergetree-table-ttl) выполняется не построчно, а либо целыми [кусками](https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/mergetree#table_engine-mergetree-multiple-volumes) (data parts), либо при операциях слияния.

Удаление целыми кусками работает эффективней и потребляет меньше ресурсов сервера, но для этого значение выражения TTL и [ключ партиционирования](https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/custom-partitioning-key) для всех строк куска данных TTL должны совпадать или хотя бы быть одного порядка.

Удаление при операциях слияния потребляет больше ресурсов и выполняется либо вместе с обычными фоновыми операциями слияния, либо во время внеплановых слияний. Периодичность операций слияния определяется значением параметра `merge_with_ttl_timeout`. Этот параметр задается при [создании](https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/mergetree#table_engine-mergetree-creating-a-table) таблицы и указывает минимальное время в секундах перед повторным слиянием для обработки данных с истекшим TTL. По умолчанию — 14400 секунд (4 часа).

Рекомендуется организовывать обработку данных по TTL так, чтобы старые данные всегда удалялись целыми кусками. Для этого при создании таблиц установите для настройки [ttl_only_drop_parts](https://clickhouse.com/docs/ru/operations/settings/settings#ttl_only_drop_parts) значение `true`.

#### Могу ли я использовать тип данных JSON для таблиц в ClickHouse®? {#how-to-use-json}

Да, но на данный момент JSON является экспериментальным типом данных в ClickHouse®. Чтобы разрешить создание таблиц такого типа, выполните запрос:

```sql
SET allow_experimental_object_type=1;
```

{% note info %}

Запросы `SET` [не поддерживаются](../operations/web-sql-query.md#query-restrictions-in-the-management-console) при подключении к кластеру через консоль управления. Для выполнения этого запроса используйте другой способ подключения к кластеру, например, [через clickhouse-client](../operations/connect/clients.md#clickhouse-client).

Убедитесь, что у вас установлена актуальная версия клиента.

{% endnote %}

Подробная информация в [документации ClickHouse®](https://clickhouse.com/docs/ru/sql-reference/data-types/newjson).

#### Почему кластер работает медленно, хотя вычислительные ресурсы использованы не до предела? {#throttling}

Вероятно, максимальные значения [IOPS и пропускной способности (bandwidth)](../../compute/concepts/storage-read-write.md) хранилища недостаточны для обработки текущего количества запросов. В этом случае срабатывает [троттлинг](../../compute/concepts/storage-read-write.md#throttling) и быстродействие всего кластера падает.

Максимальные IOPS и bandwidth прирастают на фиксированную величину при увеличении размера хранилища на определенный шаг. Шаг и прирост зависят от типа дисков:

| Тип дисков                  | Шаг, ГБ | Прирост макс. IOPS (чтение/запись) | Прирост макс. bandwidth (чтение/запись), МБ/с |
|-----------------------------|---------|------------------------------------|-----------------------------------------------|
| `network-hdd`               | 256     | 300/300                            | 30/30                                         |
| `network-ssd`               | 32      | 1000/1000                          | 15/15                                         |
| `network-ssd-nonreplicated`, `network-ssd-io-m3` | 93      | 28000/5600                         | 110/82                                        |

Чтобы увеличить максимальные значения IOPS и bandwidth и снизить вероятность троттлинга, расширьте размер хранилища при [изменении кластера](../operations/update.md#change-disk-size).

Если вы используете хранилище с типом диска `network-hdd`, рассмотрите возможность перехода на `network-ssd` или `network-ssd-nonreplicated` путем [восстановления кластера](../operations/cluster-backups.md#restore) из резервной копии.

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._