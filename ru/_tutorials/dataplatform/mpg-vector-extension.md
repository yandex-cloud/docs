# Выполнение векторного поиска в {{ mpg-full-name }} с помощью vector

Вы можете хранить векторные данные и выполнять векторный поиск в [{{ mpg-full-name }}](../../managed-postgresql/index.yaml) с помощью расширения [vector](../../managed-postgresql/operations/extensions/vector.md).

{% include [mpg-vector-introduction](../../_includes/mdb/mpg-vector-introduction.md) %}

Расширение `vector` доступно в кластерах {{ mpg-name }} версии `13` и выше. Подробнее о расширении `vector` читайте в его [документации](https://github.com/pgvector/pgvector).

Чтобы выполнить векторный поиск в {{ mpg-name }}:

1. [Подготовьте инфраструктуру](#infra).
1. [Подготовьте тестовые данные](#prepare-test-data).
1. [Выполните поисковые запросы](#execute-queries).
1. [Создайте индекс для ускорения поиска](#add-index).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

* Кластер {{ mpg-name }}: использование выделенных хостам вычислительных ресурсов, объем хранилища и резервных копий ([тарифы {{ mpg-name }}](../../managed-postgresql/pricing.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ ([тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).


## Подготовьте инфраструктуру {#infra}

1. [Создайте облачную сеть](../../vpc/operations/network-create.md) с именем `demo-network`.

   
   При создании сети автоматически создаются три подсети в разных зонах доступности.



1. В сети `demo-network` [создайте группу безопасности](../../vpc/operations/security-group-create.md) `mpg-sg` для кластера {{ mpg-name }} и [добавьте](../../vpc/operations/security-group-add-rule.md) в группу правило для входящего трафика, которое разрешает подключение к кластеру через интернет:

    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-mpg }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.


1. [Создайте кластер {{ mpg-name }}](../../managed-postgresql/operations/cluster-create.md) любой подходящей конфигурации со следующими настройками:

    * **Версия** — `13` или выше.
    * **Сеть** — `demo-network`.

    
    * **Группа безопасности** — `mpg-sg`.


    * **База данных** — `pgdb`.

    
   При создании кластера включите публичный доступ к хостам.

    {% include [public-access](../../_includes/mdb/note-public-access.md) %}


1. В кластере {{ mpg-name }} [добавьте расширение](../../managed-postgresql/operations/extensions/cluster-extensions.md#update-extensions) `vector` в базу данных `pgdb`.

## Подготовьте тестовые данные {#prepare-test-data}

1. [Подключитесь к кластеру {{ mpg-name }}](../../managed-postgresql/operations/connect/clients.md).
1. Создайте столбец-вектор размером `3`:

   ```sql
   CREATE TABLE items (
     id bigserial PRIMARY KEY, 
     embedding vector(3)
   );
   ```

1. Добавьте векторы: 

   ```sql
   INSERT INTO items (embedding) 
   VALUES
   ('[1,2,3]'),
   ('[4,5,6]'),
   ('[7,8,9]'),
   ('[10,11,12]'),
   ('[13,14,15]'),
   ('[16,17,18]');
   ```

## Выполните поисковые запросы {#execute-queries}

1. Найдите трех ближайших соседей на расстоянии L2:

   ```sql
   SELECT *
   FROM items
   ORDER BY embedding <-> '[3,1,2]'
   LIMIT 3;
   ```

   Для получения расстояния в расширении `vector` используются следующие функции:

   * `<->` — расстояние L2 (евклидово расстояние);
   * `<#>` — отрицательное скалярное произведение;
   * `<=>` — косинусное расстояние;
   * `<+>` — расстояние L1 (манхэттенское расстояние);
   * `<~>` — расстояние Хэмминга (для бинарных векторов);
   * `<%>` — расстояние Жаккара (для бинарных векторов).

1. Найдите три строки, наиболее похожие на первую:

   ```sql
   SELECT *
   FROM items
   WHERE id != 1
   ORDER BY embedding <->
   (
   SELECT embedding
   FROM items
   WHERE id = 1
   )
   LIMIT 3;
   ```

1. Найдите строки, находящиеся в пределах заданного расстояния:

   ```sql
   SELECT *
   FROM items
   WHERE embedding <-> '[3,1,2]' < 15;
   ```

1. Получите расстояние, на котором находится каждый вектор от вектора `[3,1,2]`:

   ```sql
   SELECT embedding <-> '[3,1,2]'
   AS distance
   FROM items;
   ```

1. Чтобы рассчитать скалярное произведение, умножьте результат на `-1`, т. к. оператор `<#>` возвращает отрицательное скалярное произведение:

   ```sql
   SELECT (embedding <#> '[3,1,2]') * -1 AS inner_product
   FROM items;
   ```

1. Чтобы узнать, насколько каждый вектор похож на вектор `[3,1,2]` по косинусному сходству, используйте `1 - cosine distance`:

   ```sql
   SELECT 1 - (embedding <=> '[3,1,2]') AS cosine_similarity
   FROM items;
   ```

1. Найдите средний вектор:

   ```sql
   SELECT AVG(embedding)
   FROM items;
   ```

## Создайте индекс для ускорения поиска {#add-index}

Создайте индекс каждого типа: [HNSW](#hnsw-index) и [IVFFlat](#ivfflat-index).

### HNSW {#hnsw-index}

1. Создайте индекс HNSW для поиска по расстоянию L2:

   ```sql
   CREATE INDEX ON items
   USING hnsw (embedding vector_l2_ops)
   WITH (
   m = 16,
   ef_construction = 64
   );
   ```

   Где:

   * `m` — максимальное количество связей, которое может иметь вершина графа на каждом уровне. По умолчанию — `16`.
   * `ef_construction` — количество кандидатов, рассматриваемых при построении графа. По умолчанию — `64`. Чем выше значение, тем выше вероятность найти наиболее подходящие записи, но индекс строится дольше и операции вставки выполняются медленнее.

   Эти параметры задаются один раз при создании индекса. Чтобы изменить их значения, пересоздайте индекс.

   Для каждой функции расчета расстояния нужно создавать свой индекс HNSW. Подробнее в [документации](https://github.com/pgvector/pgvector#hnsw) расширения `vector`.

1. Настройте параметры поиска:

   ```sql
   SET hnsw.ef_search = 3;
   ```

   Где `ef_search` — количество векторов, которые алгоритм рассматривает во время поиска. По умолчанию — `40`. Чем выше значение, тем выше вероятность найти наиболее похожие записи, но запрос будет выполняться медленнее.

   В отличие от параметров индекса `m` и `ef_construction`, параметр поиска `ef_search` можно изменять перед выполнением запросов.

1. Выполните поиск ближайших соседей:

   ```sql
   SELECT *
   FROM items
   ORDER BY embedding <-> '[3,1,2]'
   LIMIT 3;
   ```

   Если результаты поиска оказались недостаточно точными, увеличьте значение `ef_search` и повторите запрос.

### IVFFlat {#ivfflat-index}

1. Создайте индекс IVFFlat для поиска по расстоянию L2:

   ```sql
   CREATE INDEX ON items
   USING ivfflat (embedding vector_l2_ops)
   WITH (
   lists = 3
   );
   ```

   Где `lists` — количество групп (списков), на которые будут разделены векторы. Рекомендуемое значение зависит от объема данных. Чем больше групп, тем быстрее поиск, но качество поиска может снизиться.

   Этот параметр задается один раз при создании индекса. Чтобы изменить его значение, пересоздайте индекс.

   Для каждой функции расчета расстояния нужно создавать свой индекс IVFFlat. Подробнее в [документации](https://github.com/pgvector/pgvector#ivfflat) расширения `vector`.

1. Настройте параметры поиска:

   ```sql
   SET ivfflat.probes = 1;
   ```

   Где `probes` — количество групп (списков), просматриваемых при выполнении поиска. По умолчанию используется `1`. Чем больше значение, тем выше вероятность найти наиболее похожие записи, но ниже скорость выполнения запроса.

   В отличие от параметра индекса `lists`, параметр поиска `probes` можно изменять перед выполнением запросов.

1. Выполните поиск ближайших соседей:

   ```sql
   SELECT *
   FROM items
   ORDER BY embedding <-> '[3,1,2]'
   LIMIT 3;
   ```

   Если результаты поиска оказались недостаточно точными, увеличьте значение `probes` и повторите запрос.

## Удалите созданные ресурсы {#clear-out}


Если не планируете больше использовать кластер {{ mpg-name }}, [удалите его](../../managed-postgresql/operations/cluster-delete.md), чтобы за него не списывалась плата.

