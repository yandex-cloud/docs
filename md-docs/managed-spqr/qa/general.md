[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for Sharded PostgreSQL](../index.md) > Вопросы и ответы > Общие вопросы

# Общие вопросы про Managed Service for Sharded PostgreSQL

* [Что такое Managed Service for Sharded PostgreSQL?](#what-is-mspqr)

* [Какие преимущества предоставляет Managed Service for Sharded PostgreSQL?](#mspqr-benefits)

* [В каких случаях стоит использовать Managed Service for Sharded PostgreSQL?](#use-cases)

* [В каких случаях мне не подходит Managed Service for Sharded PostgreSQL?](#not-suitable-use-cases)

* [Поддерживаются ли JSONB и большие объекты?](#jsonb-support)

* [Зачем использовать Managed Service for Sharded PostgreSQL вместо Yandex Managed Service for YDB?](#mspqr-vs-ydb)

* [Может ли кластер Managed Service for PostgreSQL из нескольких хостов быть шардом в Managed Service for Sharded PostgreSQL?](#multi-host-pg-cluster)

* [Имеет ли смысл переносить мощные инстансы PostgreSQL (например, 96 vCPU) на Sharded PostgreSQL?](#powerful-pg-instances)

* [Чем Managed Service for Sharded PostgreSQL отличается от Neon?](#mspqr-vs-neon)

* [Чем Managed Service for Sharded PostgreSQL отличается от Citus/Vitess?](#mspqr-vs-citus-vs-vitess)

* [Как начать работу с сервисом Managed Service for Sharded PostgreSQL?](#how-to-start)

#### Что такое Managed Service for Sharded PostgreSQL? {#what-is-mspqr}

Managed Service for Sharded PostgreSQL (Sharded PostgreSQL) — это управляемый сервис для горизонтального масштабирования PostgreSQL через автоматическое [шардирование](../concepts/sharding.md). Он функционирует как интеллектуальный прокси-роутер, который обрабатывает SQL-запросы и распределяет их по шардам на основе заданных правил — [ключей шардирования](../concepts/sharding-keys.md). При этом сервис Managed Service for Sharded PostgreSQL:

- Использует высокодоступные кластеры как основу шардирования для максимальной надежности.
- Сохраняет доступность кластера при переходе между монолитной и шардированной архитектурой.
- Оптимизирован под OLTP-запросы с минимальными накладными расходами.

Возможности:

* Шардирование по диапазону значений или по хешу: [роутер](../concepts/index.md#router) определяет, на каком [шарде](../concepts/index.md#shard) нужно выполнить запрос.
* Совместимость с расширенным протоколом PostgreSQL, что позволяет использовать подготовленные выражения и клиентские библиотеки без изменений.
* Поддержка сессионного и транзакционного режимов.
* Неограниченное количество роутеров.
* [Перебалансировка](../concepts/sharding-method.md#data-rebalancing) — миграция данных между шардами для равномерного распределения нагрузки.
* Возможность указать несколько серверов для одного шарда. В таком случае роутер будет распределять запросы только для чтения среди реплик и автоматически определять, где находится мастер.

#### Какие преимущества предоставляет Managed Service for Sharded PostgreSQL? {#mspqr-benefits}

С Managed Service for Sharded PostgreSQL вы получаете следующие преимущества:

* Управляемый сервис — автообновления, мониторинг и резервное копирование доступны «из коробки».
* Высокая доступность — автоматическое переключение на реплики при сбоях.
* Динамическая перебалансировка — перераспределение данных между шардами командой `REDISTRIBUTE KEY RANGE`.
* Транзакционная поддержка — сессионный (`SESSION`) и транзакционный (`TRANSACTION`) режимы управления соединениями.
* Мониторинг ресурсов (но контроль за нагрузкой остается на пользователе).
* Консультационная поддержка.

#### В каких случаях стоит использовать Managed Service for Sharded PostgreSQL? {#use-cases}

Сервис оптимален для сценариев, где выполняется одно или несколько условий:
* Размер данных превышает 1 ТБ, при этом возможности вертикального масштабирования исчерпаны.
* Нагрузка превышает 20 000 запросов в секунду, при этом наблюдается деградация производительности.
* Нужно охлаждение данных (архивация старых данных с сохранением их доступности).
* Необходимо автоматизировать существующую шардированную инфраструктуру.

Рекомендуется начинать шардирование, если в кластере больше четырех хостов, больше 40 ядер CPU или размер диска превышает 600 ГБ. Миграция на Managed Service for Sharded PostgreSQL на раннем этапе проще, чем при терабайтных объемах.

#### В каких случаях мне не подходит Managed Service for Sharded PostgreSQL? {#not-suitable-use-cases}

Сервис Managed Service for Sharded PostgreSQL не подходит для:

* OLAP-нагрузок (для этого рекомендуется использовать сервис [Yandex MPP Analytics for PostgreSQL](../../managed-greenplum/index.md)).
* Выполнения сложных запросов, которые затрагивают данные нескольких шардов (например, JOIN между разными шардами).

#### Поддерживаются ли JSONB и большие объекты? {#jsonb-support}
Да, Managed Service for Sharded PostgreSQL полностью совместим с типами данных PostgreSQL, включая JSONB. При этом большие объекты могут влиять на производительность сети.

#### Зачем использовать Managed Service for Sharded PostgreSQL вместо Yandex Managed Service for YDB? {#mspqr-vs-ydb}
Managed Service for Sharded PostgreSQL решает проблему масштабирования для PostgreSQL без смены типа СУБД.

#### Может ли кластер Managed Service for PostgreSQL из нескольких хостов быть шардом в Managed Service for Sharded PostgreSQL? {#multi-host-pg-cluster}
Да. В Managed Service for Sharded PostgreSQL шардом может быть как однохостовый, так и многохостовый кластер Managed Service for PostgreSQL.

#### Имеет ли смысл переносить мощные инстансы PostgreSQL (например, 96 vCPU) на Sharded PostgreSQL? {#powerful-pg-instances}
Да, если клиент готов к шардированию. Sharded PostgreSQL позволяет добавлять ресурсы горизонтально: вместо одного мощного хоста — несколько меньших, с балансировкой нагрузки.

#### Чем Managed Service for Sharded PostgreSQL отличается от Neon? {#mspqr-vs-neon}

Neon реализует разделение compute- и storage-слоев (как Amazon Aurora), но не является шардированным решением и не позволяет горизонтально масштабировать кластер. Sharded PostgreSQL обеспечивает горизонтальное масштабирование через шардирование данных и запросов между независимыми узлами PostgreSQL.

#### Чем Managed Service for Sharded PostgreSQL отличается от Citus/Vitess? {#mspqr-vs-citus-vs-vitess}

| **Критерий** | **Managed Service for Sharded PostgreSQL** | **Citus** | **Vitess** |
|--------------|--------------------------------|-----------|------------|
| Производительность, по сравнению с PostgreSQL | На 10–30% меньше | На 15–40% меньше | На 20–50% меньше |
| Протокол | Нативный PostgreSQL | Расширения PostgreSQL | Проприетарный |
| Перебалансировка | Командой `REDISTRIBUTE KEY RANGE`, при этом кластер остается доступен на чтение и запись | Требует остановки | Через VReplication |
| Управление | Полная интеграция с управляемыми БД | Ручное администрирование | Комплексная настройка |
| Чтение с реплик | Автоматическое | Только через мастер | Через VTGate |
| Лицензия | Открытая лицензия PostgreSQL | GNU AGPLv3 с ограничениями | Apache License 2.0 |

#### Как начать работу с сервисом Managed Service for Sharded PostgreSQL? {#how-to-start}

Создайте ваш первый кластер Managed Service for Sharded PostgreSQL. Подробная инструкция приведена в разделе [Начало работы с Managed Service for Sharded PostgreSQL](../quickstart.md).

Перед началом работы определитесь с характеристиками вашего кластера:
* [Тип шардирования](../concepts/sharding.md#shard-management).
* [Сеть](../../vpc/concepts/network.md#network), к которой будет подключен ваш кластер.
* [Зона доступности](../../overview/concepts/geo-scope.md), в которой будут расположены хосты вашего кластера.
* Количество и [класс хостов](../concepts/instance-types.md).
* Объем [хранилища](../concepts/storage.md) (резервируется в полном объеме при создании кластера).