- **Audit log**{#setting-audit-log} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

  Настройки [логов системы аудита](https://www.mongodb.com/docs/manual/core/auditing/). Доступны только для Enterprise-версии кластера {{ mmg-name }}.

  - **Filter**{#setting-filter}

    Настройка определяет, какие события аудита будут записаны в лог. Входным параметром служит любое поле из [сообщения аудита](https://www.mongodb.com/docs/manual/reference/audit-message/) в формате JSON-строки.

    Например, чтобы логировать только события аудита, связанные с пользователем `example-user`, укажите:

    ```json
    {"user": "example-user"}
    ```

    Подробнее см. в [документации {{ MG }}](https://www.mongodb.com/docs/manual/tutorial/configure-audit-filters/#filter-configuration-at-system-startup).

  - **Runtime configuration**{#setting-runtime-configuration}

    Настройка позволяет изменять конфигурацию фильтра во время работы сервера.

    Подробнее см. в [документации {{ MG }}](https://www.mongodb.com/docs/manual/tutorial/configure-audit-filters/#filter-configuration-at-runtime).

- **Net → Max incoming connections**{#setting-max-incoming-connections} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

  Максимальное количество входящих соединений.

  Минимальное значение — `10`, максимальное значение [зависит от выбранного класса хостов](#settings-instance-dependent) и равно объему RAM на хосте в МБ, но не более `16384`. Значение по умолчанию: `1024`.

  Подробнее см. в разделе [Ограничения на количество подключений](../../managed-mongodb/operations/connect/index.md#connection-limits).

- **Operation profiling**{#setting-operation-profiling} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

  {% note info  %}

  Настройка недоступна для хостов с ролью `MONGOS` шардированного кластера.

  {% endnote %}

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

- **Security**{#setting-security} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

  Настройки шифрования данных в хранилище (Encryption at rest). Доступны только для Enterprise-версии кластера {{ mmg-name }}.
  
  Для шифрования используется протокол совместного управления ключами (KMIP).

  Подробнее см. в [документации {{ MG }}](https://www.mongodb.com/docs/manual/core/security-encryption-at-rest/).

  - **Enable encryption**{#enabling-encryption}
  
    Настройка включает шифрование данных в хранилище.

    Подробнее см. в [документации {{ MG }}](https://www.mongodb.com/docs/manual/reference/program/mongod/#std-option-mongod.--enableEncryption).

  - **Kmip**{#setting-kmip}

    Настройки подключения к KMIP-серверу.

    Подробнее см. в [документации {{ MG }}](https://www.mongodb.com/docs/manual/tutorial/configure-encryption/).

    - **Client certificate**{#setting-client-certificate}

      Путь к клиентскому сертификату, который {{ MG }} использует для аутентификации на KMIP-сервере.

      Подробнее см. в [документации {{ MG }}](https://www.mongodb.com/docs/manual/reference/program/mongod/#std-option-mongod.--kmipClientCertificateFile).

    - **Key identifier**{#setting-key-identifier}

      Уникальный идентификатор ключа шифрования на KMIP-сервере.

      Если не указан, то {{ MG }} запросит у KMIP-сервера создание нового ключа и будет использовать его.

      Если на KMIP-сервере нет ключа с указанным идентификатором или данные уже зашифрованы другим ключом, {{ MG }} выдаст ошибку.

      Подробнее см. в [документации {{ MG }}](https://www.mongodb.com/docs/manual/reference/program/mongod/#std-option-mongod.--kmipKeyIdentifier).

    - **Port**{#setting-port}

      Номер порта, используемый для связи с KMIP-сервером.

      Если в поле [**Server name**](#setting-server-name) указано несколько серверов, то при попытке подключения к каждому из них {{ MG }} будет использовать указанный порт.

      Подробнее см. в [документации {{ MG }}](https://www.mongodb.com/docs/manual/reference/program/mongod/#std-option-mongod.--kmipPort).

    - **Server ca**{#setting-server-ca-file}

      Путь к файлу сертификата удостоверяющего центра (CA).

      Сертификат подтверждает безопасность подключения клиента к KMIP-серверу.

      Подробнее см. в [документации {{ MG }}](https://www.mongodb.com/docs/manual/reference/program/mongod/#std-option-mongod.--kmipServerCAFile).

    - **Server name**{#setting-server-name}

      Доменное имя или IP-адрес KMIP-сервера, к которому подключается {{ MG }}.

      Вы можете указать несколько KMIP-серверов через запятую без пробела, например: `server1.example.com,server2.example.com`. В этом случае {{ MG }} последовательно попытается подключиться к каждому серверу в указанном порядке и установит соединение с первым доступным сервером.

      Подробнее см. в [документации {{ MG }}](https://www.mongodb.com/docs/manual/reference/program/mongod/#std-option-mongod.--kmipServerName).

- **Storage**{#setting-storage} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

  {% note info %}

  Настройка недоступна для хостов с ролью `MONGOS` шардированного кластера.

  Для хостов с ролью `MONGOCFG` доступна только настройка **Engine config → Cache size gb**.

  {% endnote %}

  Настройки взаимодействия {{ MG }} с [хранилищем данных](https://docs.mongodb.com/manual/core/storage-engines/).

  - **Journal → Commit interval**{#setting-journal-commit-interval}
  
    Интервал в миллисекундах между сохранениями [данных журнала](https://docs.mongodb.com/manual/core/journaling/) {{ MG }} на диск.

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
