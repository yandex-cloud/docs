- **Audit log**{#setting-audit-log} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

   [Audit system log](https://www.mongodb.com/docs/manual/core/auditing/) settings, which are only available for the {{ mmg-name }} cluster Enterprise version.

   - **Filter**{#setting-filter}

      This setting defines which audit events will be logged. The input parameter is any field from an [audit message](https://www.mongodb.com/docs/manual/reference/audit-message/) in JSON string format.

      For example, to only log audit events related to a user named `example-user`, specify the following:

      ```json
      {"user": "example-user"}
      ```

      For more information, see the [{{ MG }} documentation](https://www.mongodb.com/docs/manual/tutorial/configure-audit-filters/#filter-configuration-at-system-startup).

   - **Runtime configuration**{#setting-runtime-configuration}

      This setting allows you to change filter configuration during the server runtime.

      For more information, see the [{{ MG }} documentation](https://www.mongodb.com/docs/manual/tutorial/configure-audit-filters/#filter-configuration-at-runtime).

- **Net → Max incoming connections**{#setting-max-incoming-connections} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

   Maximum number of inbound connections.

   The minimum value is `10`. The maximum value [depends on the selected host class](#settings-instance-dependent) and is equal to the host's RAM volume in MB, with a maximum of `16384`. Default value: `1024`.

   For more information, see [Connection limits](../../managed-mongodb/operations/connect/index.md#connection-limits).

- **Operation profiling**{#setting-operation-profiling} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

   {% note info %}

   This setting is unavailable for hosts with the `MONGOS` role in a sharded cluster.

   {% endnote %}

   DBMS profiler settings. The profiler collects query data and then uses it to determine a query optimization strategy.

   - **Mode**{#setting-operation-profiling-mode}

      DBMS profiler mode:

      - `off`: Profiling is disabled.
      - `slowOp` (default): Only collects information about slow operations (that take longer than the threshold value specified in the [Slow op threshold](#setting-slow-op-threshold) setting).
      - `all`: Collects information about all queries in progress.

      For more information, see the [{{ MG }} documentation](https://docs.mongodb.com/manual/administration/analyzing-mongodb-performance/#database-profiling).

   - **Slow op threshold**{#setting-slow-op-threshold}

      Sets the operation execution time (in milliseconds). If exceeded, the operation is considered slow.

      The minimum value is `0` and the maximum value is `36000000` (10 hours). The default value is `300`.

      For more information, see the [{{ MG }} documentation](https://docs.mongodb.com/manual/tutorial/manage-the-database-profiler/#specify-the-threshold-for-slow-operations).

- **Security**{#setting-security} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

   Settings of storage data encryption at rest, which are only available for the {{ mmg-name }} cluster Enterprise version.

   Data is encrypted using the Key Management Interoperability Protocol (KMIP).

   For more information, see the [{{ MG }} documentation](https://www.mongodb.com/docs/manual/core/security-encryption-at-rest/).

   - **Enable encryption**{#enabling-encryption}

      This setting enables encryption for data in the storage.

      For more information, see the [{{ MG }} documentation](https://www.mongodb.com/docs/manual/reference/program/mongod/#std-option-mongod.--enableEncryption).

   - **Kmip**{#setting-kmip}

      KMIP server connection settings.

      For more information, see the [{{ MG }} documentation](https://www.mongodb.com/docs/manual/tutorial/configure-encryption/).

      - **Client certificate**{#setting-client-certificate}

         Path to the client certificate that is used by {{ MG }} for authentication on the KMIP server.

         For more information, see the [{{ MG }} documentation](https://www.mongodb.com/docs/manual/reference/program/mongod/#std-option-mongod.--kmipClientCertificateFile).

      - **Key identifier**{#setting-key-identifier}

         Unique ID of the encryption key on the KMIP server.

         If it is not specified, {{ MG }} will request the KMIP server to create a new key, and will use it.

         If the KMIP server has no key with the specified ID or the data is already encrypted with a different key, {{ MG }} will return an error.

         For more information, see the [{{ MG }} documentation](https://www.mongodb.com/docs/manual/reference/program/mongod/#std-option-mongod.--kmipKeyIdentifier).

      - **Port**{#setting-port}

         Number of the port used to communicate with the KMIP server.

         If the [**Server name**](#setting-server-name) field lists multiple servers, {{ MG }} will use the specified port at an attempt to connect to each of them.

         For more information, see the [{{ MG }} documentation](https://www.mongodb.com/docs/manual/reference/program/mongod/#std-option-mongod.--kmipPort).

      - **Server ca**{#setting-server-ca-file}

         Path to the CA certificate file.

         The certificate confirms that a client connection to the KMIP server is secure.

         For more information, see the [{{ MG }} documentation](https://www.mongodb.com/docs/manual/reference/program/mongod/#std-option-mongod.--kmipServerCAFile).

      - **Server name**{#setting-server-name}

         Domain name or IP address of the KMIP server {{ MG }} connects to.

         You can specify multiple KMIP servers as a comma-separated list without spaces, such as: `server1.example.com,server2.example.com`. In this case, {{ MG }} will try to connect to each server, one by one, in the specified order and establish a connection to the first available server.

         For more information, see the [{{ MG }} documentation](https://www.mongodb.com/docs/manual/reference/program/mongod/#std-option-mongod.--kmipServerName).

- **Storage**{#setting-storage} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

   {% note info %}

   This setting is unavailable for hosts with the `MONGOS` role in a sharded cluster.

   Hosts with the `MONGOCFG` role only have the **Engine config → Cache size gb** setting available.

   {% endnote %}

   Settings that define how {{ MG }} works with the [storage](https://docs.mongodb.com/manual/core/storage-engines/).

   - **Journal → Commit interval**{#setting-journal-commit-interval}

      The interval in milliseconds between when {{ MG }} [journal data](https://docs.mongodb.com/manual/core/journaling/) is written to disk.

      The minimum value is `1` and the maximum value is `500`. The default value is `300`.

      For more information, see the [{{ MG }} documentation](https://docs.mongodb.com/manual/reference/configuration-options/#mongodb-setting-storage.journal.commitIntervalMs).

   - **Wired tiger**{#setting-wired-tiger}

       Settings for the [storage engine](https://docs.mongodb.com/manual/core/wiredtiger/):

      - **Collection config → Block compressor**{#setting-block-compressor}

         Data compression option. The value set here only applies to new collections. You can also redefine it for [individual collections](https://docs.mongodb.com/manual/reference/method/db.createCollection/#create-collection-storage-engine-options) and [indexes](https://docs.mongodb.com/manual/reference/method/db.collection.createIndex/#options).

         - `none`: Compression is disabled.
         - `snappy`: Data is compressed using the [snappy](https://google.github.io/snappy/) library. If you select this setting, data compression and decompression will be, in most cases, faster than if you use the `zlib` library; however, the resulting file size will be 20% to 100% larger.
         - `zlib`: Data is compressed using the [zlib](http://www.zlib.net/) library. This method is slower than using the `snappy` library, but, in most cases, it compresses data better.

         For more information, see the [{{ MG }} documentation](https://docs.mongodb.com/manual/reference/configuration-options/#mongodb-setting-storage.wiredTiger.collectionConfig.blockCompressor).

      - **Engine config → Cache size gb**{#setting-engine-cache-size}

         Maximum size of the internal cache used for data storage (in GB). This setting does not affect the amount of RAM used to create an index.

         Minimum value: `0.25` (256 MB). The maximum and default values [depend on the selected host class](#settings-instance-dependent) and are determined by these formulas:

         - Maximum value: `0.9 × <amount of RAM on the host>`
         - Default value: `0.5 × <amount of RAM on the host>`

         For example, for {{ s1-medium }} class hosts, the maximum value of the setting is `28.8`, the default value is `16`.

         For more information, see the [{{ MG }} documentation](https://docs.mongodb.com/manual/reference/configuration-options/#mongodb-setting-storage.wiredTiger.engineConfig.cacheSizeGB).
