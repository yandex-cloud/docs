- **Net → Max incoming connections**{#setting-max-incoming-connections} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

  Максимальное количество входящих соединений.

  Минимальное значение — `10`, максимальное значение зависит от объема оперативной памяти на хосте. 

  Подробнее см. в разделе [Ограничения на количество подключений](../../managed-mongodb/operations/connect.md#connection-limits).

- **Operation profiling**{#setting-operation-profiling} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

  Настройки профилировщика СУБД. Профилировщик собирает данные о запросах. Затем на основе этих данных формируется стратегия оптимизации запросов.

  - **Mode**{#setting-operation-profiling-mode}
  
    Режим работы профилировщика СУБД:

    - `off` — профилирование выключено;
    - `slowOp` (по умолчанию) — собирается информация только о медленных операциях (выполняющихся дольше порога, заданного настройкой [Slow op threshold](#setting-slow-op-threshold));
    - `all` — собирается информация обо всех выполняющихся запросах.

    Подробнее см. в [документации {{ MG }}](https://docs.mongodb.com/manual/administration/analyzing-mongodb-performance/#database-profiling).

  - **Slow op threshold**{#setting-slow-op-threshold}
  
    Время выполнения операции (в миллисекундах), при превышении которого она будет считаться медленной.

    Минимальное значение — `0`, максимальное значение — `36000000` (10 часов), значение по умолчанию — `300`.

    Подробнее см. в [документации {{ MG }}](https://docs.mongodb.com/manual/tutorial/manage-the-database-profiler/#specify-the-threshold-for-slow-operations).

- **Storage**{#setting-storage} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

  Настройки взаимодействия {{ MG }} с [хранилищем данных](https://docs.mongodb.com/manual/core/storage-engines/).

  - **Journal → Commit interval**{#setting-journal-commit-interval}
  
    Интервал в миллисекундах между сохранениями [данных журнала](https://docs.mongodb.com/manual/core/journaling/) {{ MG }} на диск.

    Минимальное значение — `1`, максимальное значение — `500`, значение по умолчанию — `300`.

    Подробнее см. в [документации {{ MG }}](https://docs.mongodb.com/manual/reference/configuration-options/#mongodb-setting-storage.journal.commitIntervalMs).

  - **Wired tiger**{#setting-wired-tiger}
  
    Настройки [движка хранения данных](https://docs.mongodb.com/manual/core/wiredtiger/):
    
    - **Connection config → Block compressor**{#setting-block-compressor}
    
      Настройка сжатия данных. Установленное здесь значение будет работать только для новых коллекций. Также вы можете переопределить его для [отдельных коллекций](https://docs.mongodb.com/manual/reference/method/db.createCollection/#create-collection-storage-engine-options) и [индексов](https://docs.mongodb.com/manual/reference/method/db.collection.createIndex/#options).

      - `none` — сжатие отключено.
      - `snappy` — использование библиотеки [snappy](https://google.github.io/snappy/) для сжатия данных. При выборе этой настройки в большинстве случаев сжатие и распаковка будут быстрее, чем при использовании библиотеки `zlib`, но итоговый размер файлов будет на 20—100% больше.
      - `zlib` — использование библиотеки [zlib](http://www.zlib.net/) для сжатия данных. Этот способ работает медленнее `snappy`, но в большинстве случаев лучше сжимает данные.

      Подробнее см. в [документации {{ MG }}](https://docs.mongodb.com/manual/reference/configuration-options/#mongodb-setting-storage.wiredTiger.collectionConfig.blockCompressor).

    - **Engine config → Cache size gb**{#setting-engine-cache-size}
    
      Максимальный размер внутреннего кеша, используемого для хранения данных (в гигабайтах). Эта настройка не влияет на объем RAM, используемый для построения индекса.

      Минимальное значение — `0.25`, максимальное значение — 90% от объема RAM на хосте, значение по умолчанию — 50% от объема RAM на хосте.

      Подробнее см. в [документации {{ MG }}](https://docs.mongodb.com/manual/reference/configuration-options/#mongodb-setting-storage.wiredTiger.engineConfig.cacheSizeGB).
