---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-redis/v1/clusters
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        folderId:
          description: |-
            **string**
            Required field. ID of the folder to create the Redis cluster in.
            The maximum string length in characters is 50.
          type: string
        name:
          description: |-
            **string**
            Required field. Name of the Redis cluster. The name must be unique within the folder.
            The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
          pattern: '[a-zA-Z0-9_-]*'
          type: string
        description:
          description: |-
            **string**
            Description of the Redis cluster.
            The maximum string length in characters is 256.
          type: string
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            Custom labels for the Redis cluster as `key:value` pairs. Maximum 64 per cluster.
            For example, "project": "mvp" or "source": "dictionary".
            The maximum string length in characters for each value is 63. The maximum string length in characters for each key is 63. Each key must match the regular expression ` [a-z][-_./\@0-9a-z]* `. Each value must match the regular expression ` [-_./\@0-9a-z]* `. No more than 64 per resource.
          type: object
          additionalProperties:
            type: string
            pattern: '[-_./\@0-9a-z]*'
            maxLength: 63
          propertyNames:
            type: string
            pattern: '[a-z][-_./\@0-9a-z]*'
          maxProperties: 64
        environment:
          description: |-
            **enum** (Environment)
            Required field. Deployment environment of the Redis cluster.
            - `PRODUCTION`: Stable environment with a conservative update policy:
            only hotfixes are applied during regular maintenance.
            - `PRESTABLE`: Environment with more aggressive update policy: new versions
            are rolled out irrespective of backward compatibility.
          type: string
          enum:
            - ENVIRONMENT_UNSPECIFIED
            - PRODUCTION
            - PRESTABLE
        configSpec:
          description: |-
            **[ConfigSpec](#yandex.cloud.mdb.redis.v1.ConfigSpec)**
            Required field. Configuration and resources for hosts that should be created for the Redis cluster.
          $ref: '#/definitions/ConfigSpec'
        hostSpecs:
          description: |-
            **[HostSpec](#yandex.cloud.mdb.redis.v1.HostSpec)**
            Individual configurations for hosts that should be created for the Redis cluster.
            The number of elements must be greater than 0.
          type: array
          items:
            $ref: '#/definitions/HostSpec'
        networkId:
          description: |-
            **string**
            ID of the network to create the cluster in.
            The maximum string length in characters is 150.
          type: string
        sharded:
          description: |-
            **boolean**
            Redis cluster mode on/off.
          type: boolean
        securityGroupIds:
          description: |-
            **string**
            User security groups
          type: array
          items:
            type: string
        tlsEnabled:
          description: |-
            **boolean**
            TLS port and functionality on\off
          type: boolean
        deletionProtection:
          description: |-
            **boolean**
            Deletion Protection inhibits deletion of the cluster
          type: boolean
        persistenceMode:
          description: |-
            **enum** (PersistenceMode)
            Persistence mode
            - `ON`: Cluster persistence mode is on.
            - `OFF`: Cluster persistence mode is off.
            - `ON_REPLICAS`: Cluster persistence is on for replicas only.
          type: string
          enum:
            - 'ON'
            - 'OFF'
            - ON_REPLICAS
        announceHostnames:
          description: |-
            **boolean**
            Enable FQDN instead of ip
          type: boolean
        maintenanceWindow:
          description: |-
            **[MaintenanceWindow](#yandex.cloud.mdb.redis.v1.MaintenanceWindow)**
            Window of maintenance operations.
          $ref: '#/definitions/MaintenanceWindow'
        userSpecs:
          description: |-
            **[UserSpec](#yandex.cloud.mdb.redis.v1.UserSpec)**
            Descriptions of users to be created in the Redis cluster.
            The minimum number of elements is 0.
          type: array
          items:
            $ref: '#/definitions/UserSpec'
        authSentinel:
          description: |-
            **boolean**
            Allows to use ACL users to auth in sentinel
          type: boolean
        diskEncryptionKeyId:
          description: |-
            **string**
            ID of the key to encrypt cluster disks.
          type: string
      required:
        - folderId
        - name
        - environment
        - configSpec
      additionalProperties: false
    definitions:
      ClientOutputBufferLimit:
        type: object
        properties:
          hardLimit:
            description: |-
              **string** (int64)
              Total limit in bytes.
              The minimum value is 0.
            type: string
            format: int64
          softLimit:
            description: |-
              **string** (int64)
              Limit in bytes during certain time period.
              The minimum value is 0.
            type: string
            format: int64
          softSeconds:
            description: |-
              **string** (int64)
              Seconds for soft limit.
              The minimum value is 0.
            type: string
            format: int64
      RedisConfig5_0:
        type: object
        properties:
          maxmemoryPolicy:
            description: |-
              **enum** (MaxmemoryPolicy)
              Redis key eviction policy for a dataset that reaches maximum memory,
              available to the host. Redis maxmemory setting depends on Managed
              Service for Redis [host class](/docs/managed-redis/concepts/instance-types).
              All policies are described in detail in [Redis documentation](https://redis.io/topics/lru-cache).
              - `VOLATILE_LRU`: Try to remove less recently used (LRU) keys with `expire set`.
              - `ALLKEYS_LRU`: Remove less recently used (LRU) keys.
              - `VOLATILE_LFU`: Try to remove least frequently used (LFU) keys with `expire set`.
              - `ALLKEYS_LFU`: Remove least frequently used (LFU) keys.
              - `VOLATILE_RANDOM`: Try to remove keys with `expire set` randomly.
              - `ALLKEYS_RANDOM`: Remove keys randomly.
              - `VOLATILE_TTL`: Try to remove less recently used (LRU) keys with `expire set`
              and shorter TTL first.
              - `NOEVICTION`: Return errors when memory limit was reached and commands could require
              more memory to be used.
            type: string
            enum:
              - MAXMEMORY_POLICY_UNSPECIFIED
              - VOLATILE_LRU
              - ALLKEYS_LRU
              - VOLATILE_LFU
              - ALLKEYS_LFU
              - VOLATILE_RANDOM
              - ALLKEYS_RANDOM
              - VOLATILE_TTL
              - NOEVICTION
          timeout:
            description: |-
              **string** (int64)
              Time that Redis keeps the connection open while the client is idle.
              If no new command is sent during that time, the connection is closed.
              Value must be greater than 0.
            type: string
            format: int64
          password:
            description: |-
              **string**
              Authentication password.
              The string length in characters must be 8-128. Value must match the regular expression ` [a-zA-Z0-9@=+?*.,!&#$^<>_-]{8,128} `.
            pattern: '[a-zA-Z0-9@=+?*.,!&#$^<>_-]{8,128}'
            type: string
          databases:
            description: |-
              **string** (int64)
              Number of database buckets on a single redis-server process.
              Value must be greater than 0.
            type: string
            format: int64
          slowlogLogSlowerThan:
            description: |-
              **string** (int64)
              Threshold for logging slow requests to server in microseconds (log only slower than it).
              The minimum value is 0.
            type: string
            format: int64
          slowlogMaxLen:
            description: |-
              **string** (int64)
              Max slow requests number to log.
              The minimum value is 0.
            type: string
            format: int64
          notifyKeyspaceEvents:
            description: |-
              **string**
              String setting for pub\sub functionality.
              Value must match the regular expression ` [KEg$lshzxeAtm]{0,12} `.
            pattern: '[KEg$lshzxeAtm]{0,12}'
            type: string
          clientOutputBufferLimitPubsub:
            description: |-
              **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig5_0.ClientOutputBufferLimit)**
              Redis connection output buffers limits for pubsub operations.
            $ref: '#/definitions/ClientOutputBufferLimit'
          clientOutputBufferLimitNormal:
            description: |-
              **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig5_0.ClientOutputBufferLimit)**
              Redis connection output buffers limits for clients.
            $ref: '#/definitions/ClientOutputBufferLimit'
      RedisConfig6_0:
        type: object
        properties:
          maxmemoryPolicy:
            description: |-
              **enum** (MaxmemoryPolicy)
              Redis key eviction policy for a dataset that reaches maximum memory,
              available to the host. Redis maxmemory setting depends on Managed
              Service for Redis [host class](/docs/managed-redis/concepts/instance-types).
              All policies are described in detail in [Redis documentation](https://redis.io/topics/lru-cache).
              - `VOLATILE_LRU`: Try to remove less recently used (LRU) keys with `expire set`.
              - `ALLKEYS_LRU`: Remove less recently used (LRU) keys.
              - `VOLATILE_LFU`: Try to remove least frequently used (LFU) keys with `expire set`.
              - `ALLKEYS_LFU`: Remove least frequently used (LFU) keys.
              - `VOLATILE_RANDOM`: Try to remove keys with `expire set` randomly.
              - `ALLKEYS_RANDOM`: Remove keys randomly.
              - `VOLATILE_TTL`: Try to remove less recently used (LRU) keys with `expire set`
              and shorter TTL first.
              - `NOEVICTION`: Return errors when memory limit was reached and commands could require
              more memory to be used.
            type: string
            enum:
              - MAXMEMORY_POLICY_UNSPECIFIED
              - VOLATILE_LRU
              - ALLKEYS_LRU
              - VOLATILE_LFU
              - ALLKEYS_LFU
              - VOLATILE_RANDOM
              - ALLKEYS_RANDOM
              - VOLATILE_TTL
              - NOEVICTION
          timeout:
            description: |-
              **string** (int64)
              Time that Redis keeps the connection open while the client is idle.
              If no new command is sent during that time, the connection is closed.
              Value must be greater than 0.
            type: string
            format: int64
          password:
            description: |-
              **string**
              Authentication password.
              The string length in characters must be 8-128. Value must match the regular expression ` [a-zA-Z0-9@=+?*.,!&#$^<>_-]{8,128} `.
            pattern: '[a-zA-Z0-9@=+?*.,!&#$^<>_-]{8,128}'
            type: string
          databases:
            description: |-
              **string** (int64)
              Number of database buckets on a single redis-server process.
              Value must be greater than 0.
            type: string
            format: int64
          slowlogLogSlowerThan:
            description: |-
              **string** (int64)
              Threshold for logging slow requests to server in microseconds (log only slower than it).
              The minimum value is 0.
            type: string
            format: int64
          slowlogMaxLen:
            description: |-
              **string** (int64)
              Max slow requests number to log.
              The minimum value is 0.
            type: string
            format: int64
          notifyKeyspaceEvents:
            description: |-
              **string**
              String setting for pub\sub functionality.
              Value must match the regular expression ` [KEg$lshzxeAtm]{0,13} `.
            pattern: '[KEg$lshzxeAtm]{0,13}'
            type: string
          clientOutputBufferLimitPubsub:
            description: |-
              **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig5_0.ClientOutputBufferLimit)**
              Redis connection output buffers limits for pubsub operations.
            $ref: '#/definitions/ClientOutputBufferLimit'
          clientOutputBufferLimitNormal:
            description: |-
              **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig5_0.ClientOutputBufferLimit)**
              Redis connection output buffers limits for clients.
            $ref: '#/definitions/ClientOutputBufferLimit'
      RedisConfig6_2:
        type: object
        properties:
          maxmemoryPolicy:
            description: |-
              **enum** (MaxmemoryPolicy)
              Redis key eviction policy for a dataset that reaches maximum memory,
              available to the host. Redis maxmemory setting depends on Managed
              Service for Redis [host class](/docs/managed-redis/concepts/instance-types).
              All policies are described in detail in [Redis documentation](https://redis.io/topics/lru-cache).
              - `VOLATILE_LRU`: Try to remove less recently used (LRU) keys with `expire set`.
              - `ALLKEYS_LRU`: Remove less recently used (LRU) keys.
              - `VOLATILE_LFU`: Try to remove least frequently used (LFU) keys with `expire set`.
              - `ALLKEYS_LFU`: Remove least frequently used (LFU) keys.
              - `VOLATILE_RANDOM`: Try to remove keys with `expire set` randomly.
              - `ALLKEYS_RANDOM`: Remove keys randomly.
              - `VOLATILE_TTL`: Try to remove less recently used (LRU) keys with `expire set`
              and shorter TTL first.
              - `NOEVICTION`: Return errors when memory limit was reached and commands could require
              more memory to be used.
            type: string
            enum:
              - MAXMEMORY_POLICY_UNSPECIFIED
              - VOLATILE_LRU
              - ALLKEYS_LRU
              - VOLATILE_LFU
              - ALLKEYS_LFU
              - VOLATILE_RANDOM
              - ALLKEYS_RANDOM
              - VOLATILE_TTL
              - NOEVICTION
          timeout:
            description: |-
              **string** (int64)
              Time that Redis keeps the connection open while the client is idle.
              If no new command is sent during that time, the connection is closed.
              The minimum value is 0.
            type: string
            format: int64
          password:
            description: |-
              **string**
              Authentication password.
              The string length in characters must be 8-128. Value must match the regular expression ` [a-zA-Z0-9@=+?*.,!&#$^<>_-]{8,128} `.
            pattern: '[a-zA-Z0-9@=+?*.,!&#$^<>_-]{8,128}'
            type: string
          databases:
            description: |-
              **string** (int64)
              Number of database buckets on a single redis-server process.
              Value must be greater than 0.
            type: string
            format: int64
          slowlogLogSlowerThan:
            description: |-
              **string** (int64)
              Threshold for logging slow requests to server in microseconds (log only slower than it).
              The minimum value is 0.
            type: string
            format: int64
          slowlogMaxLen:
            description: |-
              **string** (int64)
              Max slow requests number to log.
              The minimum value is 0.
            type: string
            format: int64
          notifyKeyspaceEvents:
            description: |-
              **string**
              String setting for pub\sub functionality.
              Value must match the regular expression ` [KEg$lshzxeAtm]{0,13} `.
            pattern: '[KEg$lshzxeAtm]{0,13}'
            type: string
          clientOutputBufferLimitPubsub:
            description: |-
              **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig5_0.ClientOutputBufferLimit)**
              Redis connection output buffers limits for pubsub operations.
            $ref: '#/definitions/ClientOutputBufferLimit'
          clientOutputBufferLimitNormal:
            description: |-
              **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig5_0.ClientOutputBufferLimit)**
              Redis connection output buffers limits for clients.
            $ref: '#/definitions/ClientOutputBufferLimit'
          maxmemoryPercent:
            description: |-
              **string** (int64)
              Redis maxmemory percent
              Acceptable values are 1 to 75, inclusive.
            type: string
            format: int64
      RedisConfig7_0:
        type: object
        properties:
          maxmemoryPolicy:
            description: |-
              **enum** (MaxmemoryPolicy)
              Redis key eviction policy for a dataset that reaches maximum memory,
              available to the host. Redis maxmemory setting depends on Managed
              Service for Redis [host class](/docs/managed-redis/concepts/instance-types).
              All policies are described in detail in [Redis documentation](https://redis.io/topics/lru-cache).
              - `VOLATILE_LRU`: Try to remove less recently used (LRU) keys with `expire set`.
              - `ALLKEYS_LRU`: Remove less recently used (LRU) keys.
              - `VOLATILE_LFU`: Try to remove least frequently used (LFU) keys with `expire set`.
              - `ALLKEYS_LFU`: Remove least frequently used (LFU) keys.
              - `VOLATILE_RANDOM`: Try to remove keys with `expire set` randomly.
              - `ALLKEYS_RANDOM`: Remove keys randomly.
              - `VOLATILE_TTL`: Try to remove less recently used (LRU) keys with `expire set`
              and shorter TTL first.
              - `NOEVICTION`: Return errors when memory limit was reached and commands could require
              more memory to be used.
            type: string
            enum:
              - MAXMEMORY_POLICY_UNSPECIFIED
              - VOLATILE_LRU
              - ALLKEYS_LRU
              - VOLATILE_LFU
              - ALLKEYS_LFU
              - VOLATILE_RANDOM
              - ALLKEYS_RANDOM
              - VOLATILE_TTL
              - NOEVICTION
          timeout:
            description: |-
              **string** (int64)
              Time that Redis keeps the connection open while the client is idle.
              If no new command is sent during that time, the connection is closed.
              The minimum value is 0.
            type: string
            format: int64
          password:
            description: |-
              **string**
              Authentication password.
              The string length in characters must be 8-128. Value must match the regular expression ` [a-zA-Z0-9@=+?*.,!&#$^<>_-]{8,128} `.
            pattern: '[a-zA-Z0-9@=+?*.,!&#$^<>_-]{8,128}'
            type: string
          databases:
            description: |-
              **string** (int64)
              Number of database buckets on a single redis-server process.
              Value must be greater than 0.
            type: string
            format: int64
          slowlogLogSlowerThan:
            description: |-
              **string** (int64)
              Threshold for logging slow requests to server in microseconds (log only slower than it).
              The minimum value is 0.
            type: string
            format: int64
          slowlogMaxLen:
            description: |-
              **string** (int64)
              Max slow requests number to log.
              The minimum value is 0.
            type: string
            format: int64
          notifyKeyspaceEvents:
            description: |-
              **string**
              String setting for pub\sub functionality.
              Value must match the regular expression ` [KEg$lshzxeAtm]{0,13} `.
            pattern: '[KEg$lshzxeAtm]{0,13}'
            type: string
          clientOutputBufferLimitPubsub:
            description: |-
              **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig5_0.ClientOutputBufferLimit)**
              Redis connection output buffers limits for pubsub operations.
            $ref: '#/definitions/ClientOutputBufferLimit'
          clientOutputBufferLimitNormal:
            description: |-
              **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig5_0.ClientOutputBufferLimit)**
              Redis connection output buffers limits for clients.
            $ref: '#/definitions/ClientOutputBufferLimit'
          maxmemoryPercent:
            description: |-
              **string** (int64)
              Redis maxmemory percent
              Acceptable values are 1 to 75, inclusive.
            type: string
            format: int64
      Resources:
        type: object
        properties:
          resourcePresetId:
            description: |-
              **string**
              Required field. ID of the preset for computational resources available to a host (CPU, memory etc.).
              All available presets are listed in the [documentation](/docs/managed-redis/concepts/instance-types).
            type: string
          diskSize:
            description: |-
              **string** (int64)
              Volume of the storage available to a host, in bytes.
            type: string
            format: int64
          diskTypeId:
            description: |-
              **string**
              Type of the storage environment for the host.
              Possible values:
              * network-ssd - network SSD drive,
              * local-ssd - local SSD storage.
            type: string
        required:
          - resourcePresetId
      TimeOfDay:
        type: object
        properties:
          hours:
            description: |-
              **integer** (int32)
              Hours of day in 24 hour format. Should be from 0 to 23. An API may choose
              to allow the value "24:00:00" for scenarios like business closing time.
            type: integer
            format: int32
          minutes:
            description: |-
              **integer** (int32)
              Minutes of hour of day. Must be from 0 to 59.
            type: integer
            format: int32
          seconds:
            description: |-
              **integer** (int32)
              Seconds of minutes of the time. Must normally be from 0 to 59. An API may
              allow the value 60 if it allows leap-seconds.
            type: integer
            format: int32
          nanos:
            description: |-
              **integer** (int32)
              Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999.
            type: integer
            format: int32
      Access:
        type: object
        properties:
          dataLens:
            description: |-
              **boolean**
              Allow access for DataLens
            type: boolean
          webSql:
            description: |-
              **boolean**
              Allow access for Web SQL.
            type: boolean
      RedisConfig:
        type: object
        properties:
          maxmemoryPolicy:
            description: |-
              **enum** (MaxmemoryPolicy)
              Redis key eviction policy for a dataset that reaches maximum memory,
              available to the host. Redis maxmemory setting depends on Managed
              Service for Redis [host class](/docs/managed-redis/concepts/instance-types).
              All policies are described in detail in [Redis documentation](https://redis.io/topics/lru-cache).
              - `VOLATILE_LRU`: Try to remove less recently used (LRU) keys with `expire set`.
              - `ALLKEYS_LRU`: Remove less recently used (LRU) keys.
              - `VOLATILE_LFU`: Try to remove least frequently used (LFU) keys with `expire set`.
              - `ALLKEYS_LFU`: Remove least frequently used (LFU) keys.
              - `VOLATILE_RANDOM`: Try to remove keys with `expire set` randomly.
              - `ALLKEYS_RANDOM`: Remove keys randomly.
              - `VOLATILE_TTL`: Try to remove less recently used (LRU) keys with `expire set`
              and shorter TTL first.
              - `NOEVICTION`: Return errors when memory limit was reached and commands could require
              more memory to be used.
            type: string
            enum:
              - MAXMEMORY_POLICY_UNSPECIFIED
              - VOLATILE_LRU
              - ALLKEYS_LRU
              - VOLATILE_LFU
              - ALLKEYS_LFU
              - VOLATILE_RANDOM
              - ALLKEYS_RANDOM
              - VOLATILE_TTL
              - NOEVICTION
          timeout:
            description: |-
              **string** (int64)
              Time that Redis keeps the connection open while the client is idle.
              If no new command is sent during that time, the connection is closed.
              The minimum value is 0.
            type: string
            format: int64
          password:
            description: |-
              **string**
              Authentication password.
            type: string
          databases:
            description: |-
              **string** (int64)
              Number of database buckets on a single redis-server process.
              Acceptable values are 1 to 1024, inclusive.
            type: string
            format: int64
          slowlogLogSlowerThan:
            description: |-
              **string** (int64)
              Threshold for logging slow requests to server in microseconds (log only slower than it).
              The minimum value is 10.
            type: string
            format: int64
          slowlogMaxLen:
            description: |-
              **string** (int64)
              Max slow requests number to log.
              The minimum value is 0.
            type: string
            format: int64
          notifyKeyspaceEvents:
            description: |-
              **string**
              String setting for pub\sub functionality.
            type: string
          clientOutputBufferLimitPubsub:
            description: |-
              **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig5_0.ClientOutputBufferLimit)**
              Redis connection output buffers limits for pubsub operations.
            $ref: '#/definitions/ClientOutputBufferLimit'
          clientOutputBufferLimitNormal:
            description: |-
              **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig5_0.ClientOutputBufferLimit)**
              Redis connection output buffers limits for clients.
            $ref: '#/definitions/ClientOutputBufferLimit'
          maxmemoryPercent:
            description: |-
              **string** (int64)
              Redis maxmemory percent
              Acceptable values are 1 to 75, inclusive.
            type: string
            format: int64
          luaTimeLimit:
            description: |-
              **string** (int64)
              Maximum time in milliseconds for Lua scripts, 0 - disabled mechanism
              Acceptable values are 0 to 5000, inclusive.
            type: string
            format: int64
          replBacklogSizePercent:
            description: |-
              **string** (int64)
              Replication backlog size as a percentage of flavor maxmemory
              Acceptable values are 1 to 75, inclusive.
            type: string
            format: int64
          clusterRequireFullCoverage:
            description: |-
              **boolean**
              Controls whether all hash slots must be covered by nodes
            type: boolean
          clusterAllowReadsWhenDown:
            description: |-
              **boolean**
              Allows read operations when cluster is down
            type: boolean
          clusterAllowPubsubshardWhenDown:
            description: |-
              **boolean**
              Permits Pub/Sub shard operations when cluster is down
            type: boolean
          lfuDecayTime:
            description: |-
              **string** (int64)
              The time, in minutes, that must elapse in order for the key counter to be divided by two (or decremented if it has a value less <= 10)
              Acceptable values are 0 to 100000, inclusive.
            type: string
            format: int64
          lfuLogFactor:
            description: |-
              **string** (int64)
              Determines how the frequency counter represents key hits.
              Acceptable values are 0 to 1000, inclusive.
            type: string
            format: int64
          turnBeforeSwitchover:
            description: |-
              **boolean**
              Allows to turn before switchover in RDSync
            type: boolean
          allowDataLoss:
            description: |-
              **boolean**
              Allows some data to be lost in favor of faster switchover/restart
            type: boolean
          useLuajit:
            description: |-
              **boolean**
              Use JIT for lua scripts and functions
            type: boolean
          ioThreadsAllowed:
            description: |-
              **boolean**
              Allow redis to use io-threads
            type: boolean
          zsetMaxListpackEntries:
            description: |-
              **string** (int64)
              Controls max number of entries in zset before conversion from memory-efficient listpack to CPU-efficient hash table and skiplist
              Acceptable values are 32 to 2048, inclusive.
            type: string
            format: int64
          aofMaxSizePercent:
            description: |-
              **string** (int64)
              AOF maximum size as a percentage of disk available
              Acceptable values are 1 to 99, inclusive.
            type: string
            format: int64
          activedefrag:
            description: |-
              **boolean**
              Enable active (online) memory defragmentation
            type: boolean
          auditLog:
            description: |-
              **boolean**
              Enable/disable audit logs for Valkey
            type: boolean
      DiskSizeAutoscaling:
        type: object
        properties:
          plannedUsageThreshold:
            description: |-
              **string** (int64)
              Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
              Acceptable values are 0 to 100, inclusive.
            type: string
            format: int64
          emergencyUsageThreshold:
            description: |-
              **string** (int64)
              Amount of used storage for immediately  automatic disk scaling, 0 means disabled, in percent.
              Acceptable values are 0 to 100, inclusive.
            type: string
            format: int64
          diskSizeLimit:
            description: |-
              **string** (int64)
              Limit on how large the storage for database instances can automatically grow, in bytes.
            type: string
            format: int64
      ValkeySearch:
        type: object
        properties:
          enabled:
            description: |-
              **boolean**
              Enable valkey-search module
            type: boolean
          readerThreads:
            description: |-
              **string** (int64)
              Controls the amount of threads executing queries
              The minimum value is 0.
            type: string
            format: int64
          writerThreads:
            description: |-
              **string** (int64)
              Controls the amount of threads processing index mutations
              The minimum value is 0.
            type: string
            format: int64
          version:
            description: |-
              **string**
              Module version
            type: string
      ValkeyJson:
        type: object
        properties:
          enabled:
            description: |-
              **boolean**
              Enable valkey-json module
            type: boolean
          version:
            description: |-
              **string**
              Module version
            type: string
      ValkeyBloom:
        type: object
        properties:
          enabled:
            description: |-
              **boolean**
              Enable valkey-bloom module
            type: boolean
          version:
            description: |-
              **string**
              Module version
            type: string
      ValkeyModules:
        type: object
        properties:
          valkeySearch:
            description: |-
              **[ValkeySearch](#yandex.cloud.mdb.redis.v1.ValkeySearch)**
              valkey-search module settings
            $ref: '#/definitions/ValkeySearch'
          valkeyJson:
            description: |-
              **[ValkeyJson](#yandex.cloud.mdb.redis.v1.ValkeyJson)**
              valkey-json module settings
            $ref: '#/definitions/ValkeyJson'
          valkeyBloom:
            description: |-
              **[ValkeyBloom](#yandex.cloud.mdb.redis.v1.ValkeyBloom)**
              valkey-bloom module settings
            $ref: '#/definitions/ValkeyBloom'
      ConfigSpec:
        type: object
        properties:
          version:
            description: |-
              **string**
              Version of Redis used in the cluster.
            type: string
          redisConfig_5_0:
            description: |-
              **[RedisConfig5_0](#yandex.cloud.mdb.redis.v1.config.RedisConfig5_0)**
              Configuration of a Redis 5.0 server.
              Includes only one of the fields `redisConfig_5_0`, `redisConfig_6_0`, `redisConfig_6_2`, `redisConfig_7_0`.
              Configuration of a Redis cluster.
            $ref: '#/definitions/RedisConfig5_0'
          redisConfig_6_0:
            description: |-
              **[RedisConfig6_0](#yandex.cloud.mdb.redis.v1.config.RedisConfig6_0)**
              Configuration of a Redis 6.0 server.
              Includes only one of the fields `redisConfig_5_0`, `redisConfig_6_0`, `redisConfig_6_2`, `redisConfig_7_0`.
              Configuration of a Redis cluster.
            $ref: '#/definitions/RedisConfig6_0'
          redisConfig_6_2:
            description: |-
              **[RedisConfig6_2](#yandex.cloud.mdb.redis.v1.config.RedisConfig6_2)**
              Configuration of a Redis 6.2 server.
              Includes only one of the fields `redisConfig_5_0`, `redisConfig_6_0`, `redisConfig_6_2`, `redisConfig_7_0`.
              Configuration of a Redis cluster.
            $ref: '#/definitions/RedisConfig6_2'
          redisConfig_7_0:
            description: |-
              **[RedisConfig7_0](#yandex.cloud.mdb.redis.v1.config.RedisConfig7_0)**
              Configuration of a Redis 7.0 server.
              Includes only one of the fields `redisConfig_5_0`, `redisConfig_6_0`, `redisConfig_6_2`, `redisConfig_7_0`.
              Configuration of a Redis cluster.
            $ref: '#/definitions/RedisConfig7_0'
          resources:
            description: |-
              **[Resources](#yandex.cloud.mdb.redis.v1.Resources)**
              Resources allocated to Redis hosts.
            $ref: '#/definitions/Resources'
          backupWindowStart:
            description: |-
              **[TimeOfDay](#google.type.TimeOfDay)**
              Time to start the daily backup, in the UTC timezone.
            $ref: '#/definitions/TimeOfDay'
          access:
            description: |-
              **[Access](#yandex.cloud.mdb.redis.v1.Access)**
              Access policy to DB
            $ref: '#/definitions/Access'
          redis:
            description: |-
              **[RedisConfig](#yandex.cloud.mdb.redis.v1.config.RedisConfig)**
              Unified configuration of a Redis cluster
            $ref: '#/definitions/RedisConfig'
          diskSizeAutoscaling:
            description: |-
              **[DiskSizeAutoscaling](#yandex.cloud.mdb.redis.v1.DiskSizeAutoscaling)**
              Disk size autoscaling settings
            $ref: '#/definitions/DiskSizeAutoscaling'
          backupRetainPeriodDays:
            description: |-
              **string** (int64)
              Retain period of automatically created backup in days
              Acceptable values are 7 to 60, inclusive.
            type: string
            format: int64
          modules:
            description: |-
              **[ValkeyModules](#yandex.cloud.mdb.redis.v1.ValkeyModules)**
              Valkey modules settings
            $ref: '#/definitions/ValkeyModules'
        oneOf:
          - required:
              - redisConfig_5_0
          - required:
              - redisConfig_6_0
          - required:
              - redisConfig_6_2
          - required:
              - redisConfig_7_0
      HostSpec:
        type: object
        properties:
          zoneId:
            description: |-
              **string**
              ID of the availability zone where the host resides.
              To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/Zone/list#List) request.
              The maximum string length in characters is 50.
            type: string
          subnetId:
            description: |-
              **string**
              ID of the subnet that the host should belong to. This subnet should be a part
              of the network that the cluster belongs to.
              The ID of the network is set in the field [Cluster.networkId](/docs/managed-redis/api-ref/Cluster/get#yandex.cloud.mdb.redis.v1.Cluster).
              The maximum string length in characters is 50.
            type: string
          shardName:
            description: |-
              **string**
              ID of the Redis shard the host belongs to.
              To get the shard ID use a [ClusterService.ListShards](/docs/managed-redis/api-ref/Cluster/listShards#ListShards) request.
              The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
            pattern: '[a-zA-Z0-9_-]*'
            type: string
          replicaPriority:
            description: |-
              **string** (int64)
              A replica with a low priority number is considered better for promotion.
              A replica with priority of 0 will never be selected by Redis Sentinel for promotion.
              Works only for non-sharded clusters. Default value is 100.
            type: string
            format: int64
          assignPublicIp:
            description: |-
              **boolean**
              Whether the host should get a public IP address on creation.
              Possible values:
              * false - don't assign a public IP to the host.
              * true - the host should have a public IP address.
            type: boolean
      AnytimeMaintenanceWindow:
        type: object
        properties: {}
      WeeklyMaintenanceWindow:
        type: object
        properties:
          day:
            description: |-
              **enum** (WeekDay)
              Day of the week (in `DDD` format).
              - `MON`: Monday.
              - `TUE`: Tuesday.
              - `WED`: Wednesday.
              - `THU`: Thursday.
              - `FRI`: Friday.
              - `SAT`: Saturday.
              - `SUN`: Sunday.
            type: string
            enum:
              - WEEK_DAY_UNSPECIFIED
              - MON
              - TUE
              - WED
              - THU
              - FRI
              - SAT
              - SUN
          hour:
            description: |-
              **string** (int64)
              Hour of the day in UTC (in `HH` format).
              Acceptable values are 1 to 24, inclusive.
            type: string
            format: int64
      MaintenanceWindow:
        type: object
        properties:
          anytime:
            description: |-
              **object**
              Maintenance operation can be scheduled anytime.
              Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`.
              The maintenance policy in effect.
            $ref: '#/definitions/AnytimeMaintenanceWindow'
          weeklyMaintenanceWindow:
            description: |-
              **[WeeklyMaintenanceWindow](#yandex.cloud.mdb.redis.v1.WeeklyMaintenanceWindow)**
              Maintenance operation can be scheduled on a weekly basis.
              Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`.
              The maintenance policy in effect.
            $ref: '#/definitions/WeeklyMaintenanceWindow'
        oneOf:
          - required:
              - anytime
          - required:
              - weeklyMaintenanceWindow
      Permissions:
        type: object
        properties:
          patterns:
            description: |-
              **string**
              Keys patterns user has permission to.
            type: string
          pubSubChannels:
            description: |-
              **string**
              Channel patterns user has permissions to.
            type: string
          categories:
            description: |-
              **string**
              Command categories user has permissions to.
            type: string
          commands:
            description: |-
              **string**
              Commands user can execute.
            type: string
          sanitizePayload:
            description: |-
              **string**
              SanitizePayload parameter.
            type: string
          databases:
            description: |-
              **string**
              Databases parameter.
            type: string
      UserSpec:
        type: object
        properties:
          name:
            description: |-
              **string**
              Required field. Name of the Redis user.
              The maximum string length in characters is 32. Value must match the regular expression ` ^[a-zA-Z0-9_][a-zA-Z0-9_@.-]*$ `.
            pattern: ^[a-zA-Z0-9_][a-zA-Z0-9_@.-]*$
            type: string
          passwords:
            description: |-
              **string**
              Password of the Redis user.
              The maximum number of elements is 1.
            uniqueItems: true
            type: array
            items:
              type: string
          permissions:
            description: |-
              **[Permissions](#yandex.cloud.mdb.redis.v1.Permissions)**
              Set of permissions to grant to the user.
            $ref: '#/definitions/Permissions'
          enabled:
            description: |-
              **boolean**
              Is Redis user enabled
            type: boolean
        required:
          - name
---

# Managed Service for Redis API, REST: Cluster.Create

Creates a Redis cluster in the specified folder.

## HTTP request

```
POST https://{{ api-host-mdb }}/managed-redis/v1/clusters
```

## Body parameters {#yandex.cloud.mdb.redis.v1.CreateClusterRequest}

```json
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "environment": "string",
  "configSpec": {
    "version": "string",
    // Includes only one of the fields `redisConfig_5_0`, `redisConfig_6_0`, `redisConfig_6_2`, `redisConfig_7_0`
    "redisConfig_5_0": {
      "maxmemoryPolicy": "string",
      "timeout": "string",
      "password": "string",
      "databases": "string",
      "slowlogLogSlowerThan": "string",
      "slowlogMaxLen": "string",
      "notifyKeyspaceEvents": "string",
      "clientOutputBufferLimitPubsub": {
        "hardLimit": "string",
        "softLimit": "string",
        "softSeconds": "string"
      },
      "clientOutputBufferLimitNormal": {
        "hardLimit": "string",
        "softLimit": "string",
        "softSeconds": "string"
      }
    },
    "redisConfig_6_0": {
      "maxmemoryPolicy": "string",
      "timeout": "string",
      "password": "string",
      "databases": "string",
      "slowlogLogSlowerThan": "string",
      "slowlogMaxLen": "string",
      "notifyKeyspaceEvents": "string",
      "clientOutputBufferLimitPubsub": {
        "hardLimit": "string",
        "softLimit": "string",
        "softSeconds": "string"
      },
      "clientOutputBufferLimitNormal": {
        "hardLimit": "string",
        "softLimit": "string",
        "softSeconds": "string"
      }
    },
    "redisConfig_6_2": {
      "maxmemoryPolicy": "string",
      "timeout": "string",
      "password": "string",
      "databases": "string",
      "slowlogLogSlowerThan": "string",
      "slowlogMaxLen": "string",
      "notifyKeyspaceEvents": "string",
      "clientOutputBufferLimitPubsub": {
        "hardLimit": "string",
        "softLimit": "string",
        "softSeconds": "string"
      },
      "clientOutputBufferLimitNormal": {
        "hardLimit": "string",
        "softLimit": "string",
        "softSeconds": "string"
      },
      "maxmemoryPercent": "string"
    },
    "redisConfig_7_0": {
      "maxmemoryPolicy": "string",
      "timeout": "string",
      "password": "string",
      "databases": "string",
      "slowlogLogSlowerThan": "string",
      "slowlogMaxLen": "string",
      "notifyKeyspaceEvents": "string",
      "clientOutputBufferLimitPubsub": {
        "hardLimit": "string",
        "softLimit": "string",
        "softSeconds": "string"
      },
      "clientOutputBufferLimitNormal": {
        "hardLimit": "string",
        "softLimit": "string",
        "softSeconds": "string"
      },
      "maxmemoryPercent": "string"
    },
    // end of the list of possible fields
    "resources": {
      "resourcePresetId": "string",
      "diskSize": "string",
      "diskTypeId": "string"
    },
    "backupWindowStart": {
      "hours": "integer",
      "minutes": "integer",
      "seconds": "integer",
      "nanos": "integer"
    },
    "access": {
      "dataLens": "boolean",
      "webSql": "boolean"
    },
    "redis": {
      "maxmemoryPolicy": "string",
      "timeout": "string",
      "password": "string",
      "databases": "string",
      "slowlogLogSlowerThan": "string",
      "slowlogMaxLen": "string",
      "notifyKeyspaceEvents": "string",
      "clientOutputBufferLimitPubsub": {
        "hardLimit": "string",
        "softLimit": "string",
        "softSeconds": "string"
      },
      "clientOutputBufferLimitNormal": {
        "hardLimit": "string",
        "softLimit": "string",
        "softSeconds": "string"
      },
      "maxmemoryPercent": "string",
      "luaTimeLimit": "string",
      "replBacklogSizePercent": "string",
      "clusterRequireFullCoverage": "boolean",
      "clusterAllowReadsWhenDown": "boolean",
      "clusterAllowPubsubshardWhenDown": "boolean",
      "lfuDecayTime": "string",
      "lfuLogFactor": "string",
      "turnBeforeSwitchover": "boolean",
      "allowDataLoss": "boolean",
      "useLuajit": "boolean",
      "ioThreadsAllowed": "boolean",
      "zsetMaxListpackEntries": "string",
      "aofMaxSizePercent": "string",
      "activedefrag": "boolean",
      "auditLog": "boolean"
    },
    "diskSizeAutoscaling": {
      "plannedUsageThreshold": "string",
      "emergencyUsageThreshold": "string",
      "diskSizeLimit": "string"
    },
    "backupRetainPeriodDays": "string",
    "modules": {
      "valkeySearch": {
        "enabled": "boolean",
        "readerThreads": "string",
        "writerThreads": "string",
        "version": "string"
      },
      "valkeyJson": {
        "enabled": "boolean",
        "version": "string"
      },
      "valkeyBloom": {
        "enabled": "boolean",
        "version": "string"
      }
    }
  },
  "hostSpecs": [
    {
      "zoneId": "string",
      "subnetId": "string",
      "shardName": "string",
      "replicaPriority": "string",
      "assignPublicIp": "boolean"
    }
  ],
  "networkId": "string",
  "sharded": "boolean",
  "securityGroupIds": [
    "string"
  ],
  "tlsEnabled": "boolean",
  "deletionProtection": "boolean",
  "persistenceMode": "string",
  "announceHostnames": "boolean",
  "maintenanceWindow": {
    // Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`
    "anytime": "object",
    "weeklyMaintenanceWindow": {
      "day": "string",
      "hour": "string"
    }
    // end of the list of possible fields
  },
  "userSpecs": [
    {
      "name": "string",
      "passwords": [
        "string"
      ],
      "permissions": {
        "patterns": "string",
        "pubSubChannels": "string",
        "categories": "string",
        "commands": "string",
        "sanitizePayload": "string",
        "databases": "string"
      },
      "enabled": "boolean"
    }
  ],
  "authSentinel": "boolean",
  "diskEncryptionKeyId": "string"
}
```

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to create the Redis cluster in.

The maximum string length in characters is 50. ||
|| name | **string**

Required field. Name of the Redis cluster. The name must be unique within the folder.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|| description | **string**

Description of the Redis cluster.

The maximum string length in characters is 256. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels for the Redis cluster as `key:value` pairs. Maximum 64 per cluster.
For example, "project": "mvp" or "source": "dictionary".

The maximum string length in characters for each value is 63. The maximum string length in characters for each key is 63. Each key must match the regular expression ` [a-z][-_./\@0-9a-z]* `. Each value must match the regular expression ` [-_./\@0-9a-z]* `. No more than 64 per resource. ||
|| environment | **enum** (Environment)

Required field. Deployment environment of the Redis cluster.

- `PRODUCTION`: Stable environment with a conservative update policy:
only hotfixes are applied during regular maintenance.
- `PRESTABLE`: Environment with more aggressive update policy: new versions
are rolled out irrespective of backward compatibility. ||
|| configSpec | **[ConfigSpec](#yandex.cloud.mdb.redis.v1.ConfigSpec)**

Required field. Configuration and resources for hosts that should be created for the Redis cluster. ||
|| hostSpecs[] | **[HostSpec](#yandex.cloud.mdb.redis.v1.HostSpec)**

Individual configurations for hosts that should be created for the Redis cluster.

The number of elements must be greater than 0. ||
|| networkId | **string**

ID of the network to create the cluster in.

The maximum string length in characters is 150. ||
|| sharded | **boolean**

Redis cluster mode on/off. ||
|| securityGroupIds[] | **string**

User security groups ||
|| tlsEnabled | **boolean**

TLS port and functionality on\off ||
|| deletionProtection | **boolean**

Deletion Protection inhibits deletion of the cluster ||
|| persistenceMode | **enum** (PersistenceMode)

Persistence mode

- `ON`: Cluster persistence mode is on.
- `OFF`: Cluster persistence mode is off.
- `ON_REPLICAS`: Cluster persistence is on for replicas only. ||
|| announceHostnames | **boolean**

Enable FQDN instead of ip ||
|| maintenanceWindow | **[MaintenanceWindow](#yandex.cloud.mdb.redis.v1.MaintenanceWindow)**

Window of maintenance operations. ||
|| userSpecs[] | **[UserSpec](#yandex.cloud.mdb.redis.v1.UserSpec)**

Descriptions of users to be created in the Redis cluster.

The minimum number of elements is 0. ||
|| authSentinel | **boolean**

Allows to use ACL users to auth in sentinel ||
|| diskEncryptionKeyId | **string**

ID of the key to encrypt cluster disks. ||
|#

## ConfigSpec {#yandex.cloud.mdb.redis.v1.ConfigSpec}

#|
||Field | Description ||
|| version | **string**

Version of Redis used in the cluster. ||
|| redisConfig_5_0 | **[RedisConfig5_0](#yandex.cloud.mdb.redis.v1.config.RedisConfig5_0)**

Configuration of a Redis 5.0 server.

Includes only one of the fields `redisConfig_5_0`, `redisConfig_6_0`, `redisConfig_6_2`, `redisConfig_7_0`.

Configuration of a Redis cluster. ||
|| redisConfig_6_0 | **[RedisConfig6_0](#yandex.cloud.mdb.redis.v1.config.RedisConfig6_0)**

Configuration of a Redis 6.0 server.

Includes only one of the fields `redisConfig_5_0`, `redisConfig_6_0`, `redisConfig_6_2`, `redisConfig_7_0`.

Configuration of a Redis cluster. ||
|| redisConfig_6_2 | **[RedisConfig6_2](#yandex.cloud.mdb.redis.v1.config.RedisConfig6_2)**

Configuration of a Redis 6.2 server.

Includes only one of the fields `redisConfig_5_0`, `redisConfig_6_0`, `redisConfig_6_2`, `redisConfig_7_0`.

Configuration of a Redis cluster. ||
|| redisConfig_7_0 | **[RedisConfig7_0](#yandex.cloud.mdb.redis.v1.config.RedisConfig7_0)**

Configuration of a Redis 7.0 server.

Includes only one of the fields `redisConfig_5_0`, `redisConfig_6_0`, `redisConfig_6_2`, `redisConfig_7_0`.

Configuration of a Redis cluster. ||
|| resources | **[Resources](#yandex.cloud.mdb.redis.v1.Resources)**

Resources allocated to Redis hosts. ||
|| backupWindowStart | **[TimeOfDay](#google.type.TimeOfDay)**

Time to start the daily backup, in the UTC timezone. ||
|| access | **[Access](#yandex.cloud.mdb.redis.v1.Access)**

Access policy to DB ||
|| redis | **[RedisConfig](#yandex.cloud.mdb.redis.v1.config.RedisConfig)**

Unified configuration of a Redis cluster ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.redis.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|| backupRetainPeriodDays | **string** (int64)

Retain period of automatically created backup in days

Acceptable values are 7 to 60, inclusive. ||
|| modules | **[ValkeyModules](#yandex.cloud.mdb.redis.v1.ValkeyModules)**

Valkey modules settings ||
|#

## RedisConfig5_0 {#yandex.cloud.mdb.redis.v1.config.RedisConfig5_0}

Fields and structure of `RedisConfig` reflects Redis configuration file
parameters.

#|
||Field | Description ||
|| maxmemoryPolicy | **enum** (MaxmemoryPolicy)

Redis key eviction policy for a dataset that reaches maximum memory,
available to the host. Redis maxmemory setting depends on Managed
Service for Redis [host class](/docs/managed-redis/concepts/instance-types).
All policies are described in detail in [Redis documentation](https://redis.io/topics/lru-cache).

- `VOLATILE_LRU`: Try to remove less recently used (LRU) keys with `expire set`.
- `ALLKEYS_LRU`: Remove less recently used (LRU) keys.
- `VOLATILE_LFU`: Try to remove least frequently used (LFU) keys with `expire set`.
- `ALLKEYS_LFU`: Remove least frequently used (LFU) keys.
- `VOLATILE_RANDOM`: Try to remove keys with `expire set` randomly.
- `ALLKEYS_RANDOM`: Remove keys randomly.
- `VOLATILE_TTL`: Try to remove less recently used (LRU) keys with `expire set`
and shorter TTL first.
- `NOEVICTION`: Return errors when memory limit was reached and commands could require
more memory to be used. ||
|| timeout | **string** (int64)

Time that Redis keeps the connection open while the client is idle.
If no new command is sent during that time, the connection is closed.

Value must be greater than 0. ||
|| password | **string**

Authentication password.

The string length in characters must be 8-128. Value must match the regular expression ` [a-zA-Z0-9@=+?*.,!&#$^<>_-]{8,128} `. ||
|| databases | **string** (int64)

Number of database buckets on a single redis-server process.

Value must be greater than 0. ||
|| slowlogLogSlowerThan | **string** (int64)

Threshold for logging slow requests to server in microseconds (log only slower than it).

The minimum value is 0. ||
|| slowlogMaxLen | **string** (int64)

Max slow requests number to log.

The minimum value is 0. ||
|| notifyKeyspaceEvents | **string**

String setting for pub\sub functionality.

Value must match the regular expression ` [KEg$lshzxeAtm]{0,12} `. ||
|| clientOutputBufferLimitPubsub | **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig5_0.ClientOutputBufferLimit)**

Redis connection output buffers limits for pubsub operations. ||
|| clientOutputBufferLimitNormal | **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig5_0.ClientOutputBufferLimit)**

Redis connection output buffers limits for clients. ||
|#

## ClientOutputBufferLimit {#yandex.cloud.mdb.redis.v1.config.RedisConfig5_0.ClientOutputBufferLimit}

#|
||Field | Description ||
|| hardLimit | **string** (int64)

Total limit in bytes.

The minimum value is 0. ||
|| softLimit | **string** (int64)

Limit in bytes during certain time period.

The minimum value is 0. ||
|| softSeconds | **string** (int64)

Seconds for soft limit.

The minimum value is 0. ||
|#

## RedisConfig6_0 {#yandex.cloud.mdb.redis.v1.config.RedisConfig6_0}

Fields and structure of `RedisConfig` reflects Redis configuration file
parameters.

#|
||Field | Description ||
|| maxmemoryPolicy | **enum** (MaxmemoryPolicy)

Redis key eviction policy for a dataset that reaches maximum memory,
available to the host. Redis maxmemory setting depends on Managed
Service for Redis [host class](/docs/managed-redis/concepts/instance-types).
All policies are described in detail in [Redis documentation](https://redis.io/topics/lru-cache).

- `VOLATILE_LRU`: Try to remove less recently used (LRU) keys with `expire set`.
- `ALLKEYS_LRU`: Remove less recently used (LRU) keys.
- `VOLATILE_LFU`: Try to remove least frequently used (LFU) keys with `expire set`.
- `ALLKEYS_LFU`: Remove least frequently used (LFU) keys.
- `VOLATILE_RANDOM`: Try to remove keys with `expire set` randomly.
- `ALLKEYS_RANDOM`: Remove keys randomly.
- `VOLATILE_TTL`: Try to remove less recently used (LRU) keys with `expire set`
and shorter TTL first.
- `NOEVICTION`: Return errors when memory limit was reached and commands could require
more memory to be used. ||
|| timeout | **string** (int64)

Time that Redis keeps the connection open while the client is idle.
If no new command is sent during that time, the connection is closed.

Value must be greater than 0. ||
|| password | **string**

Authentication password.

The string length in characters must be 8-128. Value must match the regular expression ` [a-zA-Z0-9@=+?*.,!&#$^<>_-]{8,128} `. ||
|| databases | **string** (int64)

Number of database buckets on a single redis-server process.

Value must be greater than 0. ||
|| slowlogLogSlowerThan | **string** (int64)

Threshold for logging slow requests to server in microseconds (log only slower than it).

The minimum value is 0. ||
|| slowlogMaxLen | **string** (int64)

Max slow requests number to log.

The minimum value is 0. ||
|| notifyKeyspaceEvents | **string**

String setting for pub\sub functionality.

Value must match the regular expression ` [KEg$lshzxeAtm]{0,13} `. ||
|| clientOutputBufferLimitPubsub | **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig6_0.ClientOutputBufferLimit)**

Redis connection output buffers limits for pubsub operations. ||
|| clientOutputBufferLimitNormal | **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig6_0.ClientOutputBufferLimit)**

Redis connection output buffers limits for clients. ||
|#

## ClientOutputBufferLimit {#yandex.cloud.mdb.redis.v1.config.RedisConfig6_0.ClientOutputBufferLimit}

#|
||Field | Description ||
|| hardLimit | **string** (int64)

Total limit in bytes.

The minimum value is 0. ||
|| softLimit | **string** (int64)

Limit in bytes during certain time period.

The minimum value is 0. ||
|| softSeconds | **string** (int64)

Seconds for soft limit.

The minimum value is 0. ||
|#

## RedisConfig6_2 {#yandex.cloud.mdb.redis.v1.config.RedisConfig6_2}

Fields and structure of `RedisConfig` reflects Redis configuration file
parameters.

#|
||Field | Description ||
|| maxmemoryPolicy | **enum** (MaxmemoryPolicy)

Redis key eviction policy for a dataset that reaches maximum memory,
available to the host. Redis maxmemory setting depends on Managed
Service for Redis [host class](/docs/managed-redis/concepts/instance-types).
All policies are described in detail in [Redis documentation](https://redis.io/topics/lru-cache).

- `VOLATILE_LRU`: Try to remove less recently used (LRU) keys with `expire set`.
- `ALLKEYS_LRU`: Remove less recently used (LRU) keys.
- `VOLATILE_LFU`: Try to remove least frequently used (LFU) keys with `expire set`.
- `ALLKEYS_LFU`: Remove least frequently used (LFU) keys.
- `VOLATILE_RANDOM`: Try to remove keys with `expire set` randomly.
- `ALLKEYS_RANDOM`: Remove keys randomly.
- `VOLATILE_TTL`: Try to remove less recently used (LRU) keys with `expire set`
and shorter TTL first.
- `NOEVICTION`: Return errors when memory limit was reached and commands could require
more memory to be used. ||
|| timeout | **string** (int64)

Time that Redis keeps the connection open while the client is idle.
If no new command is sent during that time, the connection is closed.

The minimum value is 0. ||
|| password | **string**

Authentication password.

The string length in characters must be 8-128. Value must match the regular expression ` [a-zA-Z0-9@=+?*.,!&#$^<>_-]{8,128} `. ||
|| databases | **string** (int64)

Number of database buckets on a single redis-server process.

Value must be greater than 0. ||
|| slowlogLogSlowerThan | **string** (int64)

Threshold for logging slow requests to server in microseconds (log only slower than it).

The minimum value is 0. ||
|| slowlogMaxLen | **string** (int64)

Max slow requests number to log.

The minimum value is 0. ||
|| notifyKeyspaceEvents | **string**

String setting for pub\sub functionality.

Value must match the regular expression ` [KEg$lshzxeAtm]{0,13} `. ||
|| clientOutputBufferLimitPubsub | **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig6_2.ClientOutputBufferLimit)**

Redis connection output buffers limits for pubsub operations. ||
|| clientOutputBufferLimitNormal | **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig6_2.ClientOutputBufferLimit)**

Redis connection output buffers limits for clients. ||
|| maxmemoryPercent | **string** (int64)

Redis maxmemory percent

Acceptable values are 1 to 75, inclusive. ||
|#

## ClientOutputBufferLimit {#yandex.cloud.mdb.redis.v1.config.RedisConfig6_2.ClientOutputBufferLimit}

#|
||Field | Description ||
|| hardLimit | **string** (int64)

Total limit in bytes.

The minimum value is 0. ||
|| softLimit | **string** (int64)

Limit in bytes during certain time period.

The minimum value is 0. ||
|| softSeconds | **string** (int64)

Seconds for soft limit.

The minimum value is 0. ||
|#

## RedisConfig7_0 {#yandex.cloud.mdb.redis.v1.config.RedisConfig7_0}

Fields and structure of `RedisConfig` reflects Redis configuration file
parameters.

#|
||Field | Description ||
|| maxmemoryPolicy | **enum** (MaxmemoryPolicy)

Redis key eviction policy for a dataset that reaches maximum memory,
available to the host. Redis maxmemory setting depends on Managed
Service for Redis [host class](/docs/managed-redis/concepts/instance-types).
All policies are described in detail in [Redis documentation](https://redis.io/topics/lru-cache).

- `VOLATILE_LRU`: Try to remove less recently used (LRU) keys with `expire set`.
- `ALLKEYS_LRU`: Remove less recently used (LRU) keys.
- `VOLATILE_LFU`: Try to remove least frequently used (LFU) keys with `expire set`.
- `ALLKEYS_LFU`: Remove least frequently used (LFU) keys.
- `VOLATILE_RANDOM`: Try to remove keys with `expire set` randomly.
- `ALLKEYS_RANDOM`: Remove keys randomly.
- `VOLATILE_TTL`: Try to remove less recently used (LRU) keys with `expire set`
and shorter TTL first.
- `NOEVICTION`: Return errors when memory limit was reached and commands could require
more memory to be used. ||
|| timeout | **string** (int64)

Time that Redis keeps the connection open while the client is idle.
If no new command is sent during that time, the connection is closed.

The minimum value is 0. ||
|| password | **string**

Authentication password.

The string length in characters must be 8-128. Value must match the regular expression ` [a-zA-Z0-9@=+?*.,!&#$^<>_-]{8,128} `. ||
|| databases | **string** (int64)

Number of database buckets on a single redis-server process.

Value must be greater than 0. ||
|| slowlogLogSlowerThan | **string** (int64)

Threshold for logging slow requests to server in microseconds (log only slower than it).

The minimum value is 0. ||
|| slowlogMaxLen | **string** (int64)

Max slow requests number to log.

The minimum value is 0. ||
|| notifyKeyspaceEvents | **string**

String setting for pub\sub functionality.

Value must match the regular expression ` [KEg$lshzxeAtm]{0,13} `. ||
|| clientOutputBufferLimitPubsub | **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig7_0.ClientOutputBufferLimit)**

Redis connection output buffers limits for pubsub operations. ||
|| clientOutputBufferLimitNormal | **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig7_0.ClientOutputBufferLimit)**

Redis connection output buffers limits for clients. ||
|| maxmemoryPercent | **string** (int64)

Redis maxmemory percent

Acceptable values are 1 to 75, inclusive. ||
|#

## ClientOutputBufferLimit {#yandex.cloud.mdb.redis.v1.config.RedisConfig7_0.ClientOutputBufferLimit}

#|
||Field | Description ||
|| hardLimit | **string** (int64)

Total limit in bytes.

The minimum value is 0. ||
|| softLimit | **string** (int64)

Limit in bytes during certain time period.

The minimum value is 0. ||
|| softSeconds | **string** (int64)

Seconds for soft limit.

The minimum value is 0. ||
|#

## Resources {#yandex.cloud.mdb.redis.v1.Resources}

#|
||Field | Description ||
|| resourcePresetId | **string**

Required field. ID of the preset for computational resources available to a host (CPU, memory etc.).
All available presets are listed in the [documentation](/docs/managed-redis/concepts/instance-types). ||
|| diskSize | **string** (int64)

Volume of the storage available to a host, in bytes. ||
|| diskTypeId | **string**

Type of the storage environment for the host.
Possible values:
* network-ssd - network SSD drive,
* local-ssd - local SSD storage. ||
|#

## TimeOfDay {#google.type.TimeOfDay}

Represents a time of day. The date and time zone are either not significant
or are specified elsewhere. An API may choose to allow leap seconds. Related
types are [google.type.Date](https://github.com/googleapis/googleapis/blob/master/google/type/date.proto) and [google.protobuf.Timestamp](https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto).

#|
||Field | Description ||
|| hours | **integer** (int32)

Hours of day in 24 hour format. Should be from 0 to 23. An API may choose
to allow the value "24:00:00" for scenarios like business closing time. ||
|| minutes | **integer** (int32)

Minutes of hour of day. Must be from 0 to 59. ||
|| seconds | **integer** (int32)

Seconds of minutes of the time. Must normally be from 0 to 59. An API may
allow the value 60 if it allows leap-seconds. ||
|| nanos | **integer** (int32)

Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999. ||
|#

## Access {#yandex.cloud.mdb.redis.v1.Access}

#|
||Field | Description ||
|| dataLens | **boolean**

Allow access for DataLens ||
|| webSql | **boolean**

Allow access for Web SQL. ||
|#

## RedisConfig {#yandex.cloud.mdb.redis.v1.config.RedisConfig}

Fields and structure of `RedisConfig` reflects Redis configuration file
parameters.

#|
||Field | Description ||
|| maxmemoryPolicy | **enum** (MaxmemoryPolicy)

Redis key eviction policy for a dataset that reaches maximum memory,
available to the host. Redis maxmemory setting depends on Managed
Service for Redis [host class](/docs/managed-redis/concepts/instance-types).
All policies are described in detail in [Redis documentation](https://redis.io/topics/lru-cache).

- `VOLATILE_LRU`: Try to remove less recently used (LRU) keys with `expire set`.
- `ALLKEYS_LRU`: Remove less recently used (LRU) keys.
- `VOLATILE_LFU`: Try to remove least frequently used (LFU) keys with `expire set`.
- `ALLKEYS_LFU`: Remove least frequently used (LFU) keys.
- `VOLATILE_RANDOM`: Try to remove keys with `expire set` randomly.
- `ALLKEYS_RANDOM`: Remove keys randomly.
- `VOLATILE_TTL`: Try to remove less recently used (LRU) keys with `expire set`
and shorter TTL first.
- `NOEVICTION`: Return errors when memory limit was reached and commands could require
more memory to be used. ||
|| timeout | **string** (int64)

Time that Redis keeps the connection open while the client is idle.
If no new command is sent during that time, the connection is closed.

The minimum value is 0. ||
|| password | **string**

Authentication password. ||
|| databases | **string** (int64)

Number of database buckets on a single redis-server process.

Acceptable values are 1 to 1024, inclusive. ||
|| slowlogLogSlowerThan | **string** (int64)

Threshold for logging slow requests to server in microseconds (log only slower than it).

The minimum value is 10. ||
|| slowlogMaxLen | **string** (int64)

Max slow requests number to log.

The minimum value is 0. ||
|| notifyKeyspaceEvents | **string**

String setting for pub\sub functionality. ||
|| clientOutputBufferLimitPubsub | **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig.ClientOutputBufferLimit)**

Redis connection output buffers limits for pubsub operations. ||
|| clientOutputBufferLimitNormal | **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig.ClientOutputBufferLimit)**

Redis connection output buffers limits for clients. ||
|| maxmemoryPercent | **string** (int64)

Redis maxmemory percent

Acceptable values are 1 to 75, inclusive. ||
|| luaTimeLimit | **string** (int64)

Maximum time in milliseconds for Lua scripts, 0 - disabled mechanism

Acceptable values are 0 to 5000, inclusive. ||
|| replBacklogSizePercent | **string** (int64)

Replication backlog size as a percentage of flavor maxmemory

Acceptable values are 1 to 75, inclusive. ||
|| clusterRequireFullCoverage | **boolean**

Controls whether all hash slots must be covered by nodes ||
|| clusterAllowReadsWhenDown | **boolean**

Allows read operations when cluster is down ||
|| clusterAllowPubsubshardWhenDown | **boolean**

Permits Pub/Sub shard operations when cluster is down ||
|| lfuDecayTime | **string** (int64)

The time, in minutes, that must elapse in order for the key counter to be divided by two (or decremented if it has a value less <= 10)

Acceptable values are 0 to 100000, inclusive. ||
|| lfuLogFactor | **string** (int64)

Determines how the frequency counter represents key hits.

Acceptable values are 0 to 1000, inclusive. ||
|| turnBeforeSwitchover | **boolean**

Allows to turn before switchover in RDSync ||
|| allowDataLoss | **boolean**

Allows some data to be lost in favor of faster switchover/restart ||
|| useLuajit | **boolean**

Use JIT for lua scripts and functions ||
|| ioThreadsAllowed | **boolean**

Allow redis to use io-threads ||
|| zsetMaxListpackEntries | **string** (int64)

Controls max number of entries in zset before conversion from memory-efficient listpack to CPU-efficient hash table and skiplist

Acceptable values are 32 to 2048, inclusive. ||
|| aofMaxSizePercent | **string** (int64)

AOF maximum size as a percentage of disk available

Acceptable values are 1 to 99, inclusive. ||
|| activedefrag | **boolean**

Enable active (online) memory defragmentation ||
|| auditLog | **boolean**

Enable/disable audit logs for Valkey ||
|#

## ClientOutputBufferLimit {#yandex.cloud.mdb.redis.v1.config.RedisConfig.ClientOutputBufferLimit}

#|
||Field | Description ||
|| hardLimit | **string** (int64)

Total limit in bytes.

The minimum value is 0. ||
|| softLimit | **string** (int64)

Limit in bytes during certain time period.

The minimum value is 0. ||
|| softSeconds | **string** (int64)

Seconds for soft limit.

The minimum value is 0. ||
|#

## DiskSizeAutoscaling {#yandex.cloud.mdb.redis.v1.DiskSizeAutoscaling}

#|
||Field | Description ||
|| plannedUsageThreshold | **string** (int64)

Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.

Acceptable values are 0 to 100, inclusive. ||
|| emergencyUsageThreshold | **string** (int64)

Amount of used storage for immediately  automatic disk scaling, 0 means disabled, in percent.

Acceptable values are 0 to 100, inclusive. ||
|| diskSizeLimit | **string** (int64)

Limit on how large the storage for database instances can automatically grow, in bytes. ||
|#

## ValkeyModules {#yandex.cloud.mdb.redis.v1.ValkeyModules}

#|
||Field | Description ||
|| valkeySearch | **[ValkeySearch](#yandex.cloud.mdb.redis.v1.ValkeySearch)**

valkey-search module settings ||
|| valkeyJson | **[ValkeyJson](#yandex.cloud.mdb.redis.v1.ValkeyJson)**

valkey-json module settings ||
|| valkeyBloom | **[ValkeyBloom](#yandex.cloud.mdb.redis.v1.ValkeyBloom)**

valkey-bloom module settings ||
|#

## ValkeySearch {#yandex.cloud.mdb.redis.v1.ValkeySearch}

#|
||Field | Description ||
|| enabled | **boolean**

Enable valkey-search module ||
|| readerThreads | **string** (int64)

Controls the amount of threads executing queries

The minimum value is 0. ||
|| writerThreads | **string** (int64)

Controls the amount of threads processing index mutations

The minimum value is 0. ||
|| version | **string**

Module version ||
|#

## ValkeyJson {#yandex.cloud.mdb.redis.v1.ValkeyJson}

#|
||Field | Description ||
|| enabled | **boolean**

Enable valkey-json module ||
|| version | **string**

Module version ||
|#

## ValkeyBloom {#yandex.cloud.mdb.redis.v1.ValkeyBloom}

#|
||Field | Description ||
|| enabled | **boolean**

Enable valkey-bloom module ||
|| version | **string**

Module version ||
|#

## HostSpec {#yandex.cloud.mdb.redis.v1.HostSpec}

#|
||Field | Description ||
|| zoneId | **string**

ID of the availability zone where the host resides.
To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/Zone/list#List) request.

The maximum string length in characters is 50. ||
|| subnetId | **string**

ID of the subnet that the host should belong to. This subnet should be a part
of the network that the cluster belongs to.
The ID of the network is set in the field [Cluster.networkId](/docs/managed-redis/api-ref/Cluster/get#yandex.cloud.mdb.redis.v1.Cluster).

The maximum string length in characters is 50. ||
|| shardName | **string**

ID of the Redis shard the host belongs to.
To get the shard ID use a [ClusterService.ListShards](/docs/managed-redis/api-ref/Cluster/listShards#ListShards) request.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|| replicaPriority | **string** (int64)

A replica with a low priority number is considered better for promotion.
A replica with priority of 0 will never be selected by Redis Sentinel for promotion.
Works only for non-sharded clusters. Default value is 100. ||
|| assignPublicIp | **boolean**

Whether the host should get a public IP address on creation.
Possible values:
* false - don't assign a public IP to the host.
* true - the host should have a public IP address. ||
|#

## MaintenanceWindow {#yandex.cloud.mdb.redis.v1.MaintenanceWindow}

A maintenance window settings.

#|
||Field | Description ||
|| anytime | **object**

Maintenance operation can be scheduled anytime.

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`.

The maintenance policy in effect. ||
|| weeklyMaintenanceWindow | **[WeeklyMaintenanceWindow](#yandex.cloud.mdb.redis.v1.WeeklyMaintenanceWindow)**

Maintenance operation can be scheduled on a weekly basis.

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`.

The maintenance policy in effect. ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.mdb.redis.v1.WeeklyMaintenanceWindow}

Weelky maintenance window settings.

#|
||Field | Description ||
|| day | **enum** (WeekDay)

Day of the week (in `DDD` format).

- `MON`: Monday.
- `TUE`: Tuesday.
- `WED`: Wednesday.
- `THU`: Thursday.
- `FRI`: Friday.
- `SAT`: Saturday.
- `SUN`: Sunday. ||
|| hour | **string** (int64)

Hour of the day in UTC (in `HH` format).

Acceptable values are 1 to 24, inclusive. ||
|#

## UserSpec {#yandex.cloud.mdb.redis.v1.UserSpec}

#|
||Field | Description ||
|| name | **string**

Required field. Name of the Redis user.

The maximum string length in characters is 32. Value must match the regular expression ` ^[a-zA-Z0-9_][a-zA-Z0-9_@.-]*$ `. ||
|| passwords[] | **string**

Password of the Redis user.

The maximum number of elements is 1. ||
|| permissions | **[Permissions](#yandex.cloud.mdb.redis.v1.Permissions)**

Set of permissions to grant to the user. ||
|| enabled | **boolean**

Is Redis user enabled ||
|#

## Permissions {#yandex.cloud.mdb.redis.v1.Permissions}

#|
||Field | Description ||
|| patterns | **string**

Keys patterns user has permission to. ||
|| pubSubChannels | **string**

Channel patterns user has permissions to. ||
|| categories | **string**

Command categories user has permissions to. ||
|| commands | **string**

Commands user can execute. ||
|| sanitizePayload | **string**

SanitizePayload parameter. ||
|| databases | **string**

Databases parameter. ||
|#

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": "object",
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object"
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **object**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **object**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#