

- **Net**{#setting-net} {{ tag-all }}

  Настройки сетевого взаимодействия.

  - **Max incoming connections**{#setting-max-incoming-connections}

    Максимальное количество входящих соединений.

    Минимальное значение — `10`, максимальное значение [зависит от выбранного класса хостов](#settings-instance-dependent) и равно объему RAM на хосте в МБ, но не более `16384`. Значение по умолчанию: `1024`.

    Подробнее см. в разделе [Ограничения на количество подключений](../../storedoc/operations/connect/index.md#connection-limits).

  - **Compression → Compressors**{#setting-compressors}

    Список методов сжатия, которые может использовать хост с ролью `MONGOD` или `MONGOS` для сжатия сетевых сообщений. Порядок перечисления методов важен.

    Значение `disabled` отключает сжатие. Значение по умолчанию — `snappy,zstd,zlib`.

    Подробнее см. в [документации {{ MG }}](https://mongodb.com/docs/manual/reference/configuration-options/#mongodb-setting-net.compression.compressors).

- **Operation profiling**{#setting-operation-profiling} {{ tag-all }}

  {% note info  %}

  Настройки недоступны для хостов с ролью `MONGOS` шардированного кластера.

  {% endnote %}

  Настройки профилировщика СУБД. Профилировщик собирает данные о запросах. Затем на основе этих данных формируется стратегия оптимизации запросов.

  - **Mode**{#setting-operation-profiling-mode}
  
    Режим работы профилировщика СУБД:

    - `off` — профилирование выключено;
    - `slowOp` (по умолчанию) — собирается информация только о медленных операциях (выполняющихся дольше порога, заданного настройкой [Slow op threshold](#setting-slow-op-threshold));
    - `all` — собирается информация обо всех выполняющихся запросах.

    Подробнее см. в [документации {{ MG }}](https://docs.mongodb.com/manual/administration/analyzing-mongodb-performance/#database-profiling).

  - **Slow op sample rate**{#setting-slow-sample-rate}

    Доля медленных операций, которые следует профилировать или логировать. Параметр влияет на журнал диагностики и на профилировщик, если он включен.

    Минимальное значение — `0`, максимальное значение — `1`, значение по умолчанию — `1`.

    Подробнее см. в [документации {{ MG }}](https://mongodb.com/docs/manual/reference/configuration-options/#mongodb-setting-operationProfiling.slowOpSampleRate).

  - **Slow op threshold**{#setting-slow-op-threshold}
  
    Время выполнения операции (в миллисекундах), при превышении которого она будет считаться медленной.

    Минимальное значение — `0`, максимальное значение — `36000000` (10 часов), значение по умолчанию — `300`.

    Подробнее см. в [документации {{ MG }}](https://docs.mongodb.com/manual/tutorial/manage-the-database-profiler/#specify-the-threshold-for-slow-operations).


- **Set parameter**{#setting-set-parameter}

  - **Enable flow control**{#setting-enable-flow-control} {{ tag-all }}

    Определяет, будет ли контролироваться скорость, с которой основной хост выполняет операции записи. Включение параметра гарантирует, что у хостов-реплик метрика «большинство записало изменение» будет не больше предустановленного значения в 10 секунд.

    Значение по умолчанию — `false` (контроль скорости отключен).

    Подробнее см. в [документации {{ MG }}](https://mongodb.com/docs/manual/reference/parameters/#mongodb-parameter-param.enableFlowControl).

  - **Min snapshot history window in seconds**{#setting-min-snapshot-history-window-in-seconds} {{ tag-all }}

    {% note info %}

    Настройка доступна только для хостов с ролью `MONGOD`.

    {% endnote %}

    Время в секундах, в течение которого хранится история снапшотов.

    Возможные значения — от нуля и выше, значение по умолчанию — `60`. Увеличение значения настройки увеличивает использование диска.

    Подробнее см. в [документации {{ MG }}](https://mongodb.com/docs/manual/reference/parameters/#mongodb-parameter-param.minSnapshotHistoryWindowInSeconds).

- **Storage**{#setting-storage} {{ tag-all }}

  {% note info %}

  Настройка недоступна для хостов с ролью `MONGOS` шардированного кластера.

  Для хостов с ролью `MONGOCFG` доступна только настройка **Engine config → Cache size gb**.

  {% endnote %}

  Настройки взаимодействия {{ SD }} с [хранилищем данных](https://docs.mongodb.com/manual/core/storage-engines/).

  - **Journal → Commit interval**{#setting-journal-commit-interval}
  
    Интервал в миллисекундах между сохранениями [данных журнала](https://docs.mongodb.com/manual/core/journaling/) {{ SD }} на диск.

    Минимальное значение — `1`, максимальное значение — `500`, значение по умолчанию — `300`.

    Подробнее см. в [документации {{ MG }}](https://docs.mongodb.com/manual/reference/configuration-options/#mongodb-setting-storage.journal.commitIntervalMs).

  - **Wired tiger**{#setting-wired-tiger}
  
    Настройки [движка хранения данных](https://docs.mongodb.com/manual/core/wiredtiger/):
    
    - **Collection config → Block compressor**{#setting-block-compressor}
    
      Настройка сжатия данных. Установленное здесь значение будет работать только для новых коллекций. Также вы можете переопределить его для [отдельных коллекций](https://docs.mongodb.com/manual/reference/method/db.createCollection/#create-collection-storage-engine-options) и [индексов](https://docs.mongodb.com/manual/reference/method/db.collection.createIndex/#options).

      - `none` — сжатие отключено.
      - `snappy` — использование библиотеки [snappy](https://google.github.io/snappy/) для сжатия данных. При выборе этой настройки в большинстве случаев сжатие и распаковка будут быстрее, чем при использовании библиотеки `zlib`, но итоговый размер файлов будет на 20—100% больше.
      - `zlib` — использование библиотеки [zlib](http://www.zlib.net/) для сжатия данных. Этот способ работает медленнее `snappy`, но в большинстве случаев лучше сжимает данные.

      Подробнее см. в [документации {{ MG }}](https://docs.mongodb.com/manual/reference/configuration-options/#mongodb-setting-storage.wiredTiger.collectionConfig.blockCompressor).

    - **Engine config → Cache size gb**{#setting-engine-cache-size}

      Максимальный размер внутреннего кеша, используемого для хранения данных (в гигабайтах). Эта настройка не влияет на объем RAM, используемый для построения индекса.

      Минимальное значение — `0.25` (256 МБ). Максимальное значение и значение по умолчанию [зависят от выбранного класса хостов](#settings-instance-dependent) и задаются формулами:

      - Максимальное значение — `0,9 × <объем_RAM_на_хосте>`.
      - Значение по умолчанию — `0,5 × <объем_RAM_на_хосте>`.

      Например, для хостов класса {{ s1-medium }} максимальное значение настройки — `28.8`, значение по умолчанию — `16`.

      Подробнее см. в [документации {{ MG }}](https://docs.mongodb.com/manual/reference/configuration-options/#mongodb-setting-storage.wiredTiger.engineConfig.cacheSizeGB).

    - **Index config → Prefix compression**{#setting-prefix-compression}

      Определяет, будет ли выполняться сжатие префиксов для индексов. Изменение параметра влияет на новые индексы, но не влияет на уже созданные.

      Значение по умолчанию — `true` (сжатие префиксов включено).

      Подробнее см. в [документации {{ MG }}](https://mongodb.com/docs/manual/reference/configuration-options/#mongodb-setting-storage.wiredTiger.indexConfig.prefixCompression).
