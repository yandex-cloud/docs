---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/{clusterId}/hosts:batchUpdate
    method: post
    path:
      type: object
      properties:
        clusterId:
          description: |-
            **string**
            Required field. ID of the PostgreSQL cluster to update hosts in.
            To get the PostgreSQL cluster ID, use a [ClusterService.List](/docs/managed-postgresql/api-ref/Cluster/list#List) request.
          type: string
      required:
        - clusterId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        updateHostSpecs:
          description: |-
            **[UpdateHostSpec](#yandex.cloud.mdb.postgresql.v1.UpdateHostSpec)**
            New configurations to apply to hosts.
          type: array
          items:
            $ref: '#/definitions/UpdateHostSpec'
      additionalProperties: false
    definitions:
      PostgresqlHostConfig9_6:
        type: object
        properties:
          recoveryMinApplyDelay:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          sharedBuffers:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          tempBuffers:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          workMem:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          replacementSortTuples:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          tempFileLimit:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          backendFlushAfter:
            description: '**string** (int64)'
            type: string
            format: int64
          oldSnapshotThreshold:
            description: '**string** (int64)'
            type: string
            format: int64
          maxStandbyStreamingDelay:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          constraintExclusion:
            description: |-
              **enum** (ConstraintExclusion)
              - `CONSTRAINT_EXCLUSION_UNSPECIFIED`
              - `CONSTRAINT_EXCLUSION_ON`
              - `CONSTRAINT_EXCLUSION_OFF`
              - `CONSTRAINT_EXCLUSION_PARTITION`
            type: string
            enum:
              - CONSTRAINT_EXCLUSION_UNSPECIFIED
              - CONSTRAINT_EXCLUSION_ON
              - CONSTRAINT_EXCLUSION_OFF
              - CONSTRAINT_EXCLUSION_PARTITION
          cursorTupleFraction:
            description: '**number** (double)'
            type: number
            format: double
          fromCollapseLimit:
            description: '**string** (int64)'
            type: string
            format: int64
          joinCollapseLimit:
            description: '**string** (int64)'
            type: string
            format: int64
          forceParallelMode:
            description: |-
              **enum** (ForceParallelMode)
              - `FORCE_PARALLEL_MODE_UNSPECIFIED`
              - `FORCE_PARALLEL_MODE_ON`
              - `FORCE_PARALLEL_MODE_OFF`
              - `FORCE_PARALLEL_MODE_REGRESS`
            type: string
            enum:
              - FORCE_PARALLEL_MODE_UNSPECIFIED
              - FORCE_PARALLEL_MODE_ON
              - FORCE_PARALLEL_MODE_OFF
              - FORCE_PARALLEL_MODE_REGRESS
          clientMinMessages:
            description: |-
              **enum** (LogLevel)
              - `LOG_LEVEL_UNSPECIFIED`
              - `LOG_LEVEL_DEBUG5`
              - `LOG_LEVEL_DEBUG4`
              - `LOG_LEVEL_DEBUG3`
              - `LOG_LEVEL_DEBUG2`
              - `LOG_LEVEL_DEBUG1`
              - `LOG_LEVEL_LOG`
              - `LOG_LEVEL_NOTICE`
              - `LOG_LEVEL_WARNING`
              - `LOG_LEVEL_ERROR`
              - `LOG_LEVEL_FATAL`
              - `LOG_LEVEL_PANIC`
            type: string
            enum:
              - LOG_LEVEL_UNSPECIFIED
              - LOG_LEVEL_DEBUG5
              - LOG_LEVEL_DEBUG4
              - LOG_LEVEL_DEBUG3
              - LOG_LEVEL_DEBUG2
              - LOG_LEVEL_DEBUG1
              - LOG_LEVEL_LOG
              - LOG_LEVEL_NOTICE
              - LOG_LEVEL_WARNING
              - LOG_LEVEL_ERROR
              - LOG_LEVEL_FATAL
              - LOG_LEVEL_PANIC
          logMinMessages:
            description: |-
              **enum** (LogLevel)
              - `LOG_LEVEL_UNSPECIFIED`
              - `LOG_LEVEL_DEBUG5`
              - `LOG_LEVEL_DEBUG4`
              - `LOG_LEVEL_DEBUG3`
              - `LOG_LEVEL_DEBUG2`
              - `LOG_LEVEL_DEBUG1`
              - `LOG_LEVEL_LOG`
              - `LOG_LEVEL_NOTICE`
              - `LOG_LEVEL_WARNING`
              - `LOG_LEVEL_ERROR`
              - `LOG_LEVEL_FATAL`
              - `LOG_LEVEL_PANIC`
            type: string
            enum:
              - LOG_LEVEL_UNSPECIFIED
              - LOG_LEVEL_DEBUG5
              - LOG_LEVEL_DEBUG4
              - LOG_LEVEL_DEBUG3
              - LOG_LEVEL_DEBUG2
              - LOG_LEVEL_DEBUG1
              - LOG_LEVEL_LOG
              - LOG_LEVEL_NOTICE
              - LOG_LEVEL_WARNING
              - LOG_LEVEL_ERROR
              - LOG_LEVEL_FATAL
              - LOG_LEVEL_PANIC
          logMinErrorStatement:
            description: |-
              **enum** (LogLevel)
              - `LOG_LEVEL_UNSPECIFIED`
              - `LOG_LEVEL_DEBUG5`
              - `LOG_LEVEL_DEBUG4`
              - `LOG_LEVEL_DEBUG3`
              - `LOG_LEVEL_DEBUG2`
              - `LOG_LEVEL_DEBUG1`
              - `LOG_LEVEL_LOG`
              - `LOG_LEVEL_NOTICE`
              - `LOG_LEVEL_WARNING`
              - `LOG_LEVEL_ERROR`
              - `LOG_LEVEL_FATAL`
              - `LOG_LEVEL_PANIC`
            type: string
            enum:
              - LOG_LEVEL_UNSPECIFIED
              - LOG_LEVEL_DEBUG5
              - LOG_LEVEL_DEBUG4
              - LOG_LEVEL_DEBUG3
              - LOG_LEVEL_DEBUG2
              - LOG_LEVEL_DEBUG1
              - LOG_LEVEL_LOG
              - LOG_LEVEL_NOTICE
              - LOG_LEVEL_WARNING
              - LOG_LEVEL_ERROR
              - LOG_LEVEL_FATAL
              - LOG_LEVEL_PANIC
          logMinDurationStatement:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          logCheckpoints:
            description: '**boolean**'
            type: boolean
          logConnections:
            description: '**boolean**'
            type: boolean
          logDisconnections:
            description: '**boolean**'
            type: boolean
          logDuration:
            description: '**boolean**'
            type: boolean
          logErrorVerbosity:
            description: |-
              **enum** (LogErrorVerbosity)
              - `LOG_ERROR_VERBOSITY_UNSPECIFIED`
              - `LOG_ERROR_VERBOSITY_TERSE`
              - `LOG_ERROR_VERBOSITY_DEFAULT`
              - `LOG_ERROR_VERBOSITY_VERBOSE`
            type: string
            enum:
              - LOG_ERROR_VERBOSITY_UNSPECIFIED
              - LOG_ERROR_VERBOSITY_TERSE
              - LOG_ERROR_VERBOSITY_DEFAULT
              - LOG_ERROR_VERBOSITY_VERBOSE
          logLockWaits:
            description: '**boolean**'
            type: boolean
          logStatement:
            description: |-
              **enum** (LogStatement)
              - `LOG_STATEMENT_UNSPECIFIED`
              - `LOG_STATEMENT_NONE`
              - `LOG_STATEMENT_DDL`
              - `LOG_STATEMENT_MOD`
              - `LOG_STATEMENT_ALL`
            type: string
            enum:
              - LOG_STATEMENT_UNSPECIFIED
              - LOG_STATEMENT_NONE
              - LOG_STATEMENT_DDL
              - LOG_STATEMENT_MOD
              - LOG_STATEMENT_ALL
          logTempFiles:
            description: '**string** (int64)'
            type: string
            format: int64
          searchPath:
            description: '**string**'
            type: string
          rowSecurity:
            description: '**boolean**'
            type: boolean
          defaultTransactionIsolation:
            description: |-
              **enum** (TransactionIsolation)
              - `TRANSACTION_ISOLATION_UNSPECIFIED`
              - `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
              - `TRANSACTION_ISOLATION_READ_COMMITTED`
              - `TRANSACTION_ISOLATION_REPEATABLE_READ`
              - `TRANSACTION_ISOLATION_SERIALIZABLE`
            type: string
            enum:
              - TRANSACTION_ISOLATION_UNSPECIFIED
              - TRANSACTION_ISOLATION_READ_UNCOMMITTED
              - TRANSACTION_ISOLATION_READ_COMMITTED
              - TRANSACTION_ISOLATION_REPEATABLE_READ
              - TRANSACTION_ISOLATION_SERIALIZABLE
          statementTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          lockTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          idleInTransactionSessionTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          byteaOutput:
            description: |-
              **enum** (ByteaOutput)
              - `BYTEA_OUTPUT_UNSPECIFIED`
              - `BYTEA_OUTPUT_HEX`
              - `BYTEA_OUTPUT_ESCAPED`
            type: string
            enum:
              - BYTEA_OUTPUT_UNSPECIFIED
              - BYTEA_OUTPUT_HEX
              - BYTEA_OUTPUT_ESCAPED
          xmlbinary:
            description: |-
              **enum** (XmlBinary)
              - `XML_BINARY_UNSPECIFIED`
              - `XML_BINARY_BASE64`
              - `XML_BINARY_HEX`
            type: string
            enum:
              - XML_BINARY_UNSPECIFIED
              - XML_BINARY_BASE64
              - XML_BINARY_HEX
          xmloption:
            description: |-
              **enum** (XmlOption)
              - `XML_OPTION_UNSPECIFIED`
              - `XML_OPTION_DOCUMENT`
              - `XML_OPTION_CONTENT`
            type: string
            enum:
              - XML_OPTION_UNSPECIFIED
              - XML_OPTION_DOCUMENT
              - XML_OPTION_CONTENT
          ginPendingListLimit:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          deadlockTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          maxLocksPerTransaction:
            description: '**string** (int64)'
            type: string
            format: int64
          maxPredLocksPerTransaction:
            description: '**string** (int64)'
            type: string
            format: int64
          arrayNulls:
            description: '**boolean**'
            type: boolean
          backslashQuote:
            description: |-
              **enum** (BackslashQuote)
              - `BACKSLASH_QUOTE_UNSPECIFIED`
              - `BACKSLASH_QUOTE`
              - `BACKSLASH_QUOTE_ON`
              - `BACKSLASH_QUOTE_OFF`
              - `BACKSLASH_QUOTE_SAFE_ENCODING`
            type: string
            enum:
              - BACKSLASH_QUOTE_UNSPECIFIED
              - BACKSLASH_QUOTE
              - BACKSLASH_QUOTE_ON
              - BACKSLASH_QUOTE_OFF
              - BACKSLASH_QUOTE_SAFE_ENCODING
          defaultWithOids:
            description: '**boolean**'
            type: boolean
          escapeStringWarning:
            description: '**boolean**'
            type: boolean
          loCompatPrivileges:
            description: '**boolean**'
            type: boolean
          operatorPrecedenceWarning:
            description: '**boolean**'
            type: boolean
          quoteAllIdentifiers:
            description: '**boolean**'
            type: boolean
          standardConformingStrings:
            description: '**boolean**'
            type: boolean
          synchronizeSeqscans:
            description: '**boolean**'
            type: boolean
          transformNullEquals:
            description: '**boolean**'
            type: boolean
          exitOnError:
            description: '**boolean**'
            type: boolean
          seqPageCost:
            description: '**number** (double)'
            type: number
            format: double
          randomPageCost:
            description: '**number** (double)'
            type: number
            format: double
          sqlInheritance:
            description: |-
              **boolean**
              This option has been removed in PostgreSQL 10.
            type: boolean
          effectiveIoConcurrency:
            description: '**string** (int64)'
            type: string
            format: int64
          effectiveCacheSize:
            description: '**string** (int64)'
            type: string
            format: int64
      PostgresqlHostConfig10_1C:
        type: object
        properties:
          recoveryMinApplyDelay:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          sharedBuffers:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          tempBuffers:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          workMem:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          replacementSortTuples:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          tempFileLimit:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          backendFlushAfter:
            description: '**string** (int64)'
            type: string
            format: int64
          oldSnapshotThreshold:
            description: '**string** (int64)'
            type: string
            format: int64
          maxStandbyStreamingDelay:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          constraintExclusion:
            description: |-
              **enum** (ConstraintExclusion)
              - `CONSTRAINT_EXCLUSION_UNSPECIFIED`
              - `CONSTRAINT_EXCLUSION_ON`
              - `CONSTRAINT_EXCLUSION_OFF`
              - `CONSTRAINT_EXCLUSION_PARTITION`
            type: string
            enum:
              - CONSTRAINT_EXCLUSION_UNSPECIFIED
              - CONSTRAINT_EXCLUSION_ON
              - CONSTRAINT_EXCLUSION_OFF
              - CONSTRAINT_EXCLUSION_PARTITION
          cursorTupleFraction:
            description: '**number** (double)'
            type: number
            format: double
          fromCollapseLimit:
            description: '**string** (int64)'
            type: string
            format: int64
          joinCollapseLimit:
            description: '**string** (int64)'
            type: string
            format: int64
          forceParallelMode:
            description: |-
              **enum** (ForceParallelMode)
              - `FORCE_PARALLEL_MODE_UNSPECIFIED`
              - `FORCE_PARALLEL_MODE_ON`
              - `FORCE_PARALLEL_MODE_OFF`
              - `FORCE_PARALLEL_MODE_REGRESS`
            type: string
            enum:
              - FORCE_PARALLEL_MODE_UNSPECIFIED
              - FORCE_PARALLEL_MODE_ON
              - FORCE_PARALLEL_MODE_OFF
              - FORCE_PARALLEL_MODE_REGRESS
          clientMinMessages:
            description: |-
              **enum** (LogLevel)
              - `LOG_LEVEL_UNSPECIFIED`
              - `LOG_LEVEL_DEBUG5`
              - `LOG_LEVEL_DEBUG4`
              - `LOG_LEVEL_DEBUG3`
              - `LOG_LEVEL_DEBUG2`
              - `LOG_LEVEL_DEBUG1`
              - `LOG_LEVEL_LOG`
              - `LOG_LEVEL_NOTICE`
              - `LOG_LEVEL_WARNING`
              - `LOG_LEVEL_ERROR`
              - `LOG_LEVEL_FATAL`
              - `LOG_LEVEL_PANIC`
            type: string
            enum:
              - LOG_LEVEL_UNSPECIFIED
              - LOG_LEVEL_DEBUG5
              - LOG_LEVEL_DEBUG4
              - LOG_LEVEL_DEBUG3
              - LOG_LEVEL_DEBUG2
              - LOG_LEVEL_DEBUG1
              - LOG_LEVEL_LOG
              - LOG_LEVEL_NOTICE
              - LOG_LEVEL_WARNING
              - LOG_LEVEL_ERROR
              - LOG_LEVEL_FATAL
              - LOG_LEVEL_PANIC
          logMinMessages:
            description: |-
              **enum** (LogLevel)
              - `LOG_LEVEL_UNSPECIFIED`
              - `LOG_LEVEL_DEBUG5`
              - `LOG_LEVEL_DEBUG4`
              - `LOG_LEVEL_DEBUG3`
              - `LOG_LEVEL_DEBUG2`
              - `LOG_LEVEL_DEBUG1`
              - `LOG_LEVEL_LOG`
              - `LOG_LEVEL_NOTICE`
              - `LOG_LEVEL_WARNING`
              - `LOG_LEVEL_ERROR`
              - `LOG_LEVEL_FATAL`
              - `LOG_LEVEL_PANIC`
            type: string
            enum:
              - LOG_LEVEL_UNSPECIFIED
              - LOG_LEVEL_DEBUG5
              - LOG_LEVEL_DEBUG4
              - LOG_LEVEL_DEBUG3
              - LOG_LEVEL_DEBUG2
              - LOG_LEVEL_DEBUG1
              - LOG_LEVEL_LOG
              - LOG_LEVEL_NOTICE
              - LOG_LEVEL_WARNING
              - LOG_LEVEL_ERROR
              - LOG_LEVEL_FATAL
              - LOG_LEVEL_PANIC
          logMinErrorStatement:
            description: |-
              **enum** (LogLevel)
              - `LOG_LEVEL_UNSPECIFIED`
              - `LOG_LEVEL_DEBUG5`
              - `LOG_LEVEL_DEBUG4`
              - `LOG_LEVEL_DEBUG3`
              - `LOG_LEVEL_DEBUG2`
              - `LOG_LEVEL_DEBUG1`
              - `LOG_LEVEL_LOG`
              - `LOG_LEVEL_NOTICE`
              - `LOG_LEVEL_WARNING`
              - `LOG_LEVEL_ERROR`
              - `LOG_LEVEL_FATAL`
              - `LOG_LEVEL_PANIC`
            type: string
            enum:
              - LOG_LEVEL_UNSPECIFIED
              - LOG_LEVEL_DEBUG5
              - LOG_LEVEL_DEBUG4
              - LOG_LEVEL_DEBUG3
              - LOG_LEVEL_DEBUG2
              - LOG_LEVEL_DEBUG1
              - LOG_LEVEL_LOG
              - LOG_LEVEL_NOTICE
              - LOG_LEVEL_WARNING
              - LOG_LEVEL_ERROR
              - LOG_LEVEL_FATAL
              - LOG_LEVEL_PANIC
          logMinDurationStatement:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          logCheckpoints:
            description: '**boolean**'
            type: boolean
          logConnections:
            description: '**boolean**'
            type: boolean
          logDisconnections:
            description: '**boolean**'
            type: boolean
          logDuration:
            description: '**boolean**'
            type: boolean
          logErrorVerbosity:
            description: |-
              **enum** (LogErrorVerbosity)
              - `LOG_ERROR_VERBOSITY_UNSPECIFIED`
              - `LOG_ERROR_VERBOSITY_TERSE`
              - `LOG_ERROR_VERBOSITY_DEFAULT`
              - `LOG_ERROR_VERBOSITY_VERBOSE`
            type: string
            enum:
              - LOG_ERROR_VERBOSITY_UNSPECIFIED
              - LOG_ERROR_VERBOSITY_TERSE
              - LOG_ERROR_VERBOSITY_DEFAULT
              - LOG_ERROR_VERBOSITY_VERBOSE
          logLockWaits:
            description: '**boolean**'
            type: boolean
          logStatement:
            description: |-
              **enum** (LogStatement)
              - `LOG_STATEMENT_UNSPECIFIED`
              - `LOG_STATEMENT_NONE`
              - `LOG_STATEMENT_DDL`
              - `LOG_STATEMENT_MOD`
              - `LOG_STATEMENT_ALL`
            type: string
            enum:
              - LOG_STATEMENT_UNSPECIFIED
              - LOG_STATEMENT_NONE
              - LOG_STATEMENT_DDL
              - LOG_STATEMENT_MOD
              - LOG_STATEMENT_ALL
          logTempFiles:
            description: '**string** (int64)'
            type: string
            format: int64
          searchPath:
            description: '**string**'
            type: string
          rowSecurity:
            description: '**boolean**'
            type: boolean
          defaultTransactionIsolation:
            description: |-
              **enum** (TransactionIsolation)
              - `TRANSACTION_ISOLATION_UNSPECIFIED`
              - `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
              - `TRANSACTION_ISOLATION_READ_COMMITTED`
              - `TRANSACTION_ISOLATION_REPEATABLE_READ`
              - `TRANSACTION_ISOLATION_SERIALIZABLE`
            type: string
            enum:
              - TRANSACTION_ISOLATION_UNSPECIFIED
              - TRANSACTION_ISOLATION_READ_UNCOMMITTED
              - TRANSACTION_ISOLATION_READ_COMMITTED
              - TRANSACTION_ISOLATION_REPEATABLE_READ
              - TRANSACTION_ISOLATION_SERIALIZABLE
          statementTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          lockTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          idleInTransactionSessionTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          byteaOutput:
            description: |-
              **enum** (ByteaOutput)
              - `BYTEA_OUTPUT_UNSPECIFIED`
              - `BYTEA_OUTPUT_HEX`
              - `BYTEA_OUTPUT_ESCAPED`
            type: string
            enum:
              - BYTEA_OUTPUT_UNSPECIFIED
              - BYTEA_OUTPUT_HEX
              - BYTEA_OUTPUT_ESCAPED
          xmlbinary:
            description: |-
              **enum** (XmlBinary)
              - `XML_BINARY_UNSPECIFIED`
              - `XML_BINARY_BASE64`
              - `XML_BINARY_HEX`
            type: string
            enum:
              - XML_BINARY_UNSPECIFIED
              - XML_BINARY_BASE64
              - XML_BINARY_HEX
          xmloption:
            description: |-
              **enum** (XmlOption)
              - `XML_OPTION_UNSPECIFIED`
              - `XML_OPTION_DOCUMENT`
              - `XML_OPTION_CONTENT`
            type: string
            enum:
              - XML_OPTION_UNSPECIFIED
              - XML_OPTION_DOCUMENT
              - XML_OPTION_CONTENT
          ginPendingListLimit:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          deadlockTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          maxLocksPerTransaction:
            description: '**string** (int64)'
            type: string
            format: int64
          maxPredLocksPerTransaction:
            description: '**string** (int64)'
            type: string
            format: int64
          arrayNulls:
            description: '**boolean**'
            type: boolean
          backslashQuote:
            description: |-
              **enum** (BackslashQuote)
              - `BACKSLASH_QUOTE_UNSPECIFIED`
              - `BACKSLASH_QUOTE`
              - `BACKSLASH_QUOTE_ON`
              - `BACKSLASH_QUOTE_OFF`
              - `BACKSLASH_QUOTE_SAFE_ENCODING`
            type: string
            enum:
              - BACKSLASH_QUOTE_UNSPECIFIED
              - BACKSLASH_QUOTE
              - BACKSLASH_QUOTE_ON
              - BACKSLASH_QUOTE_OFF
              - BACKSLASH_QUOTE_SAFE_ENCODING
          defaultWithOids:
            description: '**boolean**'
            type: boolean
          escapeStringWarning:
            description: '**boolean**'
            type: boolean
          loCompatPrivileges:
            description: '**boolean**'
            type: boolean
          operatorPrecedenceWarning:
            description: '**boolean**'
            type: boolean
          quoteAllIdentifiers:
            description: '**boolean**'
            type: boolean
          standardConformingStrings:
            description: '**boolean**'
            type: boolean
          synchronizeSeqscans:
            description: '**boolean**'
            type: boolean
          transformNullEquals:
            description: '**boolean**'
            type: boolean
          exitOnError:
            description: '**boolean**'
            type: boolean
          seqPageCost:
            description: '**number** (double)'
            type: number
            format: double
          randomPageCost:
            description: '**number** (double)'
            type: number
            format: double
          enableBitmapscan:
            description: '**boolean**'
            type: boolean
          enableHashagg:
            description: '**boolean**'
            type: boolean
          enableHashjoin:
            description: '**boolean**'
            type: boolean
          enableIndexscan:
            description: '**boolean**'
            type: boolean
          enableIndexonlyscan:
            description: '**boolean**'
            type: boolean
          enableMaterial:
            description: '**boolean**'
            type: boolean
          enableMergejoin:
            description: '**boolean**'
            type: boolean
          enableNestloop:
            description: '**boolean**'
            type: boolean
          enableSeqscan:
            description: '**boolean**'
            type: boolean
          enableSort:
            description: '**boolean**'
            type: boolean
          enableTidscan:
            description: '**boolean**'
            type: boolean
          maxParallelWorkers:
            description: '**string** (int64)'
            type: string
            format: int64
          maxParallelWorkersPerGather:
            description: '**string** (int64)'
            type: string
            format: int64
          timezone:
            description: '**string**'
            type: string
          effectiveIoConcurrency:
            description: '**string** (int64)'
            type: string
            format: int64
          effectiveCacheSize:
            description: '**string** (int64)'
            type: string
            format: int64
      PostgresqlHostConfig10:
        type: object
        properties:
          recoveryMinApplyDelay:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          sharedBuffers:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          tempBuffers:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          workMem:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          replacementSortTuples:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          tempFileLimit:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          backendFlushAfter:
            description: '**string** (int64)'
            type: string
            format: int64
          oldSnapshotThreshold:
            description: '**string** (int64)'
            type: string
            format: int64
          maxStandbyStreamingDelay:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          constraintExclusion:
            description: |-
              **enum** (ConstraintExclusion)
              - `CONSTRAINT_EXCLUSION_UNSPECIFIED`
              - `CONSTRAINT_EXCLUSION_ON`
              - `CONSTRAINT_EXCLUSION_OFF`
              - `CONSTRAINT_EXCLUSION_PARTITION`
            type: string
            enum:
              - CONSTRAINT_EXCLUSION_UNSPECIFIED
              - CONSTRAINT_EXCLUSION_ON
              - CONSTRAINT_EXCLUSION_OFF
              - CONSTRAINT_EXCLUSION_PARTITION
          cursorTupleFraction:
            description: '**number** (double)'
            type: number
            format: double
          fromCollapseLimit:
            description: '**string** (int64)'
            type: string
            format: int64
          joinCollapseLimit:
            description: '**string** (int64)'
            type: string
            format: int64
          forceParallelMode:
            description: |-
              **enum** (ForceParallelMode)
              - `FORCE_PARALLEL_MODE_UNSPECIFIED`
              - `FORCE_PARALLEL_MODE_ON`
              - `FORCE_PARALLEL_MODE_OFF`
              - `FORCE_PARALLEL_MODE_REGRESS`
            type: string
            enum:
              - FORCE_PARALLEL_MODE_UNSPECIFIED
              - FORCE_PARALLEL_MODE_ON
              - FORCE_PARALLEL_MODE_OFF
              - FORCE_PARALLEL_MODE_REGRESS
          clientMinMessages:
            description: |-
              **enum** (LogLevel)
              - `LOG_LEVEL_UNSPECIFIED`
              - `LOG_LEVEL_DEBUG5`
              - `LOG_LEVEL_DEBUG4`
              - `LOG_LEVEL_DEBUG3`
              - `LOG_LEVEL_DEBUG2`
              - `LOG_LEVEL_DEBUG1`
              - `LOG_LEVEL_LOG`
              - `LOG_LEVEL_NOTICE`
              - `LOG_LEVEL_WARNING`
              - `LOG_LEVEL_ERROR`
              - `LOG_LEVEL_FATAL`
              - `LOG_LEVEL_PANIC`
            type: string
            enum:
              - LOG_LEVEL_UNSPECIFIED
              - LOG_LEVEL_DEBUG5
              - LOG_LEVEL_DEBUG4
              - LOG_LEVEL_DEBUG3
              - LOG_LEVEL_DEBUG2
              - LOG_LEVEL_DEBUG1
              - LOG_LEVEL_LOG
              - LOG_LEVEL_NOTICE
              - LOG_LEVEL_WARNING
              - LOG_LEVEL_ERROR
              - LOG_LEVEL_FATAL
              - LOG_LEVEL_PANIC
          logMinMessages:
            description: |-
              **enum** (LogLevel)
              - `LOG_LEVEL_UNSPECIFIED`
              - `LOG_LEVEL_DEBUG5`
              - `LOG_LEVEL_DEBUG4`
              - `LOG_LEVEL_DEBUG3`
              - `LOG_LEVEL_DEBUG2`
              - `LOG_LEVEL_DEBUG1`
              - `LOG_LEVEL_LOG`
              - `LOG_LEVEL_NOTICE`
              - `LOG_LEVEL_WARNING`
              - `LOG_LEVEL_ERROR`
              - `LOG_LEVEL_FATAL`
              - `LOG_LEVEL_PANIC`
            type: string
            enum:
              - LOG_LEVEL_UNSPECIFIED
              - LOG_LEVEL_DEBUG5
              - LOG_LEVEL_DEBUG4
              - LOG_LEVEL_DEBUG3
              - LOG_LEVEL_DEBUG2
              - LOG_LEVEL_DEBUG1
              - LOG_LEVEL_LOG
              - LOG_LEVEL_NOTICE
              - LOG_LEVEL_WARNING
              - LOG_LEVEL_ERROR
              - LOG_LEVEL_FATAL
              - LOG_LEVEL_PANIC
          logMinErrorStatement:
            description: |-
              **enum** (LogLevel)
              - `LOG_LEVEL_UNSPECIFIED`
              - `LOG_LEVEL_DEBUG5`
              - `LOG_LEVEL_DEBUG4`
              - `LOG_LEVEL_DEBUG3`
              - `LOG_LEVEL_DEBUG2`
              - `LOG_LEVEL_DEBUG1`
              - `LOG_LEVEL_LOG`
              - `LOG_LEVEL_NOTICE`
              - `LOG_LEVEL_WARNING`
              - `LOG_LEVEL_ERROR`
              - `LOG_LEVEL_FATAL`
              - `LOG_LEVEL_PANIC`
            type: string
            enum:
              - LOG_LEVEL_UNSPECIFIED
              - LOG_LEVEL_DEBUG5
              - LOG_LEVEL_DEBUG4
              - LOG_LEVEL_DEBUG3
              - LOG_LEVEL_DEBUG2
              - LOG_LEVEL_DEBUG1
              - LOG_LEVEL_LOG
              - LOG_LEVEL_NOTICE
              - LOG_LEVEL_WARNING
              - LOG_LEVEL_ERROR
              - LOG_LEVEL_FATAL
              - LOG_LEVEL_PANIC
          logMinDurationStatement:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          logCheckpoints:
            description: '**boolean**'
            type: boolean
          logConnections:
            description: '**boolean**'
            type: boolean
          logDisconnections:
            description: '**boolean**'
            type: boolean
          logDuration:
            description: '**boolean**'
            type: boolean
          logErrorVerbosity:
            description: |-
              **enum** (LogErrorVerbosity)
              - `LOG_ERROR_VERBOSITY_UNSPECIFIED`
              - `LOG_ERROR_VERBOSITY_TERSE`
              - `LOG_ERROR_VERBOSITY_DEFAULT`
              - `LOG_ERROR_VERBOSITY_VERBOSE`
            type: string
            enum:
              - LOG_ERROR_VERBOSITY_UNSPECIFIED
              - LOG_ERROR_VERBOSITY_TERSE
              - LOG_ERROR_VERBOSITY_DEFAULT
              - LOG_ERROR_VERBOSITY_VERBOSE
          logLockWaits:
            description: '**boolean**'
            type: boolean
          logStatement:
            description: |-
              **enum** (LogStatement)
              - `LOG_STATEMENT_UNSPECIFIED`
              - `LOG_STATEMENT_NONE`
              - `LOG_STATEMENT_DDL`
              - `LOG_STATEMENT_MOD`
              - `LOG_STATEMENT_ALL`
            type: string
            enum:
              - LOG_STATEMENT_UNSPECIFIED
              - LOG_STATEMENT_NONE
              - LOG_STATEMENT_DDL
              - LOG_STATEMENT_MOD
              - LOG_STATEMENT_ALL
          logTempFiles:
            description: '**string** (int64)'
            type: string
            format: int64
          searchPath:
            description: '**string**'
            type: string
          rowSecurity:
            description: '**boolean**'
            type: boolean
          defaultTransactionIsolation:
            description: |-
              **enum** (TransactionIsolation)
              - `TRANSACTION_ISOLATION_UNSPECIFIED`
              - `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
              - `TRANSACTION_ISOLATION_READ_COMMITTED`
              - `TRANSACTION_ISOLATION_REPEATABLE_READ`
              - `TRANSACTION_ISOLATION_SERIALIZABLE`
            type: string
            enum:
              - TRANSACTION_ISOLATION_UNSPECIFIED
              - TRANSACTION_ISOLATION_READ_UNCOMMITTED
              - TRANSACTION_ISOLATION_READ_COMMITTED
              - TRANSACTION_ISOLATION_REPEATABLE_READ
              - TRANSACTION_ISOLATION_SERIALIZABLE
          statementTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          lockTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          idleInTransactionSessionTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          byteaOutput:
            description: |-
              **enum** (ByteaOutput)
              - `BYTEA_OUTPUT_UNSPECIFIED`
              - `BYTEA_OUTPUT_HEX`
              - `BYTEA_OUTPUT_ESCAPED`
            type: string
            enum:
              - BYTEA_OUTPUT_UNSPECIFIED
              - BYTEA_OUTPUT_HEX
              - BYTEA_OUTPUT_ESCAPED
          xmlbinary:
            description: |-
              **enum** (XmlBinary)
              - `XML_BINARY_UNSPECIFIED`
              - `XML_BINARY_BASE64`
              - `XML_BINARY_HEX`
            type: string
            enum:
              - XML_BINARY_UNSPECIFIED
              - XML_BINARY_BASE64
              - XML_BINARY_HEX
          xmloption:
            description: |-
              **enum** (XmlOption)
              - `XML_OPTION_UNSPECIFIED`
              - `XML_OPTION_DOCUMENT`
              - `XML_OPTION_CONTENT`
            type: string
            enum:
              - XML_OPTION_UNSPECIFIED
              - XML_OPTION_DOCUMENT
              - XML_OPTION_CONTENT
          ginPendingListLimit:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          deadlockTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          maxLocksPerTransaction:
            description: '**string** (int64)'
            type: string
            format: int64
          maxPredLocksPerTransaction:
            description: '**string** (int64)'
            type: string
            format: int64
          arrayNulls:
            description: '**boolean**'
            type: boolean
          backslashQuote:
            description: |-
              **enum** (BackslashQuote)
              - `BACKSLASH_QUOTE_UNSPECIFIED`
              - `BACKSLASH_QUOTE`
              - `BACKSLASH_QUOTE_ON`
              - `BACKSLASH_QUOTE_OFF`
              - `BACKSLASH_QUOTE_SAFE_ENCODING`
            type: string
            enum:
              - BACKSLASH_QUOTE_UNSPECIFIED
              - BACKSLASH_QUOTE
              - BACKSLASH_QUOTE_ON
              - BACKSLASH_QUOTE_OFF
              - BACKSLASH_QUOTE_SAFE_ENCODING
          defaultWithOids:
            description: '**boolean**'
            type: boolean
          escapeStringWarning:
            description: '**boolean**'
            type: boolean
          loCompatPrivileges:
            description: '**boolean**'
            type: boolean
          operatorPrecedenceWarning:
            description: '**boolean**'
            type: boolean
          quoteAllIdentifiers:
            description: '**boolean**'
            type: boolean
          standardConformingStrings:
            description: '**boolean**'
            type: boolean
          synchronizeSeqscans:
            description: '**boolean**'
            type: boolean
          transformNullEquals:
            description: '**boolean**'
            type: boolean
          exitOnError:
            description: '**boolean**'
            type: boolean
          seqPageCost:
            description: '**number** (double)'
            type: number
            format: double
          randomPageCost:
            description: '**number** (double)'
            type: number
            format: double
          enableBitmapscan:
            description: '**boolean**'
            type: boolean
          enableHashagg:
            description: '**boolean**'
            type: boolean
          enableHashjoin:
            description: '**boolean**'
            type: boolean
          enableIndexscan:
            description: '**boolean**'
            type: boolean
          enableIndexonlyscan:
            description: '**boolean**'
            type: boolean
          enableMaterial:
            description: '**boolean**'
            type: boolean
          enableMergejoin:
            description: '**boolean**'
            type: boolean
          enableNestloop:
            description: '**boolean**'
            type: boolean
          enableSeqscan:
            description: '**boolean**'
            type: boolean
          enableSort:
            description: '**boolean**'
            type: boolean
          enableTidscan:
            description: '**boolean**'
            type: boolean
          maxParallelWorkers:
            description: '**string** (int64)'
            type: string
            format: int64
          maxParallelWorkersPerGather:
            description: '**string** (int64)'
            type: string
            format: int64
          timezone:
            description: '**string**'
            type: string
          effectiveIoConcurrency:
            description: '**string** (int64)'
            type: string
            format: int64
          effectiveCacheSize:
            description: '**string** (int64)'
            type: string
            format: int64
      PostgresqlHostConfig11:
        type: object
        properties:
          recoveryMinApplyDelay:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          sharedBuffers:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          tempBuffers:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          workMem:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          tempFileLimit:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          backendFlushAfter:
            description: '**string** (int64)'
            type: string
            format: int64
          oldSnapshotThreshold:
            description: '**string** (int64)'
            type: string
            format: int64
          maxStandbyStreamingDelay:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          constraintExclusion:
            description: |-
              **enum** (ConstraintExclusion)
              - `CONSTRAINT_EXCLUSION_UNSPECIFIED`
              - `CONSTRAINT_EXCLUSION_ON`
              - `CONSTRAINT_EXCLUSION_OFF`
              - `CONSTRAINT_EXCLUSION_PARTITION`
            type: string
            enum:
              - CONSTRAINT_EXCLUSION_UNSPECIFIED
              - CONSTRAINT_EXCLUSION_ON
              - CONSTRAINT_EXCLUSION_OFF
              - CONSTRAINT_EXCLUSION_PARTITION
          cursorTupleFraction:
            description: '**number** (double)'
            type: number
            format: double
          fromCollapseLimit:
            description: '**string** (int64)'
            type: string
            format: int64
          joinCollapseLimit:
            description: '**string** (int64)'
            type: string
            format: int64
          forceParallelMode:
            description: |-
              **enum** (ForceParallelMode)
              - `FORCE_PARALLEL_MODE_UNSPECIFIED`
              - `FORCE_PARALLEL_MODE_ON`
              - `FORCE_PARALLEL_MODE_OFF`
              - `FORCE_PARALLEL_MODE_REGRESS`
            type: string
            enum:
              - FORCE_PARALLEL_MODE_UNSPECIFIED
              - FORCE_PARALLEL_MODE_ON
              - FORCE_PARALLEL_MODE_OFF
              - FORCE_PARALLEL_MODE_REGRESS
          clientMinMessages:
            description: |-
              **enum** (LogLevel)
              - `LOG_LEVEL_UNSPECIFIED`
              - `LOG_LEVEL_DEBUG5`
              - `LOG_LEVEL_DEBUG4`
              - `LOG_LEVEL_DEBUG3`
              - `LOG_LEVEL_DEBUG2`
              - `LOG_LEVEL_DEBUG1`
              - `LOG_LEVEL_LOG`
              - `LOG_LEVEL_NOTICE`
              - `LOG_LEVEL_WARNING`
              - `LOG_LEVEL_ERROR`
              - `LOG_LEVEL_FATAL`
              - `LOG_LEVEL_PANIC`
            type: string
            enum:
              - LOG_LEVEL_UNSPECIFIED
              - LOG_LEVEL_DEBUG5
              - LOG_LEVEL_DEBUG4
              - LOG_LEVEL_DEBUG3
              - LOG_LEVEL_DEBUG2
              - LOG_LEVEL_DEBUG1
              - LOG_LEVEL_LOG
              - LOG_LEVEL_NOTICE
              - LOG_LEVEL_WARNING
              - LOG_LEVEL_ERROR
              - LOG_LEVEL_FATAL
              - LOG_LEVEL_PANIC
          logMinMessages:
            description: |-
              **enum** (LogLevel)
              - `LOG_LEVEL_UNSPECIFIED`
              - `LOG_LEVEL_DEBUG5`
              - `LOG_LEVEL_DEBUG4`
              - `LOG_LEVEL_DEBUG3`
              - `LOG_LEVEL_DEBUG2`
              - `LOG_LEVEL_DEBUG1`
              - `LOG_LEVEL_LOG`
              - `LOG_LEVEL_NOTICE`
              - `LOG_LEVEL_WARNING`
              - `LOG_LEVEL_ERROR`
              - `LOG_LEVEL_FATAL`
              - `LOG_LEVEL_PANIC`
            type: string
            enum:
              - LOG_LEVEL_UNSPECIFIED
              - LOG_LEVEL_DEBUG5
              - LOG_LEVEL_DEBUG4
              - LOG_LEVEL_DEBUG3
              - LOG_LEVEL_DEBUG2
              - LOG_LEVEL_DEBUG1
              - LOG_LEVEL_LOG
              - LOG_LEVEL_NOTICE
              - LOG_LEVEL_WARNING
              - LOG_LEVEL_ERROR
              - LOG_LEVEL_FATAL
              - LOG_LEVEL_PANIC
          logMinErrorStatement:
            description: |-
              **enum** (LogLevel)
              - `LOG_LEVEL_UNSPECIFIED`
              - `LOG_LEVEL_DEBUG5`
              - `LOG_LEVEL_DEBUG4`
              - `LOG_LEVEL_DEBUG3`
              - `LOG_LEVEL_DEBUG2`
              - `LOG_LEVEL_DEBUG1`
              - `LOG_LEVEL_LOG`
              - `LOG_LEVEL_NOTICE`
              - `LOG_LEVEL_WARNING`
              - `LOG_LEVEL_ERROR`
              - `LOG_LEVEL_FATAL`
              - `LOG_LEVEL_PANIC`
            type: string
            enum:
              - LOG_LEVEL_UNSPECIFIED
              - LOG_LEVEL_DEBUG5
              - LOG_LEVEL_DEBUG4
              - LOG_LEVEL_DEBUG3
              - LOG_LEVEL_DEBUG2
              - LOG_LEVEL_DEBUG1
              - LOG_LEVEL_LOG
              - LOG_LEVEL_NOTICE
              - LOG_LEVEL_WARNING
              - LOG_LEVEL_ERROR
              - LOG_LEVEL_FATAL
              - LOG_LEVEL_PANIC
          logMinDurationStatement:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          logCheckpoints:
            description: '**boolean**'
            type: boolean
          logConnections:
            description: '**boolean**'
            type: boolean
          logDisconnections:
            description: '**boolean**'
            type: boolean
          logDuration:
            description: '**boolean**'
            type: boolean
          logErrorVerbosity:
            description: |-
              **enum** (LogErrorVerbosity)
              - `LOG_ERROR_VERBOSITY_UNSPECIFIED`
              - `LOG_ERROR_VERBOSITY_TERSE`
              - `LOG_ERROR_VERBOSITY_DEFAULT`
              - `LOG_ERROR_VERBOSITY_VERBOSE`
            type: string
            enum:
              - LOG_ERROR_VERBOSITY_UNSPECIFIED
              - LOG_ERROR_VERBOSITY_TERSE
              - LOG_ERROR_VERBOSITY_DEFAULT
              - LOG_ERROR_VERBOSITY_VERBOSE
          logLockWaits:
            description: '**boolean**'
            type: boolean
          logStatement:
            description: |-
              **enum** (LogStatement)
              - `LOG_STATEMENT_UNSPECIFIED`
              - `LOG_STATEMENT_NONE`
              - `LOG_STATEMENT_DDL`
              - `LOG_STATEMENT_MOD`
              - `LOG_STATEMENT_ALL`
            type: string
            enum:
              - LOG_STATEMENT_UNSPECIFIED
              - LOG_STATEMENT_NONE
              - LOG_STATEMENT_DDL
              - LOG_STATEMENT_MOD
              - LOG_STATEMENT_ALL
          logTempFiles:
            description: '**string** (int64)'
            type: string
            format: int64
          searchPath:
            description: '**string**'
            type: string
          rowSecurity:
            description: '**boolean**'
            type: boolean
          defaultTransactionIsolation:
            description: |-
              **enum** (TransactionIsolation)
              - `TRANSACTION_ISOLATION_UNSPECIFIED`
              - `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
              - `TRANSACTION_ISOLATION_READ_COMMITTED`
              - `TRANSACTION_ISOLATION_REPEATABLE_READ`
              - `TRANSACTION_ISOLATION_SERIALIZABLE`
            type: string
            enum:
              - TRANSACTION_ISOLATION_UNSPECIFIED
              - TRANSACTION_ISOLATION_READ_UNCOMMITTED
              - TRANSACTION_ISOLATION_READ_COMMITTED
              - TRANSACTION_ISOLATION_REPEATABLE_READ
              - TRANSACTION_ISOLATION_SERIALIZABLE
          statementTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          lockTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          idleInTransactionSessionTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          byteaOutput:
            description: |-
              **enum** (ByteaOutput)
              - `BYTEA_OUTPUT_UNSPECIFIED`
              - `BYTEA_OUTPUT_HEX`
              - `BYTEA_OUTPUT_ESCAPED`
            type: string
            enum:
              - BYTEA_OUTPUT_UNSPECIFIED
              - BYTEA_OUTPUT_HEX
              - BYTEA_OUTPUT_ESCAPED
          xmlbinary:
            description: |-
              **enum** (XmlBinary)
              - `XML_BINARY_UNSPECIFIED`
              - `XML_BINARY_BASE64`
              - `XML_BINARY_HEX`
            type: string
            enum:
              - XML_BINARY_UNSPECIFIED
              - XML_BINARY_BASE64
              - XML_BINARY_HEX
          xmloption:
            description: |-
              **enum** (XmlOption)
              - `XML_OPTION_UNSPECIFIED`
              - `XML_OPTION_DOCUMENT`
              - `XML_OPTION_CONTENT`
            type: string
            enum:
              - XML_OPTION_UNSPECIFIED
              - XML_OPTION_DOCUMENT
              - XML_OPTION_CONTENT
          ginPendingListLimit:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          deadlockTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          maxLocksPerTransaction:
            description: '**string** (int64)'
            type: string
            format: int64
          maxPredLocksPerTransaction:
            description: '**string** (int64)'
            type: string
            format: int64
          arrayNulls:
            description: '**boolean**'
            type: boolean
          backslashQuote:
            description: |-
              **enum** (BackslashQuote)
              - `BACKSLASH_QUOTE_UNSPECIFIED`
              - `BACKSLASH_QUOTE`
              - `BACKSLASH_QUOTE_ON`
              - `BACKSLASH_QUOTE_OFF`
              - `BACKSLASH_QUOTE_SAFE_ENCODING`
            type: string
            enum:
              - BACKSLASH_QUOTE_UNSPECIFIED
              - BACKSLASH_QUOTE
              - BACKSLASH_QUOTE_ON
              - BACKSLASH_QUOTE_OFF
              - BACKSLASH_QUOTE_SAFE_ENCODING
          defaultWithOids:
            description: '**boolean**'
            type: boolean
          escapeStringWarning:
            description: '**boolean**'
            type: boolean
          loCompatPrivileges:
            description: '**boolean**'
            type: boolean
          operatorPrecedenceWarning:
            description: '**boolean**'
            type: boolean
          quoteAllIdentifiers:
            description: '**boolean**'
            type: boolean
          standardConformingStrings:
            description: '**boolean**'
            type: boolean
          synchronizeSeqscans:
            description: '**boolean**'
            type: boolean
          transformNullEquals:
            description: '**boolean**'
            type: boolean
          exitOnError:
            description: '**boolean**'
            type: boolean
          seqPageCost:
            description: '**number** (double)'
            type: number
            format: double
          randomPageCost:
            description: '**number** (double)'
            type: number
            format: double
          enableBitmapscan:
            description: '**boolean**'
            type: boolean
          enableHashagg:
            description: '**boolean**'
            type: boolean
          enableHashjoin:
            description: '**boolean**'
            type: boolean
          enableIndexscan:
            description: '**boolean**'
            type: boolean
          enableIndexonlyscan:
            description: '**boolean**'
            type: boolean
          enableMaterial:
            description: '**boolean**'
            type: boolean
          enableMergejoin:
            description: '**boolean**'
            type: boolean
          enableNestloop:
            description: '**boolean**'
            type: boolean
          enableSeqscan:
            description: '**boolean**'
            type: boolean
          enableSort:
            description: '**boolean**'
            type: boolean
          enableTidscan:
            description: '**boolean**'
            type: boolean
          maxParallelWorkers:
            description: '**string** (int64)'
            type: string
            format: int64
          maxParallelWorkersPerGather:
            description: '**string** (int64)'
            type: string
            format: int64
          timezone:
            description: '**string**'
            type: string
          effectiveIoConcurrency:
            description: '**string** (int64)'
            type: string
            format: int64
          effectiveCacheSize:
            description: '**string** (int64)'
            type: string
            format: int64
      PostgresqlHostConfig11_1C:
        type: object
        properties:
          recoveryMinApplyDelay:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          sharedBuffers:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          tempBuffers:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          workMem:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          tempFileLimit:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          backendFlushAfter:
            description: '**string** (int64)'
            type: string
            format: int64
          oldSnapshotThreshold:
            description: '**string** (int64)'
            type: string
            format: int64
          maxStandbyStreamingDelay:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          constraintExclusion:
            description: |-
              **enum** (ConstraintExclusion)
              - `CONSTRAINT_EXCLUSION_UNSPECIFIED`
              - `CONSTRAINT_EXCLUSION_ON`
              - `CONSTRAINT_EXCLUSION_OFF`
              - `CONSTRAINT_EXCLUSION_PARTITION`
            type: string
            enum:
              - CONSTRAINT_EXCLUSION_UNSPECIFIED
              - CONSTRAINT_EXCLUSION_ON
              - CONSTRAINT_EXCLUSION_OFF
              - CONSTRAINT_EXCLUSION_PARTITION
          cursorTupleFraction:
            description: '**number** (double)'
            type: number
            format: double
          fromCollapseLimit:
            description: '**string** (int64)'
            type: string
            format: int64
          joinCollapseLimit:
            description: '**string** (int64)'
            type: string
            format: int64
          forceParallelMode:
            description: |-
              **enum** (ForceParallelMode)
              - `FORCE_PARALLEL_MODE_UNSPECIFIED`
              - `FORCE_PARALLEL_MODE_ON`
              - `FORCE_PARALLEL_MODE_OFF`
              - `FORCE_PARALLEL_MODE_REGRESS`
            type: string
            enum:
              - FORCE_PARALLEL_MODE_UNSPECIFIED
              - FORCE_PARALLEL_MODE_ON
              - FORCE_PARALLEL_MODE_OFF
              - FORCE_PARALLEL_MODE_REGRESS
          clientMinMessages:
            description: |-
              **enum** (LogLevel)
              - `LOG_LEVEL_UNSPECIFIED`
              - `LOG_LEVEL_DEBUG5`
              - `LOG_LEVEL_DEBUG4`
              - `LOG_LEVEL_DEBUG3`
              - `LOG_LEVEL_DEBUG2`
              - `LOG_LEVEL_DEBUG1`
              - `LOG_LEVEL_LOG`
              - `LOG_LEVEL_NOTICE`
              - `LOG_LEVEL_WARNING`
              - `LOG_LEVEL_ERROR`
              - `LOG_LEVEL_FATAL`
              - `LOG_LEVEL_PANIC`
            type: string
            enum:
              - LOG_LEVEL_UNSPECIFIED
              - LOG_LEVEL_DEBUG5
              - LOG_LEVEL_DEBUG4
              - LOG_LEVEL_DEBUG3
              - LOG_LEVEL_DEBUG2
              - LOG_LEVEL_DEBUG1
              - LOG_LEVEL_LOG
              - LOG_LEVEL_NOTICE
              - LOG_LEVEL_WARNING
              - LOG_LEVEL_ERROR
              - LOG_LEVEL_FATAL
              - LOG_LEVEL_PANIC
          logMinMessages:
            description: |-
              **enum** (LogLevel)
              - `LOG_LEVEL_UNSPECIFIED`
              - `LOG_LEVEL_DEBUG5`
              - `LOG_LEVEL_DEBUG4`
              - `LOG_LEVEL_DEBUG3`
              - `LOG_LEVEL_DEBUG2`
              - `LOG_LEVEL_DEBUG1`
              - `LOG_LEVEL_LOG`
              - `LOG_LEVEL_NOTICE`
              - `LOG_LEVEL_WARNING`
              - `LOG_LEVEL_ERROR`
              - `LOG_LEVEL_FATAL`
              - `LOG_LEVEL_PANIC`
            type: string
            enum:
              - LOG_LEVEL_UNSPECIFIED
              - LOG_LEVEL_DEBUG5
              - LOG_LEVEL_DEBUG4
              - LOG_LEVEL_DEBUG3
              - LOG_LEVEL_DEBUG2
              - LOG_LEVEL_DEBUG1
              - LOG_LEVEL_LOG
              - LOG_LEVEL_NOTICE
              - LOG_LEVEL_WARNING
              - LOG_LEVEL_ERROR
              - LOG_LEVEL_FATAL
              - LOG_LEVEL_PANIC
          logMinErrorStatement:
            description: |-
              **enum** (LogLevel)
              - `LOG_LEVEL_UNSPECIFIED`
              - `LOG_LEVEL_DEBUG5`
              - `LOG_LEVEL_DEBUG4`
              - `LOG_LEVEL_DEBUG3`
              - `LOG_LEVEL_DEBUG2`
              - `LOG_LEVEL_DEBUG1`
              - `LOG_LEVEL_LOG`
              - `LOG_LEVEL_NOTICE`
              - `LOG_LEVEL_WARNING`
              - `LOG_LEVEL_ERROR`
              - `LOG_LEVEL_FATAL`
              - `LOG_LEVEL_PANIC`
            type: string
            enum:
              - LOG_LEVEL_UNSPECIFIED
              - LOG_LEVEL_DEBUG5
              - LOG_LEVEL_DEBUG4
              - LOG_LEVEL_DEBUG3
              - LOG_LEVEL_DEBUG2
              - LOG_LEVEL_DEBUG1
              - LOG_LEVEL_LOG
              - LOG_LEVEL_NOTICE
              - LOG_LEVEL_WARNING
              - LOG_LEVEL_ERROR
              - LOG_LEVEL_FATAL
              - LOG_LEVEL_PANIC
          logMinDurationStatement:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          logCheckpoints:
            description: '**boolean**'
            type: boolean
          logConnections:
            description: '**boolean**'
            type: boolean
          logDisconnections:
            description: '**boolean**'
            type: boolean
          logDuration:
            description: '**boolean**'
            type: boolean
          logErrorVerbosity:
            description: |-
              **enum** (LogErrorVerbosity)
              - `LOG_ERROR_VERBOSITY_UNSPECIFIED`
              - `LOG_ERROR_VERBOSITY_TERSE`
              - `LOG_ERROR_VERBOSITY_DEFAULT`
              - `LOG_ERROR_VERBOSITY_VERBOSE`
            type: string
            enum:
              - LOG_ERROR_VERBOSITY_UNSPECIFIED
              - LOG_ERROR_VERBOSITY_TERSE
              - LOG_ERROR_VERBOSITY_DEFAULT
              - LOG_ERROR_VERBOSITY_VERBOSE
          logLockWaits:
            description: '**boolean**'
            type: boolean
          logStatement:
            description: |-
              **enum** (LogStatement)
              - `LOG_STATEMENT_UNSPECIFIED`
              - `LOG_STATEMENT_NONE`
              - `LOG_STATEMENT_DDL`
              - `LOG_STATEMENT_MOD`
              - `LOG_STATEMENT_ALL`
            type: string
            enum:
              - LOG_STATEMENT_UNSPECIFIED
              - LOG_STATEMENT_NONE
              - LOG_STATEMENT_DDL
              - LOG_STATEMENT_MOD
              - LOG_STATEMENT_ALL
          logTempFiles:
            description: '**string** (int64)'
            type: string
            format: int64
          searchPath:
            description: '**string**'
            type: string
          rowSecurity:
            description: '**boolean**'
            type: boolean
          defaultTransactionIsolation:
            description: |-
              **enum** (TransactionIsolation)
              - `TRANSACTION_ISOLATION_UNSPECIFIED`
              - `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
              - `TRANSACTION_ISOLATION_READ_COMMITTED`
              - `TRANSACTION_ISOLATION_REPEATABLE_READ`
              - `TRANSACTION_ISOLATION_SERIALIZABLE`
            type: string
            enum:
              - TRANSACTION_ISOLATION_UNSPECIFIED
              - TRANSACTION_ISOLATION_READ_UNCOMMITTED
              - TRANSACTION_ISOLATION_READ_COMMITTED
              - TRANSACTION_ISOLATION_REPEATABLE_READ
              - TRANSACTION_ISOLATION_SERIALIZABLE
          statementTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          lockTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          idleInTransactionSessionTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          byteaOutput:
            description: |-
              **enum** (ByteaOutput)
              - `BYTEA_OUTPUT_UNSPECIFIED`
              - `BYTEA_OUTPUT_HEX`
              - `BYTEA_OUTPUT_ESCAPED`
            type: string
            enum:
              - BYTEA_OUTPUT_UNSPECIFIED
              - BYTEA_OUTPUT_HEX
              - BYTEA_OUTPUT_ESCAPED
          xmlbinary:
            description: |-
              **enum** (XmlBinary)
              - `XML_BINARY_UNSPECIFIED`
              - `XML_BINARY_BASE64`
              - `XML_BINARY_HEX`
            type: string
            enum:
              - XML_BINARY_UNSPECIFIED
              - XML_BINARY_BASE64
              - XML_BINARY_HEX
          xmloption:
            description: |-
              **enum** (XmlOption)
              - `XML_OPTION_UNSPECIFIED`
              - `XML_OPTION_DOCUMENT`
              - `XML_OPTION_CONTENT`
            type: string
            enum:
              - XML_OPTION_UNSPECIFIED
              - XML_OPTION_DOCUMENT
              - XML_OPTION_CONTENT
          ginPendingListLimit:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          deadlockTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          maxLocksPerTransaction:
            description: '**string** (int64)'
            type: string
            format: int64
          maxPredLocksPerTransaction:
            description: '**string** (int64)'
            type: string
            format: int64
          arrayNulls:
            description: '**boolean**'
            type: boolean
          backslashQuote:
            description: |-
              **enum** (BackslashQuote)
              - `BACKSLASH_QUOTE_UNSPECIFIED`
              - `BACKSLASH_QUOTE`
              - `BACKSLASH_QUOTE_ON`
              - `BACKSLASH_QUOTE_OFF`
              - `BACKSLASH_QUOTE_SAFE_ENCODING`
            type: string
            enum:
              - BACKSLASH_QUOTE_UNSPECIFIED
              - BACKSLASH_QUOTE
              - BACKSLASH_QUOTE_ON
              - BACKSLASH_QUOTE_OFF
              - BACKSLASH_QUOTE_SAFE_ENCODING
          defaultWithOids:
            description: '**boolean**'
            type: boolean
          escapeStringWarning:
            description: '**boolean**'
            type: boolean
          loCompatPrivileges:
            description: '**boolean**'
            type: boolean
          operatorPrecedenceWarning:
            description: '**boolean**'
            type: boolean
          quoteAllIdentifiers:
            description: '**boolean**'
            type: boolean
          standardConformingStrings:
            description: '**boolean**'
            type: boolean
          synchronizeSeqscans:
            description: '**boolean**'
            type: boolean
          transformNullEquals:
            description: '**boolean**'
            type: boolean
          exitOnError:
            description: '**boolean**'
            type: boolean
          seqPageCost:
            description: '**number** (double)'
            type: number
            format: double
          randomPageCost:
            description: '**number** (double)'
            type: number
            format: double
          enableBitmapscan:
            description: '**boolean**'
            type: boolean
          enableHashagg:
            description: '**boolean**'
            type: boolean
          enableHashjoin:
            description: '**boolean**'
            type: boolean
          enableIndexscan:
            description: '**boolean**'
            type: boolean
          enableIndexonlyscan:
            description: '**boolean**'
            type: boolean
          enableMaterial:
            description: '**boolean**'
            type: boolean
          enableMergejoin:
            description: '**boolean**'
            type: boolean
          enableNestloop:
            description: '**boolean**'
            type: boolean
          enableSeqscan:
            description: '**boolean**'
            type: boolean
          enableSort:
            description: '**boolean**'
            type: boolean
          enableTidscan:
            description: '**boolean**'
            type: boolean
          maxParallelWorkers:
            description: '**string** (int64)'
            type: string
            format: int64
          maxParallelWorkersPerGather:
            description: '**string** (int64)'
            type: string
            format: int64
          timezone:
            description: '**string**'
            type: string
          effectiveIoConcurrency:
            description: '**string** (int64)'
            type: string
            format: int64
          effectiveCacheSize:
            description: '**string** (int64)'
            type: string
            format: int64
      PostgresqlHostConfig12:
        type: object
        properties:
          recoveryMinApplyDelay:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          sharedBuffers:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          tempBuffers:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          workMem:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          tempFileLimit:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          backendFlushAfter:
            description: '**string** (int64)'
            type: string
            format: int64
          oldSnapshotThreshold:
            description: '**string** (int64)'
            type: string
            format: int64
          maxStandbyStreamingDelay:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          constraintExclusion:
            description: |-
              **enum** (ConstraintExclusion)
              - `CONSTRAINT_EXCLUSION_UNSPECIFIED`
              - `CONSTRAINT_EXCLUSION_ON`
              - `CONSTRAINT_EXCLUSION_OFF`
              - `CONSTRAINT_EXCLUSION_PARTITION`
            type: string
            enum:
              - CONSTRAINT_EXCLUSION_UNSPECIFIED
              - CONSTRAINT_EXCLUSION_ON
              - CONSTRAINT_EXCLUSION_OFF
              - CONSTRAINT_EXCLUSION_PARTITION
          cursorTupleFraction:
            description: '**number** (double)'
            type: number
            format: double
          fromCollapseLimit:
            description: '**string** (int64)'
            type: string
            format: int64
          joinCollapseLimit:
            description: '**string** (int64)'
            type: string
            format: int64
          forceParallelMode:
            description: |-
              **enum** (ForceParallelMode)
              - `FORCE_PARALLEL_MODE_UNSPECIFIED`
              - `FORCE_PARALLEL_MODE_ON`
              - `FORCE_PARALLEL_MODE_OFF`
              - `FORCE_PARALLEL_MODE_REGRESS`
            type: string
            enum:
              - FORCE_PARALLEL_MODE_UNSPECIFIED
              - FORCE_PARALLEL_MODE_ON
              - FORCE_PARALLEL_MODE_OFF
              - FORCE_PARALLEL_MODE_REGRESS
          clientMinMessages:
            description: |-
              **enum** (LogLevel)
              - `LOG_LEVEL_UNSPECIFIED`
              - `LOG_LEVEL_DEBUG5`
              - `LOG_LEVEL_DEBUG4`
              - `LOG_LEVEL_DEBUG3`
              - `LOG_LEVEL_DEBUG2`
              - `LOG_LEVEL_DEBUG1`
              - `LOG_LEVEL_LOG`
              - `LOG_LEVEL_NOTICE`
              - `LOG_LEVEL_WARNING`
              - `LOG_LEVEL_ERROR`
              - `LOG_LEVEL_FATAL`
              - `LOG_LEVEL_PANIC`
            type: string
            enum:
              - LOG_LEVEL_UNSPECIFIED
              - LOG_LEVEL_DEBUG5
              - LOG_LEVEL_DEBUG4
              - LOG_LEVEL_DEBUG3
              - LOG_LEVEL_DEBUG2
              - LOG_LEVEL_DEBUG1
              - LOG_LEVEL_LOG
              - LOG_LEVEL_NOTICE
              - LOG_LEVEL_WARNING
              - LOG_LEVEL_ERROR
              - LOG_LEVEL_FATAL
              - LOG_LEVEL_PANIC
          logMinMessages:
            description: |-
              **enum** (LogLevel)
              - `LOG_LEVEL_UNSPECIFIED`
              - `LOG_LEVEL_DEBUG5`
              - `LOG_LEVEL_DEBUG4`
              - `LOG_LEVEL_DEBUG3`
              - `LOG_LEVEL_DEBUG2`
              - `LOG_LEVEL_DEBUG1`
              - `LOG_LEVEL_LOG`
              - `LOG_LEVEL_NOTICE`
              - `LOG_LEVEL_WARNING`
              - `LOG_LEVEL_ERROR`
              - `LOG_LEVEL_FATAL`
              - `LOG_LEVEL_PANIC`
            type: string
            enum:
              - LOG_LEVEL_UNSPECIFIED
              - LOG_LEVEL_DEBUG5
              - LOG_LEVEL_DEBUG4
              - LOG_LEVEL_DEBUG3
              - LOG_LEVEL_DEBUG2
              - LOG_LEVEL_DEBUG1
              - LOG_LEVEL_LOG
              - LOG_LEVEL_NOTICE
              - LOG_LEVEL_WARNING
              - LOG_LEVEL_ERROR
              - LOG_LEVEL_FATAL
              - LOG_LEVEL_PANIC
          logMinErrorStatement:
            description: |-
              **enum** (LogLevel)
              - `LOG_LEVEL_UNSPECIFIED`
              - `LOG_LEVEL_DEBUG5`
              - `LOG_LEVEL_DEBUG4`
              - `LOG_LEVEL_DEBUG3`
              - `LOG_LEVEL_DEBUG2`
              - `LOG_LEVEL_DEBUG1`
              - `LOG_LEVEL_LOG`
              - `LOG_LEVEL_NOTICE`
              - `LOG_LEVEL_WARNING`
              - `LOG_LEVEL_ERROR`
              - `LOG_LEVEL_FATAL`
              - `LOG_LEVEL_PANIC`
            type: string
            enum:
              - LOG_LEVEL_UNSPECIFIED
              - LOG_LEVEL_DEBUG5
              - LOG_LEVEL_DEBUG4
              - LOG_LEVEL_DEBUG3
              - LOG_LEVEL_DEBUG2
              - LOG_LEVEL_DEBUG1
              - LOG_LEVEL_LOG
              - LOG_LEVEL_NOTICE
              - LOG_LEVEL_WARNING
              - LOG_LEVEL_ERROR
              - LOG_LEVEL_FATAL
              - LOG_LEVEL_PANIC
          logMinDurationStatement:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          logCheckpoints:
            description: '**boolean**'
            type: boolean
          logConnections:
            description: '**boolean**'
            type: boolean
          logDisconnections:
            description: '**boolean**'
            type: boolean
          logDuration:
            description: '**boolean**'
            type: boolean
          logErrorVerbosity:
            description: |-
              **enum** (LogErrorVerbosity)
              - `LOG_ERROR_VERBOSITY_UNSPECIFIED`
              - `LOG_ERROR_VERBOSITY_TERSE`
              - `LOG_ERROR_VERBOSITY_DEFAULT`
              - `LOG_ERROR_VERBOSITY_VERBOSE`
            type: string
            enum:
              - LOG_ERROR_VERBOSITY_UNSPECIFIED
              - LOG_ERROR_VERBOSITY_TERSE
              - LOG_ERROR_VERBOSITY_DEFAULT
              - LOG_ERROR_VERBOSITY_VERBOSE
          logLockWaits:
            description: '**boolean**'
            type: boolean
          logStatement:
            description: |-
              **enum** (LogStatement)
              - `LOG_STATEMENT_UNSPECIFIED`
              - `LOG_STATEMENT_NONE`
              - `LOG_STATEMENT_DDL`
              - `LOG_STATEMENT_MOD`
              - `LOG_STATEMENT_ALL`
            type: string
            enum:
              - LOG_STATEMENT_UNSPECIFIED
              - LOG_STATEMENT_NONE
              - LOG_STATEMENT_DDL
              - LOG_STATEMENT_MOD
              - LOG_STATEMENT_ALL
          logTempFiles:
            description: '**string** (int64)'
            type: string
            format: int64
          searchPath:
            description: '**string**'
            type: string
          rowSecurity:
            description: '**boolean**'
            type: boolean
          defaultTransactionIsolation:
            description: |-
              **enum** (TransactionIsolation)
              - `TRANSACTION_ISOLATION_UNSPECIFIED`
              - `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
              - `TRANSACTION_ISOLATION_READ_COMMITTED`
              - `TRANSACTION_ISOLATION_REPEATABLE_READ`
              - `TRANSACTION_ISOLATION_SERIALIZABLE`
            type: string
            enum:
              - TRANSACTION_ISOLATION_UNSPECIFIED
              - TRANSACTION_ISOLATION_READ_UNCOMMITTED
              - TRANSACTION_ISOLATION_READ_COMMITTED
              - TRANSACTION_ISOLATION_REPEATABLE_READ
              - TRANSACTION_ISOLATION_SERIALIZABLE
          statementTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          lockTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          idleInTransactionSessionTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          byteaOutput:
            description: |-
              **enum** (ByteaOutput)
              - `BYTEA_OUTPUT_UNSPECIFIED`
              - `BYTEA_OUTPUT_HEX`
              - `BYTEA_OUTPUT_ESCAPED`
            type: string
            enum:
              - BYTEA_OUTPUT_UNSPECIFIED
              - BYTEA_OUTPUT_HEX
              - BYTEA_OUTPUT_ESCAPED
          xmlbinary:
            description: |-
              **enum** (XmlBinary)
              - `XML_BINARY_UNSPECIFIED`
              - `XML_BINARY_BASE64`
              - `XML_BINARY_HEX`
            type: string
            enum:
              - XML_BINARY_UNSPECIFIED
              - XML_BINARY_BASE64
              - XML_BINARY_HEX
          xmloption:
            description: |-
              **enum** (XmlOption)
              - `XML_OPTION_UNSPECIFIED`
              - `XML_OPTION_DOCUMENT`
              - `XML_OPTION_CONTENT`
            type: string
            enum:
              - XML_OPTION_UNSPECIFIED
              - XML_OPTION_DOCUMENT
              - XML_OPTION_CONTENT
          ginPendingListLimit:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          deadlockTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          maxLocksPerTransaction:
            description: '**string** (int64)'
            type: string
            format: int64
          maxPredLocksPerTransaction:
            description: '**string** (int64)'
            type: string
            format: int64
          arrayNulls:
            description: '**boolean**'
            type: boolean
          backslashQuote:
            description: |-
              **enum** (BackslashQuote)
              - `BACKSLASH_QUOTE_UNSPECIFIED`
              - `BACKSLASH_QUOTE`
              - `BACKSLASH_QUOTE_ON`
              - `BACKSLASH_QUOTE_OFF`
              - `BACKSLASH_QUOTE_SAFE_ENCODING`
            type: string
            enum:
              - BACKSLASH_QUOTE_UNSPECIFIED
              - BACKSLASH_QUOTE
              - BACKSLASH_QUOTE_ON
              - BACKSLASH_QUOTE_OFF
              - BACKSLASH_QUOTE_SAFE_ENCODING
          defaultWithOids:
            description: '**boolean**'
            type: boolean
          escapeStringWarning:
            description: '**boolean**'
            type: boolean
          loCompatPrivileges:
            description: '**boolean**'
            type: boolean
          operatorPrecedenceWarning:
            description: '**boolean**'
            type: boolean
          quoteAllIdentifiers:
            description: '**boolean**'
            type: boolean
          standardConformingStrings:
            description: '**boolean**'
            type: boolean
          synchronizeSeqscans:
            description: '**boolean**'
            type: boolean
          transformNullEquals:
            description: '**boolean**'
            type: boolean
          exitOnError:
            description: '**boolean**'
            type: boolean
          seqPageCost:
            description: '**number** (double)'
            type: number
            format: double
          randomPageCost:
            description: '**number** (double)'
            type: number
            format: double
          enableBitmapscan:
            description: '**boolean**'
            type: boolean
          enableHashagg:
            description: '**boolean**'
            type: boolean
          enableHashjoin:
            description: '**boolean**'
            type: boolean
          enableIndexscan:
            description: '**boolean**'
            type: boolean
          enableIndexonlyscan:
            description: '**boolean**'
            type: boolean
          enableMaterial:
            description: '**boolean**'
            type: boolean
          enableMergejoin:
            description: '**boolean**'
            type: boolean
          enableNestloop:
            description: '**boolean**'
            type: boolean
          enableSeqscan:
            description: '**boolean**'
            type: boolean
          enableSort:
            description: '**boolean**'
            type: boolean
          enableTidscan:
            description: '**boolean**'
            type: boolean
          maxParallelWorkers:
            description: '**string** (int64)'
            type: string
            format: int64
          maxParallelWorkersPerGather:
            description: '**string** (int64)'
            type: string
            format: int64
          timezone:
            description: '**string**'
            type: string
          effectiveIoConcurrency:
            description: '**string** (int64)'
            type: string
            format: int64
          effectiveCacheSize:
            description: '**string** (int64)'
            type: string
            format: int64
      PostgresqlHostConfig12_1C:
        type: object
        properties:
          recoveryMinApplyDelay:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          sharedBuffers:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          tempBuffers:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          workMem:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          tempFileLimit:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          backendFlushAfter:
            description: '**string** (int64)'
            type: string
            format: int64
          oldSnapshotThreshold:
            description: '**string** (int64)'
            type: string
            format: int64
          maxStandbyStreamingDelay:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          constraintExclusion:
            description: |-
              **enum** (ConstraintExclusion)
              - `CONSTRAINT_EXCLUSION_UNSPECIFIED`
              - `CONSTRAINT_EXCLUSION_ON`
              - `CONSTRAINT_EXCLUSION_OFF`
              - `CONSTRAINT_EXCLUSION_PARTITION`
            type: string
            enum:
              - CONSTRAINT_EXCLUSION_UNSPECIFIED
              - CONSTRAINT_EXCLUSION_ON
              - CONSTRAINT_EXCLUSION_OFF
              - CONSTRAINT_EXCLUSION_PARTITION
          cursorTupleFraction:
            description: '**number** (double)'
            type: number
            format: double
          fromCollapseLimit:
            description: '**string** (int64)'
            type: string
            format: int64
          joinCollapseLimit:
            description: '**string** (int64)'
            type: string
            format: int64
          forceParallelMode:
            description: |-
              **enum** (ForceParallelMode)
              - `FORCE_PARALLEL_MODE_UNSPECIFIED`
              - `FORCE_PARALLEL_MODE_ON`
              - `FORCE_PARALLEL_MODE_OFF`
              - `FORCE_PARALLEL_MODE_REGRESS`
            type: string
            enum:
              - FORCE_PARALLEL_MODE_UNSPECIFIED
              - FORCE_PARALLEL_MODE_ON
              - FORCE_PARALLEL_MODE_OFF
              - FORCE_PARALLEL_MODE_REGRESS
          clientMinMessages:
            description: |-
              **enum** (LogLevel)
              - `LOG_LEVEL_UNSPECIFIED`
              - `LOG_LEVEL_DEBUG5`
              - `LOG_LEVEL_DEBUG4`
              - `LOG_LEVEL_DEBUG3`
              - `LOG_LEVEL_DEBUG2`
              - `LOG_LEVEL_DEBUG1`
              - `LOG_LEVEL_LOG`
              - `LOG_LEVEL_NOTICE`
              - `LOG_LEVEL_WARNING`
              - `LOG_LEVEL_ERROR`
              - `LOG_LEVEL_FATAL`
              - `LOG_LEVEL_PANIC`
            type: string
            enum:
              - LOG_LEVEL_UNSPECIFIED
              - LOG_LEVEL_DEBUG5
              - LOG_LEVEL_DEBUG4
              - LOG_LEVEL_DEBUG3
              - LOG_LEVEL_DEBUG2
              - LOG_LEVEL_DEBUG1
              - LOG_LEVEL_LOG
              - LOG_LEVEL_NOTICE
              - LOG_LEVEL_WARNING
              - LOG_LEVEL_ERROR
              - LOG_LEVEL_FATAL
              - LOG_LEVEL_PANIC
          logMinMessages:
            description: |-
              **enum** (LogLevel)
              - `LOG_LEVEL_UNSPECIFIED`
              - `LOG_LEVEL_DEBUG5`
              - `LOG_LEVEL_DEBUG4`
              - `LOG_LEVEL_DEBUG3`
              - `LOG_LEVEL_DEBUG2`
              - `LOG_LEVEL_DEBUG1`
              - `LOG_LEVEL_LOG`
              - `LOG_LEVEL_NOTICE`
              - `LOG_LEVEL_WARNING`
              - `LOG_LEVEL_ERROR`
              - `LOG_LEVEL_FATAL`
              - `LOG_LEVEL_PANIC`
            type: string
            enum:
              - LOG_LEVEL_UNSPECIFIED
              - LOG_LEVEL_DEBUG5
              - LOG_LEVEL_DEBUG4
              - LOG_LEVEL_DEBUG3
              - LOG_LEVEL_DEBUG2
              - LOG_LEVEL_DEBUG1
              - LOG_LEVEL_LOG
              - LOG_LEVEL_NOTICE
              - LOG_LEVEL_WARNING
              - LOG_LEVEL_ERROR
              - LOG_LEVEL_FATAL
              - LOG_LEVEL_PANIC
          logMinErrorStatement:
            description: |-
              **enum** (LogLevel)
              - `LOG_LEVEL_UNSPECIFIED`
              - `LOG_LEVEL_DEBUG5`
              - `LOG_LEVEL_DEBUG4`
              - `LOG_LEVEL_DEBUG3`
              - `LOG_LEVEL_DEBUG2`
              - `LOG_LEVEL_DEBUG1`
              - `LOG_LEVEL_LOG`
              - `LOG_LEVEL_NOTICE`
              - `LOG_LEVEL_WARNING`
              - `LOG_LEVEL_ERROR`
              - `LOG_LEVEL_FATAL`
              - `LOG_LEVEL_PANIC`
            type: string
            enum:
              - LOG_LEVEL_UNSPECIFIED
              - LOG_LEVEL_DEBUG5
              - LOG_LEVEL_DEBUG4
              - LOG_LEVEL_DEBUG3
              - LOG_LEVEL_DEBUG2
              - LOG_LEVEL_DEBUG1
              - LOG_LEVEL_LOG
              - LOG_LEVEL_NOTICE
              - LOG_LEVEL_WARNING
              - LOG_LEVEL_ERROR
              - LOG_LEVEL_FATAL
              - LOG_LEVEL_PANIC
          logMinDurationStatement:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          logCheckpoints:
            description: '**boolean**'
            type: boolean
          logConnections:
            description: '**boolean**'
            type: boolean
          logDisconnections:
            description: '**boolean**'
            type: boolean
          logDuration:
            description: '**boolean**'
            type: boolean
          logErrorVerbosity:
            description: |-
              **enum** (LogErrorVerbosity)
              - `LOG_ERROR_VERBOSITY_UNSPECIFIED`
              - `LOG_ERROR_VERBOSITY_TERSE`
              - `LOG_ERROR_VERBOSITY_DEFAULT`
              - `LOG_ERROR_VERBOSITY_VERBOSE`
            type: string
            enum:
              - LOG_ERROR_VERBOSITY_UNSPECIFIED
              - LOG_ERROR_VERBOSITY_TERSE
              - LOG_ERROR_VERBOSITY_DEFAULT
              - LOG_ERROR_VERBOSITY_VERBOSE
          logLockWaits:
            description: '**boolean**'
            type: boolean
          logStatement:
            description: |-
              **enum** (LogStatement)
              - `LOG_STATEMENT_UNSPECIFIED`
              - `LOG_STATEMENT_NONE`
              - `LOG_STATEMENT_DDL`
              - `LOG_STATEMENT_MOD`
              - `LOG_STATEMENT_ALL`
            type: string
            enum:
              - LOG_STATEMENT_UNSPECIFIED
              - LOG_STATEMENT_NONE
              - LOG_STATEMENT_DDL
              - LOG_STATEMENT_MOD
              - LOG_STATEMENT_ALL
          logTempFiles:
            description: '**string** (int64)'
            type: string
            format: int64
          searchPath:
            description: '**string**'
            type: string
          rowSecurity:
            description: '**boolean**'
            type: boolean
          defaultTransactionIsolation:
            description: |-
              **enum** (TransactionIsolation)
              - `TRANSACTION_ISOLATION_UNSPECIFIED`
              - `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
              - `TRANSACTION_ISOLATION_READ_COMMITTED`
              - `TRANSACTION_ISOLATION_REPEATABLE_READ`
              - `TRANSACTION_ISOLATION_SERIALIZABLE`
            type: string
            enum:
              - TRANSACTION_ISOLATION_UNSPECIFIED
              - TRANSACTION_ISOLATION_READ_UNCOMMITTED
              - TRANSACTION_ISOLATION_READ_COMMITTED
              - TRANSACTION_ISOLATION_REPEATABLE_READ
              - TRANSACTION_ISOLATION_SERIALIZABLE
          statementTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          lockTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          idleInTransactionSessionTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          byteaOutput:
            description: |-
              **enum** (ByteaOutput)
              - `BYTEA_OUTPUT_UNSPECIFIED`
              - `BYTEA_OUTPUT_HEX`
              - `BYTEA_OUTPUT_ESCAPED`
            type: string
            enum:
              - BYTEA_OUTPUT_UNSPECIFIED
              - BYTEA_OUTPUT_HEX
              - BYTEA_OUTPUT_ESCAPED
          xmlbinary:
            description: |-
              **enum** (XmlBinary)
              - `XML_BINARY_UNSPECIFIED`
              - `XML_BINARY_BASE64`
              - `XML_BINARY_HEX`
            type: string
            enum:
              - XML_BINARY_UNSPECIFIED
              - XML_BINARY_BASE64
              - XML_BINARY_HEX
          xmloption:
            description: |-
              **enum** (XmlOption)
              - `XML_OPTION_UNSPECIFIED`
              - `XML_OPTION_DOCUMENT`
              - `XML_OPTION_CONTENT`
            type: string
            enum:
              - XML_OPTION_UNSPECIFIED
              - XML_OPTION_DOCUMENT
              - XML_OPTION_CONTENT
          ginPendingListLimit:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          deadlockTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          maxLocksPerTransaction:
            description: '**string** (int64)'
            type: string
            format: int64
          maxPredLocksPerTransaction:
            description: '**string** (int64)'
            type: string
            format: int64
          arrayNulls:
            description: '**boolean**'
            type: boolean
          backslashQuote:
            description: |-
              **enum** (BackslashQuote)
              - `BACKSLASH_QUOTE_UNSPECIFIED`
              - `BACKSLASH_QUOTE`
              - `BACKSLASH_QUOTE_ON`
              - `BACKSLASH_QUOTE_OFF`
              - `BACKSLASH_QUOTE_SAFE_ENCODING`
            type: string
            enum:
              - BACKSLASH_QUOTE_UNSPECIFIED
              - BACKSLASH_QUOTE
              - BACKSLASH_QUOTE_ON
              - BACKSLASH_QUOTE_OFF
              - BACKSLASH_QUOTE_SAFE_ENCODING
          defaultWithOids:
            description: '**boolean**'
            type: boolean
          escapeStringWarning:
            description: '**boolean**'
            type: boolean
          loCompatPrivileges:
            description: '**boolean**'
            type: boolean
          operatorPrecedenceWarning:
            description: '**boolean**'
            type: boolean
          quoteAllIdentifiers:
            description: '**boolean**'
            type: boolean
          standardConformingStrings:
            description: '**boolean**'
            type: boolean
          synchronizeSeqscans:
            description: '**boolean**'
            type: boolean
          transformNullEquals:
            description: '**boolean**'
            type: boolean
          exitOnError:
            description: '**boolean**'
            type: boolean
          seqPageCost:
            description: '**number** (double)'
            type: number
            format: double
          randomPageCost:
            description: '**number** (double)'
            type: number
            format: double
          enableBitmapscan:
            description: '**boolean**'
            type: boolean
          enableHashagg:
            description: '**boolean**'
            type: boolean
          enableHashjoin:
            description: '**boolean**'
            type: boolean
          enableIndexscan:
            description: '**boolean**'
            type: boolean
          enableIndexonlyscan:
            description: '**boolean**'
            type: boolean
          enableMaterial:
            description: '**boolean**'
            type: boolean
          enableMergejoin:
            description: '**boolean**'
            type: boolean
          enableNestloop:
            description: '**boolean**'
            type: boolean
          enableSeqscan:
            description: '**boolean**'
            type: boolean
          enableSort:
            description: '**boolean**'
            type: boolean
          enableTidscan:
            description: '**boolean**'
            type: boolean
          maxParallelWorkers:
            description: '**string** (int64)'
            type: string
            format: int64
          maxParallelWorkersPerGather:
            description: '**string** (int64)'
            type: string
            format: int64
          timezone:
            description: '**string**'
            type: string
          effectiveIoConcurrency:
            description: '**string** (int64)'
            type: string
            format: int64
          effectiveCacheSize:
            description: '**string** (int64)'
            type: string
            format: int64
      PostgresqlHostConfig13:
        type: object
        properties:
          recoveryMinApplyDelay:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          sharedBuffers:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          tempBuffers:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          workMem:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          tempFileLimit:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          backendFlushAfter:
            description: '**string** (int64)'
            type: string
            format: int64
          oldSnapshotThreshold:
            description: '**string** (int64)'
            type: string
            format: int64
          maxStandbyStreamingDelay:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          constraintExclusion:
            description: |-
              **enum** (ConstraintExclusion)
              - `CONSTRAINT_EXCLUSION_UNSPECIFIED`
              - `CONSTRAINT_EXCLUSION_ON`
              - `CONSTRAINT_EXCLUSION_OFF`
              - `CONSTRAINT_EXCLUSION_PARTITION`
            type: string
            enum:
              - CONSTRAINT_EXCLUSION_UNSPECIFIED
              - CONSTRAINT_EXCLUSION_ON
              - CONSTRAINT_EXCLUSION_OFF
              - CONSTRAINT_EXCLUSION_PARTITION
          cursorTupleFraction:
            description: '**number** (double)'
            type: number
            format: double
          fromCollapseLimit:
            description: '**string** (int64)'
            type: string
            format: int64
          joinCollapseLimit:
            description: '**string** (int64)'
            type: string
            format: int64
          forceParallelMode:
            description: |-
              **enum** (ForceParallelMode)
              - `FORCE_PARALLEL_MODE_UNSPECIFIED`
              - `FORCE_PARALLEL_MODE_ON`
              - `FORCE_PARALLEL_MODE_OFF`
              - `FORCE_PARALLEL_MODE_REGRESS`
            type: string
            enum:
              - FORCE_PARALLEL_MODE_UNSPECIFIED
              - FORCE_PARALLEL_MODE_ON
              - FORCE_PARALLEL_MODE_OFF
              - FORCE_PARALLEL_MODE_REGRESS
          clientMinMessages:
            description: |-
              **enum** (LogLevel)
              - `LOG_LEVEL_UNSPECIFIED`
              - `LOG_LEVEL_DEBUG5`
              - `LOG_LEVEL_DEBUG4`
              - `LOG_LEVEL_DEBUG3`
              - `LOG_LEVEL_DEBUG2`
              - `LOG_LEVEL_DEBUG1`
              - `LOG_LEVEL_LOG`
              - `LOG_LEVEL_NOTICE`
              - `LOG_LEVEL_WARNING`
              - `LOG_LEVEL_ERROR`
              - `LOG_LEVEL_FATAL`
              - `LOG_LEVEL_PANIC`
            type: string
            enum:
              - LOG_LEVEL_UNSPECIFIED
              - LOG_LEVEL_DEBUG5
              - LOG_LEVEL_DEBUG4
              - LOG_LEVEL_DEBUG3
              - LOG_LEVEL_DEBUG2
              - LOG_LEVEL_DEBUG1
              - LOG_LEVEL_LOG
              - LOG_LEVEL_NOTICE
              - LOG_LEVEL_WARNING
              - LOG_LEVEL_ERROR
              - LOG_LEVEL_FATAL
              - LOG_LEVEL_PANIC
          logMinMessages:
            description: |-
              **enum** (LogLevel)
              - `LOG_LEVEL_UNSPECIFIED`
              - `LOG_LEVEL_DEBUG5`
              - `LOG_LEVEL_DEBUG4`
              - `LOG_LEVEL_DEBUG3`
              - `LOG_LEVEL_DEBUG2`
              - `LOG_LEVEL_DEBUG1`
              - `LOG_LEVEL_LOG`
              - `LOG_LEVEL_NOTICE`
              - `LOG_LEVEL_WARNING`
              - `LOG_LEVEL_ERROR`
              - `LOG_LEVEL_FATAL`
              - `LOG_LEVEL_PANIC`
            type: string
            enum:
              - LOG_LEVEL_UNSPECIFIED
              - LOG_LEVEL_DEBUG5
              - LOG_LEVEL_DEBUG4
              - LOG_LEVEL_DEBUG3
              - LOG_LEVEL_DEBUG2
              - LOG_LEVEL_DEBUG1
              - LOG_LEVEL_LOG
              - LOG_LEVEL_NOTICE
              - LOG_LEVEL_WARNING
              - LOG_LEVEL_ERROR
              - LOG_LEVEL_FATAL
              - LOG_LEVEL_PANIC
          logMinErrorStatement:
            description: |-
              **enum** (LogLevel)
              - `LOG_LEVEL_UNSPECIFIED`
              - `LOG_LEVEL_DEBUG5`
              - `LOG_LEVEL_DEBUG4`
              - `LOG_LEVEL_DEBUG3`
              - `LOG_LEVEL_DEBUG2`
              - `LOG_LEVEL_DEBUG1`
              - `LOG_LEVEL_LOG`
              - `LOG_LEVEL_NOTICE`
              - `LOG_LEVEL_WARNING`
              - `LOG_LEVEL_ERROR`
              - `LOG_LEVEL_FATAL`
              - `LOG_LEVEL_PANIC`
            type: string
            enum:
              - LOG_LEVEL_UNSPECIFIED
              - LOG_LEVEL_DEBUG5
              - LOG_LEVEL_DEBUG4
              - LOG_LEVEL_DEBUG3
              - LOG_LEVEL_DEBUG2
              - LOG_LEVEL_DEBUG1
              - LOG_LEVEL_LOG
              - LOG_LEVEL_NOTICE
              - LOG_LEVEL_WARNING
              - LOG_LEVEL_ERROR
              - LOG_LEVEL_FATAL
              - LOG_LEVEL_PANIC
          logMinDurationStatement:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          logCheckpoints:
            description: '**boolean**'
            type: boolean
          logConnections:
            description: '**boolean**'
            type: boolean
          logDisconnections:
            description: '**boolean**'
            type: boolean
          logDuration:
            description: '**boolean**'
            type: boolean
          logErrorVerbosity:
            description: |-
              **enum** (LogErrorVerbosity)
              - `LOG_ERROR_VERBOSITY_UNSPECIFIED`
              - `LOG_ERROR_VERBOSITY_TERSE`
              - `LOG_ERROR_VERBOSITY_DEFAULT`
              - `LOG_ERROR_VERBOSITY_VERBOSE`
            type: string
            enum:
              - LOG_ERROR_VERBOSITY_UNSPECIFIED
              - LOG_ERROR_VERBOSITY_TERSE
              - LOG_ERROR_VERBOSITY_DEFAULT
              - LOG_ERROR_VERBOSITY_VERBOSE
          logLockWaits:
            description: '**boolean**'
            type: boolean
          logStatement:
            description: |-
              **enum** (LogStatement)
              - `LOG_STATEMENT_UNSPECIFIED`
              - `LOG_STATEMENT_NONE`
              - `LOG_STATEMENT_DDL`
              - `LOG_STATEMENT_MOD`
              - `LOG_STATEMENT_ALL`
            type: string
            enum:
              - LOG_STATEMENT_UNSPECIFIED
              - LOG_STATEMENT_NONE
              - LOG_STATEMENT_DDL
              - LOG_STATEMENT_MOD
              - LOG_STATEMENT_ALL
          logTempFiles:
            description: '**string** (int64)'
            type: string
            format: int64
          searchPath:
            description: '**string**'
            type: string
          rowSecurity:
            description: '**boolean**'
            type: boolean
          defaultTransactionIsolation:
            description: |-
              **enum** (TransactionIsolation)
              - `TRANSACTION_ISOLATION_UNSPECIFIED`
              - `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
              - `TRANSACTION_ISOLATION_READ_COMMITTED`
              - `TRANSACTION_ISOLATION_REPEATABLE_READ`
              - `TRANSACTION_ISOLATION_SERIALIZABLE`
            type: string
            enum:
              - TRANSACTION_ISOLATION_UNSPECIFIED
              - TRANSACTION_ISOLATION_READ_UNCOMMITTED
              - TRANSACTION_ISOLATION_READ_COMMITTED
              - TRANSACTION_ISOLATION_REPEATABLE_READ
              - TRANSACTION_ISOLATION_SERIALIZABLE
          statementTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          lockTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          idleInTransactionSessionTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          byteaOutput:
            description: |-
              **enum** (ByteaOutput)
              - `BYTEA_OUTPUT_UNSPECIFIED`
              - `BYTEA_OUTPUT_HEX`
              - `BYTEA_OUTPUT_ESCAPED`
            type: string
            enum:
              - BYTEA_OUTPUT_UNSPECIFIED
              - BYTEA_OUTPUT_HEX
              - BYTEA_OUTPUT_ESCAPED
          xmlbinary:
            description: |-
              **enum** (XmlBinary)
              - `XML_BINARY_UNSPECIFIED`
              - `XML_BINARY_BASE64`
              - `XML_BINARY_HEX`
            type: string
            enum:
              - XML_BINARY_UNSPECIFIED
              - XML_BINARY_BASE64
              - XML_BINARY_HEX
          xmloption:
            description: |-
              **enum** (XmlOption)
              - `XML_OPTION_UNSPECIFIED`
              - `XML_OPTION_DOCUMENT`
              - `XML_OPTION_CONTENT`
            type: string
            enum:
              - XML_OPTION_UNSPECIFIED
              - XML_OPTION_DOCUMENT
              - XML_OPTION_CONTENT
          ginPendingListLimit:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          deadlockTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          maxLocksPerTransaction:
            description: '**string** (int64)'
            type: string
            format: int64
          maxPredLocksPerTransaction:
            description: '**string** (int64)'
            type: string
            format: int64
          arrayNulls:
            description: '**boolean**'
            type: boolean
          backslashQuote:
            description: |-
              **enum** (BackslashQuote)
              - `BACKSLASH_QUOTE_UNSPECIFIED`
              - `BACKSLASH_QUOTE`
              - `BACKSLASH_QUOTE_ON`
              - `BACKSLASH_QUOTE_OFF`
              - `BACKSLASH_QUOTE_SAFE_ENCODING`
            type: string
            enum:
              - BACKSLASH_QUOTE_UNSPECIFIED
              - BACKSLASH_QUOTE
              - BACKSLASH_QUOTE_ON
              - BACKSLASH_QUOTE_OFF
              - BACKSLASH_QUOTE_SAFE_ENCODING
          defaultWithOids:
            description: '**boolean**'
            type: boolean
          escapeStringWarning:
            description: '**boolean**'
            type: boolean
          loCompatPrivileges:
            description: '**boolean**'
            type: boolean
          operatorPrecedenceWarning:
            description: '**boolean**'
            type: boolean
          quoteAllIdentifiers:
            description: '**boolean**'
            type: boolean
          standardConformingStrings:
            description: '**boolean**'
            type: boolean
          synchronizeSeqscans:
            description: '**boolean**'
            type: boolean
          transformNullEquals:
            description: '**boolean**'
            type: boolean
          exitOnError:
            description: '**boolean**'
            type: boolean
          seqPageCost:
            description: '**number** (double)'
            type: number
            format: double
          randomPageCost:
            description: '**number** (double)'
            type: number
            format: double
          enableBitmapscan:
            description: '**boolean**'
            type: boolean
          enableHashagg:
            description: '**boolean**'
            type: boolean
          enableHashjoin:
            description: '**boolean**'
            type: boolean
          enableIndexscan:
            description: '**boolean**'
            type: boolean
          enableIndexonlyscan:
            description: '**boolean**'
            type: boolean
          enableMaterial:
            description: '**boolean**'
            type: boolean
          enableMergejoin:
            description: '**boolean**'
            type: boolean
          enableNestloop:
            description: '**boolean**'
            type: boolean
          enableSeqscan:
            description: '**boolean**'
            type: boolean
          enableSort:
            description: '**boolean**'
            type: boolean
          enableTidscan:
            description: '**boolean**'
            type: boolean
          maxParallelWorkers:
            description: '**string** (int64)'
            type: string
            format: int64
          maxParallelWorkersPerGather:
            description: '**string** (int64)'
            type: string
            format: int64
          timezone:
            description: '**string**'
            type: string
          effectiveIoConcurrency:
            description: '**string** (int64)'
            type: string
            format: int64
          effectiveCacheSize:
            description: '**string** (int64)'
            type: string
            format: int64
      PostgresqlHostConfig13_1C:
        type: object
        properties:
          recoveryMinApplyDelay:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          sharedBuffers:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          tempBuffers:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          workMem:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          tempFileLimit:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          backendFlushAfter:
            description: '**string** (int64)'
            type: string
            format: int64
          oldSnapshotThreshold:
            description: '**string** (int64)'
            type: string
            format: int64
          maxStandbyStreamingDelay:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          constraintExclusion:
            description: |-
              **enum** (ConstraintExclusion)
              - `CONSTRAINT_EXCLUSION_UNSPECIFIED`
              - `CONSTRAINT_EXCLUSION_ON`
              - `CONSTRAINT_EXCLUSION_OFF`
              - `CONSTRAINT_EXCLUSION_PARTITION`
            type: string
            enum:
              - CONSTRAINT_EXCLUSION_UNSPECIFIED
              - CONSTRAINT_EXCLUSION_ON
              - CONSTRAINT_EXCLUSION_OFF
              - CONSTRAINT_EXCLUSION_PARTITION
          cursorTupleFraction:
            description: '**number** (double)'
            type: number
            format: double
          fromCollapseLimit:
            description: '**string** (int64)'
            type: string
            format: int64
          joinCollapseLimit:
            description: '**string** (int64)'
            type: string
            format: int64
          forceParallelMode:
            description: |-
              **enum** (ForceParallelMode)
              - `FORCE_PARALLEL_MODE_UNSPECIFIED`
              - `FORCE_PARALLEL_MODE_ON`
              - `FORCE_PARALLEL_MODE_OFF`
              - `FORCE_PARALLEL_MODE_REGRESS`
            type: string
            enum:
              - FORCE_PARALLEL_MODE_UNSPECIFIED
              - FORCE_PARALLEL_MODE_ON
              - FORCE_PARALLEL_MODE_OFF
              - FORCE_PARALLEL_MODE_REGRESS
          clientMinMessages:
            description: |-
              **enum** (LogLevel)
              - `LOG_LEVEL_UNSPECIFIED`
              - `LOG_LEVEL_DEBUG5`
              - `LOG_LEVEL_DEBUG4`
              - `LOG_LEVEL_DEBUG3`
              - `LOG_LEVEL_DEBUG2`
              - `LOG_LEVEL_DEBUG1`
              - `LOG_LEVEL_LOG`
              - `LOG_LEVEL_NOTICE`
              - `LOG_LEVEL_WARNING`
              - `LOG_LEVEL_ERROR`
              - `LOG_LEVEL_FATAL`
              - `LOG_LEVEL_PANIC`
            type: string
            enum:
              - LOG_LEVEL_UNSPECIFIED
              - LOG_LEVEL_DEBUG5
              - LOG_LEVEL_DEBUG4
              - LOG_LEVEL_DEBUG3
              - LOG_LEVEL_DEBUG2
              - LOG_LEVEL_DEBUG1
              - LOG_LEVEL_LOG
              - LOG_LEVEL_NOTICE
              - LOG_LEVEL_WARNING
              - LOG_LEVEL_ERROR
              - LOG_LEVEL_FATAL
              - LOG_LEVEL_PANIC
          logMinMessages:
            description: |-
              **enum** (LogLevel)
              - `LOG_LEVEL_UNSPECIFIED`
              - `LOG_LEVEL_DEBUG5`
              - `LOG_LEVEL_DEBUG4`
              - `LOG_LEVEL_DEBUG3`
              - `LOG_LEVEL_DEBUG2`
              - `LOG_LEVEL_DEBUG1`
              - `LOG_LEVEL_LOG`
              - `LOG_LEVEL_NOTICE`
              - `LOG_LEVEL_WARNING`
              - `LOG_LEVEL_ERROR`
              - `LOG_LEVEL_FATAL`
              - `LOG_LEVEL_PANIC`
            type: string
            enum:
              - LOG_LEVEL_UNSPECIFIED
              - LOG_LEVEL_DEBUG5
              - LOG_LEVEL_DEBUG4
              - LOG_LEVEL_DEBUG3
              - LOG_LEVEL_DEBUG2
              - LOG_LEVEL_DEBUG1
              - LOG_LEVEL_LOG
              - LOG_LEVEL_NOTICE
              - LOG_LEVEL_WARNING
              - LOG_LEVEL_ERROR
              - LOG_LEVEL_FATAL
              - LOG_LEVEL_PANIC
          logMinErrorStatement:
            description: |-
              **enum** (LogLevel)
              - `LOG_LEVEL_UNSPECIFIED`
              - `LOG_LEVEL_DEBUG5`
              - `LOG_LEVEL_DEBUG4`
              - `LOG_LEVEL_DEBUG3`
              - `LOG_LEVEL_DEBUG2`
              - `LOG_LEVEL_DEBUG1`
              - `LOG_LEVEL_LOG`
              - `LOG_LEVEL_NOTICE`
              - `LOG_LEVEL_WARNING`
              - `LOG_LEVEL_ERROR`
              - `LOG_LEVEL_FATAL`
              - `LOG_LEVEL_PANIC`
            type: string
            enum:
              - LOG_LEVEL_UNSPECIFIED
              - LOG_LEVEL_DEBUG5
              - LOG_LEVEL_DEBUG4
              - LOG_LEVEL_DEBUG3
              - LOG_LEVEL_DEBUG2
              - LOG_LEVEL_DEBUG1
              - LOG_LEVEL_LOG
              - LOG_LEVEL_NOTICE
              - LOG_LEVEL_WARNING
              - LOG_LEVEL_ERROR
              - LOG_LEVEL_FATAL
              - LOG_LEVEL_PANIC
          logMinDurationStatement:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          logCheckpoints:
            description: '**boolean**'
            type: boolean
          logConnections:
            description: '**boolean**'
            type: boolean
          logDisconnections:
            description: '**boolean**'
            type: boolean
          logDuration:
            description: '**boolean**'
            type: boolean
          logErrorVerbosity:
            description: |-
              **enum** (LogErrorVerbosity)
              - `LOG_ERROR_VERBOSITY_UNSPECIFIED`
              - `LOG_ERROR_VERBOSITY_TERSE`
              - `LOG_ERROR_VERBOSITY_DEFAULT`
              - `LOG_ERROR_VERBOSITY_VERBOSE`
            type: string
            enum:
              - LOG_ERROR_VERBOSITY_UNSPECIFIED
              - LOG_ERROR_VERBOSITY_TERSE
              - LOG_ERROR_VERBOSITY_DEFAULT
              - LOG_ERROR_VERBOSITY_VERBOSE
          logLockWaits:
            description: '**boolean**'
            type: boolean
          logStatement:
            description: |-
              **enum** (LogStatement)
              - `LOG_STATEMENT_UNSPECIFIED`
              - `LOG_STATEMENT_NONE`
              - `LOG_STATEMENT_DDL`
              - `LOG_STATEMENT_MOD`
              - `LOG_STATEMENT_ALL`
            type: string
            enum:
              - LOG_STATEMENT_UNSPECIFIED
              - LOG_STATEMENT_NONE
              - LOG_STATEMENT_DDL
              - LOG_STATEMENT_MOD
              - LOG_STATEMENT_ALL
          logTempFiles:
            description: '**string** (int64)'
            type: string
            format: int64
          searchPath:
            description: '**string**'
            type: string
          rowSecurity:
            description: '**boolean**'
            type: boolean
          defaultTransactionIsolation:
            description: |-
              **enum** (TransactionIsolation)
              - `TRANSACTION_ISOLATION_UNSPECIFIED`
              - `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
              - `TRANSACTION_ISOLATION_READ_COMMITTED`
              - `TRANSACTION_ISOLATION_REPEATABLE_READ`
              - `TRANSACTION_ISOLATION_SERIALIZABLE`
            type: string
            enum:
              - TRANSACTION_ISOLATION_UNSPECIFIED
              - TRANSACTION_ISOLATION_READ_UNCOMMITTED
              - TRANSACTION_ISOLATION_READ_COMMITTED
              - TRANSACTION_ISOLATION_REPEATABLE_READ
              - TRANSACTION_ISOLATION_SERIALIZABLE
          statementTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          lockTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          idleInTransactionSessionTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          byteaOutput:
            description: |-
              **enum** (ByteaOutput)
              - `BYTEA_OUTPUT_UNSPECIFIED`
              - `BYTEA_OUTPUT_HEX`
              - `BYTEA_OUTPUT_ESCAPED`
            type: string
            enum:
              - BYTEA_OUTPUT_UNSPECIFIED
              - BYTEA_OUTPUT_HEX
              - BYTEA_OUTPUT_ESCAPED
          xmlbinary:
            description: |-
              **enum** (XmlBinary)
              - `XML_BINARY_UNSPECIFIED`
              - `XML_BINARY_BASE64`
              - `XML_BINARY_HEX`
            type: string
            enum:
              - XML_BINARY_UNSPECIFIED
              - XML_BINARY_BASE64
              - XML_BINARY_HEX
          xmloption:
            description: |-
              **enum** (XmlOption)
              - `XML_OPTION_UNSPECIFIED`
              - `XML_OPTION_DOCUMENT`
              - `XML_OPTION_CONTENT`
            type: string
            enum:
              - XML_OPTION_UNSPECIFIED
              - XML_OPTION_DOCUMENT
              - XML_OPTION_CONTENT
          ginPendingListLimit:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          deadlockTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          maxLocksPerTransaction:
            description: '**string** (int64)'
            type: string
            format: int64
          maxPredLocksPerTransaction:
            description: '**string** (int64)'
            type: string
            format: int64
          arrayNulls:
            description: '**boolean**'
            type: boolean
          backslashQuote:
            description: |-
              **enum** (BackslashQuote)
              - `BACKSLASH_QUOTE_UNSPECIFIED`
              - `BACKSLASH_QUOTE`
              - `BACKSLASH_QUOTE_ON`
              - `BACKSLASH_QUOTE_OFF`
              - `BACKSLASH_QUOTE_SAFE_ENCODING`
            type: string
            enum:
              - BACKSLASH_QUOTE_UNSPECIFIED
              - BACKSLASH_QUOTE
              - BACKSLASH_QUOTE_ON
              - BACKSLASH_QUOTE_OFF
              - BACKSLASH_QUOTE_SAFE_ENCODING
          defaultWithOids:
            description: '**boolean**'
            type: boolean
          escapeStringWarning:
            description: '**boolean**'
            type: boolean
          loCompatPrivileges:
            description: '**boolean**'
            type: boolean
          operatorPrecedenceWarning:
            description: '**boolean**'
            type: boolean
          quoteAllIdentifiers:
            description: '**boolean**'
            type: boolean
          standardConformingStrings:
            description: '**boolean**'
            type: boolean
          synchronizeSeqscans:
            description: '**boolean**'
            type: boolean
          transformNullEquals:
            description: '**boolean**'
            type: boolean
          exitOnError:
            description: '**boolean**'
            type: boolean
          seqPageCost:
            description: '**number** (double)'
            type: number
            format: double
          randomPageCost:
            description: '**number** (double)'
            type: number
            format: double
          enableBitmapscan:
            description: '**boolean**'
            type: boolean
          enableHashagg:
            description: '**boolean**'
            type: boolean
          enableHashjoin:
            description: '**boolean**'
            type: boolean
          enableIndexscan:
            description: '**boolean**'
            type: boolean
          enableIndexonlyscan:
            description: '**boolean**'
            type: boolean
          enableMaterial:
            description: '**boolean**'
            type: boolean
          enableMergejoin:
            description: '**boolean**'
            type: boolean
          enableNestloop:
            description: '**boolean**'
            type: boolean
          enableSeqscan:
            description: '**boolean**'
            type: boolean
          enableSort:
            description: '**boolean**'
            type: boolean
          enableTidscan:
            description: '**boolean**'
            type: boolean
          maxParallelWorkers:
            description: '**string** (int64)'
            type: string
            format: int64
          maxParallelWorkersPerGather:
            description: '**string** (int64)'
            type: string
            format: int64
          timezone:
            description: '**string**'
            type: string
          effectiveIoConcurrency:
            description: '**string** (int64)'
            type: string
            format: int64
          effectiveCacheSize:
            description: '**string** (int64)'
            type: string
            format: int64
      PostgresqlHostConfig14:
        type: object
        properties:
          recoveryMinApplyDelay:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          sharedBuffers:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          tempBuffers:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          workMem:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          tempFileLimit:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          backendFlushAfter:
            description: '**string** (int64)'
            type: string
            format: int64
          oldSnapshotThreshold:
            description: '**string** (int64)'
            type: string
            format: int64
          maxStandbyStreamingDelay:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          constraintExclusion:
            description: |-
              **enum** (ConstraintExclusion)
              - `CONSTRAINT_EXCLUSION_UNSPECIFIED`
              - `CONSTRAINT_EXCLUSION_ON`
              - `CONSTRAINT_EXCLUSION_OFF`
              - `CONSTRAINT_EXCLUSION_PARTITION`
            type: string
            enum:
              - CONSTRAINT_EXCLUSION_UNSPECIFIED
              - CONSTRAINT_EXCLUSION_ON
              - CONSTRAINT_EXCLUSION_OFF
              - CONSTRAINT_EXCLUSION_PARTITION
          cursorTupleFraction:
            description: '**number** (double)'
            type: number
            format: double
          fromCollapseLimit:
            description: '**string** (int64)'
            type: string
            format: int64
          joinCollapseLimit:
            description: '**string** (int64)'
            type: string
            format: int64
          forceParallelMode:
            description: |-
              **enum** (ForceParallelMode)
              - `FORCE_PARALLEL_MODE_UNSPECIFIED`
              - `FORCE_PARALLEL_MODE_ON`
              - `FORCE_PARALLEL_MODE_OFF`
              - `FORCE_PARALLEL_MODE_REGRESS`
            type: string
            enum:
              - FORCE_PARALLEL_MODE_UNSPECIFIED
              - FORCE_PARALLEL_MODE_ON
              - FORCE_PARALLEL_MODE_OFF
              - FORCE_PARALLEL_MODE_REGRESS
          clientMinMessages:
            description: |-
              **enum** (LogLevel)
              - `LOG_LEVEL_UNSPECIFIED`
              - `LOG_LEVEL_DEBUG5`
              - `LOG_LEVEL_DEBUG4`
              - `LOG_LEVEL_DEBUG3`
              - `LOG_LEVEL_DEBUG2`
              - `LOG_LEVEL_DEBUG1`
              - `LOG_LEVEL_LOG`
              - `LOG_LEVEL_NOTICE`
              - `LOG_LEVEL_WARNING`
              - `LOG_LEVEL_ERROR`
              - `LOG_LEVEL_FATAL`
              - `LOG_LEVEL_PANIC`
            type: string
            enum:
              - LOG_LEVEL_UNSPECIFIED
              - LOG_LEVEL_DEBUG5
              - LOG_LEVEL_DEBUG4
              - LOG_LEVEL_DEBUG3
              - LOG_LEVEL_DEBUG2
              - LOG_LEVEL_DEBUG1
              - LOG_LEVEL_LOG
              - LOG_LEVEL_NOTICE
              - LOG_LEVEL_WARNING
              - LOG_LEVEL_ERROR
              - LOG_LEVEL_FATAL
              - LOG_LEVEL_PANIC
          logMinMessages:
            description: |-
              **enum** (LogLevel)
              - `LOG_LEVEL_UNSPECIFIED`
              - `LOG_LEVEL_DEBUG5`
              - `LOG_LEVEL_DEBUG4`
              - `LOG_LEVEL_DEBUG3`
              - `LOG_LEVEL_DEBUG2`
              - `LOG_LEVEL_DEBUG1`
              - `LOG_LEVEL_LOG`
              - `LOG_LEVEL_NOTICE`
              - `LOG_LEVEL_WARNING`
              - `LOG_LEVEL_ERROR`
              - `LOG_LEVEL_FATAL`
              - `LOG_LEVEL_PANIC`
            type: string
            enum:
              - LOG_LEVEL_UNSPECIFIED
              - LOG_LEVEL_DEBUG5
              - LOG_LEVEL_DEBUG4
              - LOG_LEVEL_DEBUG3
              - LOG_LEVEL_DEBUG2
              - LOG_LEVEL_DEBUG1
              - LOG_LEVEL_LOG
              - LOG_LEVEL_NOTICE
              - LOG_LEVEL_WARNING
              - LOG_LEVEL_ERROR
              - LOG_LEVEL_FATAL
              - LOG_LEVEL_PANIC
          logMinErrorStatement:
            description: |-
              **enum** (LogLevel)
              - `LOG_LEVEL_UNSPECIFIED`
              - `LOG_LEVEL_DEBUG5`
              - `LOG_LEVEL_DEBUG4`
              - `LOG_LEVEL_DEBUG3`
              - `LOG_LEVEL_DEBUG2`
              - `LOG_LEVEL_DEBUG1`
              - `LOG_LEVEL_LOG`
              - `LOG_LEVEL_NOTICE`
              - `LOG_LEVEL_WARNING`
              - `LOG_LEVEL_ERROR`
              - `LOG_LEVEL_FATAL`
              - `LOG_LEVEL_PANIC`
            type: string
            enum:
              - LOG_LEVEL_UNSPECIFIED
              - LOG_LEVEL_DEBUG5
              - LOG_LEVEL_DEBUG4
              - LOG_LEVEL_DEBUG3
              - LOG_LEVEL_DEBUG2
              - LOG_LEVEL_DEBUG1
              - LOG_LEVEL_LOG
              - LOG_LEVEL_NOTICE
              - LOG_LEVEL_WARNING
              - LOG_LEVEL_ERROR
              - LOG_LEVEL_FATAL
              - LOG_LEVEL_PANIC
          logMinDurationStatement:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          logCheckpoints:
            description: '**boolean**'
            type: boolean
          logConnections:
            description: '**boolean**'
            type: boolean
          logDisconnections:
            description: '**boolean**'
            type: boolean
          logDuration:
            description: '**boolean**'
            type: boolean
          logErrorVerbosity:
            description: |-
              **enum** (LogErrorVerbosity)
              - `LOG_ERROR_VERBOSITY_UNSPECIFIED`
              - `LOG_ERROR_VERBOSITY_TERSE`
              - `LOG_ERROR_VERBOSITY_DEFAULT`
              - `LOG_ERROR_VERBOSITY_VERBOSE`
            type: string
            enum:
              - LOG_ERROR_VERBOSITY_UNSPECIFIED
              - LOG_ERROR_VERBOSITY_TERSE
              - LOG_ERROR_VERBOSITY_DEFAULT
              - LOG_ERROR_VERBOSITY_VERBOSE
          logLockWaits:
            description: '**boolean**'
            type: boolean
          logStatement:
            description: |-
              **enum** (LogStatement)
              - `LOG_STATEMENT_UNSPECIFIED`
              - `LOG_STATEMENT_NONE`
              - `LOG_STATEMENT_DDL`
              - `LOG_STATEMENT_MOD`
              - `LOG_STATEMENT_ALL`
            type: string
            enum:
              - LOG_STATEMENT_UNSPECIFIED
              - LOG_STATEMENT_NONE
              - LOG_STATEMENT_DDL
              - LOG_STATEMENT_MOD
              - LOG_STATEMENT_ALL
          logTempFiles:
            description: '**string** (int64)'
            type: string
            format: int64
          searchPath:
            description: '**string**'
            type: string
          rowSecurity:
            description: '**boolean**'
            type: boolean
          defaultTransactionIsolation:
            description: |-
              **enum** (TransactionIsolation)
              - `TRANSACTION_ISOLATION_UNSPECIFIED`
              - `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
              - `TRANSACTION_ISOLATION_READ_COMMITTED`
              - `TRANSACTION_ISOLATION_REPEATABLE_READ`
              - `TRANSACTION_ISOLATION_SERIALIZABLE`
            type: string
            enum:
              - TRANSACTION_ISOLATION_UNSPECIFIED
              - TRANSACTION_ISOLATION_READ_UNCOMMITTED
              - TRANSACTION_ISOLATION_READ_COMMITTED
              - TRANSACTION_ISOLATION_REPEATABLE_READ
              - TRANSACTION_ISOLATION_SERIALIZABLE
          statementTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          lockTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          idleInTransactionSessionTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          byteaOutput:
            description: |-
              **enum** (ByteaOutput)
              - `BYTEA_OUTPUT_UNSPECIFIED`
              - `BYTEA_OUTPUT_HEX`
              - `BYTEA_OUTPUT_ESCAPED`
            type: string
            enum:
              - BYTEA_OUTPUT_UNSPECIFIED
              - BYTEA_OUTPUT_HEX
              - BYTEA_OUTPUT_ESCAPED
          xmlbinary:
            description: |-
              **enum** (XmlBinary)
              - `XML_BINARY_UNSPECIFIED`
              - `XML_BINARY_BASE64`
              - `XML_BINARY_HEX`
            type: string
            enum:
              - XML_BINARY_UNSPECIFIED
              - XML_BINARY_BASE64
              - XML_BINARY_HEX
          xmloption:
            description: |-
              **enum** (XmlOption)
              - `XML_OPTION_UNSPECIFIED`
              - `XML_OPTION_DOCUMENT`
              - `XML_OPTION_CONTENT`
            type: string
            enum:
              - XML_OPTION_UNSPECIFIED
              - XML_OPTION_DOCUMENT
              - XML_OPTION_CONTENT
          ginPendingListLimit:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          deadlockTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          maxLocksPerTransaction:
            description: '**string** (int64)'
            type: string
            format: int64
          maxPredLocksPerTransaction:
            description: '**string** (int64)'
            type: string
            format: int64
          arrayNulls:
            description: '**boolean**'
            type: boolean
          backslashQuote:
            description: |-
              **enum** (BackslashQuote)
              - `BACKSLASH_QUOTE_UNSPECIFIED`
              - `BACKSLASH_QUOTE`
              - `BACKSLASH_QUOTE_ON`
              - `BACKSLASH_QUOTE_OFF`
              - `BACKSLASH_QUOTE_SAFE_ENCODING`
            type: string
            enum:
              - BACKSLASH_QUOTE_UNSPECIFIED
              - BACKSLASH_QUOTE
              - BACKSLASH_QUOTE_ON
              - BACKSLASH_QUOTE_OFF
              - BACKSLASH_QUOTE_SAFE_ENCODING
          defaultWithOids:
            description: '**boolean**'
            type: boolean
          escapeStringWarning:
            description: '**boolean**'
            type: boolean
          loCompatPrivileges:
            description: '**boolean**'
            type: boolean
          quoteAllIdentifiers:
            description: '**boolean**'
            type: boolean
          standardConformingStrings:
            description: '**boolean**'
            type: boolean
          synchronizeSeqscans:
            description: '**boolean**'
            type: boolean
          transformNullEquals:
            description: '**boolean**'
            type: boolean
          exitOnError:
            description: '**boolean**'
            type: boolean
          seqPageCost:
            description: '**number** (double)'
            type: number
            format: double
          randomPageCost:
            description: '**number** (double)'
            type: number
            format: double
          enableBitmapscan:
            description: '**boolean**'
            type: boolean
          enableHashagg:
            description: '**boolean**'
            type: boolean
          enableHashjoin:
            description: '**boolean**'
            type: boolean
          enableIndexscan:
            description: '**boolean**'
            type: boolean
          enableIndexonlyscan:
            description: '**boolean**'
            type: boolean
          enableMaterial:
            description: '**boolean**'
            type: boolean
          enableMergejoin:
            description: '**boolean**'
            type: boolean
          enableNestloop:
            description: '**boolean**'
            type: boolean
          enableSeqscan:
            description: '**boolean**'
            type: boolean
          enableSort:
            description: '**boolean**'
            type: boolean
          enableTidscan:
            description: '**boolean**'
            type: boolean
          maxParallelWorkers:
            description: '**string** (int64)'
            type: string
            format: int64
          maxParallelWorkersPerGather:
            description: '**string** (int64)'
            type: string
            format: int64
          timezone:
            description: '**string**'
            type: string
          effectiveIoConcurrency:
            description: '**string** (int64)'
            type: string
            format: int64
          effectiveCacheSize:
            description: '**string** (int64)'
            type: string
            format: int64
      PostgresqlHostConfig14_1C:
        type: object
        properties:
          recoveryMinApplyDelay:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          sharedBuffers:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          tempBuffers:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          workMem:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          tempFileLimit:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          backendFlushAfter:
            description: '**string** (int64)'
            type: string
            format: int64
          oldSnapshotThreshold:
            description: '**string** (int64)'
            type: string
            format: int64
          maxStandbyStreamingDelay:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          constraintExclusion:
            description: |-
              **enum** (ConstraintExclusion)
              - `CONSTRAINT_EXCLUSION_UNSPECIFIED`
              - `CONSTRAINT_EXCLUSION_ON`
              - `CONSTRAINT_EXCLUSION_OFF`
              - `CONSTRAINT_EXCLUSION_PARTITION`
            type: string
            enum:
              - CONSTRAINT_EXCLUSION_UNSPECIFIED
              - CONSTRAINT_EXCLUSION_ON
              - CONSTRAINT_EXCLUSION_OFF
              - CONSTRAINT_EXCLUSION_PARTITION
          cursorTupleFraction:
            description: '**number** (double)'
            type: number
            format: double
          fromCollapseLimit:
            description: '**string** (int64)'
            type: string
            format: int64
          joinCollapseLimit:
            description: '**string** (int64)'
            type: string
            format: int64
          forceParallelMode:
            description: |-
              **enum** (ForceParallelMode)
              - `FORCE_PARALLEL_MODE_UNSPECIFIED`
              - `FORCE_PARALLEL_MODE_ON`
              - `FORCE_PARALLEL_MODE_OFF`
              - `FORCE_PARALLEL_MODE_REGRESS`
            type: string
            enum:
              - FORCE_PARALLEL_MODE_UNSPECIFIED
              - FORCE_PARALLEL_MODE_ON
              - FORCE_PARALLEL_MODE_OFF
              - FORCE_PARALLEL_MODE_REGRESS
          clientMinMessages:
            description: |-
              **enum** (LogLevel)
              - `LOG_LEVEL_UNSPECIFIED`
              - `LOG_LEVEL_DEBUG5`
              - `LOG_LEVEL_DEBUG4`
              - `LOG_LEVEL_DEBUG3`
              - `LOG_LEVEL_DEBUG2`
              - `LOG_LEVEL_DEBUG1`
              - `LOG_LEVEL_LOG`
              - `LOG_LEVEL_NOTICE`
              - `LOG_LEVEL_WARNING`
              - `LOG_LEVEL_ERROR`
              - `LOG_LEVEL_FATAL`
              - `LOG_LEVEL_PANIC`
            type: string
            enum:
              - LOG_LEVEL_UNSPECIFIED
              - LOG_LEVEL_DEBUG5
              - LOG_LEVEL_DEBUG4
              - LOG_LEVEL_DEBUG3
              - LOG_LEVEL_DEBUG2
              - LOG_LEVEL_DEBUG1
              - LOG_LEVEL_LOG
              - LOG_LEVEL_NOTICE
              - LOG_LEVEL_WARNING
              - LOG_LEVEL_ERROR
              - LOG_LEVEL_FATAL
              - LOG_LEVEL_PANIC
          logMinMessages:
            description: |-
              **enum** (LogLevel)
              - `LOG_LEVEL_UNSPECIFIED`
              - `LOG_LEVEL_DEBUG5`
              - `LOG_LEVEL_DEBUG4`
              - `LOG_LEVEL_DEBUG3`
              - `LOG_LEVEL_DEBUG2`
              - `LOG_LEVEL_DEBUG1`
              - `LOG_LEVEL_LOG`
              - `LOG_LEVEL_NOTICE`
              - `LOG_LEVEL_WARNING`
              - `LOG_LEVEL_ERROR`
              - `LOG_LEVEL_FATAL`
              - `LOG_LEVEL_PANIC`
            type: string
            enum:
              - LOG_LEVEL_UNSPECIFIED
              - LOG_LEVEL_DEBUG5
              - LOG_LEVEL_DEBUG4
              - LOG_LEVEL_DEBUG3
              - LOG_LEVEL_DEBUG2
              - LOG_LEVEL_DEBUG1
              - LOG_LEVEL_LOG
              - LOG_LEVEL_NOTICE
              - LOG_LEVEL_WARNING
              - LOG_LEVEL_ERROR
              - LOG_LEVEL_FATAL
              - LOG_LEVEL_PANIC
          logMinErrorStatement:
            description: |-
              **enum** (LogLevel)
              - `LOG_LEVEL_UNSPECIFIED`
              - `LOG_LEVEL_DEBUG5`
              - `LOG_LEVEL_DEBUG4`
              - `LOG_LEVEL_DEBUG3`
              - `LOG_LEVEL_DEBUG2`
              - `LOG_LEVEL_DEBUG1`
              - `LOG_LEVEL_LOG`
              - `LOG_LEVEL_NOTICE`
              - `LOG_LEVEL_WARNING`
              - `LOG_LEVEL_ERROR`
              - `LOG_LEVEL_FATAL`
              - `LOG_LEVEL_PANIC`
            type: string
            enum:
              - LOG_LEVEL_UNSPECIFIED
              - LOG_LEVEL_DEBUG5
              - LOG_LEVEL_DEBUG4
              - LOG_LEVEL_DEBUG3
              - LOG_LEVEL_DEBUG2
              - LOG_LEVEL_DEBUG1
              - LOG_LEVEL_LOG
              - LOG_LEVEL_NOTICE
              - LOG_LEVEL_WARNING
              - LOG_LEVEL_ERROR
              - LOG_LEVEL_FATAL
              - LOG_LEVEL_PANIC
          logMinDurationStatement:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          logCheckpoints:
            description: '**boolean**'
            type: boolean
          logConnections:
            description: '**boolean**'
            type: boolean
          logDisconnections:
            description: '**boolean**'
            type: boolean
          logDuration:
            description: '**boolean**'
            type: boolean
          logErrorVerbosity:
            description: |-
              **enum** (LogErrorVerbosity)
              - `LOG_ERROR_VERBOSITY_UNSPECIFIED`
              - `LOG_ERROR_VERBOSITY_TERSE`
              - `LOG_ERROR_VERBOSITY_DEFAULT`
              - `LOG_ERROR_VERBOSITY_VERBOSE`
            type: string
            enum:
              - LOG_ERROR_VERBOSITY_UNSPECIFIED
              - LOG_ERROR_VERBOSITY_TERSE
              - LOG_ERROR_VERBOSITY_DEFAULT
              - LOG_ERROR_VERBOSITY_VERBOSE
          logLockWaits:
            description: '**boolean**'
            type: boolean
          logStatement:
            description: |-
              **enum** (LogStatement)
              - `LOG_STATEMENT_UNSPECIFIED`
              - `LOG_STATEMENT_NONE`
              - `LOG_STATEMENT_DDL`
              - `LOG_STATEMENT_MOD`
              - `LOG_STATEMENT_ALL`
            type: string
            enum:
              - LOG_STATEMENT_UNSPECIFIED
              - LOG_STATEMENT_NONE
              - LOG_STATEMENT_DDL
              - LOG_STATEMENT_MOD
              - LOG_STATEMENT_ALL
          logTempFiles:
            description: '**string** (int64)'
            type: string
            format: int64
          searchPath:
            description: '**string**'
            type: string
          rowSecurity:
            description: '**boolean**'
            type: boolean
          defaultTransactionIsolation:
            description: |-
              **enum** (TransactionIsolation)
              - `TRANSACTION_ISOLATION_UNSPECIFIED`
              - `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
              - `TRANSACTION_ISOLATION_READ_COMMITTED`
              - `TRANSACTION_ISOLATION_REPEATABLE_READ`
              - `TRANSACTION_ISOLATION_SERIALIZABLE`
            type: string
            enum:
              - TRANSACTION_ISOLATION_UNSPECIFIED
              - TRANSACTION_ISOLATION_READ_UNCOMMITTED
              - TRANSACTION_ISOLATION_READ_COMMITTED
              - TRANSACTION_ISOLATION_REPEATABLE_READ
              - TRANSACTION_ISOLATION_SERIALIZABLE
          statementTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          lockTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          idleInTransactionSessionTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          byteaOutput:
            description: |-
              **enum** (ByteaOutput)
              - `BYTEA_OUTPUT_UNSPECIFIED`
              - `BYTEA_OUTPUT_HEX`
              - `BYTEA_OUTPUT_ESCAPED`
            type: string
            enum:
              - BYTEA_OUTPUT_UNSPECIFIED
              - BYTEA_OUTPUT_HEX
              - BYTEA_OUTPUT_ESCAPED
          xmlbinary:
            description: |-
              **enum** (XmlBinary)
              - `XML_BINARY_UNSPECIFIED`
              - `XML_BINARY_BASE64`
              - `XML_BINARY_HEX`
            type: string
            enum:
              - XML_BINARY_UNSPECIFIED
              - XML_BINARY_BASE64
              - XML_BINARY_HEX
          xmloption:
            description: |-
              **enum** (XmlOption)
              - `XML_OPTION_UNSPECIFIED`
              - `XML_OPTION_DOCUMENT`
              - `XML_OPTION_CONTENT`
            type: string
            enum:
              - XML_OPTION_UNSPECIFIED
              - XML_OPTION_DOCUMENT
              - XML_OPTION_CONTENT
          ginPendingListLimit:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          deadlockTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          maxLocksPerTransaction:
            description: '**string** (int64)'
            type: string
            format: int64
          maxPredLocksPerTransaction:
            description: '**string** (int64)'
            type: string
            format: int64
          arrayNulls:
            description: '**boolean**'
            type: boolean
          backslashQuote:
            description: |-
              **enum** (BackslashQuote)
              - `BACKSLASH_QUOTE_UNSPECIFIED`
              - `BACKSLASH_QUOTE`
              - `BACKSLASH_QUOTE_ON`
              - `BACKSLASH_QUOTE_OFF`
              - `BACKSLASH_QUOTE_SAFE_ENCODING`
            type: string
            enum:
              - BACKSLASH_QUOTE_UNSPECIFIED
              - BACKSLASH_QUOTE
              - BACKSLASH_QUOTE_ON
              - BACKSLASH_QUOTE_OFF
              - BACKSLASH_QUOTE_SAFE_ENCODING
          defaultWithOids:
            description: '**boolean**'
            type: boolean
          escapeStringWarning:
            description: '**boolean**'
            type: boolean
          loCompatPrivileges:
            description: '**boolean**'
            type: boolean
          quoteAllIdentifiers:
            description: '**boolean**'
            type: boolean
          standardConformingStrings:
            description: '**boolean**'
            type: boolean
          synchronizeSeqscans:
            description: '**boolean**'
            type: boolean
          transformNullEquals:
            description: '**boolean**'
            type: boolean
          exitOnError:
            description: '**boolean**'
            type: boolean
          seqPageCost:
            description: '**number** (double)'
            type: number
            format: double
          randomPageCost:
            description: '**number** (double)'
            type: number
            format: double
          enableBitmapscan:
            description: '**boolean**'
            type: boolean
          enableHashagg:
            description: '**boolean**'
            type: boolean
          enableHashjoin:
            description: '**boolean**'
            type: boolean
          enableIndexscan:
            description: '**boolean**'
            type: boolean
          enableIndexonlyscan:
            description: '**boolean**'
            type: boolean
          enableMaterial:
            description: '**boolean**'
            type: boolean
          enableMergejoin:
            description: '**boolean**'
            type: boolean
          enableNestloop:
            description: '**boolean**'
            type: boolean
          enableSeqscan:
            description: '**boolean**'
            type: boolean
          enableSort:
            description: '**boolean**'
            type: boolean
          enableTidscan:
            description: '**boolean**'
            type: boolean
          maxParallelWorkers:
            description: '**string** (int64)'
            type: string
            format: int64
          maxParallelWorkersPerGather:
            description: '**string** (int64)'
            type: string
            format: int64
          timezone:
            description: '**string**'
            type: string
          effectiveIoConcurrency:
            description: '**string** (int64)'
            type: string
            format: int64
          effectiveCacheSize:
            description: '**string** (int64)'
            type: string
            format: int64
      PostgresqlHostConfig15:
        type: object
        properties:
          recoveryMinApplyDelay:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          sharedBuffers:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          tempBuffers:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          workMem:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          tempFileLimit:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          backendFlushAfter:
            description: '**string** (int64)'
            type: string
            format: int64
          oldSnapshotThreshold:
            description: '**string** (int64)'
            type: string
            format: int64
          maxStandbyStreamingDelay:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          constraintExclusion:
            description: |-
              **enum** (ConstraintExclusion)
              - `CONSTRAINT_EXCLUSION_UNSPECIFIED`
              - `CONSTRAINT_EXCLUSION_ON`
              - `CONSTRAINT_EXCLUSION_OFF`
              - `CONSTRAINT_EXCLUSION_PARTITION`
            type: string
            enum:
              - CONSTRAINT_EXCLUSION_UNSPECIFIED
              - CONSTRAINT_EXCLUSION_ON
              - CONSTRAINT_EXCLUSION_OFF
              - CONSTRAINT_EXCLUSION_PARTITION
          cursorTupleFraction:
            description: '**number** (double)'
            type: number
            format: double
          fromCollapseLimit:
            description: '**string** (int64)'
            type: string
            format: int64
          joinCollapseLimit:
            description: '**string** (int64)'
            type: string
            format: int64
          forceParallelMode:
            description: |-
              **enum** (ForceParallelMode)
              - `FORCE_PARALLEL_MODE_UNSPECIFIED`
              - `FORCE_PARALLEL_MODE_ON`
              - `FORCE_PARALLEL_MODE_OFF`
              - `FORCE_PARALLEL_MODE_REGRESS`
            type: string
            enum:
              - FORCE_PARALLEL_MODE_UNSPECIFIED
              - FORCE_PARALLEL_MODE_ON
              - FORCE_PARALLEL_MODE_OFF
              - FORCE_PARALLEL_MODE_REGRESS
          clientMinMessages:
            description: |-
              **enum** (LogLevel)
              - `LOG_LEVEL_UNSPECIFIED`
              - `LOG_LEVEL_DEBUG5`
              - `LOG_LEVEL_DEBUG4`
              - `LOG_LEVEL_DEBUG3`
              - `LOG_LEVEL_DEBUG2`
              - `LOG_LEVEL_DEBUG1`
              - `LOG_LEVEL_LOG`
              - `LOG_LEVEL_NOTICE`
              - `LOG_LEVEL_WARNING`
              - `LOG_LEVEL_ERROR`
              - `LOG_LEVEL_FATAL`
              - `LOG_LEVEL_PANIC`
            type: string
            enum:
              - LOG_LEVEL_UNSPECIFIED
              - LOG_LEVEL_DEBUG5
              - LOG_LEVEL_DEBUG4
              - LOG_LEVEL_DEBUG3
              - LOG_LEVEL_DEBUG2
              - LOG_LEVEL_DEBUG1
              - LOG_LEVEL_LOG
              - LOG_LEVEL_NOTICE
              - LOG_LEVEL_WARNING
              - LOG_LEVEL_ERROR
              - LOG_LEVEL_FATAL
              - LOG_LEVEL_PANIC
          logMinMessages:
            description: |-
              **enum** (LogLevel)
              - `LOG_LEVEL_UNSPECIFIED`
              - `LOG_LEVEL_DEBUG5`
              - `LOG_LEVEL_DEBUG4`
              - `LOG_LEVEL_DEBUG3`
              - `LOG_LEVEL_DEBUG2`
              - `LOG_LEVEL_DEBUG1`
              - `LOG_LEVEL_LOG`
              - `LOG_LEVEL_NOTICE`
              - `LOG_LEVEL_WARNING`
              - `LOG_LEVEL_ERROR`
              - `LOG_LEVEL_FATAL`
              - `LOG_LEVEL_PANIC`
            type: string
            enum:
              - LOG_LEVEL_UNSPECIFIED
              - LOG_LEVEL_DEBUG5
              - LOG_LEVEL_DEBUG4
              - LOG_LEVEL_DEBUG3
              - LOG_LEVEL_DEBUG2
              - LOG_LEVEL_DEBUG1
              - LOG_LEVEL_LOG
              - LOG_LEVEL_NOTICE
              - LOG_LEVEL_WARNING
              - LOG_LEVEL_ERROR
              - LOG_LEVEL_FATAL
              - LOG_LEVEL_PANIC
          logMinErrorStatement:
            description: |-
              **enum** (LogLevel)
              - `LOG_LEVEL_UNSPECIFIED`
              - `LOG_LEVEL_DEBUG5`
              - `LOG_LEVEL_DEBUG4`
              - `LOG_LEVEL_DEBUG3`
              - `LOG_LEVEL_DEBUG2`
              - `LOG_LEVEL_DEBUG1`
              - `LOG_LEVEL_LOG`
              - `LOG_LEVEL_NOTICE`
              - `LOG_LEVEL_WARNING`
              - `LOG_LEVEL_ERROR`
              - `LOG_LEVEL_FATAL`
              - `LOG_LEVEL_PANIC`
            type: string
            enum:
              - LOG_LEVEL_UNSPECIFIED
              - LOG_LEVEL_DEBUG5
              - LOG_LEVEL_DEBUG4
              - LOG_LEVEL_DEBUG3
              - LOG_LEVEL_DEBUG2
              - LOG_LEVEL_DEBUG1
              - LOG_LEVEL_LOG
              - LOG_LEVEL_NOTICE
              - LOG_LEVEL_WARNING
              - LOG_LEVEL_ERROR
              - LOG_LEVEL_FATAL
              - LOG_LEVEL_PANIC
          logMinDurationStatement:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          logCheckpoints:
            description: '**boolean**'
            type: boolean
          logConnections:
            description: '**boolean**'
            type: boolean
          logDisconnections:
            description: '**boolean**'
            type: boolean
          logDuration:
            description: '**boolean**'
            type: boolean
          logErrorVerbosity:
            description: |-
              **enum** (LogErrorVerbosity)
              - `LOG_ERROR_VERBOSITY_UNSPECIFIED`
              - `LOG_ERROR_VERBOSITY_TERSE`
              - `LOG_ERROR_VERBOSITY_DEFAULT`
              - `LOG_ERROR_VERBOSITY_VERBOSE`
            type: string
            enum:
              - LOG_ERROR_VERBOSITY_UNSPECIFIED
              - LOG_ERROR_VERBOSITY_TERSE
              - LOG_ERROR_VERBOSITY_DEFAULT
              - LOG_ERROR_VERBOSITY_VERBOSE
          logLockWaits:
            description: '**boolean**'
            type: boolean
          logStatement:
            description: |-
              **enum** (LogStatement)
              - `LOG_STATEMENT_UNSPECIFIED`
              - `LOG_STATEMENT_NONE`
              - `LOG_STATEMENT_DDL`
              - `LOG_STATEMENT_MOD`
              - `LOG_STATEMENT_ALL`
            type: string
            enum:
              - LOG_STATEMENT_UNSPECIFIED
              - LOG_STATEMENT_NONE
              - LOG_STATEMENT_DDL
              - LOG_STATEMENT_MOD
              - LOG_STATEMENT_ALL
          logTempFiles:
            description: '**string** (int64)'
            type: string
            format: int64
          searchPath:
            description: '**string**'
            type: string
          rowSecurity:
            description: '**boolean**'
            type: boolean
          defaultTransactionIsolation:
            description: |-
              **enum** (TransactionIsolation)
              - `TRANSACTION_ISOLATION_UNSPECIFIED`
              - `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
              - `TRANSACTION_ISOLATION_READ_COMMITTED`
              - `TRANSACTION_ISOLATION_REPEATABLE_READ`
              - `TRANSACTION_ISOLATION_SERIALIZABLE`
            type: string
            enum:
              - TRANSACTION_ISOLATION_UNSPECIFIED
              - TRANSACTION_ISOLATION_READ_UNCOMMITTED
              - TRANSACTION_ISOLATION_READ_COMMITTED
              - TRANSACTION_ISOLATION_REPEATABLE_READ
              - TRANSACTION_ISOLATION_SERIALIZABLE
          statementTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          lockTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          idleInTransactionSessionTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          byteaOutput:
            description: |-
              **enum** (ByteaOutput)
              - `BYTEA_OUTPUT_UNSPECIFIED`
              - `BYTEA_OUTPUT_HEX`
              - `BYTEA_OUTPUT_ESCAPED`
            type: string
            enum:
              - BYTEA_OUTPUT_UNSPECIFIED
              - BYTEA_OUTPUT_HEX
              - BYTEA_OUTPUT_ESCAPED
          xmlbinary:
            description: |-
              **enum** (XmlBinary)
              - `XML_BINARY_UNSPECIFIED`
              - `XML_BINARY_BASE64`
              - `XML_BINARY_HEX`
            type: string
            enum:
              - XML_BINARY_UNSPECIFIED
              - XML_BINARY_BASE64
              - XML_BINARY_HEX
          xmloption:
            description: |-
              **enum** (XmlOption)
              - `XML_OPTION_UNSPECIFIED`
              - `XML_OPTION_DOCUMENT`
              - `XML_OPTION_CONTENT`
            type: string
            enum:
              - XML_OPTION_UNSPECIFIED
              - XML_OPTION_DOCUMENT
              - XML_OPTION_CONTENT
          ginPendingListLimit:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          deadlockTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          maxLocksPerTransaction:
            description: '**string** (int64)'
            type: string
            format: int64
          maxPredLocksPerTransaction:
            description: '**string** (int64)'
            type: string
            format: int64
          arrayNulls:
            description: '**boolean**'
            type: boolean
          backslashQuote:
            description: |-
              **enum** (BackslashQuote)
              - `BACKSLASH_QUOTE_UNSPECIFIED`
              - `BACKSLASH_QUOTE`
              - `BACKSLASH_QUOTE_ON`
              - `BACKSLASH_QUOTE_OFF`
              - `BACKSLASH_QUOTE_SAFE_ENCODING`
            type: string
            enum:
              - BACKSLASH_QUOTE_UNSPECIFIED
              - BACKSLASH_QUOTE
              - BACKSLASH_QUOTE_ON
              - BACKSLASH_QUOTE_OFF
              - BACKSLASH_QUOTE_SAFE_ENCODING
          defaultWithOids:
            description: '**boolean**'
            type: boolean
          escapeStringWarning:
            description: '**boolean**'
            type: boolean
          loCompatPrivileges:
            description: '**boolean**'
            type: boolean
          quoteAllIdentifiers:
            description: '**boolean**'
            type: boolean
          standardConformingStrings:
            description: '**boolean**'
            type: boolean
          synchronizeSeqscans:
            description: '**boolean**'
            type: boolean
          transformNullEquals:
            description: '**boolean**'
            type: boolean
          exitOnError:
            description: '**boolean**'
            type: boolean
          seqPageCost:
            description: '**number** (double)'
            type: number
            format: double
          randomPageCost:
            description: '**number** (double)'
            type: number
            format: double
          enableBitmapscan:
            description: '**boolean**'
            type: boolean
          enableHashagg:
            description: '**boolean**'
            type: boolean
          enableHashjoin:
            description: '**boolean**'
            type: boolean
          enableIndexscan:
            description: '**boolean**'
            type: boolean
          enableIndexonlyscan:
            description: '**boolean**'
            type: boolean
          enableMaterial:
            description: '**boolean**'
            type: boolean
          enableMergejoin:
            description: '**boolean**'
            type: boolean
          enableNestloop:
            description: '**boolean**'
            type: boolean
          enableSeqscan:
            description: '**boolean**'
            type: boolean
          enableSort:
            description: '**boolean**'
            type: boolean
          enableTidscan:
            description: '**boolean**'
            type: boolean
          maxParallelWorkers:
            description: '**string** (int64)'
            type: string
            format: int64
          maxParallelWorkersPerGather:
            description: '**string** (int64)'
            type: string
            format: int64
          timezone:
            description: '**string**'
            type: string
          effectiveIoConcurrency:
            description: '**string** (int64)'
            type: string
            format: int64
          effectiveCacheSize:
            description: '**string** (int64)'
            type: string
            format: int64
      PostgresqlHostConfig15_1C:
        type: object
        properties:
          recoveryMinApplyDelay:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          sharedBuffers:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          tempBuffers:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          workMem:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          tempFileLimit:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          backendFlushAfter:
            description: '**string** (int64)'
            type: string
            format: int64
          oldSnapshotThreshold:
            description: '**string** (int64)'
            type: string
            format: int64
          maxStandbyStreamingDelay:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          constraintExclusion:
            description: |-
              **enum** (ConstraintExclusion)
              - `CONSTRAINT_EXCLUSION_UNSPECIFIED`
              - `CONSTRAINT_EXCLUSION_ON`
              - `CONSTRAINT_EXCLUSION_OFF`
              - `CONSTRAINT_EXCLUSION_PARTITION`
            type: string
            enum:
              - CONSTRAINT_EXCLUSION_UNSPECIFIED
              - CONSTRAINT_EXCLUSION_ON
              - CONSTRAINT_EXCLUSION_OFF
              - CONSTRAINT_EXCLUSION_PARTITION
          cursorTupleFraction:
            description: '**number** (double)'
            type: number
            format: double
          fromCollapseLimit:
            description: '**string** (int64)'
            type: string
            format: int64
          joinCollapseLimit:
            description: '**string** (int64)'
            type: string
            format: int64
          forceParallelMode:
            description: |-
              **enum** (ForceParallelMode)
              - `FORCE_PARALLEL_MODE_UNSPECIFIED`
              - `FORCE_PARALLEL_MODE_ON`
              - `FORCE_PARALLEL_MODE_OFF`
              - `FORCE_PARALLEL_MODE_REGRESS`
            type: string
            enum:
              - FORCE_PARALLEL_MODE_UNSPECIFIED
              - FORCE_PARALLEL_MODE_ON
              - FORCE_PARALLEL_MODE_OFF
              - FORCE_PARALLEL_MODE_REGRESS
          clientMinMessages:
            description: |-
              **enum** (LogLevel)
              - `LOG_LEVEL_UNSPECIFIED`
              - `LOG_LEVEL_DEBUG5`
              - `LOG_LEVEL_DEBUG4`
              - `LOG_LEVEL_DEBUG3`
              - `LOG_LEVEL_DEBUG2`
              - `LOG_LEVEL_DEBUG1`
              - `LOG_LEVEL_LOG`
              - `LOG_LEVEL_NOTICE`
              - `LOG_LEVEL_WARNING`
              - `LOG_LEVEL_ERROR`
              - `LOG_LEVEL_FATAL`
              - `LOG_LEVEL_PANIC`
            type: string
            enum:
              - LOG_LEVEL_UNSPECIFIED
              - LOG_LEVEL_DEBUG5
              - LOG_LEVEL_DEBUG4
              - LOG_LEVEL_DEBUG3
              - LOG_LEVEL_DEBUG2
              - LOG_LEVEL_DEBUG1
              - LOG_LEVEL_LOG
              - LOG_LEVEL_NOTICE
              - LOG_LEVEL_WARNING
              - LOG_LEVEL_ERROR
              - LOG_LEVEL_FATAL
              - LOG_LEVEL_PANIC
          logMinMessages:
            description: |-
              **enum** (LogLevel)
              - `LOG_LEVEL_UNSPECIFIED`
              - `LOG_LEVEL_DEBUG5`
              - `LOG_LEVEL_DEBUG4`
              - `LOG_LEVEL_DEBUG3`
              - `LOG_LEVEL_DEBUG2`
              - `LOG_LEVEL_DEBUG1`
              - `LOG_LEVEL_LOG`
              - `LOG_LEVEL_NOTICE`
              - `LOG_LEVEL_WARNING`
              - `LOG_LEVEL_ERROR`
              - `LOG_LEVEL_FATAL`
              - `LOG_LEVEL_PANIC`
            type: string
            enum:
              - LOG_LEVEL_UNSPECIFIED
              - LOG_LEVEL_DEBUG5
              - LOG_LEVEL_DEBUG4
              - LOG_LEVEL_DEBUG3
              - LOG_LEVEL_DEBUG2
              - LOG_LEVEL_DEBUG1
              - LOG_LEVEL_LOG
              - LOG_LEVEL_NOTICE
              - LOG_LEVEL_WARNING
              - LOG_LEVEL_ERROR
              - LOG_LEVEL_FATAL
              - LOG_LEVEL_PANIC
          logMinErrorStatement:
            description: |-
              **enum** (LogLevel)
              - `LOG_LEVEL_UNSPECIFIED`
              - `LOG_LEVEL_DEBUG5`
              - `LOG_LEVEL_DEBUG4`
              - `LOG_LEVEL_DEBUG3`
              - `LOG_LEVEL_DEBUG2`
              - `LOG_LEVEL_DEBUG1`
              - `LOG_LEVEL_LOG`
              - `LOG_LEVEL_NOTICE`
              - `LOG_LEVEL_WARNING`
              - `LOG_LEVEL_ERROR`
              - `LOG_LEVEL_FATAL`
              - `LOG_LEVEL_PANIC`
            type: string
            enum:
              - LOG_LEVEL_UNSPECIFIED
              - LOG_LEVEL_DEBUG5
              - LOG_LEVEL_DEBUG4
              - LOG_LEVEL_DEBUG3
              - LOG_LEVEL_DEBUG2
              - LOG_LEVEL_DEBUG1
              - LOG_LEVEL_LOG
              - LOG_LEVEL_NOTICE
              - LOG_LEVEL_WARNING
              - LOG_LEVEL_ERROR
              - LOG_LEVEL_FATAL
              - LOG_LEVEL_PANIC
          logMinDurationStatement:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          logCheckpoints:
            description: '**boolean**'
            type: boolean
          logConnections:
            description: '**boolean**'
            type: boolean
          logDisconnections:
            description: '**boolean**'
            type: boolean
          logDuration:
            description: '**boolean**'
            type: boolean
          logErrorVerbosity:
            description: |-
              **enum** (LogErrorVerbosity)
              - `LOG_ERROR_VERBOSITY_UNSPECIFIED`
              - `LOG_ERROR_VERBOSITY_TERSE`
              - `LOG_ERROR_VERBOSITY_DEFAULT`
              - `LOG_ERROR_VERBOSITY_VERBOSE`
            type: string
            enum:
              - LOG_ERROR_VERBOSITY_UNSPECIFIED
              - LOG_ERROR_VERBOSITY_TERSE
              - LOG_ERROR_VERBOSITY_DEFAULT
              - LOG_ERROR_VERBOSITY_VERBOSE
          logLockWaits:
            description: '**boolean**'
            type: boolean
          logStatement:
            description: |-
              **enum** (LogStatement)
              - `LOG_STATEMENT_UNSPECIFIED`
              - `LOG_STATEMENT_NONE`
              - `LOG_STATEMENT_DDL`
              - `LOG_STATEMENT_MOD`
              - `LOG_STATEMENT_ALL`
            type: string
            enum:
              - LOG_STATEMENT_UNSPECIFIED
              - LOG_STATEMENT_NONE
              - LOG_STATEMENT_DDL
              - LOG_STATEMENT_MOD
              - LOG_STATEMENT_ALL
          logTempFiles:
            description: '**string** (int64)'
            type: string
            format: int64
          searchPath:
            description: '**string**'
            type: string
          rowSecurity:
            description: '**boolean**'
            type: boolean
          defaultTransactionIsolation:
            description: |-
              **enum** (TransactionIsolation)
              - `TRANSACTION_ISOLATION_UNSPECIFIED`
              - `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
              - `TRANSACTION_ISOLATION_READ_COMMITTED`
              - `TRANSACTION_ISOLATION_REPEATABLE_READ`
              - `TRANSACTION_ISOLATION_SERIALIZABLE`
            type: string
            enum:
              - TRANSACTION_ISOLATION_UNSPECIFIED
              - TRANSACTION_ISOLATION_READ_UNCOMMITTED
              - TRANSACTION_ISOLATION_READ_COMMITTED
              - TRANSACTION_ISOLATION_REPEATABLE_READ
              - TRANSACTION_ISOLATION_SERIALIZABLE
          statementTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          lockTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          idleInTransactionSessionTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          byteaOutput:
            description: |-
              **enum** (ByteaOutput)
              - `BYTEA_OUTPUT_UNSPECIFIED`
              - `BYTEA_OUTPUT_HEX`
              - `BYTEA_OUTPUT_ESCAPED`
            type: string
            enum:
              - BYTEA_OUTPUT_UNSPECIFIED
              - BYTEA_OUTPUT_HEX
              - BYTEA_OUTPUT_ESCAPED
          xmlbinary:
            description: |-
              **enum** (XmlBinary)
              - `XML_BINARY_UNSPECIFIED`
              - `XML_BINARY_BASE64`
              - `XML_BINARY_HEX`
            type: string
            enum:
              - XML_BINARY_UNSPECIFIED
              - XML_BINARY_BASE64
              - XML_BINARY_HEX
          xmloption:
            description: |-
              **enum** (XmlOption)
              - `XML_OPTION_UNSPECIFIED`
              - `XML_OPTION_DOCUMENT`
              - `XML_OPTION_CONTENT`
            type: string
            enum:
              - XML_OPTION_UNSPECIFIED
              - XML_OPTION_DOCUMENT
              - XML_OPTION_CONTENT
          ginPendingListLimit:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          deadlockTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          maxLocksPerTransaction:
            description: '**string** (int64)'
            type: string
            format: int64
          maxPredLocksPerTransaction:
            description: '**string** (int64)'
            type: string
            format: int64
          arrayNulls:
            description: '**boolean**'
            type: boolean
          backslashQuote:
            description: |-
              **enum** (BackslashQuote)
              - `BACKSLASH_QUOTE_UNSPECIFIED`
              - `BACKSLASH_QUOTE`
              - `BACKSLASH_QUOTE_ON`
              - `BACKSLASH_QUOTE_OFF`
              - `BACKSLASH_QUOTE_SAFE_ENCODING`
            type: string
            enum:
              - BACKSLASH_QUOTE_UNSPECIFIED
              - BACKSLASH_QUOTE
              - BACKSLASH_QUOTE_ON
              - BACKSLASH_QUOTE_OFF
              - BACKSLASH_QUOTE_SAFE_ENCODING
          defaultWithOids:
            description: '**boolean**'
            type: boolean
          escapeStringWarning:
            description: '**boolean**'
            type: boolean
          loCompatPrivileges:
            description: '**boolean**'
            type: boolean
          quoteAllIdentifiers:
            description: '**boolean**'
            type: boolean
          standardConformingStrings:
            description: '**boolean**'
            type: boolean
          synchronizeSeqscans:
            description: '**boolean**'
            type: boolean
          transformNullEquals:
            description: '**boolean**'
            type: boolean
          exitOnError:
            description: '**boolean**'
            type: boolean
          seqPageCost:
            description: '**number** (double)'
            type: number
            format: double
          randomPageCost:
            description: '**number** (double)'
            type: number
            format: double
          enableBitmapscan:
            description: '**boolean**'
            type: boolean
          enableHashagg:
            description: '**boolean**'
            type: boolean
          enableHashjoin:
            description: '**boolean**'
            type: boolean
          enableIndexscan:
            description: '**boolean**'
            type: boolean
          enableIndexonlyscan:
            description: '**boolean**'
            type: boolean
          enableMaterial:
            description: '**boolean**'
            type: boolean
          enableMergejoin:
            description: '**boolean**'
            type: boolean
          enableNestloop:
            description: '**boolean**'
            type: boolean
          enableSeqscan:
            description: '**boolean**'
            type: boolean
          enableSort:
            description: '**boolean**'
            type: boolean
          enableTidscan:
            description: '**boolean**'
            type: boolean
          maxParallelWorkers:
            description: '**string** (int64)'
            type: string
            format: int64
          maxParallelWorkersPerGather:
            description: '**string** (int64)'
            type: string
            format: int64
          timezone:
            description: '**string**'
            type: string
          effectiveIoConcurrency:
            description: '**string** (int64)'
            type: string
            format: int64
          effectiveCacheSize:
            description: '**string** (int64)'
            type: string
            format: int64
      PostgresqlHostConfig16:
        type: object
        properties:
          recoveryMinApplyDelay:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          sharedBuffers:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          tempBuffers:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          workMem:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          tempFileLimit:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          backendFlushAfter:
            description: '**string** (int64)'
            type: string
            format: int64
          oldSnapshotThreshold:
            description: '**string** (int64)'
            type: string
            format: int64
          maxStandbyStreamingDelay:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          constraintExclusion:
            description: |-
              **enum** (ConstraintExclusion)
              - `CONSTRAINT_EXCLUSION_UNSPECIFIED`
              - `CONSTRAINT_EXCLUSION_ON`
              - `CONSTRAINT_EXCLUSION_OFF`
              - `CONSTRAINT_EXCLUSION_PARTITION`
            type: string
            enum:
              - CONSTRAINT_EXCLUSION_UNSPECIFIED
              - CONSTRAINT_EXCLUSION_ON
              - CONSTRAINT_EXCLUSION_OFF
              - CONSTRAINT_EXCLUSION_PARTITION
          cursorTupleFraction:
            description: '**number** (double)'
            type: number
            format: double
          fromCollapseLimit:
            description: '**string** (int64)'
            type: string
            format: int64
          joinCollapseLimit:
            description: '**string** (int64)'
            type: string
            format: int64
          debugParallelQuery:
            description: |-
              **enum** (DebugParallelQuery)
              - `DEBUG_PARALLEL_QUERY_UNSPECIFIED`
              - `DEBUG_PARALLEL_QUERY_ON`
              - `DEBUG_PARALLEL_QUERY_OFF`
              - `DEBUG_PARALLEL_QUERY_REGRESS`
            type: string
            enum:
              - DEBUG_PARALLEL_QUERY_UNSPECIFIED
              - DEBUG_PARALLEL_QUERY_ON
              - DEBUG_PARALLEL_QUERY_OFF
              - DEBUG_PARALLEL_QUERY_REGRESS
          clientMinMessages:
            description: |-
              **enum** (LogLevel)
              - `LOG_LEVEL_UNSPECIFIED`
              - `LOG_LEVEL_DEBUG5`
              - `LOG_LEVEL_DEBUG4`
              - `LOG_LEVEL_DEBUG3`
              - `LOG_LEVEL_DEBUG2`
              - `LOG_LEVEL_DEBUG1`
              - `LOG_LEVEL_LOG`
              - `LOG_LEVEL_NOTICE`
              - `LOG_LEVEL_WARNING`
              - `LOG_LEVEL_ERROR`
              - `LOG_LEVEL_FATAL`
              - `LOG_LEVEL_PANIC`
            type: string
            enum:
              - LOG_LEVEL_UNSPECIFIED
              - LOG_LEVEL_DEBUG5
              - LOG_LEVEL_DEBUG4
              - LOG_LEVEL_DEBUG3
              - LOG_LEVEL_DEBUG2
              - LOG_LEVEL_DEBUG1
              - LOG_LEVEL_LOG
              - LOG_LEVEL_NOTICE
              - LOG_LEVEL_WARNING
              - LOG_LEVEL_ERROR
              - LOG_LEVEL_FATAL
              - LOG_LEVEL_PANIC
          logMinMessages:
            description: |-
              **enum** (LogLevel)
              - `LOG_LEVEL_UNSPECIFIED`
              - `LOG_LEVEL_DEBUG5`
              - `LOG_LEVEL_DEBUG4`
              - `LOG_LEVEL_DEBUG3`
              - `LOG_LEVEL_DEBUG2`
              - `LOG_LEVEL_DEBUG1`
              - `LOG_LEVEL_LOG`
              - `LOG_LEVEL_NOTICE`
              - `LOG_LEVEL_WARNING`
              - `LOG_LEVEL_ERROR`
              - `LOG_LEVEL_FATAL`
              - `LOG_LEVEL_PANIC`
            type: string
            enum:
              - LOG_LEVEL_UNSPECIFIED
              - LOG_LEVEL_DEBUG5
              - LOG_LEVEL_DEBUG4
              - LOG_LEVEL_DEBUG3
              - LOG_LEVEL_DEBUG2
              - LOG_LEVEL_DEBUG1
              - LOG_LEVEL_LOG
              - LOG_LEVEL_NOTICE
              - LOG_LEVEL_WARNING
              - LOG_LEVEL_ERROR
              - LOG_LEVEL_FATAL
              - LOG_LEVEL_PANIC
          logMinErrorStatement:
            description: |-
              **enum** (LogLevel)
              - `LOG_LEVEL_UNSPECIFIED`
              - `LOG_LEVEL_DEBUG5`
              - `LOG_LEVEL_DEBUG4`
              - `LOG_LEVEL_DEBUG3`
              - `LOG_LEVEL_DEBUG2`
              - `LOG_LEVEL_DEBUG1`
              - `LOG_LEVEL_LOG`
              - `LOG_LEVEL_NOTICE`
              - `LOG_LEVEL_WARNING`
              - `LOG_LEVEL_ERROR`
              - `LOG_LEVEL_FATAL`
              - `LOG_LEVEL_PANIC`
            type: string
            enum:
              - LOG_LEVEL_UNSPECIFIED
              - LOG_LEVEL_DEBUG5
              - LOG_LEVEL_DEBUG4
              - LOG_LEVEL_DEBUG3
              - LOG_LEVEL_DEBUG2
              - LOG_LEVEL_DEBUG1
              - LOG_LEVEL_LOG
              - LOG_LEVEL_NOTICE
              - LOG_LEVEL_WARNING
              - LOG_LEVEL_ERROR
              - LOG_LEVEL_FATAL
              - LOG_LEVEL_PANIC
          logMinDurationStatement:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          logCheckpoints:
            description: '**boolean**'
            type: boolean
          logConnections:
            description: '**boolean**'
            type: boolean
          logDisconnections:
            description: '**boolean**'
            type: boolean
          logDuration:
            description: '**boolean**'
            type: boolean
          logErrorVerbosity:
            description: |-
              **enum** (LogErrorVerbosity)
              - `LOG_ERROR_VERBOSITY_UNSPECIFIED`
              - `LOG_ERROR_VERBOSITY_TERSE`
              - `LOG_ERROR_VERBOSITY_DEFAULT`
              - `LOG_ERROR_VERBOSITY_VERBOSE`
            type: string
            enum:
              - LOG_ERROR_VERBOSITY_UNSPECIFIED
              - LOG_ERROR_VERBOSITY_TERSE
              - LOG_ERROR_VERBOSITY_DEFAULT
              - LOG_ERROR_VERBOSITY_VERBOSE
          logLockWaits:
            description: '**boolean**'
            type: boolean
          logStatement:
            description: |-
              **enum** (LogStatement)
              - `LOG_STATEMENT_UNSPECIFIED`
              - `LOG_STATEMENT_NONE`
              - `LOG_STATEMENT_DDL`
              - `LOG_STATEMENT_MOD`
              - `LOG_STATEMENT_ALL`
            type: string
            enum:
              - LOG_STATEMENT_UNSPECIFIED
              - LOG_STATEMENT_NONE
              - LOG_STATEMENT_DDL
              - LOG_STATEMENT_MOD
              - LOG_STATEMENT_ALL
          logTempFiles:
            description: '**string** (int64)'
            type: string
            format: int64
          searchPath:
            description: '**string**'
            type: string
          rowSecurity:
            description: '**boolean**'
            type: boolean
          defaultTransactionIsolation:
            description: |-
              **enum** (TransactionIsolation)
              - `TRANSACTION_ISOLATION_UNSPECIFIED`
              - `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
              - `TRANSACTION_ISOLATION_READ_COMMITTED`
              - `TRANSACTION_ISOLATION_REPEATABLE_READ`
              - `TRANSACTION_ISOLATION_SERIALIZABLE`
            type: string
            enum:
              - TRANSACTION_ISOLATION_UNSPECIFIED
              - TRANSACTION_ISOLATION_READ_UNCOMMITTED
              - TRANSACTION_ISOLATION_READ_COMMITTED
              - TRANSACTION_ISOLATION_REPEATABLE_READ
              - TRANSACTION_ISOLATION_SERIALIZABLE
          statementTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          lockTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          idleInTransactionSessionTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          byteaOutput:
            description: |-
              **enum** (ByteaOutput)
              - `BYTEA_OUTPUT_UNSPECIFIED`
              - `BYTEA_OUTPUT_HEX`
              - `BYTEA_OUTPUT_ESCAPED`
            type: string
            enum:
              - BYTEA_OUTPUT_UNSPECIFIED
              - BYTEA_OUTPUT_HEX
              - BYTEA_OUTPUT_ESCAPED
          xmlbinary:
            description: |-
              **enum** (XmlBinary)
              - `XML_BINARY_UNSPECIFIED`
              - `XML_BINARY_BASE64`
              - `XML_BINARY_HEX`
            type: string
            enum:
              - XML_BINARY_UNSPECIFIED
              - XML_BINARY_BASE64
              - XML_BINARY_HEX
          xmloption:
            description: |-
              **enum** (XmlOption)
              - `XML_OPTION_UNSPECIFIED`
              - `XML_OPTION_DOCUMENT`
              - `XML_OPTION_CONTENT`
            type: string
            enum:
              - XML_OPTION_UNSPECIFIED
              - XML_OPTION_DOCUMENT
              - XML_OPTION_CONTENT
          ginPendingListLimit:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          deadlockTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          maxLocksPerTransaction:
            description: '**string** (int64)'
            type: string
            format: int64
          maxPredLocksPerTransaction:
            description: '**string** (int64)'
            type: string
            format: int64
          arrayNulls:
            description: '**boolean**'
            type: boolean
          backslashQuote:
            description: |-
              **enum** (BackslashQuote)
              - `BACKSLASH_QUOTE_UNSPECIFIED`
              - `BACKSLASH_QUOTE`
              - `BACKSLASH_QUOTE_ON`
              - `BACKSLASH_QUOTE_OFF`
              - `BACKSLASH_QUOTE_SAFE_ENCODING`
            type: string
            enum:
              - BACKSLASH_QUOTE_UNSPECIFIED
              - BACKSLASH_QUOTE
              - BACKSLASH_QUOTE_ON
              - BACKSLASH_QUOTE_OFF
              - BACKSLASH_QUOTE_SAFE_ENCODING
          defaultWithOids:
            description: '**boolean**'
            type: boolean
          escapeStringWarning:
            description: '**boolean**'
            type: boolean
          loCompatPrivileges:
            description: '**boolean**'
            type: boolean
          quoteAllIdentifiers:
            description: '**boolean**'
            type: boolean
          standardConformingStrings:
            description: '**boolean**'
            type: boolean
          synchronizeSeqscans:
            description: '**boolean**'
            type: boolean
          transformNullEquals:
            description: '**boolean**'
            type: boolean
          exitOnError:
            description: '**boolean**'
            type: boolean
          seqPageCost:
            description: '**number** (double)'
            type: number
            format: double
          randomPageCost:
            description: '**number** (double)'
            type: number
            format: double
          enableBitmapscan:
            description: '**boolean**'
            type: boolean
          enableHashagg:
            description: '**boolean**'
            type: boolean
          enableHashjoin:
            description: '**boolean**'
            type: boolean
          enableIndexscan:
            description: '**boolean**'
            type: boolean
          enableIndexonlyscan:
            description: '**boolean**'
            type: boolean
          enableMaterial:
            description: '**boolean**'
            type: boolean
          enableMergejoin:
            description: '**boolean**'
            type: boolean
          enableNestloop:
            description: '**boolean**'
            type: boolean
          enableSeqscan:
            description: '**boolean**'
            type: boolean
          enableSort:
            description: '**boolean**'
            type: boolean
          enableTidscan:
            description: '**boolean**'
            type: boolean
          maxParallelWorkers:
            description: '**string** (int64)'
            type: string
            format: int64
          maxParallelWorkersPerGather:
            description: '**string** (int64)'
            type: string
            format: int64
          timezone:
            description: '**string**'
            type: string
          effectiveIoConcurrency:
            description: '**string** (int64)'
            type: string
            format: int64
          effectiveCacheSize:
            description: '**string** (int64)'
            type: string
            format: int64
      PostgresqlHostConfig16_1C:
        type: object
        properties:
          recoveryMinApplyDelay:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          sharedBuffers:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          tempBuffers:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          workMem:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          tempFileLimit:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          backendFlushAfter:
            description: '**string** (int64)'
            type: string
            format: int64
          oldSnapshotThreshold:
            description: '**string** (int64)'
            type: string
            format: int64
          maxStandbyStreamingDelay:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          constraintExclusion:
            description: |-
              **enum** (ConstraintExclusion)
              - `CONSTRAINT_EXCLUSION_UNSPECIFIED`
              - `CONSTRAINT_EXCLUSION_ON`
              - `CONSTRAINT_EXCLUSION_OFF`
              - `CONSTRAINT_EXCLUSION_PARTITION`
            type: string
            enum:
              - CONSTRAINT_EXCLUSION_UNSPECIFIED
              - CONSTRAINT_EXCLUSION_ON
              - CONSTRAINT_EXCLUSION_OFF
              - CONSTRAINT_EXCLUSION_PARTITION
          cursorTupleFraction:
            description: '**number** (double)'
            type: number
            format: double
          fromCollapseLimit:
            description: '**string** (int64)'
            type: string
            format: int64
          joinCollapseLimit:
            description: '**string** (int64)'
            type: string
            format: int64
          debugParallelQuery:
            description: |-
              **enum** (DebugParallelQuery)
              - `DEBUG_PARALLEL_QUERY_UNSPECIFIED`
              - `DEBUG_PARALLEL_QUERY_ON`
              - `DEBUG_PARALLEL_QUERY_OFF`
              - `DEBUG_PARALLEL_QUERY_REGRESS`
            type: string
            enum:
              - DEBUG_PARALLEL_QUERY_UNSPECIFIED
              - DEBUG_PARALLEL_QUERY_ON
              - DEBUG_PARALLEL_QUERY_OFF
              - DEBUG_PARALLEL_QUERY_REGRESS
          clientMinMessages:
            description: |-
              **enum** (LogLevel)
              - `LOG_LEVEL_UNSPECIFIED`
              - `LOG_LEVEL_DEBUG5`
              - `LOG_LEVEL_DEBUG4`
              - `LOG_LEVEL_DEBUG3`
              - `LOG_LEVEL_DEBUG2`
              - `LOG_LEVEL_DEBUG1`
              - `LOG_LEVEL_LOG`
              - `LOG_LEVEL_NOTICE`
              - `LOG_LEVEL_WARNING`
              - `LOG_LEVEL_ERROR`
              - `LOG_LEVEL_FATAL`
              - `LOG_LEVEL_PANIC`
            type: string
            enum:
              - LOG_LEVEL_UNSPECIFIED
              - LOG_LEVEL_DEBUG5
              - LOG_LEVEL_DEBUG4
              - LOG_LEVEL_DEBUG3
              - LOG_LEVEL_DEBUG2
              - LOG_LEVEL_DEBUG1
              - LOG_LEVEL_LOG
              - LOG_LEVEL_NOTICE
              - LOG_LEVEL_WARNING
              - LOG_LEVEL_ERROR
              - LOG_LEVEL_FATAL
              - LOG_LEVEL_PANIC
          logMinMessages:
            description: |-
              **enum** (LogLevel)
              - `LOG_LEVEL_UNSPECIFIED`
              - `LOG_LEVEL_DEBUG5`
              - `LOG_LEVEL_DEBUG4`
              - `LOG_LEVEL_DEBUG3`
              - `LOG_LEVEL_DEBUG2`
              - `LOG_LEVEL_DEBUG1`
              - `LOG_LEVEL_LOG`
              - `LOG_LEVEL_NOTICE`
              - `LOG_LEVEL_WARNING`
              - `LOG_LEVEL_ERROR`
              - `LOG_LEVEL_FATAL`
              - `LOG_LEVEL_PANIC`
            type: string
            enum:
              - LOG_LEVEL_UNSPECIFIED
              - LOG_LEVEL_DEBUG5
              - LOG_LEVEL_DEBUG4
              - LOG_LEVEL_DEBUG3
              - LOG_LEVEL_DEBUG2
              - LOG_LEVEL_DEBUG1
              - LOG_LEVEL_LOG
              - LOG_LEVEL_NOTICE
              - LOG_LEVEL_WARNING
              - LOG_LEVEL_ERROR
              - LOG_LEVEL_FATAL
              - LOG_LEVEL_PANIC
          logMinErrorStatement:
            description: |-
              **enum** (LogLevel)
              - `LOG_LEVEL_UNSPECIFIED`
              - `LOG_LEVEL_DEBUG5`
              - `LOG_LEVEL_DEBUG4`
              - `LOG_LEVEL_DEBUG3`
              - `LOG_LEVEL_DEBUG2`
              - `LOG_LEVEL_DEBUG1`
              - `LOG_LEVEL_LOG`
              - `LOG_LEVEL_NOTICE`
              - `LOG_LEVEL_WARNING`
              - `LOG_LEVEL_ERROR`
              - `LOG_LEVEL_FATAL`
              - `LOG_LEVEL_PANIC`
            type: string
            enum:
              - LOG_LEVEL_UNSPECIFIED
              - LOG_LEVEL_DEBUG5
              - LOG_LEVEL_DEBUG4
              - LOG_LEVEL_DEBUG3
              - LOG_LEVEL_DEBUG2
              - LOG_LEVEL_DEBUG1
              - LOG_LEVEL_LOG
              - LOG_LEVEL_NOTICE
              - LOG_LEVEL_WARNING
              - LOG_LEVEL_ERROR
              - LOG_LEVEL_FATAL
              - LOG_LEVEL_PANIC
          logMinDurationStatement:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          logCheckpoints:
            description: '**boolean**'
            type: boolean
          logConnections:
            description: '**boolean**'
            type: boolean
          logDisconnections:
            description: '**boolean**'
            type: boolean
          logDuration:
            description: '**boolean**'
            type: boolean
          logErrorVerbosity:
            description: |-
              **enum** (LogErrorVerbosity)
              - `LOG_ERROR_VERBOSITY_UNSPECIFIED`
              - `LOG_ERROR_VERBOSITY_TERSE`
              - `LOG_ERROR_VERBOSITY_DEFAULT`
              - `LOG_ERROR_VERBOSITY_VERBOSE`
            type: string
            enum:
              - LOG_ERROR_VERBOSITY_UNSPECIFIED
              - LOG_ERROR_VERBOSITY_TERSE
              - LOG_ERROR_VERBOSITY_DEFAULT
              - LOG_ERROR_VERBOSITY_VERBOSE
          logLockWaits:
            description: '**boolean**'
            type: boolean
          logStatement:
            description: |-
              **enum** (LogStatement)
              - `LOG_STATEMENT_UNSPECIFIED`
              - `LOG_STATEMENT_NONE`
              - `LOG_STATEMENT_DDL`
              - `LOG_STATEMENT_MOD`
              - `LOG_STATEMENT_ALL`
            type: string
            enum:
              - LOG_STATEMENT_UNSPECIFIED
              - LOG_STATEMENT_NONE
              - LOG_STATEMENT_DDL
              - LOG_STATEMENT_MOD
              - LOG_STATEMENT_ALL
          logTempFiles:
            description: '**string** (int64)'
            type: string
            format: int64
          searchPath:
            description: '**string**'
            type: string
          rowSecurity:
            description: '**boolean**'
            type: boolean
          defaultTransactionIsolation:
            description: |-
              **enum** (TransactionIsolation)
              - `TRANSACTION_ISOLATION_UNSPECIFIED`
              - `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
              - `TRANSACTION_ISOLATION_READ_COMMITTED`
              - `TRANSACTION_ISOLATION_REPEATABLE_READ`
              - `TRANSACTION_ISOLATION_SERIALIZABLE`
            type: string
            enum:
              - TRANSACTION_ISOLATION_UNSPECIFIED
              - TRANSACTION_ISOLATION_READ_UNCOMMITTED
              - TRANSACTION_ISOLATION_READ_COMMITTED
              - TRANSACTION_ISOLATION_REPEATABLE_READ
              - TRANSACTION_ISOLATION_SERIALIZABLE
          statementTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          lockTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          idleInTransactionSessionTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          byteaOutput:
            description: |-
              **enum** (ByteaOutput)
              - `BYTEA_OUTPUT_UNSPECIFIED`
              - `BYTEA_OUTPUT_HEX`
              - `BYTEA_OUTPUT_ESCAPED`
            type: string
            enum:
              - BYTEA_OUTPUT_UNSPECIFIED
              - BYTEA_OUTPUT_HEX
              - BYTEA_OUTPUT_ESCAPED
          xmlbinary:
            description: |-
              **enum** (XmlBinary)
              - `XML_BINARY_UNSPECIFIED`
              - `XML_BINARY_BASE64`
              - `XML_BINARY_HEX`
            type: string
            enum:
              - XML_BINARY_UNSPECIFIED
              - XML_BINARY_BASE64
              - XML_BINARY_HEX
          xmloption:
            description: |-
              **enum** (XmlOption)
              - `XML_OPTION_UNSPECIFIED`
              - `XML_OPTION_DOCUMENT`
              - `XML_OPTION_CONTENT`
            type: string
            enum:
              - XML_OPTION_UNSPECIFIED
              - XML_OPTION_DOCUMENT
              - XML_OPTION_CONTENT
          ginPendingListLimit:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          deadlockTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          maxLocksPerTransaction:
            description: '**string** (int64)'
            type: string
            format: int64
          maxPredLocksPerTransaction:
            description: '**string** (int64)'
            type: string
            format: int64
          arrayNulls:
            description: '**boolean**'
            type: boolean
          backslashQuote:
            description: |-
              **enum** (BackslashQuote)
              - `BACKSLASH_QUOTE_UNSPECIFIED`
              - `BACKSLASH_QUOTE`
              - `BACKSLASH_QUOTE_ON`
              - `BACKSLASH_QUOTE_OFF`
              - `BACKSLASH_QUOTE_SAFE_ENCODING`
            type: string
            enum:
              - BACKSLASH_QUOTE_UNSPECIFIED
              - BACKSLASH_QUOTE
              - BACKSLASH_QUOTE_ON
              - BACKSLASH_QUOTE_OFF
              - BACKSLASH_QUOTE_SAFE_ENCODING
          defaultWithOids:
            description: '**boolean**'
            type: boolean
          escapeStringWarning:
            description: '**boolean**'
            type: boolean
          loCompatPrivileges:
            description: '**boolean**'
            type: boolean
          quoteAllIdentifiers:
            description: '**boolean**'
            type: boolean
          standardConformingStrings:
            description: '**boolean**'
            type: boolean
          synchronizeSeqscans:
            description: '**boolean**'
            type: boolean
          transformNullEquals:
            description: '**boolean**'
            type: boolean
          exitOnError:
            description: '**boolean**'
            type: boolean
          seqPageCost:
            description: '**number** (double)'
            type: number
            format: double
          randomPageCost:
            description: '**number** (double)'
            type: number
            format: double
          enableBitmapscan:
            description: '**boolean**'
            type: boolean
          enableHashagg:
            description: '**boolean**'
            type: boolean
          enableHashjoin:
            description: '**boolean**'
            type: boolean
          enableIndexscan:
            description: '**boolean**'
            type: boolean
          enableIndexonlyscan:
            description: '**boolean**'
            type: boolean
          enableMaterial:
            description: '**boolean**'
            type: boolean
          enableMergejoin:
            description: '**boolean**'
            type: boolean
          enableNestloop:
            description: '**boolean**'
            type: boolean
          enableSeqscan:
            description: '**boolean**'
            type: boolean
          enableSort:
            description: '**boolean**'
            type: boolean
          enableTidscan:
            description: '**boolean**'
            type: boolean
          maxParallelWorkers:
            description: '**string** (int64)'
            type: string
            format: int64
          maxParallelWorkersPerGather:
            description: '**string** (int64)'
            type: string
            format: int64
          timezone:
            description: '**string**'
            type: string
          effectiveIoConcurrency:
            description: '**string** (int64)'
            type: string
            format: int64
          effectiveCacheSize:
            description: '**string** (int64)'
            type: string
            format: int64
      PostgresqlHostConfig17:
        type: object
        properties:
          recoveryMinApplyDelay:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          sharedBuffers:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          tempBuffers:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          workMem:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          tempFileLimit:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          backendFlushAfter:
            description: '**string** (int64)'
            type: string
            format: int64
          maxStandbyStreamingDelay:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          constraintExclusion:
            description: |-
              **enum** (ConstraintExclusion)
              - `CONSTRAINT_EXCLUSION_UNSPECIFIED`
              - `CONSTRAINT_EXCLUSION_ON`
              - `CONSTRAINT_EXCLUSION_OFF`
              - `CONSTRAINT_EXCLUSION_PARTITION`
            type: string
            enum:
              - CONSTRAINT_EXCLUSION_UNSPECIFIED
              - CONSTRAINT_EXCLUSION_ON
              - CONSTRAINT_EXCLUSION_OFF
              - CONSTRAINT_EXCLUSION_PARTITION
          cursorTupleFraction:
            description: '**number** (double)'
            type: number
            format: double
          fromCollapseLimit:
            description: '**string** (int64)'
            type: string
            format: int64
          joinCollapseLimit:
            description: '**string** (int64)'
            type: string
            format: int64
          debugParallelQuery:
            description: |-
              **enum** (DebugParallelQuery)
              - `DEBUG_PARALLEL_QUERY_UNSPECIFIED`
              - `DEBUG_PARALLEL_QUERY_ON`
              - `DEBUG_PARALLEL_QUERY_OFF`
              - `DEBUG_PARALLEL_QUERY_REGRESS`
            type: string
            enum:
              - DEBUG_PARALLEL_QUERY_UNSPECIFIED
              - DEBUG_PARALLEL_QUERY_ON
              - DEBUG_PARALLEL_QUERY_OFF
              - DEBUG_PARALLEL_QUERY_REGRESS
          clientMinMessages:
            description: |-
              **enum** (LogLevel)
              - `LOG_LEVEL_UNSPECIFIED`
              - `LOG_LEVEL_DEBUG5`
              - `LOG_LEVEL_DEBUG4`
              - `LOG_LEVEL_DEBUG3`
              - `LOG_LEVEL_DEBUG2`
              - `LOG_LEVEL_DEBUG1`
              - `LOG_LEVEL_LOG`
              - `LOG_LEVEL_NOTICE`
              - `LOG_LEVEL_WARNING`
              - `LOG_LEVEL_ERROR`
              - `LOG_LEVEL_FATAL`
              - `LOG_LEVEL_PANIC`
            type: string
            enum:
              - LOG_LEVEL_UNSPECIFIED
              - LOG_LEVEL_DEBUG5
              - LOG_LEVEL_DEBUG4
              - LOG_LEVEL_DEBUG3
              - LOG_LEVEL_DEBUG2
              - LOG_LEVEL_DEBUG1
              - LOG_LEVEL_LOG
              - LOG_LEVEL_NOTICE
              - LOG_LEVEL_WARNING
              - LOG_LEVEL_ERROR
              - LOG_LEVEL_FATAL
              - LOG_LEVEL_PANIC
          logMinMessages:
            description: |-
              **enum** (LogLevel)
              - `LOG_LEVEL_UNSPECIFIED`
              - `LOG_LEVEL_DEBUG5`
              - `LOG_LEVEL_DEBUG4`
              - `LOG_LEVEL_DEBUG3`
              - `LOG_LEVEL_DEBUG2`
              - `LOG_LEVEL_DEBUG1`
              - `LOG_LEVEL_LOG`
              - `LOG_LEVEL_NOTICE`
              - `LOG_LEVEL_WARNING`
              - `LOG_LEVEL_ERROR`
              - `LOG_LEVEL_FATAL`
              - `LOG_LEVEL_PANIC`
            type: string
            enum:
              - LOG_LEVEL_UNSPECIFIED
              - LOG_LEVEL_DEBUG5
              - LOG_LEVEL_DEBUG4
              - LOG_LEVEL_DEBUG3
              - LOG_LEVEL_DEBUG2
              - LOG_LEVEL_DEBUG1
              - LOG_LEVEL_LOG
              - LOG_LEVEL_NOTICE
              - LOG_LEVEL_WARNING
              - LOG_LEVEL_ERROR
              - LOG_LEVEL_FATAL
              - LOG_LEVEL_PANIC
          logMinErrorStatement:
            description: |-
              **enum** (LogLevel)
              - `LOG_LEVEL_UNSPECIFIED`
              - `LOG_LEVEL_DEBUG5`
              - `LOG_LEVEL_DEBUG4`
              - `LOG_LEVEL_DEBUG3`
              - `LOG_LEVEL_DEBUG2`
              - `LOG_LEVEL_DEBUG1`
              - `LOG_LEVEL_LOG`
              - `LOG_LEVEL_NOTICE`
              - `LOG_LEVEL_WARNING`
              - `LOG_LEVEL_ERROR`
              - `LOG_LEVEL_FATAL`
              - `LOG_LEVEL_PANIC`
            type: string
            enum:
              - LOG_LEVEL_UNSPECIFIED
              - LOG_LEVEL_DEBUG5
              - LOG_LEVEL_DEBUG4
              - LOG_LEVEL_DEBUG3
              - LOG_LEVEL_DEBUG2
              - LOG_LEVEL_DEBUG1
              - LOG_LEVEL_LOG
              - LOG_LEVEL_NOTICE
              - LOG_LEVEL_WARNING
              - LOG_LEVEL_ERROR
              - LOG_LEVEL_FATAL
              - LOG_LEVEL_PANIC
          logMinDurationStatement:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          logCheckpoints:
            description: '**boolean**'
            type: boolean
          logConnections:
            description: '**boolean**'
            type: boolean
          logDisconnections:
            description: '**boolean**'
            type: boolean
          logDuration:
            description: '**boolean**'
            type: boolean
          logErrorVerbosity:
            description: |-
              **enum** (LogErrorVerbosity)
              - `LOG_ERROR_VERBOSITY_UNSPECIFIED`
              - `LOG_ERROR_VERBOSITY_TERSE`
              - `LOG_ERROR_VERBOSITY_DEFAULT`
              - `LOG_ERROR_VERBOSITY_VERBOSE`
            type: string
            enum:
              - LOG_ERROR_VERBOSITY_UNSPECIFIED
              - LOG_ERROR_VERBOSITY_TERSE
              - LOG_ERROR_VERBOSITY_DEFAULT
              - LOG_ERROR_VERBOSITY_VERBOSE
          logLockWaits:
            description: '**boolean**'
            type: boolean
          logStatement:
            description: |-
              **enum** (LogStatement)
              - `LOG_STATEMENT_UNSPECIFIED`
              - `LOG_STATEMENT_NONE`
              - `LOG_STATEMENT_DDL`
              - `LOG_STATEMENT_MOD`
              - `LOG_STATEMENT_ALL`
            type: string
            enum:
              - LOG_STATEMENT_UNSPECIFIED
              - LOG_STATEMENT_NONE
              - LOG_STATEMENT_DDL
              - LOG_STATEMENT_MOD
              - LOG_STATEMENT_ALL
          logTempFiles:
            description: '**string** (int64)'
            type: string
            format: int64
          searchPath:
            description: '**string**'
            type: string
          rowSecurity:
            description: '**boolean**'
            type: boolean
          defaultTransactionIsolation:
            description: |-
              **enum** (TransactionIsolation)
              - `TRANSACTION_ISOLATION_UNSPECIFIED`
              - `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
              - `TRANSACTION_ISOLATION_READ_COMMITTED`
              - `TRANSACTION_ISOLATION_REPEATABLE_READ`
              - `TRANSACTION_ISOLATION_SERIALIZABLE`
            type: string
            enum:
              - TRANSACTION_ISOLATION_UNSPECIFIED
              - TRANSACTION_ISOLATION_READ_UNCOMMITTED
              - TRANSACTION_ISOLATION_READ_COMMITTED
              - TRANSACTION_ISOLATION_REPEATABLE_READ
              - TRANSACTION_ISOLATION_SERIALIZABLE
          statementTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          lockTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          idleInTransactionSessionTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          byteaOutput:
            description: |-
              **enum** (ByteaOutput)
              - `BYTEA_OUTPUT_UNSPECIFIED`
              - `BYTEA_OUTPUT_HEX`
              - `BYTEA_OUTPUT_ESCAPED`
            type: string
            enum:
              - BYTEA_OUTPUT_UNSPECIFIED
              - BYTEA_OUTPUT_HEX
              - BYTEA_OUTPUT_ESCAPED
          xmlbinary:
            description: |-
              **enum** (XmlBinary)
              - `XML_BINARY_UNSPECIFIED`
              - `XML_BINARY_BASE64`
              - `XML_BINARY_HEX`
            type: string
            enum:
              - XML_BINARY_UNSPECIFIED
              - XML_BINARY_BASE64
              - XML_BINARY_HEX
          xmloption:
            description: |-
              **enum** (XmlOption)
              - `XML_OPTION_UNSPECIFIED`
              - `XML_OPTION_DOCUMENT`
              - `XML_OPTION_CONTENT`
            type: string
            enum:
              - XML_OPTION_UNSPECIFIED
              - XML_OPTION_DOCUMENT
              - XML_OPTION_CONTENT
          ginPendingListLimit:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          deadlockTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          maxLocksPerTransaction:
            description: '**string** (int64)'
            type: string
            format: int64
          maxPredLocksPerTransaction:
            description: '**string** (int64)'
            type: string
            format: int64
          arrayNulls:
            description: '**boolean**'
            type: boolean
          backslashQuote:
            description: |-
              **enum** (BackslashQuote)
              - `BACKSLASH_QUOTE_UNSPECIFIED`
              - `BACKSLASH_QUOTE`
              - `BACKSLASH_QUOTE_ON`
              - `BACKSLASH_QUOTE_OFF`
              - `BACKSLASH_QUOTE_SAFE_ENCODING`
            type: string
            enum:
              - BACKSLASH_QUOTE_UNSPECIFIED
              - BACKSLASH_QUOTE
              - BACKSLASH_QUOTE_ON
              - BACKSLASH_QUOTE_OFF
              - BACKSLASH_QUOTE_SAFE_ENCODING
          defaultWithOids:
            description: '**boolean**'
            type: boolean
          escapeStringWarning:
            description: '**boolean**'
            type: boolean
          loCompatPrivileges:
            description: '**boolean**'
            type: boolean
          quoteAllIdentifiers:
            description: '**boolean**'
            type: boolean
          standardConformingStrings:
            description: '**boolean**'
            type: boolean
          synchronizeSeqscans:
            description: '**boolean**'
            type: boolean
          transformNullEquals:
            description: '**boolean**'
            type: boolean
          exitOnError:
            description: '**boolean**'
            type: boolean
          seqPageCost:
            description: '**number** (double)'
            type: number
            format: double
          randomPageCost:
            description: '**number** (double)'
            type: number
            format: double
          enableBitmapscan:
            description: '**boolean**'
            type: boolean
          enableHashagg:
            description: '**boolean**'
            type: boolean
          enableHashjoin:
            description: '**boolean**'
            type: boolean
          enableIndexscan:
            description: '**boolean**'
            type: boolean
          enableIndexonlyscan:
            description: '**boolean**'
            type: boolean
          enableMaterial:
            description: '**boolean**'
            type: boolean
          enableMergejoin:
            description: '**boolean**'
            type: boolean
          enableNestloop:
            description: '**boolean**'
            type: boolean
          enableSeqscan:
            description: '**boolean**'
            type: boolean
          enableSort:
            description: '**boolean**'
            type: boolean
          enableTidscan:
            description: '**boolean**'
            type: boolean
          maxParallelWorkers:
            description: '**string** (int64)'
            type: string
            format: int64
          maxParallelWorkersPerGather:
            description: '**string** (int64)'
            type: string
            format: int64
          timezone:
            description: '**string**'
            type: string
          effectiveIoConcurrency:
            description: '**string** (int64)'
            type: string
            format: int64
          effectiveCacheSize:
            description: '**string** (int64)'
            type: string
            format: int64
      PostgresqlHostConfig17_1C:
        type: object
        properties:
          recoveryMinApplyDelay:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          sharedBuffers:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          tempBuffers:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          workMem:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          tempFileLimit:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          backendFlushAfter:
            description: '**string** (int64)'
            type: string
            format: int64
          maxStandbyStreamingDelay:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          constraintExclusion:
            description: |-
              **enum** (ConstraintExclusion)
              - `CONSTRAINT_EXCLUSION_UNSPECIFIED`
              - `CONSTRAINT_EXCLUSION_ON`
              - `CONSTRAINT_EXCLUSION_OFF`
              - `CONSTRAINT_EXCLUSION_PARTITION`
            type: string
            enum:
              - CONSTRAINT_EXCLUSION_UNSPECIFIED
              - CONSTRAINT_EXCLUSION_ON
              - CONSTRAINT_EXCLUSION_OFF
              - CONSTRAINT_EXCLUSION_PARTITION
          cursorTupleFraction:
            description: '**number** (double)'
            type: number
            format: double
          fromCollapseLimit:
            description: '**string** (int64)'
            type: string
            format: int64
          joinCollapseLimit:
            description: '**string** (int64)'
            type: string
            format: int64
          debugParallelQuery:
            description: |-
              **enum** (DebugParallelQuery)
              - `DEBUG_PARALLEL_QUERY_UNSPECIFIED`
              - `DEBUG_PARALLEL_QUERY_ON`
              - `DEBUG_PARALLEL_QUERY_OFF`
              - `DEBUG_PARALLEL_QUERY_REGRESS`
            type: string
            enum:
              - DEBUG_PARALLEL_QUERY_UNSPECIFIED
              - DEBUG_PARALLEL_QUERY_ON
              - DEBUG_PARALLEL_QUERY_OFF
              - DEBUG_PARALLEL_QUERY_REGRESS
          clientMinMessages:
            description: |-
              **enum** (LogLevel)
              - `LOG_LEVEL_UNSPECIFIED`
              - `LOG_LEVEL_DEBUG5`
              - `LOG_LEVEL_DEBUG4`
              - `LOG_LEVEL_DEBUG3`
              - `LOG_LEVEL_DEBUG2`
              - `LOG_LEVEL_DEBUG1`
              - `LOG_LEVEL_LOG`
              - `LOG_LEVEL_NOTICE`
              - `LOG_LEVEL_WARNING`
              - `LOG_LEVEL_ERROR`
              - `LOG_LEVEL_FATAL`
              - `LOG_LEVEL_PANIC`
            type: string
            enum:
              - LOG_LEVEL_UNSPECIFIED
              - LOG_LEVEL_DEBUG5
              - LOG_LEVEL_DEBUG4
              - LOG_LEVEL_DEBUG3
              - LOG_LEVEL_DEBUG2
              - LOG_LEVEL_DEBUG1
              - LOG_LEVEL_LOG
              - LOG_LEVEL_NOTICE
              - LOG_LEVEL_WARNING
              - LOG_LEVEL_ERROR
              - LOG_LEVEL_FATAL
              - LOG_LEVEL_PANIC
          logMinMessages:
            description: |-
              **enum** (LogLevel)
              - `LOG_LEVEL_UNSPECIFIED`
              - `LOG_LEVEL_DEBUG5`
              - `LOG_LEVEL_DEBUG4`
              - `LOG_LEVEL_DEBUG3`
              - `LOG_LEVEL_DEBUG2`
              - `LOG_LEVEL_DEBUG1`
              - `LOG_LEVEL_LOG`
              - `LOG_LEVEL_NOTICE`
              - `LOG_LEVEL_WARNING`
              - `LOG_LEVEL_ERROR`
              - `LOG_LEVEL_FATAL`
              - `LOG_LEVEL_PANIC`
            type: string
            enum:
              - LOG_LEVEL_UNSPECIFIED
              - LOG_LEVEL_DEBUG5
              - LOG_LEVEL_DEBUG4
              - LOG_LEVEL_DEBUG3
              - LOG_LEVEL_DEBUG2
              - LOG_LEVEL_DEBUG1
              - LOG_LEVEL_LOG
              - LOG_LEVEL_NOTICE
              - LOG_LEVEL_WARNING
              - LOG_LEVEL_ERROR
              - LOG_LEVEL_FATAL
              - LOG_LEVEL_PANIC
          logMinErrorStatement:
            description: |-
              **enum** (LogLevel)
              - `LOG_LEVEL_UNSPECIFIED`
              - `LOG_LEVEL_DEBUG5`
              - `LOG_LEVEL_DEBUG4`
              - `LOG_LEVEL_DEBUG3`
              - `LOG_LEVEL_DEBUG2`
              - `LOG_LEVEL_DEBUG1`
              - `LOG_LEVEL_LOG`
              - `LOG_LEVEL_NOTICE`
              - `LOG_LEVEL_WARNING`
              - `LOG_LEVEL_ERROR`
              - `LOG_LEVEL_FATAL`
              - `LOG_LEVEL_PANIC`
            type: string
            enum:
              - LOG_LEVEL_UNSPECIFIED
              - LOG_LEVEL_DEBUG5
              - LOG_LEVEL_DEBUG4
              - LOG_LEVEL_DEBUG3
              - LOG_LEVEL_DEBUG2
              - LOG_LEVEL_DEBUG1
              - LOG_LEVEL_LOG
              - LOG_LEVEL_NOTICE
              - LOG_LEVEL_WARNING
              - LOG_LEVEL_ERROR
              - LOG_LEVEL_FATAL
              - LOG_LEVEL_PANIC
          logMinDurationStatement:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          logCheckpoints:
            description: '**boolean**'
            type: boolean
          logConnections:
            description: '**boolean**'
            type: boolean
          logDisconnections:
            description: '**boolean**'
            type: boolean
          logDuration:
            description: '**boolean**'
            type: boolean
          logErrorVerbosity:
            description: |-
              **enum** (LogErrorVerbosity)
              - `LOG_ERROR_VERBOSITY_UNSPECIFIED`
              - `LOG_ERROR_VERBOSITY_TERSE`
              - `LOG_ERROR_VERBOSITY_DEFAULT`
              - `LOG_ERROR_VERBOSITY_VERBOSE`
            type: string
            enum:
              - LOG_ERROR_VERBOSITY_UNSPECIFIED
              - LOG_ERROR_VERBOSITY_TERSE
              - LOG_ERROR_VERBOSITY_DEFAULT
              - LOG_ERROR_VERBOSITY_VERBOSE
          logLockWaits:
            description: '**boolean**'
            type: boolean
          logStatement:
            description: |-
              **enum** (LogStatement)
              - `LOG_STATEMENT_UNSPECIFIED`
              - `LOG_STATEMENT_NONE`
              - `LOG_STATEMENT_DDL`
              - `LOG_STATEMENT_MOD`
              - `LOG_STATEMENT_ALL`
            type: string
            enum:
              - LOG_STATEMENT_UNSPECIFIED
              - LOG_STATEMENT_NONE
              - LOG_STATEMENT_DDL
              - LOG_STATEMENT_MOD
              - LOG_STATEMENT_ALL
          logTempFiles:
            description: '**string** (int64)'
            type: string
            format: int64
          searchPath:
            description: '**string**'
            type: string
          rowSecurity:
            description: '**boolean**'
            type: boolean
          defaultTransactionIsolation:
            description: |-
              **enum** (TransactionIsolation)
              - `TRANSACTION_ISOLATION_UNSPECIFIED`
              - `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
              - `TRANSACTION_ISOLATION_READ_COMMITTED`
              - `TRANSACTION_ISOLATION_REPEATABLE_READ`
              - `TRANSACTION_ISOLATION_SERIALIZABLE`
            type: string
            enum:
              - TRANSACTION_ISOLATION_UNSPECIFIED
              - TRANSACTION_ISOLATION_READ_UNCOMMITTED
              - TRANSACTION_ISOLATION_READ_COMMITTED
              - TRANSACTION_ISOLATION_REPEATABLE_READ
              - TRANSACTION_ISOLATION_SERIALIZABLE
          statementTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          lockTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          idleInTransactionSessionTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          byteaOutput:
            description: |-
              **enum** (ByteaOutput)
              - `BYTEA_OUTPUT_UNSPECIFIED`
              - `BYTEA_OUTPUT_HEX`
              - `BYTEA_OUTPUT_ESCAPED`
            type: string
            enum:
              - BYTEA_OUTPUT_UNSPECIFIED
              - BYTEA_OUTPUT_HEX
              - BYTEA_OUTPUT_ESCAPED
          xmlbinary:
            description: |-
              **enum** (XmlBinary)
              - `XML_BINARY_UNSPECIFIED`
              - `XML_BINARY_BASE64`
              - `XML_BINARY_HEX`
            type: string
            enum:
              - XML_BINARY_UNSPECIFIED
              - XML_BINARY_BASE64
              - XML_BINARY_HEX
          xmloption:
            description: |-
              **enum** (XmlOption)
              - `XML_OPTION_UNSPECIFIED`
              - `XML_OPTION_DOCUMENT`
              - `XML_OPTION_CONTENT`
            type: string
            enum:
              - XML_OPTION_UNSPECIFIED
              - XML_OPTION_DOCUMENT
              - XML_OPTION_CONTENT
          ginPendingListLimit:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          deadlockTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          maxLocksPerTransaction:
            description: '**string** (int64)'
            type: string
            format: int64
          maxPredLocksPerTransaction:
            description: '**string** (int64)'
            type: string
            format: int64
          arrayNulls:
            description: '**boolean**'
            type: boolean
          backslashQuote:
            description: |-
              **enum** (BackslashQuote)
              - `BACKSLASH_QUOTE_UNSPECIFIED`
              - `BACKSLASH_QUOTE`
              - `BACKSLASH_QUOTE_ON`
              - `BACKSLASH_QUOTE_OFF`
              - `BACKSLASH_QUOTE_SAFE_ENCODING`
            type: string
            enum:
              - BACKSLASH_QUOTE_UNSPECIFIED
              - BACKSLASH_QUOTE
              - BACKSLASH_QUOTE_ON
              - BACKSLASH_QUOTE_OFF
              - BACKSLASH_QUOTE_SAFE_ENCODING
          defaultWithOids:
            description: '**boolean**'
            type: boolean
          escapeStringWarning:
            description: '**boolean**'
            type: boolean
          loCompatPrivileges:
            description: '**boolean**'
            type: boolean
          quoteAllIdentifiers:
            description: '**boolean**'
            type: boolean
          standardConformingStrings:
            description: '**boolean**'
            type: boolean
          synchronizeSeqscans:
            description: '**boolean**'
            type: boolean
          transformNullEquals:
            description: '**boolean**'
            type: boolean
          exitOnError:
            description: '**boolean**'
            type: boolean
          seqPageCost:
            description: '**number** (double)'
            type: number
            format: double
          randomPageCost:
            description: '**number** (double)'
            type: number
            format: double
          enableBitmapscan:
            description: '**boolean**'
            type: boolean
          enableHashagg:
            description: '**boolean**'
            type: boolean
          enableHashjoin:
            description: '**boolean**'
            type: boolean
          enableIndexscan:
            description: '**boolean**'
            type: boolean
          enableIndexonlyscan:
            description: '**boolean**'
            type: boolean
          enableMaterial:
            description: '**boolean**'
            type: boolean
          enableMergejoin:
            description: '**boolean**'
            type: boolean
          enableNestloop:
            description: '**boolean**'
            type: boolean
          enableSeqscan:
            description: '**boolean**'
            type: boolean
          enableSort:
            description: '**boolean**'
            type: boolean
          enableTidscan:
            description: '**boolean**'
            type: boolean
          maxParallelWorkers:
            description: '**string** (int64)'
            type: string
            format: int64
          maxParallelWorkersPerGather:
            description: '**string** (int64)'
            type: string
            format: int64
          timezone:
            description: '**string**'
            type: string
          effectiveIoConcurrency:
            description: '**string** (int64)'
            type: string
            format: int64
          effectiveCacheSize:
            description: '**string** (int64)'
            type: string
            format: int64
      PostgresqlHostConfig18:
        type: object
        properties:
          recoveryMinApplyDelay:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          sharedBuffers:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          tempBuffers:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          workMem:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          tempFileLimit:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          backendFlushAfter:
            description: '**string** (int64)'
            type: string
            format: int64
          maxStandbyStreamingDelay:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          constraintExclusion:
            description: |-
              **enum** (ConstraintExclusion)
              - `CONSTRAINT_EXCLUSION_UNSPECIFIED`
              - `CONSTRAINT_EXCLUSION_ON`
              - `CONSTRAINT_EXCLUSION_OFF`
              - `CONSTRAINT_EXCLUSION_PARTITION`
            type: string
            enum:
              - CONSTRAINT_EXCLUSION_UNSPECIFIED
              - CONSTRAINT_EXCLUSION_ON
              - CONSTRAINT_EXCLUSION_OFF
              - CONSTRAINT_EXCLUSION_PARTITION
          cursorTupleFraction:
            description: '**number** (double)'
            type: number
            format: double
          fromCollapseLimit:
            description: '**string** (int64)'
            type: string
            format: int64
          joinCollapseLimit:
            description: '**string** (int64)'
            type: string
            format: int64
          debugParallelQuery:
            description: |-
              **enum** (DebugParallelQuery)
              - `DEBUG_PARALLEL_QUERY_UNSPECIFIED`
              - `DEBUG_PARALLEL_QUERY_ON`
              - `DEBUG_PARALLEL_QUERY_OFF`
              - `DEBUG_PARALLEL_QUERY_REGRESS`
            type: string
            enum:
              - DEBUG_PARALLEL_QUERY_UNSPECIFIED
              - DEBUG_PARALLEL_QUERY_ON
              - DEBUG_PARALLEL_QUERY_OFF
              - DEBUG_PARALLEL_QUERY_REGRESS
          clientMinMessages:
            description: |-
              **enum** (LogLevel)
              - `LOG_LEVEL_UNSPECIFIED`
              - `LOG_LEVEL_DEBUG5`
              - `LOG_LEVEL_DEBUG4`
              - `LOG_LEVEL_DEBUG3`
              - `LOG_LEVEL_DEBUG2`
              - `LOG_LEVEL_DEBUG1`
              - `LOG_LEVEL_LOG`
              - `LOG_LEVEL_NOTICE`
              - `LOG_LEVEL_WARNING`
              - `LOG_LEVEL_ERROR`
              - `LOG_LEVEL_FATAL`
              - `LOG_LEVEL_PANIC`
            type: string
            enum:
              - LOG_LEVEL_UNSPECIFIED
              - LOG_LEVEL_DEBUG5
              - LOG_LEVEL_DEBUG4
              - LOG_LEVEL_DEBUG3
              - LOG_LEVEL_DEBUG2
              - LOG_LEVEL_DEBUG1
              - LOG_LEVEL_LOG
              - LOG_LEVEL_NOTICE
              - LOG_LEVEL_WARNING
              - LOG_LEVEL_ERROR
              - LOG_LEVEL_FATAL
              - LOG_LEVEL_PANIC
          logMinMessages:
            description: |-
              **enum** (LogLevel)
              - `LOG_LEVEL_UNSPECIFIED`
              - `LOG_LEVEL_DEBUG5`
              - `LOG_LEVEL_DEBUG4`
              - `LOG_LEVEL_DEBUG3`
              - `LOG_LEVEL_DEBUG2`
              - `LOG_LEVEL_DEBUG1`
              - `LOG_LEVEL_LOG`
              - `LOG_LEVEL_NOTICE`
              - `LOG_LEVEL_WARNING`
              - `LOG_LEVEL_ERROR`
              - `LOG_LEVEL_FATAL`
              - `LOG_LEVEL_PANIC`
            type: string
            enum:
              - LOG_LEVEL_UNSPECIFIED
              - LOG_LEVEL_DEBUG5
              - LOG_LEVEL_DEBUG4
              - LOG_LEVEL_DEBUG3
              - LOG_LEVEL_DEBUG2
              - LOG_LEVEL_DEBUG1
              - LOG_LEVEL_LOG
              - LOG_LEVEL_NOTICE
              - LOG_LEVEL_WARNING
              - LOG_LEVEL_ERROR
              - LOG_LEVEL_FATAL
              - LOG_LEVEL_PANIC
          logMinErrorStatement:
            description: |-
              **enum** (LogLevel)
              - `LOG_LEVEL_UNSPECIFIED`
              - `LOG_LEVEL_DEBUG5`
              - `LOG_LEVEL_DEBUG4`
              - `LOG_LEVEL_DEBUG3`
              - `LOG_LEVEL_DEBUG2`
              - `LOG_LEVEL_DEBUG1`
              - `LOG_LEVEL_LOG`
              - `LOG_LEVEL_NOTICE`
              - `LOG_LEVEL_WARNING`
              - `LOG_LEVEL_ERROR`
              - `LOG_LEVEL_FATAL`
              - `LOG_LEVEL_PANIC`
            type: string
            enum:
              - LOG_LEVEL_UNSPECIFIED
              - LOG_LEVEL_DEBUG5
              - LOG_LEVEL_DEBUG4
              - LOG_LEVEL_DEBUG3
              - LOG_LEVEL_DEBUG2
              - LOG_LEVEL_DEBUG1
              - LOG_LEVEL_LOG
              - LOG_LEVEL_NOTICE
              - LOG_LEVEL_WARNING
              - LOG_LEVEL_ERROR
              - LOG_LEVEL_FATAL
              - LOG_LEVEL_PANIC
          logMinDurationStatement:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          logCheckpoints:
            description: '**boolean**'
            type: boolean
          logConnections:
            description: '**boolean**'
            type: boolean
          logDisconnections:
            description: '**boolean**'
            type: boolean
          logDuration:
            description: '**boolean**'
            type: boolean
          logErrorVerbosity:
            description: |-
              **enum** (LogErrorVerbosity)
              - `LOG_ERROR_VERBOSITY_UNSPECIFIED`
              - `LOG_ERROR_VERBOSITY_TERSE`
              - `LOG_ERROR_VERBOSITY_DEFAULT`
              - `LOG_ERROR_VERBOSITY_VERBOSE`
            type: string
            enum:
              - LOG_ERROR_VERBOSITY_UNSPECIFIED
              - LOG_ERROR_VERBOSITY_TERSE
              - LOG_ERROR_VERBOSITY_DEFAULT
              - LOG_ERROR_VERBOSITY_VERBOSE
          logLockWaits:
            description: '**boolean**'
            type: boolean
          logStatement:
            description: |-
              **enum** (LogStatement)
              - `LOG_STATEMENT_UNSPECIFIED`
              - `LOG_STATEMENT_NONE`
              - `LOG_STATEMENT_DDL`
              - `LOG_STATEMENT_MOD`
              - `LOG_STATEMENT_ALL`
            type: string
            enum:
              - LOG_STATEMENT_UNSPECIFIED
              - LOG_STATEMENT_NONE
              - LOG_STATEMENT_DDL
              - LOG_STATEMENT_MOD
              - LOG_STATEMENT_ALL
          logTempFiles:
            description: '**string** (int64)'
            type: string
            format: int64
          searchPath:
            description: '**string**'
            type: string
          rowSecurity:
            description: '**boolean**'
            type: boolean
          defaultTransactionIsolation:
            description: |-
              **enum** (TransactionIsolation)
              - `TRANSACTION_ISOLATION_UNSPECIFIED`
              - `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
              - `TRANSACTION_ISOLATION_READ_COMMITTED`
              - `TRANSACTION_ISOLATION_REPEATABLE_READ`
              - `TRANSACTION_ISOLATION_SERIALIZABLE`
            type: string
            enum:
              - TRANSACTION_ISOLATION_UNSPECIFIED
              - TRANSACTION_ISOLATION_READ_UNCOMMITTED
              - TRANSACTION_ISOLATION_READ_COMMITTED
              - TRANSACTION_ISOLATION_REPEATABLE_READ
              - TRANSACTION_ISOLATION_SERIALIZABLE
          statementTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          lockTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          idleInTransactionSessionTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          byteaOutput:
            description: |-
              **enum** (ByteaOutput)
              - `BYTEA_OUTPUT_UNSPECIFIED`
              - `BYTEA_OUTPUT_HEX`
              - `BYTEA_OUTPUT_ESCAPED`
            type: string
            enum:
              - BYTEA_OUTPUT_UNSPECIFIED
              - BYTEA_OUTPUT_HEX
              - BYTEA_OUTPUT_ESCAPED
          xmlbinary:
            description: |-
              **enum** (XmlBinary)
              - `XML_BINARY_UNSPECIFIED`
              - `XML_BINARY_BASE64`
              - `XML_BINARY_HEX`
            type: string
            enum:
              - XML_BINARY_UNSPECIFIED
              - XML_BINARY_BASE64
              - XML_BINARY_HEX
          xmloption:
            description: |-
              **enum** (XmlOption)
              - `XML_OPTION_UNSPECIFIED`
              - `XML_OPTION_DOCUMENT`
              - `XML_OPTION_CONTENT`
            type: string
            enum:
              - XML_OPTION_UNSPECIFIED
              - XML_OPTION_DOCUMENT
              - XML_OPTION_CONTENT
          ginPendingListLimit:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          deadlockTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          maxLocksPerTransaction:
            description: '**string** (int64)'
            type: string
            format: int64
          maxPredLocksPerTransaction:
            description: '**string** (int64)'
            type: string
            format: int64
          arrayNulls:
            description: '**boolean**'
            type: boolean
          backslashQuote:
            description: |-
              **enum** (BackslashQuote)
              - `BACKSLASH_QUOTE_UNSPECIFIED`
              - `BACKSLASH_QUOTE`
              - `BACKSLASH_QUOTE_ON`
              - `BACKSLASH_QUOTE_OFF`
              - `BACKSLASH_QUOTE_SAFE_ENCODING`
            type: string
            enum:
              - BACKSLASH_QUOTE_UNSPECIFIED
              - BACKSLASH_QUOTE
              - BACKSLASH_QUOTE_ON
              - BACKSLASH_QUOTE_OFF
              - BACKSLASH_QUOTE_SAFE_ENCODING
          defaultWithOids:
            description: '**boolean**'
            type: boolean
          escapeStringWarning:
            description: '**boolean**'
            type: boolean
          loCompatPrivileges:
            description: '**boolean**'
            type: boolean
          quoteAllIdentifiers:
            description: '**boolean**'
            type: boolean
          standardConformingStrings:
            description: '**boolean**'
            type: boolean
          synchronizeSeqscans:
            description: '**boolean**'
            type: boolean
          transformNullEquals:
            description: '**boolean**'
            type: boolean
          exitOnError:
            description: '**boolean**'
            type: boolean
          seqPageCost:
            description: '**number** (double)'
            type: number
            format: double
          randomPageCost:
            description: '**number** (double)'
            type: number
            format: double
          enableBitmapscan:
            description: '**boolean**'
            type: boolean
          enableHashagg:
            description: '**boolean**'
            type: boolean
          enableHashjoin:
            description: '**boolean**'
            type: boolean
          enableIndexscan:
            description: '**boolean**'
            type: boolean
          enableIndexonlyscan:
            description: '**boolean**'
            type: boolean
          enableMaterial:
            description: '**boolean**'
            type: boolean
          enableMergejoin:
            description: '**boolean**'
            type: boolean
          enableNestloop:
            description: '**boolean**'
            type: boolean
          enableSeqscan:
            description: '**boolean**'
            type: boolean
          enableSort:
            description: '**boolean**'
            type: boolean
          enableTidscan:
            description: '**boolean**'
            type: boolean
          maxParallelWorkers:
            description: '**string** (int64)'
            type: string
            format: int64
          maxParallelWorkersPerGather:
            description: '**string** (int64)'
            type: string
            format: int64
          timezone:
            description: '**string**'
            type: string
          effectiveIoConcurrency:
            description: '**string** (int64)'
            type: string
            format: int64
          effectiveCacheSize:
            description: '**string** (int64)'
            type: string
            format: int64
      PostgresqlHostConfig18_1C:
        type: object
        properties:
          recoveryMinApplyDelay:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          sharedBuffers:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          tempBuffers:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          workMem:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          tempFileLimit:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          backendFlushAfter:
            description: '**string** (int64)'
            type: string
            format: int64
          maxStandbyStreamingDelay:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          constraintExclusion:
            description: |-
              **enum** (ConstraintExclusion)
              - `CONSTRAINT_EXCLUSION_UNSPECIFIED`
              - `CONSTRAINT_EXCLUSION_ON`
              - `CONSTRAINT_EXCLUSION_OFF`
              - `CONSTRAINT_EXCLUSION_PARTITION`
            type: string
            enum:
              - CONSTRAINT_EXCLUSION_UNSPECIFIED
              - CONSTRAINT_EXCLUSION_ON
              - CONSTRAINT_EXCLUSION_OFF
              - CONSTRAINT_EXCLUSION_PARTITION
          cursorTupleFraction:
            description: '**number** (double)'
            type: number
            format: double
          fromCollapseLimit:
            description: '**string** (int64)'
            type: string
            format: int64
          joinCollapseLimit:
            description: '**string** (int64)'
            type: string
            format: int64
          debugParallelQuery:
            description: |-
              **enum** (DebugParallelQuery)
              - `DEBUG_PARALLEL_QUERY_UNSPECIFIED`
              - `DEBUG_PARALLEL_QUERY_ON`
              - `DEBUG_PARALLEL_QUERY_OFF`
              - `DEBUG_PARALLEL_QUERY_REGRESS`
            type: string
            enum:
              - DEBUG_PARALLEL_QUERY_UNSPECIFIED
              - DEBUG_PARALLEL_QUERY_ON
              - DEBUG_PARALLEL_QUERY_OFF
              - DEBUG_PARALLEL_QUERY_REGRESS
          clientMinMessages:
            description: |-
              **enum** (LogLevel)
              - `LOG_LEVEL_UNSPECIFIED`
              - `LOG_LEVEL_DEBUG5`
              - `LOG_LEVEL_DEBUG4`
              - `LOG_LEVEL_DEBUG3`
              - `LOG_LEVEL_DEBUG2`
              - `LOG_LEVEL_DEBUG1`
              - `LOG_LEVEL_LOG`
              - `LOG_LEVEL_NOTICE`
              - `LOG_LEVEL_WARNING`
              - `LOG_LEVEL_ERROR`
              - `LOG_LEVEL_FATAL`
              - `LOG_LEVEL_PANIC`
            type: string
            enum:
              - LOG_LEVEL_UNSPECIFIED
              - LOG_LEVEL_DEBUG5
              - LOG_LEVEL_DEBUG4
              - LOG_LEVEL_DEBUG3
              - LOG_LEVEL_DEBUG2
              - LOG_LEVEL_DEBUG1
              - LOG_LEVEL_LOG
              - LOG_LEVEL_NOTICE
              - LOG_LEVEL_WARNING
              - LOG_LEVEL_ERROR
              - LOG_LEVEL_FATAL
              - LOG_LEVEL_PANIC
          logMinMessages:
            description: |-
              **enum** (LogLevel)
              - `LOG_LEVEL_UNSPECIFIED`
              - `LOG_LEVEL_DEBUG5`
              - `LOG_LEVEL_DEBUG4`
              - `LOG_LEVEL_DEBUG3`
              - `LOG_LEVEL_DEBUG2`
              - `LOG_LEVEL_DEBUG1`
              - `LOG_LEVEL_LOG`
              - `LOG_LEVEL_NOTICE`
              - `LOG_LEVEL_WARNING`
              - `LOG_LEVEL_ERROR`
              - `LOG_LEVEL_FATAL`
              - `LOG_LEVEL_PANIC`
            type: string
            enum:
              - LOG_LEVEL_UNSPECIFIED
              - LOG_LEVEL_DEBUG5
              - LOG_LEVEL_DEBUG4
              - LOG_LEVEL_DEBUG3
              - LOG_LEVEL_DEBUG2
              - LOG_LEVEL_DEBUG1
              - LOG_LEVEL_LOG
              - LOG_LEVEL_NOTICE
              - LOG_LEVEL_WARNING
              - LOG_LEVEL_ERROR
              - LOG_LEVEL_FATAL
              - LOG_LEVEL_PANIC
          logMinErrorStatement:
            description: |-
              **enum** (LogLevel)
              - `LOG_LEVEL_UNSPECIFIED`
              - `LOG_LEVEL_DEBUG5`
              - `LOG_LEVEL_DEBUG4`
              - `LOG_LEVEL_DEBUG3`
              - `LOG_LEVEL_DEBUG2`
              - `LOG_LEVEL_DEBUG1`
              - `LOG_LEVEL_LOG`
              - `LOG_LEVEL_NOTICE`
              - `LOG_LEVEL_WARNING`
              - `LOG_LEVEL_ERROR`
              - `LOG_LEVEL_FATAL`
              - `LOG_LEVEL_PANIC`
            type: string
            enum:
              - LOG_LEVEL_UNSPECIFIED
              - LOG_LEVEL_DEBUG5
              - LOG_LEVEL_DEBUG4
              - LOG_LEVEL_DEBUG3
              - LOG_LEVEL_DEBUG2
              - LOG_LEVEL_DEBUG1
              - LOG_LEVEL_LOG
              - LOG_LEVEL_NOTICE
              - LOG_LEVEL_WARNING
              - LOG_LEVEL_ERROR
              - LOG_LEVEL_FATAL
              - LOG_LEVEL_PANIC
          logMinDurationStatement:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          logCheckpoints:
            description: '**boolean**'
            type: boolean
          logConnections:
            description: '**boolean**'
            type: boolean
          logDisconnections:
            description: '**boolean**'
            type: boolean
          logDuration:
            description: '**boolean**'
            type: boolean
          logErrorVerbosity:
            description: |-
              **enum** (LogErrorVerbosity)
              - `LOG_ERROR_VERBOSITY_UNSPECIFIED`
              - `LOG_ERROR_VERBOSITY_TERSE`
              - `LOG_ERROR_VERBOSITY_DEFAULT`
              - `LOG_ERROR_VERBOSITY_VERBOSE`
            type: string
            enum:
              - LOG_ERROR_VERBOSITY_UNSPECIFIED
              - LOG_ERROR_VERBOSITY_TERSE
              - LOG_ERROR_VERBOSITY_DEFAULT
              - LOG_ERROR_VERBOSITY_VERBOSE
          logLockWaits:
            description: '**boolean**'
            type: boolean
          logStatement:
            description: |-
              **enum** (LogStatement)
              - `LOG_STATEMENT_UNSPECIFIED`
              - `LOG_STATEMENT_NONE`
              - `LOG_STATEMENT_DDL`
              - `LOG_STATEMENT_MOD`
              - `LOG_STATEMENT_ALL`
            type: string
            enum:
              - LOG_STATEMENT_UNSPECIFIED
              - LOG_STATEMENT_NONE
              - LOG_STATEMENT_DDL
              - LOG_STATEMENT_MOD
              - LOG_STATEMENT_ALL
          logTempFiles:
            description: '**string** (int64)'
            type: string
            format: int64
          searchPath:
            description: '**string**'
            type: string
          rowSecurity:
            description: '**boolean**'
            type: boolean
          defaultTransactionIsolation:
            description: |-
              **enum** (TransactionIsolation)
              - `TRANSACTION_ISOLATION_UNSPECIFIED`
              - `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
              - `TRANSACTION_ISOLATION_READ_COMMITTED`
              - `TRANSACTION_ISOLATION_REPEATABLE_READ`
              - `TRANSACTION_ISOLATION_SERIALIZABLE`
            type: string
            enum:
              - TRANSACTION_ISOLATION_UNSPECIFIED
              - TRANSACTION_ISOLATION_READ_UNCOMMITTED
              - TRANSACTION_ISOLATION_READ_COMMITTED
              - TRANSACTION_ISOLATION_REPEATABLE_READ
              - TRANSACTION_ISOLATION_SERIALIZABLE
          statementTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          lockTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          idleInTransactionSessionTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          byteaOutput:
            description: |-
              **enum** (ByteaOutput)
              - `BYTEA_OUTPUT_UNSPECIFIED`
              - `BYTEA_OUTPUT_HEX`
              - `BYTEA_OUTPUT_ESCAPED`
            type: string
            enum:
              - BYTEA_OUTPUT_UNSPECIFIED
              - BYTEA_OUTPUT_HEX
              - BYTEA_OUTPUT_ESCAPED
          xmlbinary:
            description: |-
              **enum** (XmlBinary)
              - `XML_BINARY_UNSPECIFIED`
              - `XML_BINARY_BASE64`
              - `XML_BINARY_HEX`
            type: string
            enum:
              - XML_BINARY_UNSPECIFIED
              - XML_BINARY_BASE64
              - XML_BINARY_HEX
          xmloption:
            description: |-
              **enum** (XmlOption)
              - `XML_OPTION_UNSPECIFIED`
              - `XML_OPTION_DOCUMENT`
              - `XML_OPTION_CONTENT`
            type: string
            enum:
              - XML_OPTION_UNSPECIFIED
              - XML_OPTION_DOCUMENT
              - XML_OPTION_CONTENT
          ginPendingListLimit:
            description: |-
              **string** (int64)
              in bytes.
            type: string
            format: int64
          deadlockTimeout:
            description: |-
              **string** (int64)
              in milliseconds.
            type: string
            format: int64
          maxLocksPerTransaction:
            description: '**string** (int64)'
            type: string
            format: int64
          maxPredLocksPerTransaction:
            description: '**string** (int64)'
            type: string
            format: int64
          arrayNulls:
            description: '**boolean**'
            type: boolean
          backslashQuote:
            description: |-
              **enum** (BackslashQuote)
              - `BACKSLASH_QUOTE_UNSPECIFIED`
              - `BACKSLASH_QUOTE`
              - `BACKSLASH_QUOTE_ON`
              - `BACKSLASH_QUOTE_OFF`
              - `BACKSLASH_QUOTE_SAFE_ENCODING`
            type: string
            enum:
              - BACKSLASH_QUOTE_UNSPECIFIED
              - BACKSLASH_QUOTE
              - BACKSLASH_QUOTE_ON
              - BACKSLASH_QUOTE_OFF
              - BACKSLASH_QUOTE_SAFE_ENCODING
          defaultWithOids:
            description: '**boolean**'
            type: boolean
          escapeStringWarning:
            description: '**boolean**'
            type: boolean
          loCompatPrivileges:
            description: '**boolean**'
            type: boolean
          quoteAllIdentifiers:
            description: '**boolean**'
            type: boolean
          standardConformingStrings:
            description: '**boolean**'
            type: boolean
          synchronizeSeqscans:
            description: '**boolean**'
            type: boolean
          transformNullEquals:
            description: '**boolean**'
            type: boolean
          exitOnError:
            description: '**boolean**'
            type: boolean
          seqPageCost:
            description: '**number** (double)'
            type: number
            format: double
          randomPageCost:
            description: '**number** (double)'
            type: number
            format: double
          enableBitmapscan:
            description: '**boolean**'
            type: boolean
          enableHashagg:
            description: '**boolean**'
            type: boolean
          enableHashjoin:
            description: '**boolean**'
            type: boolean
          enableIndexscan:
            description: '**boolean**'
            type: boolean
          enableIndexonlyscan:
            description: '**boolean**'
            type: boolean
          enableMaterial:
            description: '**boolean**'
            type: boolean
          enableMergejoin:
            description: '**boolean**'
            type: boolean
          enableNestloop:
            description: '**boolean**'
            type: boolean
          enableSeqscan:
            description: '**boolean**'
            type: boolean
          enableSort:
            description: '**boolean**'
            type: boolean
          enableTidscan:
            description: '**boolean**'
            type: boolean
          maxParallelWorkers:
            description: '**string** (int64)'
            type: string
            format: int64
          maxParallelWorkersPerGather:
            description: '**string** (int64)'
            type: string
            format: int64
          timezone:
            description: '**string**'
            type: string
          effectiveIoConcurrency:
            description: '**string** (int64)'
            type: string
            format: int64
          effectiveCacheSize:
            description: '**string** (int64)'
            type: string
            format: int64
      ConfigHostSpec:
        type: object
        properties:
          postgresqlConfig_9_6:
            description: |-
              **[PostgresqlHostConfig9_6](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig9_6)**
              Configuration for a host with PostgreSQL 9.6 server deployed.
              Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`.
            $ref: '#/definitions/PostgresqlHostConfig9_6'
          postgresqlConfig_10_1c:
            description: |-
              **[PostgresqlHostConfig10_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig10_1C)**
              Configuration for a host with PostgreSQL 10 1C server deployed.
              Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`.
            $ref: '#/definitions/PostgresqlHostConfig10_1C'
          postgresqlConfig_10:
            description: |-
              **[PostgresqlHostConfig10](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig10)**
              Configuration for a host with PostgreSQL 10 server deployed.
              Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`.
            $ref: '#/definitions/PostgresqlHostConfig10'
          postgresqlConfig_11:
            description: |-
              **[PostgresqlHostConfig11](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig11)**
              Configuration for a host with PostgreSQL 11 server deployed.
              Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`.
            $ref: '#/definitions/PostgresqlHostConfig11'
          postgresqlConfig_11_1c:
            description: |-
              **[PostgresqlHostConfig11_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig11_1C)**
              Configuration for a host with PostgreSQL 11 1C server deployed.
              Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`.
            $ref: '#/definitions/PostgresqlHostConfig11_1C'
          postgresqlConfig_12:
            description: |-
              **[PostgresqlHostConfig12](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig12)**
              Configuration for a host with PostgreSQL 12 server deployed.
              Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`.
            $ref: '#/definitions/PostgresqlHostConfig12'
          postgresqlConfig_12_1c:
            description: |-
              **[PostgresqlHostConfig12_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig12_1C)**
              Configuration for a host with PostgreSQL 12 1C server deployed.
              Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`.
            $ref: '#/definitions/PostgresqlHostConfig12_1C'
          postgresqlConfig_13:
            description: |-
              **[PostgresqlHostConfig13](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig13)**
              Configuration for a host with PostgreSQL 13 server deployed.
              Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`.
            $ref: '#/definitions/PostgresqlHostConfig13'
          postgresqlConfig_13_1c:
            description: |-
              **[PostgresqlHostConfig13_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig13_1C)**
              Configuration for a host with PostgreSQL 13 1C server deployed.
              Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`.
            $ref: '#/definitions/PostgresqlHostConfig13_1C'
          postgresqlConfig_14:
            description: |-
              **[PostgresqlHostConfig14](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig14)**
              Configuration for a host with PostgreSQL 14 server deployed.
              Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`.
            $ref: '#/definitions/PostgresqlHostConfig14'
          postgresqlConfig_14_1c:
            description: |-
              **[PostgresqlHostConfig14_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig14_1C)**
              Configuration for a host with PostgreSQL 14 1C server deployed.
              Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`.
            $ref: '#/definitions/PostgresqlHostConfig14_1C'
          postgresqlConfig_15:
            description: |-
              **[PostgresqlHostConfig15](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig15)**
              Configuration for a host with PostgreSQL 15 server deployed.
              Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`.
            $ref: '#/definitions/PostgresqlHostConfig15'
          postgresqlConfig_15_1c:
            description: |-
              **[PostgresqlHostConfig15_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig15_1C)**
              Configuration for a host with PostgreSQL 15 1C server deployed.
              Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`.
            $ref: '#/definitions/PostgresqlHostConfig15_1C'
          postgresqlConfig_16:
            description: |-
              **[PostgresqlHostConfig16](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig16)**
              Configuration for a host with PostgreSQL 16 server deployed.
              Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`.
            $ref: '#/definitions/PostgresqlHostConfig16'
          postgresqlConfig_16_1c:
            description: |-
              **[PostgresqlHostConfig16_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig16_1C)**
              Configuration for a host with PostgreSQL 16 1C server deployed.
              Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`.
            $ref: '#/definitions/PostgresqlHostConfig16_1C'
          postgresqlConfig_17:
            description: |-
              **[PostgresqlHostConfig17](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig17)**
              Configuration for a host with PostgreSQL 17 1C server deployed.
              Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`.
            $ref: '#/definitions/PostgresqlHostConfig17'
          postgresqlConfig_17_1c:
            description: |-
              **[PostgresqlHostConfig17_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig17_1C)**
              Configuration for a host with PostgreSQL 17 1C server deployed.
              Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`.
            $ref: '#/definitions/PostgresqlHostConfig17_1C'
          postgresqlConfig_18:
            description: |-
              **[PostgresqlHostConfig18](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig18)**
              Configuration for a host with PostgreSQL 18 1C server deployed.
              Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`.
            $ref: '#/definitions/PostgresqlHostConfig18'
          postgresqlConfig_18_1c:
            description: |-
              **[PostgresqlHostConfig18_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig18_1C)**
              Configuration for a host with PostgreSQL 18 1C server deployed.
              Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`.
            $ref: '#/definitions/PostgresqlHostConfig18_1C'
        oneOf:
          - required:
              - postgresqlConfig_9_6
          - required:
              - postgresqlConfig_10_1c
          - required:
              - postgresqlConfig_10
          - required:
              - postgresqlConfig_11
          - required:
              - postgresqlConfig_11_1c
          - required:
              - postgresqlConfig_12
          - required:
              - postgresqlConfig_12_1c
          - required:
              - postgresqlConfig_13
          - required:
              - postgresqlConfig_13_1c
          - required:
              - postgresqlConfig_14
          - required:
              - postgresqlConfig_14_1c
          - required:
              - postgresqlConfig_15
          - required:
              - postgresqlConfig_15_1c
          - required:
              - postgresqlConfig_16
          - required:
              - postgresqlConfig_16_1c
          - required:
              - postgresqlConfig_17
          - required:
              - postgresqlConfig_17_1c
          - required:
              - postgresqlConfig_18
          - required:
              - postgresqlConfig_18_1c
      UpdateHostSpec:
        type: object
        properties:
          hostName:
            description: |-
              **string**
              Required field. Name of the host to update.
              To get the PostgreSQL host name, use a [ClusterService.ListHosts](/docs/managed-postgresql/api-ref/Cluster/listHosts#ListHosts) request.
            type: string
          replicationSource:
            description: |-
              **string**
              [Host.name](/docs/managed-postgresql/api-ref/Cluster/listHosts#yandex.cloud.mdb.postgresql.v1.Host) of the host to be used as the replication source (for cascading replication).
              To get the PostgreSQL host name, use a [ClusterService.ListHosts](/docs/managed-postgresql/api-ref/Cluster/listHosts#ListHosts) request.
            type: string
          priority:
            description: |-
              **string** (int64)
              The host with the highest priority is the synchronous replica. All others are asynchronous.
              The synchronous replica replaces the master when needed.
              When a replica becomes the master, its priority is ignored.
            type: string
            format: int64
          configSpec:
            description: |-
              **[ConfigHostSpec](#yandex.cloud.mdb.postgresql.v1.ConfigHostSpec)**
              Configuration of a PostgreSQL server for the host.
            $ref: '#/definitions/ConfigHostSpec'
          updateMask:
            description: |-
              **string** (field-mask)
              A comma-separated names off ALL fields to be updated.
              Only the specified fields will be changed. The others will be left untouched.
              If the field is specified in `` updateMask `` and no value for that field was sent in the request,
              the field's value will be reset to the default. The default value for most fields is null or 0.
              If `` updateMask `` is not sent in the request, all fields' values will be updated.
              Fields specified in the request will be updated to provided values.
              The rest of the fields will be reset to the default.
            type: string
            format: field-mask
          assignPublicIp:
            description: |-
              **boolean**
              Whether the host should get a public IP address on creation.
            type: boolean
        required:
          - hostName
sourcePath: en/_api-ref/mdb/postgresql/v1/api-ref/Cluster/updateHosts.md
---

# Managed Service for PostgreSQL API, REST: Cluster.UpdateHosts

Updates the specified hosts.

## HTTP request

```
POST https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/{clusterId}/hosts:batchUpdate
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the PostgreSQL cluster to update hosts in.
To get the PostgreSQL cluster ID, use a [ClusterService.List](/docs/managed-postgresql/api-ref/Cluster/list#List) request. ||
|#

## Body parameters {#yandex.cloud.mdb.postgresql.v1.UpdateClusterHostsRequest}

```json
{
  "updateHostSpecs": [
    {
      "hostName": "string",
      "replicationSource": "string",
      "priority": "string",
      "configSpec": {
        // Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`
        "postgresqlConfig_9_6": {
          "recoveryMinApplyDelay": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "workMem": "string",
          "replacementSortTuples": "string",
          "tempFileLimit": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "maxStandbyStreamingDelay": "string",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "string",
          "joinCollapseLimit": "string",
          "forceParallelMode": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "string",
          "logCheckpoints": "boolean",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logDuration": "boolean",
          "logErrorVerbosity": "string",
          "logLockWaits": "boolean",
          "logStatement": "string",
          "logTempFiles": "string",
          "searchPath": "string",
          "rowSecurity": "boolean",
          "defaultTransactionIsolation": "string",
          "statementTimeout": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "string",
          "deadlockTimeout": "string",
          "maxLocksPerTransaction": "string",
          "maxPredLocksPerTransaction": "string",
          "arrayNulls": "boolean",
          "backslashQuote": "string",
          "defaultWithOids": "boolean",
          "escapeStringWarning": "boolean",
          "loCompatPrivileges": "boolean",
          "operatorPrecedenceWarning": "boolean",
          "quoteAllIdentifiers": "boolean",
          "standardConformingStrings": "boolean",
          "synchronizeSeqscans": "boolean",
          "transformNullEquals": "boolean",
          "exitOnError": "boolean",
          "seqPageCost": "number",
          "randomPageCost": "number",
          "sqlInheritance": "boolean",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string"
        },
        "postgresqlConfig_10_1c": {
          "recoveryMinApplyDelay": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "workMem": "string",
          "replacementSortTuples": "string",
          "tempFileLimit": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "maxStandbyStreamingDelay": "string",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "string",
          "joinCollapseLimit": "string",
          "forceParallelMode": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "string",
          "logCheckpoints": "boolean",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logDuration": "boolean",
          "logErrorVerbosity": "string",
          "logLockWaits": "boolean",
          "logStatement": "string",
          "logTempFiles": "string",
          "searchPath": "string",
          "rowSecurity": "boolean",
          "defaultTransactionIsolation": "string",
          "statementTimeout": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "string",
          "deadlockTimeout": "string",
          "maxLocksPerTransaction": "string",
          "maxPredLocksPerTransaction": "string",
          "arrayNulls": "boolean",
          "backslashQuote": "string",
          "defaultWithOids": "boolean",
          "escapeStringWarning": "boolean",
          "loCompatPrivileges": "boolean",
          "operatorPrecedenceWarning": "boolean",
          "quoteAllIdentifiers": "boolean",
          "standardConformingStrings": "boolean",
          "synchronizeSeqscans": "boolean",
          "transformNullEquals": "boolean",
          "exitOnError": "boolean",
          "seqPageCost": "number",
          "randomPageCost": "number",
          "enableBitmapscan": "boolean",
          "enableHashagg": "boolean",
          "enableHashjoin": "boolean",
          "enableIndexscan": "boolean",
          "enableIndexonlyscan": "boolean",
          "enableMaterial": "boolean",
          "enableMergejoin": "boolean",
          "enableNestloop": "boolean",
          "enableSeqscan": "boolean",
          "enableSort": "boolean",
          "enableTidscan": "boolean",
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "timezone": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string"
        },
        "postgresqlConfig_10": {
          "recoveryMinApplyDelay": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "workMem": "string",
          "replacementSortTuples": "string",
          "tempFileLimit": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "maxStandbyStreamingDelay": "string",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "string",
          "joinCollapseLimit": "string",
          "forceParallelMode": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "string",
          "logCheckpoints": "boolean",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logDuration": "boolean",
          "logErrorVerbosity": "string",
          "logLockWaits": "boolean",
          "logStatement": "string",
          "logTempFiles": "string",
          "searchPath": "string",
          "rowSecurity": "boolean",
          "defaultTransactionIsolation": "string",
          "statementTimeout": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "string",
          "deadlockTimeout": "string",
          "maxLocksPerTransaction": "string",
          "maxPredLocksPerTransaction": "string",
          "arrayNulls": "boolean",
          "backslashQuote": "string",
          "defaultWithOids": "boolean",
          "escapeStringWarning": "boolean",
          "loCompatPrivileges": "boolean",
          "operatorPrecedenceWarning": "boolean",
          "quoteAllIdentifiers": "boolean",
          "standardConformingStrings": "boolean",
          "synchronizeSeqscans": "boolean",
          "transformNullEquals": "boolean",
          "exitOnError": "boolean",
          "seqPageCost": "number",
          "randomPageCost": "number",
          "enableBitmapscan": "boolean",
          "enableHashagg": "boolean",
          "enableHashjoin": "boolean",
          "enableIndexscan": "boolean",
          "enableIndexonlyscan": "boolean",
          "enableMaterial": "boolean",
          "enableMergejoin": "boolean",
          "enableNestloop": "boolean",
          "enableSeqscan": "boolean",
          "enableSort": "boolean",
          "enableTidscan": "boolean",
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "timezone": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string"
        },
        "postgresqlConfig_11": {
          "recoveryMinApplyDelay": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "workMem": "string",
          "tempFileLimit": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "maxStandbyStreamingDelay": "string",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "string",
          "joinCollapseLimit": "string",
          "forceParallelMode": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "string",
          "logCheckpoints": "boolean",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logDuration": "boolean",
          "logErrorVerbosity": "string",
          "logLockWaits": "boolean",
          "logStatement": "string",
          "logTempFiles": "string",
          "searchPath": "string",
          "rowSecurity": "boolean",
          "defaultTransactionIsolation": "string",
          "statementTimeout": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "string",
          "deadlockTimeout": "string",
          "maxLocksPerTransaction": "string",
          "maxPredLocksPerTransaction": "string",
          "arrayNulls": "boolean",
          "backslashQuote": "string",
          "defaultWithOids": "boolean",
          "escapeStringWarning": "boolean",
          "loCompatPrivileges": "boolean",
          "operatorPrecedenceWarning": "boolean",
          "quoteAllIdentifiers": "boolean",
          "standardConformingStrings": "boolean",
          "synchronizeSeqscans": "boolean",
          "transformNullEquals": "boolean",
          "exitOnError": "boolean",
          "seqPageCost": "number",
          "randomPageCost": "number",
          "enableBitmapscan": "boolean",
          "enableHashagg": "boolean",
          "enableHashjoin": "boolean",
          "enableIndexscan": "boolean",
          "enableIndexonlyscan": "boolean",
          "enableMaterial": "boolean",
          "enableMergejoin": "boolean",
          "enableNestloop": "boolean",
          "enableSeqscan": "boolean",
          "enableSort": "boolean",
          "enableTidscan": "boolean",
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "timezone": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string"
        },
        "postgresqlConfig_11_1c": {
          "recoveryMinApplyDelay": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "workMem": "string",
          "tempFileLimit": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "maxStandbyStreamingDelay": "string",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "string",
          "joinCollapseLimit": "string",
          "forceParallelMode": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "string",
          "logCheckpoints": "boolean",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logDuration": "boolean",
          "logErrorVerbosity": "string",
          "logLockWaits": "boolean",
          "logStatement": "string",
          "logTempFiles": "string",
          "searchPath": "string",
          "rowSecurity": "boolean",
          "defaultTransactionIsolation": "string",
          "statementTimeout": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "string",
          "deadlockTimeout": "string",
          "maxLocksPerTransaction": "string",
          "maxPredLocksPerTransaction": "string",
          "arrayNulls": "boolean",
          "backslashQuote": "string",
          "defaultWithOids": "boolean",
          "escapeStringWarning": "boolean",
          "loCompatPrivileges": "boolean",
          "operatorPrecedenceWarning": "boolean",
          "quoteAllIdentifiers": "boolean",
          "standardConformingStrings": "boolean",
          "synchronizeSeqscans": "boolean",
          "transformNullEquals": "boolean",
          "exitOnError": "boolean",
          "seqPageCost": "number",
          "randomPageCost": "number",
          "enableBitmapscan": "boolean",
          "enableHashagg": "boolean",
          "enableHashjoin": "boolean",
          "enableIndexscan": "boolean",
          "enableIndexonlyscan": "boolean",
          "enableMaterial": "boolean",
          "enableMergejoin": "boolean",
          "enableNestloop": "boolean",
          "enableSeqscan": "boolean",
          "enableSort": "boolean",
          "enableTidscan": "boolean",
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "timezone": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string"
        },
        "postgresqlConfig_12": {
          "recoveryMinApplyDelay": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "workMem": "string",
          "tempFileLimit": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "maxStandbyStreamingDelay": "string",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "string",
          "joinCollapseLimit": "string",
          "forceParallelMode": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "string",
          "logCheckpoints": "boolean",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logDuration": "boolean",
          "logErrorVerbosity": "string",
          "logLockWaits": "boolean",
          "logStatement": "string",
          "logTempFiles": "string",
          "searchPath": "string",
          "rowSecurity": "boolean",
          "defaultTransactionIsolation": "string",
          "statementTimeout": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "string",
          "deadlockTimeout": "string",
          "maxLocksPerTransaction": "string",
          "maxPredLocksPerTransaction": "string",
          "arrayNulls": "boolean",
          "backslashQuote": "string",
          "defaultWithOids": "boolean",
          "escapeStringWarning": "boolean",
          "loCompatPrivileges": "boolean",
          "operatorPrecedenceWarning": "boolean",
          "quoteAllIdentifiers": "boolean",
          "standardConformingStrings": "boolean",
          "synchronizeSeqscans": "boolean",
          "transformNullEquals": "boolean",
          "exitOnError": "boolean",
          "seqPageCost": "number",
          "randomPageCost": "number",
          "enableBitmapscan": "boolean",
          "enableHashagg": "boolean",
          "enableHashjoin": "boolean",
          "enableIndexscan": "boolean",
          "enableIndexonlyscan": "boolean",
          "enableMaterial": "boolean",
          "enableMergejoin": "boolean",
          "enableNestloop": "boolean",
          "enableSeqscan": "boolean",
          "enableSort": "boolean",
          "enableTidscan": "boolean",
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "timezone": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string"
        },
        "postgresqlConfig_12_1c": {
          "recoveryMinApplyDelay": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "workMem": "string",
          "tempFileLimit": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "maxStandbyStreamingDelay": "string",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "string",
          "joinCollapseLimit": "string",
          "forceParallelMode": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "string",
          "logCheckpoints": "boolean",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logDuration": "boolean",
          "logErrorVerbosity": "string",
          "logLockWaits": "boolean",
          "logStatement": "string",
          "logTempFiles": "string",
          "searchPath": "string",
          "rowSecurity": "boolean",
          "defaultTransactionIsolation": "string",
          "statementTimeout": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "string",
          "deadlockTimeout": "string",
          "maxLocksPerTransaction": "string",
          "maxPredLocksPerTransaction": "string",
          "arrayNulls": "boolean",
          "backslashQuote": "string",
          "defaultWithOids": "boolean",
          "escapeStringWarning": "boolean",
          "loCompatPrivileges": "boolean",
          "operatorPrecedenceWarning": "boolean",
          "quoteAllIdentifiers": "boolean",
          "standardConformingStrings": "boolean",
          "synchronizeSeqscans": "boolean",
          "transformNullEquals": "boolean",
          "exitOnError": "boolean",
          "seqPageCost": "number",
          "randomPageCost": "number",
          "enableBitmapscan": "boolean",
          "enableHashagg": "boolean",
          "enableHashjoin": "boolean",
          "enableIndexscan": "boolean",
          "enableIndexonlyscan": "boolean",
          "enableMaterial": "boolean",
          "enableMergejoin": "boolean",
          "enableNestloop": "boolean",
          "enableSeqscan": "boolean",
          "enableSort": "boolean",
          "enableTidscan": "boolean",
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "timezone": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string"
        },
        "postgresqlConfig_13": {
          "recoveryMinApplyDelay": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "workMem": "string",
          "tempFileLimit": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "maxStandbyStreamingDelay": "string",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "string",
          "joinCollapseLimit": "string",
          "forceParallelMode": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "string",
          "logCheckpoints": "boolean",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logDuration": "boolean",
          "logErrorVerbosity": "string",
          "logLockWaits": "boolean",
          "logStatement": "string",
          "logTempFiles": "string",
          "searchPath": "string",
          "rowSecurity": "boolean",
          "defaultTransactionIsolation": "string",
          "statementTimeout": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "string",
          "deadlockTimeout": "string",
          "maxLocksPerTransaction": "string",
          "maxPredLocksPerTransaction": "string",
          "arrayNulls": "boolean",
          "backslashQuote": "string",
          "defaultWithOids": "boolean",
          "escapeStringWarning": "boolean",
          "loCompatPrivileges": "boolean",
          "operatorPrecedenceWarning": "boolean",
          "quoteAllIdentifiers": "boolean",
          "standardConformingStrings": "boolean",
          "synchronizeSeqscans": "boolean",
          "transformNullEquals": "boolean",
          "exitOnError": "boolean",
          "seqPageCost": "number",
          "randomPageCost": "number",
          "enableBitmapscan": "boolean",
          "enableHashagg": "boolean",
          "enableHashjoin": "boolean",
          "enableIndexscan": "boolean",
          "enableIndexonlyscan": "boolean",
          "enableMaterial": "boolean",
          "enableMergejoin": "boolean",
          "enableNestloop": "boolean",
          "enableSeqscan": "boolean",
          "enableSort": "boolean",
          "enableTidscan": "boolean",
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "timezone": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string"
        },
        "postgresqlConfig_13_1c": {
          "recoveryMinApplyDelay": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "workMem": "string",
          "tempFileLimit": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "maxStandbyStreamingDelay": "string",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "string",
          "joinCollapseLimit": "string",
          "forceParallelMode": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "string",
          "logCheckpoints": "boolean",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logDuration": "boolean",
          "logErrorVerbosity": "string",
          "logLockWaits": "boolean",
          "logStatement": "string",
          "logTempFiles": "string",
          "searchPath": "string",
          "rowSecurity": "boolean",
          "defaultTransactionIsolation": "string",
          "statementTimeout": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "string",
          "deadlockTimeout": "string",
          "maxLocksPerTransaction": "string",
          "maxPredLocksPerTransaction": "string",
          "arrayNulls": "boolean",
          "backslashQuote": "string",
          "defaultWithOids": "boolean",
          "escapeStringWarning": "boolean",
          "loCompatPrivileges": "boolean",
          "operatorPrecedenceWarning": "boolean",
          "quoteAllIdentifiers": "boolean",
          "standardConformingStrings": "boolean",
          "synchronizeSeqscans": "boolean",
          "transformNullEquals": "boolean",
          "exitOnError": "boolean",
          "seqPageCost": "number",
          "randomPageCost": "number",
          "enableBitmapscan": "boolean",
          "enableHashagg": "boolean",
          "enableHashjoin": "boolean",
          "enableIndexscan": "boolean",
          "enableIndexonlyscan": "boolean",
          "enableMaterial": "boolean",
          "enableMergejoin": "boolean",
          "enableNestloop": "boolean",
          "enableSeqscan": "boolean",
          "enableSort": "boolean",
          "enableTidscan": "boolean",
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "timezone": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string"
        },
        "postgresqlConfig_14": {
          "recoveryMinApplyDelay": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "workMem": "string",
          "tempFileLimit": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "maxStandbyStreamingDelay": "string",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "string",
          "joinCollapseLimit": "string",
          "forceParallelMode": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "string",
          "logCheckpoints": "boolean",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logDuration": "boolean",
          "logErrorVerbosity": "string",
          "logLockWaits": "boolean",
          "logStatement": "string",
          "logTempFiles": "string",
          "searchPath": "string",
          "rowSecurity": "boolean",
          "defaultTransactionIsolation": "string",
          "statementTimeout": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "string",
          "deadlockTimeout": "string",
          "maxLocksPerTransaction": "string",
          "maxPredLocksPerTransaction": "string",
          "arrayNulls": "boolean",
          "backslashQuote": "string",
          "defaultWithOids": "boolean",
          "escapeStringWarning": "boolean",
          "loCompatPrivileges": "boolean",
          "quoteAllIdentifiers": "boolean",
          "standardConformingStrings": "boolean",
          "synchronizeSeqscans": "boolean",
          "transformNullEquals": "boolean",
          "exitOnError": "boolean",
          "seqPageCost": "number",
          "randomPageCost": "number",
          "enableBitmapscan": "boolean",
          "enableHashagg": "boolean",
          "enableHashjoin": "boolean",
          "enableIndexscan": "boolean",
          "enableIndexonlyscan": "boolean",
          "enableMaterial": "boolean",
          "enableMergejoin": "boolean",
          "enableNestloop": "boolean",
          "enableSeqscan": "boolean",
          "enableSort": "boolean",
          "enableTidscan": "boolean",
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "timezone": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string"
        },
        "postgresqlConfig_14_1c": {
          "recoveryMinApplyDelay": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "workMem": "string",
          "tempFileLimit": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "maxStandbyStreamingDelay": "string",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "string",
          "joinCollapseLimit": "string",
          "forceParallelMode": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "string",
          "logCheckpoints": "boolean",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logDuration": "boolean",
          "logErrorVerbosity": "string",
          "logLockWaits": "boolean",
          "logStatement": "string",
          "logTempFiles": "string",
          "searchPath": "string",
          "rowSecurity": "boolean",
          "defaultTransactionIsolation": "string",
          "statementTimeout": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "string",
          "deadlockTimeout": "string",
          "maxLocksPerTransaction": "string",
          "maxPredLocksPerTransaction": "string",
          "arrayNulls": "boolean",
          "backslashQuote": "string",
          "defaultWithOids": "boolean",
          "escapeStringWarning": "boolean",
          "loCompatPrivileges": "boolean",
          "quoteAllIdentifiers": "boolean",
          "standardConformingStrings": "boolean",
          "synchronizeSeqscans": "boolean",
          "transformNullEquals": "boolean",
          "exitOnError": "boolean",
          "seqPageCost": "number",
          "randomPageCost": "number",
          "enableBitmapscan": "boolean",
          "enableHashagg": "boolean",
          "enableHashjoin": "boolean",
          "enableIndexscan": "boolean",
          "enableIndexonlyscan": "boolean",
          "enableMaterial": "boolean",
          "enableMergejoin": "boolean",
          "enableNestloop": "boolean",
          "enableSeqscan": "boolean",
          "enableSort": "boolean",
          "enableTidscan": "boolean",
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "timezone": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string"
        },
        "postgresqlConfig_15": {
          "recoveryMinApplyDelay": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "workMem": "string",
          "tempFileLimit": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "maxStandbyStreamingDelay": "string",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "string",
          "joinCollapseLimit": "string",
          "forceParallelMode": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "string",
          "logCheckpoints": "boolean",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logDuration": "boolean",
          "logErrorVerbosity": "string",
          "logLockWaits": "boolean",
          "logStatement": "string",
          "logTempFiles": "string",
          "searchPath": "string",
          "rowSecurity": "boolean",
          "defaultTransactionIsolation": "string",
          "statementTimeout": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "string",
          "deadlockTimeout": "string",
          "maxLocksPerTransaction": "string",
          "maxPredLocksPerTransaction": "string",
          "arrayNulls": "boolean",
          "backslashQuote": "string",
          "defaultWithOids": "boolean",
          "escapeStringWarning": "boolean",
          "loCompatPrivileges": "boolean",
          "quoteAllIdentifiers": "boolean",
          "standardConformingStrings": "boolean",
          "synchronizeSeqscans": "boolean",
          "transformNullEquals": "boolean",
          "exitOnError": "boolean",
          "seqPageCost": "number",
          "randomPageCost": "number",
          "enableBitmapscan": "boolean",
          "enableHashagg": "boolean",
          "enableHashjoin": "boolean",
          "enableIndexscan": "boolean",
          "enableIndexonlyscan": "boolean",
          "enableMaterial": "boolean",
          "enableMergejoin": "boolean",
          "enableNestloop": "boolean",
          "enableSeqscan": "boolean",
          "enableSort": "boolean",
          "enableTidscan": "boolean",
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "timezone": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string"
        },
        "postgresqlConfig_15_1c": {
          "recoveryMinApplyDelay": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "workMem": "string",
          "tempFileLimit": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "maxStandbyStreamingDelay": "string",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "string",
          "joinCollapseLimit": "string",
          "forceParallelMode": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "string",
          "logCheckpoints": "boolean",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logDuration": "boolean",
          "logErrorVerbosity": "string",
          "logLockWaits": "boolean",
          "logStatement": "string",
          "logTempFiles": "string",
          "searchPath": "string",
          "rowSecurity": "boolean",
          "defaultTransactionIsolation": "string",
          "statementTimeout": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "string",
          "deadlockTimeout": "string",
          "maxLocksPerTransaction": "string",
          "maxPredLocksPerTransaction": "string",
          "arrayNulls": "boolean",
          "backslashQuote": "string",
          "defaultWithOids": "boolean",
          "escapeStringWarning": "boolean",
          "loCompatPrivileges": "boolean",
          "quoteAllIdentifiers": "boolean",
          "standardConformingStrings": "boolean",
          "synchronizeSeqscans": "boolean",
          "transformNullEquals": "boolean",
          "exitOnError": "boolean",
          "seqPageCost": "number",
          "randomPageCost": "number",
          "enableBitmapscan": "boolean",
          "enableHashagg": "boolean",
          "enableHashjoin": "boolean",
          "enableIndexscan": "boolean",
          "enableIndexonlyscan": "boolean",
          "enableMaterial": "boolean",
          "enableMergejoin": "boolean",
          "enableNestloop": "boolean",
          "enableSeqscan": "boolean",
          "enableSort": "boolean",
          "enableTidscan": "boolean",
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "timezone": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string"
        },
        "postgresqlConfig_16": {
          "recoveryMinApplyDelay": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "workMem": "string",
          "tempFileLimit": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "maxStandbyStreamingDelay": "string",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "string",
          "joinCollapseLimit": "string",
          "debugParallelQuery": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "string",
          "logCheckpoints": "boolean",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logDuration": "boolean",
          "logErrorVerbosity": "string",
          "logLockWaits": "boolean",
          "logStatement": "string",
          "logTempFiles": "string",
          "searchPath": "string",
          "rowSecurity": "boolean",
          "defaultTransactionIsolation": "string",
          "statementTimeout": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "string",
          "deadlockTimeout": "string",
          "maxLocksPerTransaction": "string",
          "maxPredLocksPerTransaction": "string",
          "arrayNulls": "boolean",
          "backslashQuote": "string",
          "defaultWithOids": "boolean",
          "escapeStringWarning": "boolean",
          "loCompatPrivileges": "boolean",
          "quoteAllIdentifiers": "boolean",
          "standardConformingStrings": "boolean",
          "synchronizeSeqscans": "boolean",
          "transformNullEquals": "boolean",
          "exitOnError": "boolean",
          "seqPageCost": "number",
          "randomPageCost": "number",
          "enableBitmapscan": "boolean",
          "enableHashagg": "boolean",
          "enableHashjoin": "boolean",
          "enableIndexscan": "boolean",
          "enableIndexonlyscan": "boolean",
          "enableMaterial": "boolean",
          "enableMergejoin": "boolean",
          "enableNestloop": "boolean",
          "enableSeqscan": "boolean",
          "enableSort": "boolean",
          "enableTidscan": "boolean",
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "timezone": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string"
        },
        "postgresqlConfig_16_1c": {
          "recoveryMinApplyDelay": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "workMem": "string",
          "tempFileLimit": "string",
          "backendFlushAfter": "string",
          "oldSnapshotThreshold": "string",
          "maxStandbyStreamingDelay": "string",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "string",
          "joinCollapseLimit": "string",
          "debugParallelQuery": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "string",
          "logCheckpoints": "boolean",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logDuration": "boolean",
          "logErrorVerbosity": "string",
          "logLockWaits": "boolean",
          "logStatement": "string",
          "logTempFiles": "string",
          "searchPath": "string",
          "rowSecurity": "boolean",
          "defaultTransactionIsolation": "string",
          "statementTimeout": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "string",
          "deadlockTimeout": "string",
          "maxLocksPerTransaction": "string",
          "maxPredLocksPerTransaction": "string",
          "arrayNulls": "boolean",
          "backslashQuote": "string",
          "defaultWithOids": "boolean",
          "escapeStringWarning": "boolean",
          "loCompatPrivileges": "boolean",
          "quoteAllIdentifiers": "boolean",
          "standardConformingStrings": "boolean",
          "synchronizeSeqscans": "boolean",
          "transformNullEquals": "boolean",
          "exitOnError": "boolean",
          "seqPageCost": "number",
          "randomPageCost": "number",
          "enableBitmapscan": "boolean",
          "enableHashagg": "boolean",
          "enableHashjoin": "boolean",
          "enableIndexscan": "boolean",
          "enableIndexonlyscan": "boolean",
          "enableMaterial": "boolean",
          "enableMergejoin": "boolean",
          "enableNestloop": "boolean",
          "enableSeqscan": "boolean",
          "enableSort": "boolean",
          "enableTidscan": "boolean",
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "timezone": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string"
        },
        "postgresqlConfig_17": {
          "recoveryMinApplyDelay": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "workMem": "string",
          "tempFileLimit": "string",
          "backendFlushAfter": "string",
          "maxStandbyStreamingDelay": "string",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "string",
          "joinCollapseLimit": "string",
          "debugParallelQuery": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "string",
          "logCheckpoints": "boolean",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logDuration": "boolean",
          "logErrorVerbosity": "string",
          "logLockWaits": "boolean",
          "logStatement": "string",
          "logTempFiles": "string",
          "searchPath": "string",
          "rowSecurity": "boolean",
          "defaultTransactionIsolation": "string",
          "statementTimeout": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "string",
          "deadlockTimeout": "string",
          "maxLocksPerTransaction": "string",
          "maxPredLocksPerTransaction": "string",
          "arrayNulls": "boolean",
          "backslashQuote": "string",
          "defaultWithOids": "boolean",
          "escapeStringWarning": "boolean",
          "loCompatPrivileges": "boolean",
          "quoteAllIdentifiers": "boolean",
          "standardConformingStrings": "boolean",
          "synchronizeSeqscans": "boolean",
          "transformNullEquals": "boolean",
          "exitOnError": "boolean",
          "seqPageCost": "number",
          "randomPageCost": "number",
          "enableBitmapscan": "boolean",
          "enableHashagg": "boolean",
          "enableHashjoin": "boolean",
          "enableIndexscan": "boolean",
          "enableIndexonlyscan": "boolean",
          "enableMaterial": "boolean",
          "enableMergejoin": "boolean",
          "enableNestloop": "boolean",
          "enableSeqscan": "boolean",
          "enableSort": "boolean",
          "enableTidscan": "boolean",
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "timezone": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string"
        },
        "postgresqlConfig_17_1c": {
          "recoveryMinApplyDelay": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "workMem": "string",
          "tempFileLimit": "string",
          "backendFlushAfter": "string",
          "maxStandbyStreamingDelay": "string",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "string",
          "joinCollapseLimit": "string",
          "debugParallelQuery": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "string",
          "logCheckpoints": "boolean",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logDuration": "boolean",
          "logErrorVerbosity": "string",
          "logLockWaits": "boolean",
          "logStatement": "string",
          "logTempFiles": "string",
          "searchPath": "string",
          "rowSecurity": "boolean",
          "defaultTransactionIsolation": "string",
          "statementTimeout": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "string",
          "deadlockTimeout": "string",
          "maxLocksPerTransaction": "string",
          "maxPredLocksPerTransaction": "string",
          "arrayNulls": "boolean",
          "backslashQuote": "string",
          "defaultWithOids": "boolean",
          "escapeStringWarning": "boolean",
          "loCompatPrivileges": "boolean",
          "quoteAllIdentifiers": "boolean",
          "standardConformingStrings": "boolean",
          "synchronizeSeqscans": "boolean",
          "transformNullEquals": "boolean",
          "exitOnError": "boolean",
          "seqPageCost": "number",
          "randomPageCost": "number",
          "enableBitmapscan": "boolean",
          "enableHashagg": "boolean",
          "enableHashjoin": "boolean",
          "enableIndexscan": "boolean",
          "enableIndexonlyscan": "boolean",
          "enableMaterial": "boolean",
          "enableMergejoin": "boolean",
          "enableNestloop": "boolean",
          "enableSeqscan": "boolean",
          "enableSort": "boolean",
          "enableTidscan": "boolean",
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "timezone": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string"
        },
        "postgresqlConfig_18": {
          "recoveryMinApplyDelay": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "workMem": "string",
          "tempFileLimit": "string",
          "backendFlushAfter": "string",
          "maxStandbyStreamingDelay": "string",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "string",
          "joinCollapseLimit": "string",
          "debugParallelQuery": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "string",
          "logCheckpoints": "boolean",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logDuration": "boolean",
          "logErrorVerbosity": "string",
          "logLockWaits": "boolean",
          "logStatement": "string",
          "logTempFiles": "string",
          "searchPath": "string",
          "rowSecurity": "boolean",
          "defaultTransactionIsolation": "string",
          "statementTimeout": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "string",
          "deadlockTimeout": "string",
          "maxLocksPerTransaction": "string",
          "maxPredLocksPerTransaction": "string",
          "arrayNulls": "boolean",
          "backslashQuote": "string",
          "defaultWithOids": "boolean",
          "escapeStringWarning": "boolean",
          "loCompatPrivileges": "boolean",
          "quoteAllIdentifiers": "boolean",
          "standardConformingStrings": "boolean",
          "synchronizeSeqscans": "boolean",
          "transformNullEquals": "boolean",
          "exitOnError": "boolean",
          "seqPageCost": "number",
          "randomPageCost": "number",
          "enableBitmapscan": "boolean",
          "enableHashagg": "boolean",
          "enableHashjoin": "boolean",
          "enableIndexscan": "boolean",
          "enableIndexonlyscan": "boolean",
          "enableMaterial": "boolean",
          "enableMergejoin": "boolean",
          "enableNestloop": "boolean",
          "enableSeqscan": "boolean",
          "enableSort": "boolean",
          "enableTidscan": "boolean",
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "timezone": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string"
        },
        "postgresqlConfig_18_1c": {
          "recoveryMinApplyDelay": "string",
          "sharedBuffers": "string",
          "tempBuffers": "string",
          "workMem": "string",
          "tempFileLimit": "string",
          "backendFlushAfter": "string",
          "maxStandbyStreamingDelay": "string",
          "constraintExclusion": "string",
          "cursorTupleFraction": "number",
          "fromCollapseLimit": "string",
          "joinCollapseLimit": "string",
          "debugParallelQuery": "string",
          "clientMinMessages": "string",
          "logMinMessages": "string",
          "logMinErrorStatement": "string",
          "logMinDurationStatement": "string",
          "logCheckpoints": "boolean",
          "logConnections": "boolean",
          "logDisconnections": "boolean",
          "logDuration": "boolean",
          "logErrorVerbosity": "string",
          "logLockWaits": "boolean",
          "logStatement": "string",
          "logTempFiles": "string",
          "searchPath": "string",
          "rowSecurity": "boolean",
          "defaultTransactionIsolation": "string",
          "statementTimeout": "string",
          "lockTimeout": "string",
          "idleInTransactionSessionTimeout": "string",
          "byteaOutput": "string",
          "xmlbinary": "string",
          "xmloption": "string",
          "ginPendingListLimit": "string",
          "deadlockTimeout": "string",
          "maxLocksPerTransaction": "string",
          "maxPredLocksPerTransaction": "string",
          "arrayNulls": "boolean",
          "backslashQuote": "string",
          "defaultWithOids": "boolean",
          "escapeStringWarning": "boolean",
          "loCompatPrivileges": "boolean",
          "quoteAllIdentifiers": "boolean",
          "standardConformingStrings": "boolean",
          "synchronizeSeqscans": "boolean",
          "transformNullEquals": "boolean",
          "exitOnError": "boolean",
          "seqPageCost": "number",
          "randomPageCost": "number",
          "enableBitmapscan": "boolean",
          "enableHashagg": "boolean",
          "enableHashjoin": "boolean",
          "enableIndexscan": "boolean",
          "enableIndexonlyscan": "boolean",
          "enableMaterial": "boolean",
          "enableMergejoin": "boolean",
          "enableNestloop": "boolean",
          "enableSeqscan": "boolean",
          "enableSort": "boolean",
          "enableTidscan": "boolean",
          "maxParallelWorkers": "string",
          "maxParallelWorkersPerGather": "string",
          "timezone": "string",
          "effectiveIoConcurrency": "string",
          "effectiveCacheSize": "string"
        }
        // end of the list of possible fields
      },
      "updateMask": "string",
      "assignPublicIp": "boolean"
    }
  ]
}
```

#|
||Field | Description ||
|| updateHostSpecs[] | **[UpdateHostSpec](#yandex.cloud.mdb.postgresql.v1.UpdateHostSpec)**

New configurations to apply to hosts. ||
|#

## UpdateHostSpec {#yandex.cloud.mdb.postgresql.v1.UpdateHostSpec}

#|
||Field | Description ||
|| hostName | **string**

Required field. Name of the host to update.
To get the PostgreSQL host name, use a [ClusterService.ListHosts](/docs/managed-postgresql/api-ref/Cluster/listHosts#ListHosts) request. ||
|| replicationSource | **string**

[Host.name](/docs/managed-postgresql/api-ref/Cluster/listHosts#yandex.cloud.mdb.postgresql.v1.Host) of the host to be used as the replication source (for cascading replication).
To get the PostgreSQL host name, use a [ClusterService.ListHosts](/docs/managed-postgresql/api-ref/Cluster/listHosts#ListHosts) request. ||
|| priority | **string** (int64)

The host with the highest priority is the synchronous replica. All others are asynchronous.
The synchronous replica replaces the master when needed.

When a replica becomes the master, its priority is ignored. ||
|| configSpec | **[ConfigHostSpec](#yandex.cloud.mdb.postgresql.v1.ConfigHostSpec)**

Configuration of a PostgreSQL server for the host. ||
|| updateMask | **string** (field-mask)

A comma-separated names off ALL fields to be updated.
Only the specified fields will be changed. The others will be left untouched.
If the field is specified in `` updateMask `` and no value for that field was sent in the request,
the field's value will be reset to the default. The default value for most fields is null or 0.

If `` updateMask `` is not sent in the request, all fields' values will be updated.
Fields specified in the request will be updated to provided values.
The rest of the fields will be reset to the default. ||
|| assignPublicIp | **boolean**

Whether the host should get a public IP address on creation. ||
|#

## ConfigHostSpec {#yandex.cloud.mdb.postgresql.v1.ConfigHostSpec}

#|
||Field | Description ||
|| postgresqlConfig_9_6 | **[PostgresqlHostConfig9_6](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig9_6)**

Configuration for a host with PostgreSQL 9.6 server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`. ||
|| postgresqlConfig_10_1c | **[PostgresqlHostConfig10_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig10_1C)**

Configuration for a host with PostgreSQL 10 1C server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`. ||
|| postgresqlConfig_10 | **[PostgresqlHostConfig10](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig10)**

Configuration for a host with PostgreSQL 10 server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`. ||
|| postgresqlConfig_11 | **[PostgresqlHostConfig11](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig11)**

Configuration for a host with PostgreSQL 11 server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`. ||
|| postgresqlConfig_11_1c | **[PostgresqlHostConfig11_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig11_1C)**

Configuration for a host with PostgreSQL 11 1C server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`. ||
|| postgresqlConfig_12 | **[PostgresqlHostConfig12](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig12)**

Configuration for a host with PostgreSQL 12 server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`. ||
|| postgresqlConfig_12_1c | **[PostgresqlHostConfig12_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig12_1C)**

Configuration for a host with PostgreSQL 12 1C server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`. ||
|| postgresqlConfig_13 | **[PostgresqlHostConfig13](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig13)**

Configuration for a host with PostgreSQL 13 server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`. ||
|| postgresqlConfig_13_1c | **[PostgresqlHostConfig13_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig13_1C)**

Configuration for a host with PostgreSQL 13 1C server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`. ||
|| postgresqlConfig_14 | **[PostgresqlHostConfig14](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig14)**

Configuration for a host with PostgreSQL 14 server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`. ||
|| postgresqlConfig_14_1c | **[PostgresqlHostConfig14_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig14_1C)**

Configuration for a host with PostgreSQL 14 1C server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`. ||
|| postgresqlConfig_15 | **[PostgresqlHostConfig15](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig15)**

Configuration for a host with PostgreSQL 15 server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`. ||
|| postgresqlConfig_15_1c | **[PostgresqlHostConfig15_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig15_1C)**

Configuration for a host with PostgreSQL 15 1C server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`. ||
|| postgresqlConfig_16 | **[PostgresqlHostConfig16](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig16)**

Configuration for a host with PostgreSQL 16 server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`. ||
|| postgresqlConfig_16_1c | **[PostgresqlHostConfig16_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig16_1C)**

Configuration for a host with PostgreSQL 16 1C server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`. ||
|| postgresqlConfig_17 | **[PostgresqlHostConfig17](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig17)**

Configuration for a host with PostgreSQL 17 1C server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`. ||
|| postgresqlConfig_17_1c | **[PostgresqlHostConfig17_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig17_1C)**

Configuration for a host with PostgreSQL 17 1C server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`. ||
|| postgresqlConfig_18 | **[PostgresqlHostConfig18](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig18)**

Configuration for a host with PostgreSQL 18 1C server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`. ||
|| postgresqlConfig_18_1c | **[PostgresqlHostConfig18_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig18_1C)**

Configuration for a host with PostgreSQL 18 1C server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`. ||
|#

## PostgresqlHostConfig9_6 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig9_6}

Options and structure of `PostgresqlHostConfig` reflects parameters of a PostgreSQL
configuration file. Detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/9.6/runtime-config.html).

#|
||Field | Description ||
|| recoveryMinApplyDelay | **string** (int64)

in milliseconds. ||
|| sharedBuffers | **string** (int64)

in bytes. ||
|| tempBuffers | **string** (int64)

in bytes. ||
|| workMem | **string** (int64)

in bytes. ||
|| replacementSortTuples | **string** (int64)

in bytes. ||
|| tempFileLimit | **string** (int64)

in bytes. ||
|| backendFlushAfter | **string** (int64) ||
|| oldSnapshotThreshold | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64)

in milliseconds. ||
|| constraintExclusion | **enum** (ConstraintExclusion)

- `CONSTRAINT_EXCLUSION_UNSPECIFIED`
- `CONSTRAINT_EXCLUSION_ON`
- `CONSTRAINT_EXCLUSION_OFF`
- `CONSTRAINT_EXCLUSION_PARTITION` ||
|| cursorTupleFraction | **number** (double) ||
|| fromCollapseLimit | **string** (int64) ||
|| joinCollapseLimit | **string** (int64) ||
|| forceParallelMode | **enum** (ForceParallelMode)

- `FORCE_PARALLEL_MODE_UNSPECIFIED`
- `FORCE_PARALLEL_MODE_ON`
- `FORCE_PARALLEL_MODE_OFF`
- `FORCE_PARALLEL_MODE_REGRESS` ||
|| clientMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinErrorStatement | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinDurationStatement | **string** (int64)

in milliseconds. ||
|| logCheckpoints | **boolean** ||
|| logConnections | **boolean** ||
|| logDisconnections | **boolean** ||
|| logDuration | **boolean** ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

- `LOG_ERROR_VERBOSITY_UNSPECIFIED`
- `LOG_ERROR_VERBOSITY_TERSE`
- `LOG_ERROR_VERBOSITY_DEFAULT`
- `LOG_ERROR_VERBOSITY_VERBOSE` ||
|| logLockWaits | **boolean** ||
|| logStatement | **enum** (LogStatement)

- `LOG_STATEMENT_UNSPECIFIED`
- `LOG_STATEMENT_NONE`
- `LOG_STATEMENT_DDL`
- `LOG_STATEMENT_MOD`
- `LOG_STATEMENT_ALL` ||
|| logTempFiles | **string** (int64) ||
|| searchPath | **string** ||
|| rowSecurity | **boolean** ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

- `TRANSACTION_ISOLATION_UNSPECIFIED`
- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
- `TRANSACTION_ISOLATION_READ_COMMITTED`
- `TRANSACTION_ISOLATION_REPEATABLE_READ`
- `TRANSACTION_ISOLATION_SERIALIZABLE` ||
|| statementTimeout | **string** (int64)

in milliseconds. ||
|| lockTimeout | **string** (int64)

in milliseconds. ||
|| idleInTransactionSessionTimeout | **string** (int64)

in milliseconds. ||
|| byteaOutput | **enum** (ByteaOutput)

- `BYTEA_OUTPUT_UNSPECIFIED`
- `BYTEA_OUTPUT_HEX`
- `BYTEA_OUTPUT_ESCAPED` ||
|| xmlbinary | **enum** (XmlBinary)

- `XML_BINARY_UNSPECIFIED`
- `XML_BINARY_BASE64`
- `XML_BINARY_HEX` ||
|| xmloption | **enum** (XmlOption)

- `XML_OPTION_UNSPECIFIED`
- `XML_OPTION_DOCUMENT`
- `XML_OPTION_CONTENT` ||
|| ginPendingListLimit | **string** (int64)

in bytes. ||
|| deadlockTimeout | **string** (int64)

in milliseconds. ||
|| maxLocksPerTransaction | **string** (int64) ||
|| maxPredLocksPerTransaction | **string** (int64) ||
|| arrayNulls | **boolean** ||
|| backslashQuote | **enum** (BackslashQuote)

- `BACKSLASH_QUOTE_UNSPECIFIED`
- `BACKSLASH_QUOTE`
- `BACKSLASH_QUOTE_ON`
- `BACKSLASH_QUOTE_OFF`
- `BACKSLASH_QUOTE_SAFE_ENCODING` ||
|| defaultWithOids | **boolean** ||
|| escapeStringWarning | **boolean** ||
|| loCompatPrivileges | **boolean** ||
|| operatorPrecedenceWarning | **boolean** ||
|| quoteAllIdentifiers | **boolean** ||
|| standardConformingStrings | **boolean** ||
|| synchronizeSeqscans | **boolean** ||
|| transformNullEquals | **boolean** ||
|| exitOnError | **boolean** ||
|| seqPageCost | **number** (double) ||
|| randomPageCost | **number** (double) ||
|| sqlInheritance | **boolean**

This option has been removed in PostgreSQL 10. ||
|| effectiveIoConcurrency | **string** (int64) ||
|| effectiveCacheSize | **string** (int64) ||
|#

## PostgresqlHostConfig10_1C {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig10_1C}

Options and structure of `PostgresqlHostConfig` reflects PostgreSQL configuration file
parameters whose detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/10/runtime-config.html).

#|
||Field | Description ||
|| recoveryMinApplyDelay | **string** (int64)

in milliseconds. ||
|| sharedBuffers | **string** (int64)

in bytes. ||
|| tempBuffers | **string** (int64)

in bytes. ||
|| workMem | **string** (int64)

in bytes. ||
|| replacementSortTuples | **string** (int64)

in bytes. ||
|| tempFileLimit | **string** (int64)

in bytes. ||
|| backendFlushAfter | **string** (int64) ||
|| oldSnapshotThreshold | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64)

in milliseconds. ||
|| constraintExclusion | **enum** (ConstraintExclusion)

- `CONSTRAINT_EXCLUSION_UNSPECIFIED`
- `CONSTRAINT_EXCLUSION_ON`
- `CONSTRAINT_EXCLUSION_OFF`
- `CONSTRAINT_EXCLUSION_PARTITION` ||
|| cursorTupleFraction | **number** (double) ||
|| fromCollapseLimit | **string** (int64) ||
|| joinCollapseLimit | **string** (int64) ||
|| forceParallelMode | **enum** (ForceParallelMode)

- `FORCE_PARALLEL_MODE_UNSPECIFIED`
- `FORCE_PARALLEL_MODE_ON`
- `FORCE_PARALLEL_MODE_OFF`
- `FORCE_PARALLEL_MODE_REGRESS` ||
|| clientMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinErrorStatement | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinDurationStatement | **string** (int64)

in milliseconds. ||
|| logCheckpoints | **boolean** ||
|| logConnections | **boolean** ||
|| logDisconnections | **boolean** ||
|| logDuration | **boolean** ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

- `LOG_ERROR_VERBOSITY_UNSPECIFIED`
- `LOG_ERROR_VERBOSITY_TERSE`
- `LOG_ERROR_VERBOSITY_DEFAULT`
- `LOG_ERROR_VERBOSITY_VERBOSE` ||
|| logLockWaits | **boolean** ||
|| logStatement | **enum** (LogStatement)

- `LOG_STATEMENT_UNSPECIFIED`
- `LOG_STATEMENT_NONE`
- `LOG_STATEMENT_DDL`
- `LOG_STATEMENT_MOD`
- `LOG_STATEMENT_ALL` ||
|| logTempFiles | **string** (int64) ||
|| searchPath | **string** ||
|| rowSecurity | **boolean** ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

- `TRANSACTION_ISOLATION_UNSPECIFIED`
- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
- `TRANSACTION_ISOLATION_READ_COMMITTED`
- `TRANSACTION_ISOLATION_REPEATABLE_READ`
- `TRANSACTION_ISOLATION_SERIALIZABLE` ||
|| statementTimeout | **string** (int64)

in milliseconds. ||
|| lockTimeout | **string** (int64)

in milliseconds. ||
|| idleInTransactionSessionTimeout | **string** (int64)

in milliseconds. ||
|| byteaOutput | **enum** (ByteaOutput)

- `BYTEA_OUTPUT_UNSPECIFIED`
- `BYTEA_OUTPUT_HEX`
- `BYTEA_OUTPUT_ESCAPED` ||
|| xmlbinary | **enum** (XmlBinary)

- `XML_BINARY_UNSPECIFIED`
- `XML_BINARY_BASE64`
- `XML_BINARY_HEX` ||
|| xmloption | **enum** (XmlOption)

- `XML_OPTION_UNSPECIFIED`
- `XML_OPTION_DOCUMENT`
- `XML_OPTION_CONTENT` ||
|| ginPendingListLimit | **string** (int64)

in bytes. ||
|| deadlockTimeout | **string** (int64)

in milliseconds. ||
|| maxLocksPerTransaction | **string** (int64) ||
|| maxPredLocksPerTransaction | **string** (int64) ||
|| arrayNulls | **boolean** ||
|| backslashQuote | **enum** (BackslashQuote)

- `BACKSLASH_QUOTE_UNSPECIFIED`
- `BACKSLASH_QUOTE`
- `BACKSLASH_QUOTE_ON`
- `BACKSLASH_QUOTE_OFF`
- `BACKSLASH_QUOTE_SAFE_ENCODING` ||
|| defaultWithOids | **boolean** ||
|| escapeStringWarning | **boolean** ||
|| loCompatPrivileges | **boolean** ||
|| operatorPrecedenceWarning | **boolean** ||
|| quoteAllIdentifiers | **boolean** ||
|| standardConformingStrings | **boolean** ||
|| synchronizeSeqscans | **boolean** ||
|| transformNullEquals | **boolean** ||
|| exitOnError | **boolean** ||
|| seqPageCost | **number** (double) ||
|| randomPageCost | **number** (double) ||
|| enableBitmapscan | **boolean** ||
|| enableHashagg | **boolean** ||
|| enableHashjoin | **boolean** ||
|| enableIndexscan | **boolean** ||
|| enableIndexonlyscan | **boolean** ||
|| enableMaterial | **boolean** ||
|| enableMergejoin | **boolean** ||
|| enableNestloop | **boolean** ||
|| enableSeqscan | **boolean** ||
|| enableSort | **boolean** ||
|| enableTidscan | **boolean** ||
|| maxParallelWorkers | **string** (int64) ||
|| maxParallelWorkersPerGather | **string** (int64) ||
|| timezone | **string** ||
|| effectiveIoConcurrency | **string** (int64) ||
|| effectiveCacheSize | **string** (int64) ||
|#

## PostgresqlHostConfig10 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig10}

Options and structure of `PostgresqlHostConfig` reflects PostgreSQL configuration file
parameters whose detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/10/runtime-config.html).

#|
||Field | Description ||
|| recoveryMinApplyDelay | **string** (int64)

in milliseconds. ||
|| sharedBuffers | **string** (int64)

in bytes. ||
|| tempBuffers | **string** (int64)

in bytes. ||
|| workMem | **string** (int64)

in bytes. ||
|| replacementSortTuples | **string** (int64)

in bytes. ||
|| tempFileLimit | **string** (int64)

in bytes. ||
|| backendFlushAfter | **string** (int64) ||
|| oldSnapshotThreshold | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64)

in milliseconds. ||
|| constraintExclusion | **enum** (ConstraintExclusion)

- `CONSTRAINT_EXCLUSION_UNSPECIFIED`
- `CONSTRAINT_EXCLUSION_ON`
- `CONSTRAINT_EXCLUSION_OFF`
- `CONSTRAINT_EXCLUSION_PARTITION` ||
|| cursorTupleFraction | **number** (double) ||
|| fromCollapseLimit | **string** (int64) ||
|| joinCollapseLimit | **string** (int64) ||
|| forceParallelMode | **enum** (ForceParallelMode)

- `FORCE_PARALLEL_MODE_UNSPECIFIED`
- `FORCE_PARALLEL_MODE_ON`
- `FORCE_PARALLEL_MODE_OFF`
- `FORCE_PARALLEL_MODE_REGRESS` ||
|| clientMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinErrorStatement | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinDurationStatement | **string** (int64)

in milliseconds. ||
|| logCheckpoints | **boolean** ||
|| logConnections | **boolean** ||
|| logDisconnections | **boolean** ||
|| logDuration | **boolean** ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

- `LOG_ERROR_VERBOSITY_UNSPECIFIED`
- `LOG_ERROR_VERBOSITY_TERSE`
- `LOG_ERROR_VERBOSITY_DEFAULT`
- `LOG_ERROR_VERBOSITY_VERBOSE` ||
|| logLockWaits | **boolean** ||
|| logStatement | **enum** (LogStatement)

- `LOG_STATEMENT_UNSPECIFIED`
- `LOG_STATEMENT_NONE`
- `LOG_STATEMENT_DDL`
- `LOG_STATEMENT_MOD`
- `LOG_STATEMENT_ALL` ||
|| logTempFiles | **string** (int64) ||
|| searchPath | **string** ||
|| rowSecurity | **boolean** ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

- `TRANSACTION_ISOLATION_UNSPECIFIED`
- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
- `TRANSACTION_ISOLATION_READ_COMMITTED`
- `TRANSACTION_ISOLATION_REPEATABLE_READ`
- `TRANSACTION_ISOLATION_SERIALIZABLE` ||
|| statementTimeout | **string** (int64)

in milliseconds. ||
|| lockTimeout | **string** (int64)

in milliseconds. ||
|| idleInTransactionSessionTimeout | **string** (int64)

in milliseconds. ||
|| byteaOutput | **enum** (ByteaOutput)

- `BYTEA_OUTPUT_UNSPECIFIED`
- `BYTEA_OUTPUT_HEX`
- `BYTEA_OUTPUT_ESCAPED` ||
|| xmlbinary | **enum** (XmlBinary)

- `XML_BINARY_UNSPECIFIED`
- `XML_BINARY_BASE64`
- `XML_BINARY_HEX` ||
|| xmloption | **enum** (XmlOption)

- `XML_OPTION_UNSPECIFIED`
- `XML_OPTION_DOCUMENT`
- `XML_OPTION_CONTENT` ||
|| ginPendingListLimit | **string** (int64)

in bytes. ||
|| deadlockTimeout | **string** (int64)

in milliseconds. ||
|| maxLocksPerTransaction | **string** (int64) ||
|| maxPredLocksPerTransaction | **string** (int64) ||
|| arrayNulls | **boolean** ||
|| backslashQuote | **enum** (BackslashQuote)

- `BACKSLASH_QUOTE_UNSPECIFIED`
- `BACKSLASH_QUOTE`
- `BACKSLASH_QUOTE_ON`
- `BACKSLASH_QUOTE_OFF`
- `BACKSLASH_QUOTE_SAFE_ENCODING` ||
|| defaultWithOids | **boolean** ||
|| escapeStringWarning | **boolean** ||
|| loCompatPrivileges | **boolean** ||
|| operatorPrecedenceWarning | **boolean** ||
|| quoteAllIdentifiers | **boolean** ||
|| standardConformingStrings | **boolean** ||
|| synchronizeSeqscans | **boolean** ||
|| transformNullEquals | **boolean** ||
|| exitOnError | **boolean** ||
|| seqPageCost | **number** (double) ||
|| randomPageCost | **number** (double) ||
|| enableBitmapscan | **boolean** ||
|| enableHashagg | **boolean** ||
|| enableHashjoin | **boolean** ||
|| enableIndexscan | **boolean** ||
|| enableIndexonlyscan | **boolean** ||
|| enableMaterial | **boolean** ||
|| enableMergejoin | **boolean** ||
|| enableNestloop | **boolean** ||
|| enableSeqscan | **boolean** ||
|| enableSort | **boolean** ||
|| enableTidscan | **boolean** ||
|| maxParallelWorkers | **string** (int64) ||
|| maxParallelWorkersPerGather | **string** (int64) ||
|| timezone | **string** ||
|| effectiveIoConcurrency | **string** (int64) ||
|| effectiveCacheSize | **string** (int64) ||
|#

## PostgresqlHostConfig11 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig11}

Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file
parameters which detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/11/runtime-config.html).

#|
||Field | Description ||
|| recoveryMinApplyDelay | **string** (int64)

in milliseconds. ||
|| sharedBuffers | **string** (int64)

in bytes. ||
|| tempBuffers | **string** (int64)

in bytes. ||
|| workMem | **string** (int64)

in bytes. ||
|| tempFileLimit | **string** (int64)

in bytes. ||
|| backendFlushAfter | **string** (int64) ||
|| oldSnapshotThreshold | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64)

in milliseconds. ||
|| constraintExclusion | **enum** (ConstraintExclusion)

- `CONSTRAINT_EXCLUSION_UNSPECIFIED`
- `CONSTRAINT_EXCLUSION_ON`
- `CONSTRAINT_EXCLUSION_OFF`
- `CONSTRAINT_EXCLUSION_PARTITION` ||
|| cursorTupleFraction | **number** (double) ||
|| fromCollapseLimit | **string** (int64) ||
|| joinCollapseLimit | **string** (int64) ||
|| forceParallelMode | **enum** (ForceParallelMode)

- `FORCE_PARALLEL_MODE_UNSPECIFIED`
- `FORCE_PARALLEL_MODE_ON`
- `FORCE_PARALLEL_MODE_OFF`
- `FORCE_PARALLEL_MODE_REGRESS` ||
|| clientMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinErrorStatement | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinDurationStatement | **string** (int64)

in milliseconds. ||
|| logCheckpoints | **boolean** ||
|| logConnections | **boolean** ||
|| logDisconnections | **boolean** ||
|| logDuration | **boolean** ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

- `LOG_ERROR_VERBOSITY_UNSPECIFIED`
- `LOG_ERROR_VERBOSITY_TERSE`
- `LOG_ERROR_VERBOSITY_DEFAULT`
- `LOG_ERROR_VERBOSITY_VERBOSE` ||
|| logLockWaits | **boolean** ||
|| logStatement | **enum** (LogStatement)

- `LOG_STATEMENT_UNSPECIFIED`
- `LOG_STATEMENT_NONE`
- `LOG_STATEMENT_DDL`
- `LOG_STATEMENT_MOD`
- `LOG_STATEMENT_ALL` ||
|| logTempFiles | **string** (int64) ||
|| searchPath | **string** ||
|| rowSecurity | **boolean** ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

- `TRANSACTION_ISOLATION_UNSPECIFIED`
- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
- `TRANSACTION_ISOLATION_READ_COMMITTED`
- `TRANSACTION_ISOLATION_REPEATABLE_READ`
- `TRANSACTION_ISOLATION_SERIALIZABLE` ||
|| statementTimeout | **string** (int64)

in milliseconds. ||
|| lockTimeout | **string** (int64)

in milliseconds. ||
|| idleInTransactionSessionTimeout | **string** (int64)

in milliseconds. ||
|| byteaOutput | **enum** (ByteaOutput)

- `BYTEA_OUTPUT_UNSPECIFIED`
- `BYTEA_OUTPUT_HEX`
- `BYTEA_OUTPUT_ESCAPED` ||
|| xmlbinary | **enum** (XmlBinary)

- `XML_BINARY_UNSPECIFIED`
- `XML_BINARY_BASE64`
- `XML_BINARY_HEX` ||
|| xmloption | **enum** (XmlOption)

- `XML_OPTION_UNSPECIFIED`
- `XML_OPTION_DOCUMENT`
- `XML_OPTION_CONTENT` ||
|| ginPendingListLimit | **string** (int64)

in bytes. ||
|| deadlockTimeout | **string** (int64)

in milliseconds. ||
|| maxLocksPerTransaction | **string** (int64) ||
|| maxPredLocksPerTransaction | **string** (int64) ||
|| arrayNulls | **boolean** ||
|| backslashQuote | **enum** (BackslashQuote)

- `BACKSLASH_QUOTE_UNSPECIFIED`
- `BACKSLASH_QUOTE`
- `BACKSLASH_QUOTE_ON`
- `BACKSLASH_QUOTE_OFF`
- `BACKSLASH_QUOTE_SAFE_ENCODING` ||
|| defaultWithOids | **boolean** ||
|| escapeStringWarning | **boolean** ||
|| loCompatPrivileges | **boolean** ||
|| operatorPrecedenceWarning | **boolean** ||
|| quoteAllIdentifiers | **boolean** ||
|| standardConformingStrings | **boolean** ||
|| synchronizeSeqscans | **boolean** ||
|| transformNullEquals | **boolean** ||
|| exitOnError | **boolean** ||
|| seqPageCost | **number** (double) ||
|| randomPageCost | **number** (double) ||
|| enableBitmapscan | **boolean** ||
|| enableHashagg | **boolean** ||
|| enableHashjoin | **boolean** ||
|| enableIndexscan | **boolean** ||
|| enableIndexonlyscan | **boolean** ||
|| enableMaterial | **boolean** ||
|| enableMergejoin | **boolean** ||
|| enableNestloop | **boolean** ||
|| enableSeqscan | **boolean** ||
|| enableSort | **boolean** ||
|| enableTidscan | **boolean** ||
|| maxParallelWorkers | **string** (int64) ||
|| maxParallelWorkersPerGather | **string** (int64) ||
|| timezone | **string** ||
|| effectiveIoConcurrency | **string** (int64) ||
|| effectiveCacheSize | **string** (int64) ||
|#

## PostgresqlHostConfig11_1C {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig11_1C}

Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file
parameters which detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/11/runtime-config.html).

#|
||Field | Description ||
|| recoveryMinApplyDelay | **string** (int64)

in milliseconds. ||
|| sharedBuffers | **string** (int64)

in bytes. ||
|| tempBuffers | **string** (int64)

in bytes. ||
|| workMem | **string** (int64)

in bytes. ||
|| tempFileLimit | **string** (int64)

in bytes. ||
|| backendFlushAfter | **string** (int64) ||
|| oldSnapshotThreshold | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64)

in milliseconds. ||
|| constraintExclusion | **enum** (ConstraintExclusion)

- `CONSTRAINT_EXCLUSION_UNSPECIFIED`
- `CONSTRAINT_EXCLUSION_ON`
- `CONSTRAINT_EXCLUSION_OFF`
- `CONSTRAINT_EXCLUSION_PARTITION` ||
|| cursorTupleFraction | **number** (double) ||
|| fromCollapseLimit | **string** (int64) ||
|| joinCollapseLimit | **string** (int64) ||
|| forceParallelMode | **enum** (ForceParallelMode)

- `FORCE_PARALLEL_MODE_UNSPECIFIED`
- `FORCE_PARALLEL_MODE_ON`
- `FORCE_PARALLEL_MODE_OFF`
- `FORCE_PARALLEL_MODE_REGRESS` ||
|| clientMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinErrorStatement | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinDurationStatement | **string** (int64)

in milliseconds. ||
|| logCheckpoints | **boolean** ||
|| logConnections | **boolean** ||
|| logDisconnections | **boolean** ||
|| logDuration | **boolean** ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

- `LOG_ERROR_VERBOSITY_UNSPECIFIED`
- `LOG_ERROR_VERBOSITY_TERSE`
- `LOG_ERROR_VERBOSITY_DEFAULT`
- `LOG_ERROR_VERBOSITY_VERBOSE` ||
|| logLockWaits | **boolean** ||
|| logStatement | **enum** (LogStatement)

- `LOG_STATEMENT_UNSPECIFIED`
- `LOG_STATEMENT_NONE`
- `LOG_STATEMENT_DDL`
- `LOG_STATEMENT_MOD`
- `LOG_STATEMENT_ALL` ||
|| logTempFiles | **string** (int64) ||
|| searchPath | **string** ||
|| rowSecurity | **boolean** ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

- `TRANSACTION_ISOLATION_UNSPECIFIED`
- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
- `TRANSACTION_ISOLATION_READ_COMMITTED`
- `TRANSACTION_ISOLATION_REPEATABLE_READ`
- `TRANSACTION_ISOLATION_SERIALIZABLE` ||
|| statementTimeout | **string** (int64)

in milliseconds. ||
|| lockTimeout | **string** (int64)

in milliseconds. ||
|| idleInTransactionSessionTimeout | **string** (int64)

in milliseconds. ||
|| byteaOutput | **enum** (ByteaOutput)

- `BYTEA_OUTPUT_UNSPECIFIED`
- `BYTEA_OUTPUT_HEX`
- `BYTEA_OUTPUT_ESCAPED` ||
|| xmlbinary | **enum** (XmlBinary)

- `XML_BINARY_UNSPECIFIED`
- `XML_BINARY_BASE64`
- `XML_BINARY_HEX` ||
|| xmloption | **enum** (XmlOption)

- `XML_OPTION_UNSPECIFIED`
- `XML_OPTION_DOCUMENT`
- `XML_OPTION_CONTENT` ||
|| ginPendingListLimit | **string** (int64)

in bytes. ||
|| deadlockTimeout | **string** (int64)

in milliseconds. ||
|| maxLocksPerTransaction | **string** (int64) ||
|| maxPredLocksPerTransaction | **string** (int64) ||
|| arrayNulls | **boolean** ||
|| backslashQuote | **enum** (BackslashQuote)

- `BACKSLASH_QUOTE_UNSPECIFIED`
- `BACKSLASH_QUOTE`
- `BACKSLASH_QUOTE_ON`
- `BACKSLASH_QUOTE_OFF`
- `BACKSLASH_QUOTE_SAFE_ENCODING` ||
|| defaultWithOids | **boolean** ||
|| escapeStringWarning | **boolean** ||
|| loCompatPrivileges | **boolean** ||
|| operatorPrecedenceWarning | **boolean** ||
|| quoteAllIdentifiers | **boolean** ||
|| standardConformingStrings | **boolean** ||
|| synchronizeSeqscans | **boolean** ||
|| transformNullEquals | **boolean** ||
|| exitOnError | **boolean** ||
|| seqPageCost | **number** (double) ||
|| randomPageCost | **number** (double) ||
|| enableBitmapscan | **boolean** ||
|| enableHashagg | **boolean** ||
|| enableHashjoin | **boolean** ||
|| enableIndexscan | **boolean** ||
|| enableIndexonlyscan | **boolean** ||
|| enableMaterial | **boolean** ||
|| enableMergejoin | **boolean** ||
|| enableNestloop | **boolean** ||
|| enableSeqscan | **boolean** ||
|| enableSort | **boolean** ||
|| enableTidscan | **boolean** ||
|| maxParallelWorkers | **string** (int64) ||
|| maxParallelWorkersPerGather | **string** (int64) ||
|| timezone | **string** ||
|| effectiveIoConcurrency | **string** (int64) ||
|| effectiveCacheSize | **string** (int64) ||
|#

## PostgresqlHostConfig12 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig12}

Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file
parameters which detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/11/runtime-config.html).

#|
||Field | Description ||
|| recoveryMinApplyDelay | **string** (int64)

in milliseconds. ||
|| sharedBuffers | **string** (int64)

in bytes. ||
|| tempBuffers | **string** (int64)

in bytes. ||
|| workMem | **string** (int64)

in bytes. ||
|| tempFileLimit | **string** (int64)

in bytes. ||
|| backendFlushAfter | **string** (int64) ||
|| oldSnapshotThreshold | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64)

in milliseconds. ||
|| constraintExclusion | **enum** (ConstraintExclusion)

- `CONSTRAINT_EXCLUSION_UNSPECIFIED`
- `CONSTRAINT_EXCLUSION_ON`
- `CONSTRAINT_EXCLUSION_OFF`
- `CONSTRAINT_EXCLUSION_PARTITION` ||
|| cursorTupleFraction | **number** (double) ||
|| fromCollapseLimit | **string** (int64) ||
|| joinCollapseLimit | **string** (int64) ||
|| forceParallelMode | **enum** (ForceParallelMode)

- `FORCE_PARALLEL_MODE_UNSPECIFIED`
- `FORCE_PARALLEL_MODE_ON`
- `FORCE_PARALLEL_MODE_OFF`
- `FORCE_PARALLEL_MODE_REGRESS` ||
|| clientMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinErrorStatement | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinDurationStatement | **string** (int64)

in milliseconds. ||
|| logCheckpoints | **boolean** ||
|| logConnections | **boolean** ||
|| logDisconnections | **boolean** ||
|| logDuration | **boolean** ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

- `LOG_ERROR_VERBOSITY_UNSPECIFIED`
- `LOG_ERROR_VERBOSITY_TERSE`
- `LOG_ERROR_VERBOSITY_DEFAULT`
- `LOG_ERROR_VERBOSITY_VERBOSE` ||
|| logLockWaits | **boolean** ||
|| logStatement | **enum** (LogStatement)

- `LOG_STATEMENT_UNSPECIFIED`
- `LOG_STATEMENT_NONE`
- `LOG_STATEMENT_DDL`
- `LOG_STATEMENT_MOD`
- `LOG_STATEMENT_ALL` ||
|| logTempFiles | **string** (int64) ||
|| searchPath | **string** ||
|| rowSecurity | **boolean** ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

- `TRANSACTION_ISOLATION_UNSPECIFIED`
- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
- `TRANSACTION_ISOLATION_READ_COMMITTED`
- `TRANSACTION_ISOLATION_REPEATABLE_READ`
- `TRANSACTION_ISOLATION_SERIALIZABLE` ||
|| statementTimeout | **string** (int64)

in milliseconds. ||
|| lockTimeout | **string** (int64)

in milliseconds. ||
|| idleInTransactionSessionTimeout | **string** (int64)

in milliseconds. ||
|| byteaOutput | **enum** (ByteaOutput)

- `BYTEA_OUTPUT_UNSPECIFIED`
- `BYTEA_OUTPUT_HEX`
- `BYTEA_OUTPUT_ESCAPED` ||
|| xmlbinary | **enum** (XmlBinary)

- `XML_BINARY_UNSPECIFIED`
- `XML_BINARY_BASE64`
- `XML_BINARY_HEX` ||
|| xmloption | **enum** (XmlOption)

- `XML_OPTION_UNSPECIFIED`
- `XML_OPTION_DOCUMENT`
- `XML_OPTION_CONTENT` ||
|| ginPendingListLimit | **string** (int64)

in bytes. ||
|| deadlockTimeout | **string** (int64)

in milliseconds. ||
|| maxLocksPerTransaction | **string** (int64) ||
|| maxPredLocksPerTransaction | **string** (int64) ||
|| arrayNulls | **boolean** ||
|| backslashQuote | **enum** (BackslashQuote)

- `BACKSLASH_QUOTE_UNSPECIFIED`
- `BACKSLASH_QUOTE`
- `BACKSLASH_QUOTE_ON`
- `BACKSLASH_QUOTE_OFF`
- `BACKSLASH_QUOTE_SAFE_ENCODING` ||
|| defaultWithOids | **boolean** ||
|| escapeStringWarning | **boolean** ||
|| loCompatPrivileges | **boolean** ||
|| operatorPrecedenceWarning | **boolean** ||
|| quoteAllIdentifiers | **boolean** ||
|| standardConformingStrings | **boolean** ||
|| synchronizeSeqscans | **boolean** ||
|| transformNullEquals | **boolean** ||
|| exitOnError | **boolean** ||
|| seqPageCost | **number** (double) ||
|| randomPageCost | **number** (double) ||
|| enableBitmapscan | **boolean** ||
|| enableHashagg | **boolean** ||
|| enableHashjoin | **boolean** ||
|| enableIndexscan | **boolean** ||
|| enableIndexonlyscan | **boolean** ||
|| enableMaterial | **boolean** ||
|| enableMergejoin | **boolean** ||
|| enableNestloop | **boolean** ||
|| enableSeqscan | **boolean** ||
|| enableSort | **boolean** ||
|| enableTidscan | **boolean** ||
|| maxParallelWorkers | **string** (int64) ||
|| maxParallelWorkersPerGather | **string** (int64) ||
|| timezone | **string** ||
|| effectiveIoConcurrency | **string** (int64) ||
|| effectiveCacheSize | **string** (int64) ||
|#

## PostgresqlHostConfig12_1C {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig12_1C}

Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file
parameters which detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/11/runtime-config.html).

#|
||Field | Description ||
|| recoveryMinApplyDelay | **string** (int64)

in milliseconds. ||
|| sharedBuffers | **string** (int64)

in bytes. ||
|| tempBuffers | **string** (int64)

in bytes. ||
|| workMem | **string** (int64)

in bytes. ||
|| tempFileLimit | **string** (int64)

in bytes. ||
|| backendFlushAfter | **string** (int64) ||
|| oldSnapshotThreshold | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64)

in milliseconds. ||
|| constraintExclusion | **enum** (ConstraintExclusion)

- `CONSTRAINT_EXCLUSION_UNSPECIFIED`
- `CONSTRAINT_EXCLUSION_ON`
- `CONSTRAINT_EXCLUSION_OFF`
- `CONSTRAINT_EXCLUSION_PARTITION` ||
|| cursorTupleFraction | **number** (double) ||
|| fromCollapseLimit | **string** (int64) ||
|| joinCollapseLimit | **string** (int64) ||
|| forceParallelMode | **enum** (ForceParallelMode)

- `FORCE_PARALLEL_MODE_UNSPECIFIED`
- `FORCE_PARALLEL_MODE_ON`
- `FORCE_PARALLEL_MODE_OFF`
- `FORCE_PARALLEL_MODE_REGRESS` ||
|| clientMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinErrorStatement | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinDurationStatement | **string** (int64)

in milliseconds. ||
|| logCheckpoints | **boolean** ||
|| logConnections | **boolean** ||
|| logDisconnections | **boolean** ||
|| logDuration | **boolean** ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

- `LOG_ERROR_VERBOSITY_UNSPECIFIED`
- `LOG_ERROR_VERBOSITY_TERSE`
- `LOG_ERROR_VERBOSITY_DEFAULT`
- `LOG_ERROR_VERBOSITY_VERBOSE` ||
|| logLockWaits | **boolean** ||
|| logStatement | **enum** (LogStatement)

- `LOG_STATEMENT_UNSPECIFIED`
- `LOG_STATEMENT_NONE`
- `LOG_STATEMENT_DDL`
- `LOG_STATEMENT_MOD`
- `LOG_STATEMENT_ALL` ||
|| logTempFiles | **string** (int64) ||
|| searchPath | **string** ||
|| rowSecurity | **boolean** ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

- `TRANSACTION_ISOLATION_UNSPECIFIED`
- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
- `TRANSACTION_ISOLATION_READ_COMMITTED`
- `TRANSACTION_ISOLATION_REPEATABLE_READ`
- `TRANSACTION_ISOLATION_SERIALIZABLE` ||
|| statementTimeout | **string** (int64)

in milliseconds. ||
|| lockTimeout | **string** (int64)

in milliseconds. ||
|| idleInTransactionSessionTimeout | **string** (int64)

in milliseconds. ||
|| byteaOutput | **enum** (ByteaOutput)

- `BYTEA_OUTPUT_UNSPECIFIED`
- `BYTEA_OUTPUT_HEX`
- `BYTEA_OUTPUT_ESCAPED` ||
|| xmlbinary | **enum** (XmlBinary)

- `XML_BINARY_UNSPECIFIED`
- `XML_BINARY_BASE64`
- `XML_BINARY_HEX` ||
|| xmloption | **enum** (XmlOption)

- `XML_OPTION_UNSPECIFIED`
- `XML_OPTION_DOCUMENT`
- `XML_OPTION_CONTENT` ||
|| ginPendingListLimit | **string** (int64)

in bytes. ||
|| deadlockTimeout | **string** (int64)

in milliseconds. ||
|| maxLocksPerTransaction | **string** (int64) ||
|| maxPredLocksPerTransaction | **string** (int64) ||
|| arrayNulls | **boolean** ||
|| backslashQuote | **enum** (BackslashQuote)

- `BACKSLASH_QUOTE_UNSPECIFIED`
- `BACKSLASH_QUOTE`
- `BACKSLASH_QUOTE_ON`
- `BACKSLASH_QUOTE_OFF`
- `BACKSLASH_QUOTE_SAFE_ENCODING` ||
|| defaultWithOids | **boolean** ||
|| escapeStringWarning | **boolean** ||
|| loCompatPrivileges | **boolean** ||
|| operatorPrecedenceWarning | **boolean** ||
|| quoteAllIdentifiers | **boolean** ||
|| standardConformingStrings | **boolean** ||
|| synchronizeSeqscans | **boolean** ||
|| transformNullEquals | **boolean** ||
|| exitOnError | **boolean** ||
|| seqPageCost | **number** (double) ||
|| randomPageCost | **number** (double) ||
|| enableBitmapscan | **boolean** ||
|| enableHashagg | **boolean** ||
|| enableHashjoin | **boolean** ||
|| enableIndexscan | **boolean** ||
|| enableIndexonlyscan | **boolean** ||
|| enableMaterial | **boolean** ||
|| enableMergejoin | **boolean** ||
|| enableNestloop | **boolean** ||
|| enableSeqscan | **boolean** ||
|| enableSort | **boolean** ||
|| enableTidscan | **boolean** ||
|| maxParallelWorkers | **string** (int64) ||
|| maxParallelWorkersPerGather | **string** (int64) ||
|| timezone | **string** ||
|| effectiveIoConcurrency | **string** (int64) ||
|| effectiveCacheSize | **string** (int64) ||
|#

## PostgresqlHostConfig13 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig13}

Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file
parameters which detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/11/runtime-config.html).

#|
||Field | Description ||
|| recoveryMinApplyDelay | **string** (int64)

in milliseconds. ||
|| sharedBuffers | **string** (int64)

in bytes. ||
|| tempBuffers | **string** (int64)

in bytes. ||
|| workMem | **string** (int64)

in bytes. ||
|| tempFileLimit | **string** (int64)

in bytes. ||
|| backendFlushAfter | **string** (int64) ||
|| oldSnapshotThreshold | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64)

in milliseconds. ||
|| constraintExclusion | **enum** (ConstraintExclusion)

- `CONSTRAINT_EXCLUSION_UNSPECIFIED`
- `CONSTRAINT_EXCLUSION_ON`
- `CONSTRAINT_EXCLUSION_OFF`
- `CONSTRAINT_EXCLUSION_PARTITION` ||
|| cursorTupleFraction | **number** (double) ||
|| fromCollapseLimit | **string** (int64) ||
|| joinCollapseLimit | **string** (int64) ||
|| forceParallelMode | **enum** (ForceParallelMode)

- `FORCE_PARALLEL_MODE_UNSPECIFIED`
- `FORCE_PARALLEL_MODE_ON`
- `FORCE_PARALLEL_MODE_OFF`
- `FORCE_PARALLEL_MODE_REGRESS` ||
|| clientMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinErrorStatement | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinDurationStatement | **string** (int64)

in milliseconds. ||
|| logCheckpoints | **boolean** ||
|| logConnections | **boolean** ||
|| logDisconnections | **boolean** ||
|| logDuration | **boolean** ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

- `LOG_ERROR_VERBOSITY_UNSPECIFIED`
- `LOG_ERROR_VERBOSITY_TERSE`
- `LOG_ERROR_VERBOSITY_DEFAULT`
- `LOG_ERROR_VERBOSITY_VERBOSE` ||
|| logLockWaits | **boolean** ||
|| logStatement | **enum** (LogStatement)

- `LOG_STATEMENT_UNSPECIFIED`
- `LOG_STATEMENT_NONE`
- `LOG_STATEMENT_DDL`
- `LOG_STATEMENT_MOD`
- `LOG_STATEMENT_ALL` ||
|| logTempFiles | **string** (int64) ||
|| searchPath | **string** ||
|| rowSecurity | **boolean** ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

- `TRANSACTION_ISOLATION_UNSPECIFIED`
- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
- `TRANSACTION_ISOLATION_READ_COMMITTED`
- `TRANSACTION_ISOLATION_REPEATABLE_READ`
- `TRANSACTION_ISOLATION_SERIALIZABLE` ||
|| statementTimeout | **string** (int64)

in milliseconds. ||
|| lockTimeout | **string** (int64)

in milliseconds. ||
|| idleInTransactionSessionTimeout | **string** (int64)

in milliseconds. ||
|| byteaOutput | **enum** (ByteaOutput)

- `BYTEA_OUTPUT_UNSPECIFIED`
- `BYTEA_OUTPUT_HEX`
- `BYTEA_OUTPUT_ESCAPED` ||
|| xmlbinary | **enum** (XmlBinary)

- `XML_BINARY_UNSPECIFIED`
- `XML_BINARY_BASE64`
- `XML_BINARY_HEX` ||
|| xmloption | **enum** (XmlOption)

- `XML_OPTION_UNSPECIFIED`
- `XML_OPTION_DOCUMENT`
- `XML_OPTION_CONTENT` ||
|| ginPendingListLimit | **string** (int64)

in bytes. ||
|| deadlockTimeout | **string** (int64)

in milliseconds. ||
|| maxLocksPerTransaction | **string** (int64) ||
|| maxPredLocksPerTransaction | **string** (int64) ||
|| arrayNulls | **boolean** ||
|| backslashQuote | **enum** (BackslashQuote)

- `BACKSLASH_QUOTE_UNSPECIFIED`
- `BACKSLASH_QUOTE`
- `BACKSLASH_QUOTE_ON`
- `BACKSLASH_QUOTE_OFF`
- `BACKSLASH_QUOTE_SAFE_ENCODING` ||
|| defaultWithOids | **boolean** ||
|| escapeStringWarning | **boolean** ||
|| loCompatPrivileges | **boolean** ||
|| operatorPrecedenceWarning | **boolean** ||
|| quoteAllIdentifiers | **boolean** ||
|| standardConformingStrings | **boolean** ||
|| synchronizeSeqscans | **boolean** ||
|| transformNullEquals | **boolean** ||
|| exitOnError | **boolean** ||
|| seqPageCost | **number** (double) ||
|| randomPageCost | **number** (double) ||
|| enableBitmapscan | **boolean** ||
|| enableHashagg | **boolean** ||
|| enableHashjoin | **boolean** ||
|| enableIndexscan | **boolean** ||
|| enableIndexonlyscan | **boolean** ||
|| enableMaterial | **boolean** ||
|| enableMergejoin | **boolean** ||
|| enableNestloop | **boolean** ||
|| enableSeqscan | **boolean** ||
|| enableSort | **boolean** ||
|| enableTidscan | **boolean** ||
|| maxParallelWorkers | **string** (int64) ||
|| maxParallelWorkersPerGather | **string** (int64) ||
|| timezone | **string** ||
|| effectiveIoConcurrency | **string** (int64) ||
|| effectiveCacheSize | **string** (int64) ||
|#

## PostgresqlHostConfig13_1C {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig13_1C}

Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file
parameters which detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/11/runtime-config.html).

#|
||Field | Description ||
|| recoveryMinApplyDelay | **string** (int64)

in milliseconds. ||
|| sharedBuffers | **string** (int64)

in bytes. ||
|| tempBuffers | **string** (int64)

in bytes. ||
|| workMem | **string** (int64)

in bytes. ||
|| tempFileLimit | **string** (int64)

in bytes. ||
|| backendFlushAfter | **string** (int64) ||
|| oldSnapshotThreshold | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64)

in milliseconds. ||
|| constraintExclusion | **enum** (ConstraintExclusion)

- `CONSTRAINT_EXCLUSION_UNSPECIFIED`
- `CONSTRAINT_EXCLUSION_ON`
- `CONSTRAINT_EXCLUSION_OFF`
- `CONSTRAINT_EXCLUSION_PARTITION` ||
|| cursorTupleFraction | **number** (double) ||
|| fromCollapseLimit | **string** (int64) ||
|| joinCollapseLimit | **string** (int64) ||
|| forceParallelMode | **enum** (ForceParallelMode)

- `FORCE_PARALLEL_MODE_UNSPECIFIED`
- `FORCE_PARALLEL_MODE_ON`
- `FORCE_PARALLEL_MODE_OFF`
- `FORCE_PARALLEL_MODE_REGRESS` ||
|| clientMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinErrorStatement | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinDurationStatement | **string** (int64)

in milliseconds. ||
|| logCheckpoints | **boolean** ||
|| logConnections | **boolean** ||
|| logDisconnections | **boolean** ||
|| logDuration | **boolean** ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

- `LOG_ERROR_VERBOSITY_UNSPECIFIED`
- `LOG_ERROR_VERBOSITY_TERSE`
- `LOG_ERROR_VERBOSITY_DEFAULT`
- `LOG_ERROR_VERBOSITY_VERBOSE` ||
|| logLockWaits | **boolean** ||
|| logStatement | **enum** (LogStatement)

- `LOG_STATEMENT_UNSPECIFIED`
- `LOG_STATEMENT_NONE`
- `LOG_STATEMENT_DDL`
- `LOG_STATEMENT_MOD`
- `LOG_STATEMENT_ALL` ||
|| logTempFiles | **string** (int64) ||
|| searchPath | **string** ||
|| rowSecurity | **boolean** ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

- `TRANSACTION_ISOLATION_UNSPECIFIED`
- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
- `TRANSACTION_ISOLATION_READ_COMMITTED`
- `TRANSACTION_ISOLATION_REPEATABLE_READ`
- `TRANSACTION_ISOLATION_SERIALIZABLE` ||
|| statementTimeout | **string** (int64)

in milliseconds. ||
|| lockTimeout | **string** (int64)

in milliseconds. ||
|| idleInTransactionSessionTimeout | **string** (int64)

in milliseconds. ||
|| byteaOutput | **enum** (ByteaOutput)

- `BYTEA_OUTPUT_UNSPECIFIED`
- `BYTEA_OUTPUT_HEX`
- `BYTEA_OUTPUT_ESCAPED` ||
|| xmlbinary | **enum** (XmlBinary)

- `XML_BINARY_UNSPECIFIED`
- `XML_BINARY_BASE64`
- `XML_BINARY_HEX` ||
|| xmloption | **enum** (XmlOption)

- `XML_OPTION_UNSPECIFIED`
- `XML_OPTION_DOCUMENT`
- `XML_OPTION_CONTENT` ||
|| ginPendingListLimit | **string** (int64)

in bytes. ||
|| deadlockTimeout | **string** (int64)

in milliseconds. ||
|| maxLocksPerTransaction | **string** (int64) ||
|| maxPredLocksPerTransaction | **string** (int64) ||
|| arrayNulls | **boolean** ||
|| backslashQuote | **enum** (BackslashQuote)

- `BACKSLASH_QUOTE_UNSPECIFIED`
- `BACKSLASH_QUOTE`
- `BACKSLASH_QUOTE_ON`
- `BACKSLASH_QUOTE_OFF`
- `BACKSLASH_QUOTE_SAFE_ENCODING` ||
|| defaultWithOids | **boolean** ||
|| escapeStringWarning | **boolean** ||
|| loCompatPrivileges | **boolean** ||
|| operatorPrecedenceWarning | **boolean** ||
|| quoteAllIdentifiers | **boolean** ||
|| standardConformingStrings | **boolean** ||
|| synchronizeSeqscans | **boolean** ||
|| transformNullEquals | **boolean** ||
|| exitOnError | **boolean** ||
|| seqPageCost | **number** (double) ||
|| randomPageCost | **number** (double) ||
|| enableBitmapscan | **boolean** ||
|| enableHashagg | **boolean** ||
|| enableHashjoin | **boolean** ||
|| enableIndexscan | **boolean** ||
|| enableIndexonlyscan | **boolean** ||
|| enableMaterial | **boolean** ||
|| enableMergejoin | **boolean** ||
|| enableNestloop | **boolean** ||
|| enableSeqscan | **boolean** ||
|| enableSort | **boolean** ||
|| enableTidscan | **boolean** ||
|| maxParallelWorkers | **string** (int64) ||
|| maxParallelWorkersPerGather | **string** (int64) ||
|| timezone | **string** ||
|| effectiveIoConcurrency | **string** (int64) ||
|| effectiveCacheSize | **string** (int64) ||
|#

## PostgresqlHostConfig14 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig14}

Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file
parameters which detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/11/runtime-config.html).

#|
||Field | Description ||
|| recoveryMinApplyDelay | **string** (int64)

in milliseconds. ||
|| sharedBuffers | **string** (int64)

in bytes. ||
|| tempBuffers | **string** (int64)

in bytes. ||
|| workMem | **string** (int64)

in bytes. ||
|| tempFileLimit | **string** (int64)

in bytes. ||
|| backendFlushAfter | **string** (int64) ||
|| oldSnapshotThreshold | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64)

in milliseconds. ||
|| constraintExclusion | **enum** (ConstraintExclusion)

- `CONSTRAINT_EXCLUSION_UNSPECIFIED`
- `CONSTRAINT_EXCLUSION_ON`
- `CONSTRAINT_EXCLUSION_OFF`
- `CONSTRAINT_EXCLUSION_PARTITION` ||
|| cursorTupleFraction | **number** (double) ||
|| fromCollapseLimit | **string** (int64) ||
|| joinCollapseLimit | **string** (int64) ||
|| forceParallelMode | **enum** (ForceParallelMode)

- `FORCE_PARALLEL_MODE_UNSPECIFIED`
- `FORCE_PARALLEL_MODE_ON`
- `FORCE_PARALLEL_MODE_OFF`
- `FORCE_PARALLEL_MODE_REGRESS` ||
|| clientMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinErrorStatement | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinDurationStatement | **string** (int64)

in milliseconds. ||
|| logCheckpoints | **boolean** ||
|| logConnections | **boolean** ||
|| logDisconnections | **boolean** ||
|| logDuration | **boolean** ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

- `LOG_ERROR_VERBOSITY_UNSPECIFIED`
- `LOG_ERROR_VERBOSITY_TERSE`
- `LOG_ERROR_VERBOSITY_DEFAULT`
- `LOG_ERROR_VERBOSITY_VERBOSE` ||
|| logLockWaits | **boolean** ||
|| logStatement | **enum** (LogStatement)

- `LOG_STATEMENT_UNSPECIFIED`
- `LOG_STATEMENT_NONE`
- `LOG_STATEMENT_DDL`
- `LOG_STATEMENT_MOD`
- `LOG_STATEMENT_ALL` ||
|| logTempFiles | **string** (int64) ||
|| searchPath | **string** ||
|| rowSecurity | **boolean** ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

- `TRANSACTION_ISOLATION_UNSPECIFIED`
- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
- `TRANSACTION_ISOLATION_READ_COMMITTED`
- `TRANSACTION_ISOLATION_REPEATABLE_READ`
- `TRANSACTION_ISOLATION_SERIALIZABLE` ||
|| statementTimeout | **string** (int64)

in milliseconds. ||
|| lockTimeout | **string** (int64)

in milliseconds. ||
|| idleInTransactionSessionTimeout | **string** (int64)

in milliseconds. ||
|| byteaOutput | **enum** (ByteaOutput)

- `BYTEA_OUTPUT_UNSPECIFIED`
- `BYTEA_OUTPUT_HEX`
- `BYTEA_OUTPUT_ESCAPED` ||
|| xmlbinary | **enum** (XmlBinary)

- `XML_BINARY_UNSPECIFIED`
- `XML_BINARY_BASE64`
- `XML_BINARY_HEX` ||
|| xmloption | **enum** (XmlOption)

- `XML_OPTION_UNSPECIFIED`
- `XML_OPTION_DOCUMENT`
- `XML_OPTION_CONTENT` ||
|| ginPendingListLimit | **string** (int64)

in bytes. ||
|| deadlockTimeout | **string** (int64)

in milliseconds. ||
|| maxLocksPerTransaction | **string** (int64) ||
|| maxPredLocksPerTransaction | **string** (int64) ||
|| arrayNulls | **boolean** ||
|| backslashQuote | **enum** (BackslashQuote)

- `BACKSLASH_QUOTE_UNSPECIFIED`
- `BACKSLASH_QUOTE`
- `BACKSLASH_QUOTE_ON`
- `BACKSLASH_QUOTE_OFF`
- `BACKSLASH_QUOTE_SAFE_ENCODING` ||
|| defaultWithOids | **boolean** ||
|| escapeStringWarning | **boolean** ||
|| loCompatPrivileges | **boolean** ||
|| quoteAllIdentifiers | **boolean** ||
|| standardConformingStrings | **boolean** ||
|| synchronizeSeqscans | **boolean** ||
|| transformNullEquals | **boolean** ||
|| exitOnError | **boolean** ||
|| seqPageCost | **number** (double) ||
|| randomPageCost | **number** (double) ||
|| enableBitmapscan | **boolean** ||
|| enableHashagg | **boolean** ||
|| enableHashjoin | **boolean** ||
|| enableIndexscan | **boolean** ||
|| enableIndexonlyscan | **boolean** ||
|| enableMaterial | **boolean** ||
|| enableMergejoin | **boolean** ||
|| enableNestloop | **boolean** ||
|| enableSeqscan | **boolean** ||
|| enableSort | **boolean** ||
|| enableTidscan | **boolean** ||
|| maxParallelWorkers | **string** (int64) ||
|| maxParallelWorkersPerGather | **string** (int64) ||
|| timezone | **string** ||
|| effectiveIoConcurrency | **string** (int64) ||
|| effectiveCacheSize | **string** (int64) ||
|#

## PostgresqlHostConfig14_1C {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig14_1C}

Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file
parameters which detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/11/runtime-config.html).

#|
||Field | Description ||
|| recoveryMinApplyDelay | **string** (int64)

in milliseconds. ||
|| sharedBuffers | **string** (int64)

in bytes. ||
|| tempBuffers | **string** (int64)

in bytes. ||
|| workMem | **string** (int64)

in bytes. ||
|| tempFileLimit | **string** (int64)

in bytes. ||
|| backendFlushAfter | **string** (int64) ||
|| oldSnapshotThreshold | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64)

in milliseconds. ||
|| constraintExclusion | **enum** (ConstraintExclusion)

- `CONSTRAINT_EXCLUSION_UNSPECIFIED`
- `CONSTRAINT_EXCLUSION_ON`
- `CONSTRAINT_EXCLUSION_OFF`
- `CONSTRAINT_EXCLUSION_PARTITION` ||
|| cursorTupleFraction | **number** (double) ||
|| fromCollapseLimit | **string** (int64) ||
|| joinCollapseLimit | **string** (int64) ||
|| forceParallelMode | **enum** (ForceParallelMode)

- `FORCE_PARALLEL_MODE_UNSPECIFIED`
- `FORCE_PARALLEL_MODE_ON`
- `FORCE_PARALLEL_MODE_OFF`
- `FORCE_PARALLEL_MODE_REGRESS` ||
|| clientMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinErrorStatement | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinDurationStatement | **string** (int64)

in milliseconds. ||
|| logCheckpoints | **boolean** ||
|| logConnections | **boolean** ||
|| logDisconnections | **boolean** ||
|| logDuration | **boolean** ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

- `LOG_ERROR_VERBOSITY_UNSPECIFIED`
- `LOG_ERROR_VERBOSITY_TERSE`
- `LOG_ERROR_VERBOSITY_DEFAULT`
- `LOG_ERROR_VERBOSITY_VERBOSE` ||
|| logLockWaits | **boolean** ||
|| logStatement | **enum** (LogStatement)

- `LOG_STATEMENT_UNSPECIFIED`
- `LOG_STATEMENT_NONE`
- `LOG_STATEMENT_DDL`
- `LOG_STATEMENT_MOD`
- `LOG_STATEMENT_ALL` ||
|| logTempFiles | **string** (int64) ||
|| searchPath | **string** ||
|| rowSecurity | **boolean** ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

- `TRANSACTION_ISOLATION_UNSPECIFIED`
- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
- `TRANSACTION_ISOLATION_READ_COMMITTED`
- `TRANSACTION_ISOLATION_REPEATABLE_READ`
- `TRANSACTION_ISOLATION_SERIALIZABLE` ||
|| statementTimeout | **string** (int64)

in milliseconds. ||
|| lockTimeout | **string** (int64)

in milliseconds. ||
|| idleInTransactionSessionTimeout | **string** (int64)

in milliseconds. ||
|| byteaOutput | **enum** (ByteaOutput)

- `BYTEA_OUTPUT_UNSPECIFIED`
- `BYTEA_OUTPUT_HEX`
- `BYTEA_OUTPUT_ESCAPED` ||
|| xmlbinary | **enum** (XmlBinary)

- `XML_BINARY_UNSPECIFIED`
- `XML_BINARY_BASE64`
- `XML_BINARY_HEX` ||
|| xmloption | **enum** (XmlOption)

- `XML_OPTION_UNSPECIFIED`
- `XML_OPTION_DOCUMENT`
- `XML_OPTION_CONTENT` ||
|| ginPendingListLimit | **string** (int64)

in bytes. ||
|| deadlockTimeout | **string** (int64)

in milliseconds. ||
|| maxLocksPerTransaction | **string** (int64) ||
|| maxPredLocksPerTransaction | **string** (int64) ||
|| arrayNulls | **boolean** ||
|| backslashQuote | **enum** (BackslashQuote)

- `BACKSLASH_QUOTE_UNSPECIFIED`
- `BACKSLASH_QUOTE`
- `BACKSLASH_QUOTE_ON`
- `BACKSLASH_QUOTE_OFF`
- `BACKSLASH_QUOTE_SAFE_ENCODING` ||
|| defaultWithOids | **boolean** ||
|| escapeStringWarning | **boolean** ||
|| loCompatPrivileges | **boolean** ||
|| quoteAllIdentifiers | **boolean** ||
|| standardConformingStrings | **boolean** ||
|| synchronizeSeqscans | **boolean** ||
|| transformNullEquals | **boolean** ||
|| exitOnError | **boolean** ||
|| seqPageCost | **number** (double) ||
|| randomPageCost | **number** (double) ||
|| enableBitmapscan | **boolean** ||
|| enableHashagg | **boolean** ||
|| enableHashjoin | **boolean** ||
|| enableIndexscan | **boolean** ||
|| enableIndexonlyscan | **boolean** ||
|| enableMaterial | **boolean** ||
|| enableMergejoin | **boolean** ||
|| enableNestloop | **boolean** ||
|| enableSeqscan | **boolean** ||
|| enableSort | **boolean** ||
|| enableTidscan | **boolean** ||
|| maxParallelWorkers | **string** (int64) ||
|| maxParallelWorkersPerGather | **string** (int64) ||
|| timezone | **string** ||
|| effectiveIoConcurrency | **string** (int64) ||
|| effectiveCacheSize | **string** (int64) ||
|#

## PostgresqlHostConfig15 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig15}

Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file
parameters which detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/11/runtime-config.html).

#|
||Field | Description ||
|| recoveryMinApplyDelay | **string** (int64)

in milliseconds. ||
|| sharedBuffers | **string** (int64)

in bytes. ||
|| tempBuffers | **string** (int64)

in bytes. ||
|| workMem | **string** (int64)

in bytes. ||
|| tempFileLimit | **string** (int64)

in bytes. ||
|| backendFlushAfter | **string** (int64) ||
|| oldSnapshotThreshold | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64)

in milliseconds. ||
|| constraintExclusion | **enum** (ConstraintExclusion)

- `CONSTRAINT_EXCLUSION_UNSPECIFIED`
- `CONSTRAINT_EXCLUSION_ON`
- `CONSTRAINT_EXCLUSION_OFF`
- `CONSTRAINT_EXCLUSION_PARTITION` ||
|| cursorTupleFraction | **number** (double) ||
|| fromCollapseLimit | **string** (int64) ||
|| joinCollapseLimit | **string** (int64) ||
|| forceParallelMode | **enum** (ForceParallelMode)

- `FORCE_PARALLEL_MODE_UNSPECIFIED`
- `FORCE_PARALLEL_MODE_ON`
- `FORCE_PARALLEL_MODE_OFF`
- `FORCE_PARALLEL_MODE_REGRESS` ||
|| clientMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinErrorStatement | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinDurationStatement | **string** (int64)

in milliseconds. ||
|| logCheckpoints | **boolean** ||
|| logConnections | **boolean** ||
|| logDisconnections | **boolean** ||
|| logDuration | **boolean** ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

- `LOG_ERROR_VERBOSITY_UNSPECIFIED`
- `LOG_ERROR_VERBOSITY_TERSE`
- `LOG_ERROR_VERBOSITY_DEFAULT`
- `LOG_ERROR_VERBOSITY_VERBOSE` ||
|| logLockWaits | **boolean** ||
|| logStatement | **enum** (LogStatement)

- `LOG_STATEMENT_UNSPECIFIED`
- `LOG_STATEMENT_NONE`
- `LOG_STATEMENT_DDL`
- `LOG_STATEMENT_MOD`
- `LOG_STATEMENT_ALL` ||
|| logTempFiles | **string** (int64) ||
|| searchPath | **string** ||
|| rowSecurity | **boolean** ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

- `TRANSACTION_ISOLATION_UNSPECIFIED`
- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
- `TRANSACTION_ISOLATION_READ_COMMITTED`
- `TRANSACTION_ISOLATION_REPEATABLE_READ`
- `TRANSACTION_ISOLATION_SERIALIZABLE` ||
|| statementTimeout | **string** (int64)

in milliseconds. ||
|| lockTimeout | **string** (int64)

in milliseconds. ||
|| idleInTransactionSessionTimeout | **string** (int64)

in milliseconds. ||
|| byteaOutput | **enum** (ByteaOutput)

- `BYTEA_OUTPUT_UNSPECIFIED`
- `BYTEA_OUTPUT_HEX`
- `BYTEA_OUTPUT_ESCAPED` ||
|| xmlbinary | **enum** (XmlBinary)

- `XML_BINARY_UNSPECIFIED`
- `XML_BINARY_BASE64`
- `XML_BINARY_HEX` ||
|| xmloption | **enum** (XmlOption)

- `XML_OPTION_UNSPECIFIED`
- `XML_OPTION_DOCUMENT`
- `XML_OPTION_CONTENT` ||
|| ginPendingListLimit | **string** (int64)

in bytes. ||
|| deadlockTimeout | **string** (int64)

in milliseconds. ||
|| maxLocksPerTransaction | **string** (int64) ||
|| maxPredLocksPerTransaction | **string** (int64) ||
|| arrayNulls | **boolean** ||
|| backslashQuote | **enum** (BackslashQuote)

- `BACKSLASH_QUOTE_UNSPECIFIED`
- `BACKSLASH_QUOTE`
- `BACKSLASH_QUOTE_ON`
- `BACKSLASH_QUOTE_OFF`
- `BACKSLASH_QUOTE_SAFE_ENCODING` ||
|| defaultWithOids | **boolean** ||
|| escapeStringWarning | **boolean** ||
|| loCompatPrivileges | **boolean** ||
|| quoteAllIdentifiers | **boolean** ||
|| standardConformingStrings | **boolean** ||
|| synchronizeSeqscans | **boolean** ||
|| transformNullEquals | **boolean** ||
|| exitOnError | **boolean** ||
|| seqPageCost | **number** (double) ||
|| randomPageCost | **number** (double) ||
|| enableBitmapscan | **boolean** ||
|| enableHashagg | **boolean** ||
|| enableHashjoin | **boolean** ||
|| enableIndexscan | **boolean** ||
|| enableIndexonlyscan | **boolean** ||
|| enableMaterial | **boolean** ||
|| enableMergejoin | **boolean** ||
|| enableNestloop | **boolean** ||
|| enableSeqscan | **boolean** ||
|| enableSort | **boolean** ||
|| enableTidscan | **boolean** ||
|| maxParallelWorkers | **string** (int64) ||
|| maxParallelWorkersPerGather | **string** (int64) ||
|| timezone | **string** ||
|| effectiveIoConcurrency | **string** (int64) ||
|| effectiveCacheSize | **string** (int64) ||
|#

## PostgresqlHostConfig15_1C {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig15_1C}

Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file
parameters which detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/11/runtime-config.html).

#|
||Field | Description ||
|| recoveryMinApplyDelay | **string** (int64)

in milliseconds. ||
|| sharedBuffers | **string** (int64)

in bytes. ||
|| tempBuffers | **string** (int64)

in bytes. ||
|| workMem | **string** (int64)

in bytes. ||
|| tempFileLimit | **string** (int64)

in bytes. ||
|| backendFlushAfter | **string** (int64) ||
|| oldSnapshotThreshold | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64)

in milliseconds. ||
|| constraintExclusion | **enum** (ConstraintExclusion)

- `CONSTRAINT_EXCLUSION_UNSPECIFIED`
- `CONSTRAINT_EXCLUSION_ON`
- `CONSTRAINT_EXCLUSION_OFF`
- `CONSTRAINT_EXCLUSION_PARTITION` ||
|| cursorTupleFraction | **number** (double) ||
|| fromCollapseLimit | **string** (int64) ||
|| joinCollapseLimit | **string** (int64) ||
|| forceParallelMode | **enum** (ForceParallelMode)

- `FORCE_PARALLEL_MODE_UNSPECIFIED`
- `FORCE_PARALLEL_MODE_ON`
- `FORCE_PARALLEL_MODE_OFF`
- `FORCE_PARALLEL_MODE_REGRESS` ||
|| clientMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinErrorStatement | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinDurationStatement | **string** (int64)

in milliseconds. ||
|| logCheckpoints | **boolean** ||
|| logConnections | **boolean** ||
|| logDisconnections | **boolean** ||
|| logDuration | **boolean** ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

- `LOG_ERROR_VERBOSITY_UNSPECIFIED`
- `LOG_ERROR_VERBOSITY_TERSE`
- `LOG_ERROR_VERBOSITY_DEFAULT`
- `LOG_ERROR_VERBOSITY_VERBOSE` ||
|| logLockWaits | **boolean** ||
|| logStatement | **enum** (LogStatement)

- `LOG_STATEMENT_UNSPECIFIED`
- `LOG_STATEMENT_NONE`
- `LOG_STATEMENT_DDL`
- `LOG_STATEMENT_MOD`
- `LOG_STATEMENT_ALL` ||
|| logTempFiles | **string** (int64) ||
|| searchPath | **string** ||
|| rowSecurity | **boolean** ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

- `TRANSACTION_ISOLATION_UNSPECIFIED`
- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
- `TRANSACTION_ISOLATION_READ_COMMITTED`
- `TRANSACTION_ISOLATION_REPEATABLE_READ`
- `TRANSACTION_ISOLATION_SERIALIZABLE` ||
|| statementTimeout | **string** (int64)

in milliseconds. ||
|| lockTimeout | **string** (int64)

in milliseconds. ||
|| idleInTransactionSessionTimeout | **string** (int64)

in milliseconds. ||
|| byteaOutput | **enum** (ByteaOutput)

- `BYTEA_OUTPUT_UNSPECIFIED`
- `BYTEA_OUTPUT_HEX`
- `BYTEA_OUTPUT_ESCAPED` ||
|| xmlbinary | **enum** (XmlBinary)

- `XML_BINARY_UNSPECIFIED`
- `XML_BINARY_BASE64`
- `XML_BINARY_HEX` ||
|| xmloption | **enum** (XmlOption)

- `XML_OPTION_UNSPECIFIED`
- `XML_OPTION_DOCUMENT`
- `XML_OPTION_CONTENT` ||
|| ginPendingListLimit | **string** (int64)

in bytes. ||
|| deadlockTimeout | **string** (int64)

in milliseconds. ||
|| maxLocksPerTransaction | **string** (int64) ||
|| maxPredLocksPerTransaction | **string** (int64) ||
|| arrayNulls | **boolean** ||
|| backslashQuote | **enum** (BackslashQuote)

- `BACKSLASH_QUOTE_UNSPECIFIED`
- `BACKSLASH_QUOTE`
- `BACKSLASH_QUOTE_ON`
- `BACKSLASH_QUOTE_OFF`
- `BACKSLASH_QUOTE_SAFE_ENCODING` ||
|| defaultWithOids | **boolean** ||
|| escapeStringWarning | **boolean** ||
|| loCompatPrivileges | **boolean** ||
|| quoteAllIdentifiers | **boolean** ||
|| standardConformingStrings | **boolean** ||
|| synchronizeSeqscans | **boolean** ||
|| transformNullEquals | **boolean** ||
|| exitOnError | **boolean** ||
|| seqPageCost | **number** (double) ||
|| randomPageCost | **number** (double) ||
|| enableBitmapscan | **boolean** ||
|| enableHashagg | **boolean** ||
|| enableHashjoin | **boolean** ||
|| enableIndexscan | **boolean** ||
|| enableIndexonlyscan | **boolean** ||
|| enableMaterial | **boolean** ||
|| enableMergejoin | **boolean** ||
|| enableNestloop | **boolean** ||
|| enableSeqscan | **boolean** ||
|| enableSort | **boolean** ||
|| enableTidscan | **boolean** ||
|| maxParallelWorkers | **string** (int64) ||
|| maxParallelWorkersPerGather | **string** (int64) ||
|| timezone | **string** ||
|| effectiveIoConcurrency | **string** (int64) ||
|| effectiveCacheSize | **string** (int64) ||
|#

## PostgresqlHostConfig16 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig16}

Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file
parameters which detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/11/runtime-config.html).

#|
||Field | Description ||
|| recoveryMinApplyDelay | **string** (int64)

in milliseconds. ||
|| sharedBuffers | **string** (int64)

in bytes. ||
|| tempBuffers | **string** (int64)

in bytes. ||
|| workMem | **string** (int64)

in bytes. ||
|| tempFileLimit | **string** (int64)

in bytes. ||
|| backendFlushAfter | **string** (int64) ||
|| oldSnapshotThreshold | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64)

in milliseconds. ||
|| constraintExclusion | **enum** (ConstraintExclusion)

- `CONSTRAINT_EXCLUSION_UNSPECIFIED`
- `CONSTRAINT_EXCLUSION_ON`
- `CONSTRAINT_EXCLUSION_OFF`
- `CONSTRAINT_EXCLUSION_PARTITION` ||
|| cursorTupleFraction | **number** (double) ||
|| fromCollapseLimit | **string** (int64) ||
|| joinCollapseLimit | **string** (int64) ||
|| debugParallelQuery | **enum** (DebugParallelQuery)

- `DEBUG_PARALLEL_QUERY_UNSPECIFIED`
- `DEBUG_PARALLEL_QUERY_ON`
- `DEBUG_PARALLEL_QUERY_OFF`
- `DEBUG_PARALLEL_QUERY_REGRESS` ||
|| clientMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_INFO`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_INFO`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinErrorStatement | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_INFO`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinDurationStatement | **string** (int64)

in milliseconds. ||
|| logCheckpoints | **boolean** ||
|| logConnections | **boolean** ||
|| logDisconnections | **boolean** ||
|| logDuration | **boolean** ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

- `LOG_ERROR_VERBOSITY_UNSPECIFIED`
- `LOG_ERROR_VERBOSITY_TERSE`
- `LOG_ERROR_VERBOSITY_DEFAULT`
- `LOG_ERROR_VERBOSITY_VERBOSE` ||
|| logLockWaits | **boolean** ||
|| logStatement | **enum** (LogStatement)

- `LOG_STATEMENT_UNSPECIFIED`
- `LOG_STATEMENT_NONE`
- `LOG_STATEMENT_DDL`
- `LOG_STATEMENT_MOD`
- `LOG_STATEMENT_ALL` ||
|| logTempFiles | **string** (int64) ||
|| searchPath | **string** ||
|| rowSecurity | **boolean** ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

- `TRANSACTION_ISOLATION_UNSPECIFIED`
- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
- `TRANSACTION_ISOLATION_READ_COMMITTED`
- `TRANSACTION_ISOLATION_REPEATABLE_READ`
- `TRANSACTION_ISOLATION_SERIALIZABLE` ||
|| statementTimeout | **string** (int64)

in milliseconds. ||
|| lockTimeout | **string** (int64)

in milliseconds. ||
|| idleInTransactionSessionTimeout | **string** (int64)

in milliseconds. ||
|| byteaOutput | **enum** (ByteaOutput)

- `BYTEA_OUTPUT_UNSPECIFIED`
- `BYTEA_OUTPUT_HEX`
- `BYTEA_OUTPUT_ESCAPED` ||
|| xmlbinary | **enum** (XmlBinary)

- `XML_BINARY_UNSPECIFIED`
- `XML_BINARY_BASE64`
- `XML_BINARY_HEX` ||
|| xmloption | **enum** (XmlOption)

- `XML_OPTION_UNSPECIFIED`
- `XML_OPTION_DOCUMENT`
- `XML_OPTION_CONTENT` ||
|| ginPendingListLimit | **string** (int64)

in bytes. ||
|| deadlockTimeout | **string** (int64)

in milliseconds. ||
|| maxLocksPerTransaction | **string** (int64) ||
|| maxPredLocksPerTransaction | **string** (int64) ||
|| arrayNulls | **boolean** ||
|| backslashQuote | **enum** (BackslashQuote)

- `BACKSLASH_QUOTE_UNSPECIFIED`
- `BACKSLASH_QUOTE`
- `BACKSLASH_QUOTE_ON`
- `BACKSLASH_QUOTE_OFF`
- `BACKSLASH_QUOTE_SAFE_ENCODING` ||
|| defaultWithOids | **boolean** ||
|| escapeStringWarning | **boolean** ||
|| loCompatPrivileges | **boolean** ||
|| quoteAllIdentifiers | **boolean** ||
|| standardConformingStrings | **boolean** ||
|| synchronizeSeqscans | **boolean** ||
|| transformNullEquals | **boolean** ||
|| exitOnError | **boolean** ||
|| seqPageCost | **number** (double) ||
|| randomPageCost | **number** (double) ||
|| enableBitmapscan | **boolean** ||
|| enableHashagg | **boolean** ||
|| enableHashjoin | **boolean** ||
|| enableIndexscan | **boolean** ||
|| enableIndexonlyscan | **boolean** ||
|| enableMaterial | **boolean** ||
|| enableMergejoin | **boolean** ||
|| enableNestloop | **boolean** ||
|| enableSeqscan | **boolean** ||
|| enableSort | **boolean** ||
|| enableTidscan | **boolean** ||
|| maxParallelWorkers | **string** (int64) ||
|| maxParallelWorkersPerGather | **string** (int64) ||
|| timezone | **string** ||
|| effectiveIoConcurrency | **string** (int64) ||
|| effectiveCacheSize | **string** (int64) ||
|#

## PostgresqlHostConfig16_1C {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig16_1C}

Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file
parameters which detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/11/runtime-config.html).

#|
||Field | Description ||
|| recoveryMinApplyDelay | **string** (int64)

in milliseconds. ||
|| sharedBuffers | **string** (int64)

in bytes. ||
|| tempBuffers | **string** (int64)

in bytes. ||
|| workMem | **string** (int64)

in bytes. ||
|| tempFileLimit | **string** (int64)

in bytes. ||
|| backendFlushAfter | **string** (int64) ||
|| oldSnapshotThreshold | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64)

in milliseconds. ||
|| constraintExclusion | **enum** (ConstraintExclusion)

- `CONSTRAINT_EXCLUSION_UNSPECIFIED`
- `CONSTRAINT_EXCLUSION_ON`
- `CONSTRAINT_EXCLUSION_OFF`
- `CONSTRAINT_EXCLUSION_PARTITION` ||
|| cursorTupleFraction | **number** (double) ||
|| fromCollapseLimit | **string** (int64) ||
|| joinCollapseLimit | **string** (int64) ||
|| debugParallelQuery | **enum** (DebugParallelQuery)

- `DEBUG_PARALLEL_QUERY_UNSPECIFIED`
- `DEBUG_PARALLEL_QUERY_ON`
- `DEBUG_PARALLEL_QUERY_OFF`
- `DEBUG_PARALLEL_QUERY_REGRESS` ||
|| clientMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_INFO`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_INFO`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinErrorStatement | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_INFO`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinDurationStatement | **string** (int64)

in milliseconds. ||
|| logCheckpoints | **boolean** ||
|| logConnections | **boolean** ||
|| logDisconnections | **boolean** ||
|| logDuration | **boolean** ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

- `LOG_ERROR_VERBOSITY_UNSPECIFIED`
- `LOG_ERROR_VERBOSITY_TERSE`
- `LOG_ERROR_VERBOSITY_DEFAULT`
- `LOG_ERROR_VERBOSITY_VERBOSE` ||
|| logLockWaits | **boolean** ||
|| logStatement | **enum** (LogStatement)

- `LOG_STATEMENT_UNSPECIFIED`
- `LOG_STATEMENT_NONE`
- `LOG_STATEMENT_DDL`
- `LOG_STATEMENT_MOD`
- `LOG_STATEMENT_ALL` ||
|| logTempFiles | **string** (int64) ||
|| searchPath | **string** ||
|| rowSecurity | **boolean** ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

- `TRANSACTION_ISOLATION_UNSPECIFIED`
- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
- `TRANSACTION_ISOLATION_READ_COMMITTED`
- `TRANSACTION_ISOLATION_REPEATABLE_READ`
- `TRANSACTION_ISOLATION_SERIALIZABLE` ||
|| statementTimeout | **string** (int64)

in milliseconds. ||
|| lockTimeout | **string** (int64)

in milliseconds. ||
|| idleInTransactionSessionTimeout | **string** (int64)

in milliseconds. ||
|| byteaOutput | **enum** (ByteaOutput)

- `BYTEA_OUTPUT_UNSPECIFIED`
- `BYTEA_OUTPUT_HEX`
- `BYTEA_OUTPUT_ESCAPED` ||
|| xmlbinary | **enum** (XmlBinary)

- `XML_BINARY_UNSPECIFIED`
- `XML_BINARY_BASE64`
- `XML_BINARY_HEX` ||
|| xmloption | **enum** (XmlOption)

- `XML_OPTION_UNSPECIFIED`
- `XML_OPTION_DOCUMENT`
- `XML_OPTION_CONTENT` ||
|| ginPendingListLimit | **string** (int64)

in bytes. ||
|| deadlockTimeout | **string** (int64)

in milliseconds. ||
|| maxLocksPerTransaction | **string** (int64) ||
|| maxPredLocksPerTransaction | **string** (int64) ||
|| arrayNulls | **boolean** ||
|| backslashQuote | **enum** (BackslashQuote)

- `BACKSLASH_QUOTE_UNSPECIFIED`
- `BACKSLASH_QUOTE`
- `BACKSLASH_QUOTE_ON`
- `BACKSLASH_QUOTE_OFF`
- `BACKSLASH_QUOTE_SAFE_ENCODING` ||
|| defaultWithOids | **boolean** ||
|| escapeStringWarning | **boolean** ||
|| loCompatPrivileges | **boolean** ||
|| quoteAllIdentifiers | **boolean** ||
|| standardConformingStrings | **boolean** ||
|| synchronizeSeqscans | **boolean** ||
|| transformNullEquals | **boolean** ||
|| exitOnError | **boolean** ||
|| seqPageCost | **number** (double) ||
|| randomPageCost | **number** (double) ||
|| enableBitmapscan | **boolean** ||
|| enableHashagg | **boolean** ||
|| enableHashjoin | **boolean** ||
|| enableIndexscan | **boolean** ||
|| enableIndexonlyscan | **boolean** ||
|| enableMaterial | **boolean** ||
|| enableMergejoin | **boolean** ||
|| enableNestloop | **boolean** ||
|| enableSeqscan | **boolean** ||
|| enableSort | **boolean** ||
|| enableTidscan | **boolean** ||
|| maxParallelWorkers | **string** (int64) ||
|| maxParallelWorkersPerGather | **string** (int64) ||
|| timezone | **string** ||
|| effectiveIoConcurrency | **string** (int64) ||
|| effectiveCacheSize | **string** (int64) ||
|#

## PostgresqlHostConfig17 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig17}

Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file
parameters which detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/17/runtime-config.html).

#|
||Field | Description ||
|| recoveryMinApplyDelay | **string** (int64)

in milliseconds. ||
|| sharedBuffers | **string** (int64)

in bytes. ||
|| tempBuffers | **string** (int64)

in bytes. ||
|| workMem | **string** (int64)

in bytes. ||
|| tempFileLimit | **string** (int64)

in bytes. ||
|| backendFlushAfter | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64)

in milliseconds. ||
|| constraintExclusion | **enum** (ConstraintExclusion)

- `CONSTRAINT_EXCLUSION_UNSPECIFIED`
- `CONSTRAINT_EXCLUSION_ON`
- `CONSTRAINT_EXCLUSION_OFF`
- `CONSTRAINT_EXCLUSION_PARTITION` ||
|| cursorTupleFraction | **number** (double) ||
|| fromCollapseLimit | **string** (int64) ||
|| joinCollapseLimit | **string** (int64) ||
|| debugParallelQuery | **enum** (DebugParallelQuery)

- `DEBUG_PARALLEL_QUERY_UNSPECIFIED`
- `DEBUG_PARALLEL_QUERY_ON`
- `DEBUG_PARALLEL_QUERY_OFF`
- `DEBUG_PARALLEL_QUERY_REGRESS` ||
|| clientMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_INFO`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_INFO`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinErrorStatement | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_INFO`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinDurationStatement | **string** (int64)

in milliseconds. ||
|| logCheckpoints | **boolean** ||
|| logConnections | **boolean** ||
|| logDisconnections | **boolean** ||
|| logDuration | **boolean** ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

- `LOG_ERROR_VERBOSITY_UNSPECIFIED`
- `LOG_ERROR_VERBOSITY_TERSE`
- `LOG_ERROR_VERBOSITY_DEFAULT`
- `LOG_ERROR_VERBOSITY_VERBOSE` ||
|| logLockWaits | **boolean** ||
|| logStatement | **enum** (LogStatement)

- `LOG_STATEMENT_UNSPECIFIED`
- `LOG_STATEMENT_NONE`
- `LOG_STATEMENT_DDL`
- `LOG_STATEMENT_MOD`
- `LOG_STATEMENT_ALL` ||
|| logTempFiles | **string** (int64) ||
|| searchPath | **string** ||
|| rowSecurity | **boolean** ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

- `TRANSACTION_ISOLATION_UNSPECIFIED`
- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
- `TRANSACTION_ISOLATION_READ_COMMITTED`
- `TRANSACTION_ISOLATION_REPEATABLE_READ`
- `TRANSACTION_ISOLATION_SERIALIZABLE` ||
|| statementTimeout | **string** (int64)

in milliseconds. ||
|| lockTimeout | **string** (int64)

in milliseconds. ||
|| idleInTransactionSessionTimeout | **string** (int64)

in milliseconds. ||
|| byteaOutput | **enum** (ByteaOutput)

- `BYTEA_OUTPUT_UNSPECIFIED`
- `BYTEA_OUTPUT_HEX`
- `BYTEA_OUTPUT_ESCAPED` ||
|| xmlbinary | **enum** (XmlBinary)

- `XML_BINARY_UNSPECIFIED`
- `XML_BINARY_BASE64`
- `XML_BINARY_HEX` ||
|| xmloption | **enum** (XmlOption)

- `XML_OPTION_UNSPECIFIED`
- `XML_OPTION_DOCUMENT`
- `XML_OPTION_CONTENT` ||
|| ginPendingListLimit | **string** (int64)

in bytes. ||
|| deadlockTimeout | **string** (int64)

in milliseconds. ||
|| maxLocksPerTransaction | **string** (int64) ||
|| maxPredLocksPerTransaction | **string** (int64) ||
|| arrayNulls | **boolean** ||
|| backslashQuote | **enum** (BackslashQuote)

- `BACKSLASH_QUOTE_UNSPECIFIED`
- `BACKSLASH_QUOTE`
- `BACKSLASH_QUOTE_ON`
- `BACKSLASH_QUOTE_OFF`
- `BACKSLASH_QUOTE_SAFE_ENCODING` ||
|| defaultWithOids | **boolean** ||
|| escapeStringWarning | **boolean** ||
|| loCompatPrivileges | **boolean** ||
|| quoteAllIdentifiers | **boolean** ||
|| standardConformingStrings | **boolean** ||
|| synchronizeSeqscans | **boolean** ||
|| transformNullEquals | **boolean** ||
|| exitOnError | **boolean** ||
|| seqPageCost | **number** (double) ||
|| randomPageCost | **number** (double) ||
|| enableBitmapscan | **boolean** ||
|| enableHashagg | **boolean** ||
|| enableHashjoin | **boolean** ||
|| enableIndexscan | **boolean** ||
|| enableIndexonlyscan | **boolean** ||
|| enableMaterial | **boolean** ||
|| enableMergejoin | **boolean** ||
|| enableNestloop | **boolean** ||
|| enableSeqscan | **boolean** ||
|| enableSort | **boolean** ||
|| enableTidscan | **boolean** ||
|| maxParallelWorkers | **string** (int64) ||
|| maxParallelWorkersPerGather | **string** (int64) ||
|| timezone | **string** ||
|| effectiveIoConcurrency | **string** (int64) ||
|| effectiveCacheSize | **string** (int64) ||
|#

## PostgresqlHostConfig17_1C {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig17_1C}

Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file
parameters which detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/17/runtime-config.html).

#|
||Field | Description ||
|| recoveryMinApplyDelay | **string** (int64)

in milliseconds. ||
|| sharedBuffers | **string** (int64)

in bytes. ||
|| tempBuffers | **string** (int64)

in bytes. ||
|| workMem | **string** (int64)

in bytes. ||
|| tempFileLimit | **string** (int64)

in bytes. ||
|| backendFlushAfter | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64)

in milliseconds. ||
|| constraintExclusion | **enum** (ConstraintExclusion)

- `CONSTRAINT_EXCLUSION_UNSPECIFIED`
- `CONSTRAINT_EXCLUSION_ON`
- `CONSTRAINT_EXCLUSION_OFF`
- `CONSTRAINT_EXCLUSION_PARTITION` ||
|| cursorTupleFraction | **number** (double) ||
|| fromCollapseLimit | **string** (int64) ||
|| joinCollapseLimit | **string** (int64) ||
|| debugParallelQuery | **enum** (DebugParallelQuery)

- `DEBUG_PARALLEL_QUERY_UNSPECIFIED`
- `DEBUG_PARALLEL_QUERY_ON`
- `DEBUG_PARALLEL_QUERY_OFF`
- `DEBUG_PARALLEL_QUERY_REGRESS` ||
|| clientMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_INFO`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_INFO`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinErrorStatement | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_INFO`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinDurationStatement | **string** (int64)

in milliseconds. ||
|| logCheckpoints | **boolean** ||
|| logConnections | **boolean** ||
|| logDisconnections | **boolean** ||
|| logDuration | **boolean** ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

- `LOG_ERROR_VERBOSITY_UNSPECIFIED`
- `LOG_ERROR_VERBOSITY_TERSE`
- `LOG_ERROR_VERBOSITY_DEFAULT`
- `LOG_ERROR_VERBOSITY_VERBOSE` ||
|| logLockWaits | **boolean** ||
|| logStatement | **enum** (LogStatement)

- `LOG_STATEMENT_UNSPECIFIED`
- `LOG_STATEMENT_NONE`
- `LOG_STATEMENT_DDL`
- `LOG_STATEMENT_MOD`
- `LOG_STATEMENT_ALL` ||
|| logTempFiles | **string** (int64) ||
|| searchPath | **string** ||
|| rowSecurity | **boolean** ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

- `TRANSACTION_ISOLATION_UNSPECIFIED`
- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
- `TRANSACTION_ISOLATION_READ_COMMITTED`
- `TRANSACTION_ISOLATION_REPEATABLE_READ`
- `TRANSACTION_ISOLATION_SERIALIZABLE` ||
|| statementTimeout | **string** (int64)

in milliseconds. ||
|| lockTimeout | **string** (int64)

in milliseconds. ||
|| idleInTransactionSessionTimeout | **string** (int64)

in milliseconds. ||
|| byteaOutput | **enum** (ByteaOutput)

- `BYTEA_OUTPUT_UNSPECIFIED`
- `BYTEA_OUTPUT_HEX`
- `BYTEA_OUTPUT_ESCAPED` ||
|| xmlbinary | **enum** (XmlBinary)

- `XML_BINARY_UNSPECIFIED`
- `XML_BINARY_BASE64`
- `XML_BINARY_HEX` ||
|| xmloption | **enum** (XmlOption)

- `XML_OPTION_UNSPECIFIED`
- `XML_OPTION_DOCUMENT`
- `XML_OPTION_CONTENT` ||
|| ginPendingListLimit | **string** (int64)

in bytes. ||
|| deadlockTimeout | **string** (int64)

in milliseconds. ||
|| maxLocksPerTransaction | **string** (int64) ||
|| maxPredLocksPerTransaction | **string** (int64) ||
|| arrayNulls | **boolean** ||
|| backslashQuote | **enum** (BackslashQuote)

- `BACKSLASH_QUOTE_UNSPECIFIED`
- `BACKSLASH_QUOTE`
- `BACKSLASH_QUOTE_ON`
- `BACKSLASH_QUOTE_OFF`
- `BACKSLASH_QUOTE_SAFE_ENCODING` ||
|| defaultWithOids | **boolean** ||
|| escapeStringWarning | **boolean** ||
|| loCompatPrivileges | **boolean** ||
|| quoteAllIdentifiers | **boolean** ||
|| standardConformingStrings | **boolean** ||
|| synchronizeSeqscans | **boolean** ||
|| transformNullEquals | **boolean** ||
|| exitOnError | **boolean** ||
|| seqPageCost | **number** (double) ||
|| randomPageCost | **number** (double) ||
|| enableBitmapscan | **boolean** ||
|| enableHashagg | **boolean** ||
|| enableHashjoin | **boolean** ||
|| enableIndexscan | **boolean** ||
|| enableIndexonlyscan | **boolean** ||
|| enableMaterial | **boolean** ||
|| enableMergejoin | **boolean** ||
|| enableNestloop | **boolean** ||
|| enableSeqscan | **boolean** ||
|| enableSort | **boolean** ||
|| enableTidscan | **boolean** ||
|| maxParallelWorkers | **string** (int64) ||
|| maxParallelWorkersPerGather | **string** (int64) ||
|| timezone | **string** ||
|| effectiveIoConcurrency | **string** (int64) ||
|| effectiveCacheSize | **string** (int64) ||
|#

## PostgresqlHostConfig18 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig18}

Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file
parameters which detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/18/runtime-config.html).

#|
||Field | Description ||
|| recoveryMinApplyDelay | **string** (int64)

in milliseconds. ||
|| sharedBuffers | **string** (int64)

in bytes. ||
|| tempBuffers | **string** (int64)

in bytes. ||
|| workMem | **string** (int64)

in bytes. ||
|| tempFileLimit | **string** (int64)

in bytes. ||
|| backendFlushAfter | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64)

in milliseconds. ||
|| constraintExclusion | **enum** (ConstraintExclusion)

- `CONSTRAINT_EXCLUSION_UNSPECIFIED`
- `CONSTRAINT_EXCLUSION_ON`
- `CONSTRAINT_EXCLUSION_OFF`
- `CONSTRAINT_EXCLUSION_PARTITION` ||
|| cursorTupleFraction | **number** (double) ||
|| fromCollapseLimit | **string** (int64) ||
|| joinCollapseLimit | **string** (int64) ||
|| debugParallelQuery | **enum** (DebugParallelQuery)

- `DEBUG_PARALLEL_QUERY_UNSPECIFIED`
- `DEBUG_PARALLEL_QUERY_ON`
- `DEBUG_PARALLEL_QUERY_OFF`
- `DEBUG_PARALLEL_QUERY_REGRESS` ||
|| clientMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_INFO`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_INFO`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinErrorStatement | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_INFO`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinDurationStatement | **string** (int64)

in milliseconds. ||
|| logCheckpoints | **boolean** ||
|| logConnections | **boolean** ||
|| logDisconnections | **boolean** ||
|| logDuration | **boolean** ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

- `LOG_ERROR_VERBOSITY_UNSPECIFIED`
- `LOG_ERROR_VERBOSITY_TERSE`
- `LOG_ERROR_VERBOSITY_DEFAULT`
- `LOG_ERROR_VERBOSITY_VERBOSE` ||
|| logLockWaits | **boolean** ||
|| logStatement | **enum** (LogStatement)

- `LOG_STATEMENT_UNSPECIFIED`
- `LOG_STATEMENT_NONE`
- `LOG_STATEMENT_DDL`
- `LOG_STATEMENT_MOD`
- `LOG_STATEMENT_ALL` ||
|| logTempFiles | **string** (int64) ||
|| searchPath | **string** ||
|| rowSecurity | **boolean** ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

- `TRANSACTION_ISOLATION_UNSPECIFIED`
- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
- `TRANSACTION_ISOLATION_READ_COMMITTED`
- `TRANSACTION_ISOLATION_REPEATABLE_READ`
- `TRANSACTION_ISOLATION_SERIALIZABLE` ||
|| statementTimeout | **string** (int64)

in milliseconds. ||
|| lockTimeout | **string** (int64)

in milliseconds. ||
|| idleInTransactionSessionTimeout | **string** (int64)

in milliseconds. ||
|| byteaOutput | **enum** (ByteaOutput)

- `BYTEA_OUTPUT_UNSPECIFIED`
- `BYTEA_OUTPUT_HEX`
- `BYTEA_OUTPUT_ESCAPED` ||
|| xmlbinary | **enum** (XmlBinary)

- `XML_BINARY_UNSPECIFIED`
- `XML_BINARY_BASE64`
- `XML_BINARY_HEX` ||
|| xmloption | **enum** (XmlOption)

- `XML_OPTION_UNSPECIFIED`
- `XML_OPTION_DOCUMENT`
- `XML_OPTION_CONTENT` ||
|| ginPendingListLimit | **string** (int64)

in bytes. ||
|| deadlockTimeout | **string** (int64)

in milliseconds. ||
|| maxLocksPerTransaction | **string** (int64) ||
|| maxPredLocksPerTransaction | **string** (int64) ||
|| arrayNulls | **boolean** ||
|| backslashQuote | **enum** (BackslashQuote)

- `BACKSLASH_QUOTE_UNSPECIFIED`
- `BACKSLASH_QUOTE`
- `BACKSLASH_QUOTE_ON`
- `BACKSLASH_QUOTE_OFF`
- `BACKSLASH_QUOTE_SAFE_ENCODING` ||
|| defaultWithOids | **boolean** ||
|| escapeStringWarning | **boolean** ||
|| loCompatPrivileges | **boolean** ||
|| quoteAllIdentifiers | **boolean** ||
|| standardConformingStrings | **boolean** ||
|| synchronizeSeqscans | **boolean** ||
|| transformNullEquals | **boolean** ||
|| exitOnError | **boolean** ||
|| seqPageCost | **number** (double) ||
|| randomPageCost | **number** (double) ||
|| enableBitmapscan | **boolean** ||
|| enableHashagg | **boolean** ||
|| enableHashjoin | **boolean** ||
|| enableIndexscan | **boolean** ||
|| enableIndexonlyscan | **boolean** ||
|| enableMaterial | **boolean** ||
|| enableMergejoin | **boolean** ||
|| enableNestloop | **boolean** ||
|| enableSeqscan | **boolean** ||
|| enableSort | **boolean** ||
|| enableTidscan | **boolean** ||
|| maxParallelWorkers | **string** (int64) ||
|| maxParallelWorkersPerGather | **string** (int64) ||
|| timezone | **string** ||
|| effectiveIoConcurrency | **string** (int64) ||
|| effectiveCacheSize | **string** (int64) ||
|#

## PostgresqlHostConfig18_1C {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig18_1C}

Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file
parameters which detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/18/runtime-config.html).

#|
||Field | Description ||
|| recoveryMinApplyDelay | **string** (int64)

in milliseconds. ||
|| sharedBuffers | **string** (int64)

in bytes. ||
|| tempBuffers | **string** (int64)

in bytes. ||
|| workMem | **string** (int64)

in bytes. ||
|| tempFileLimit | **string** (int64)

in bytes. ||
|| backendFlushAfter | **string** (int64) ||
|| maxStandbyStreamingDelay | **string** (int64)

in milliseconds. ||
|| constraintExclusion | **enum** (ConstraintExclusion)

- `CONSTRAINT_EXCLUSION_UNSPECIFIED`
- `CONSTRAINT_EXCLUSION_ON`
- `CONSTRAINT_EXCLUSION_OFF`
- `CONSTRAINT_EXCLUSION_PARTITION` ||
|| cursorTupleFraction | **number** (double) ||
|| fromCollapseLimit | **string** (int64) ||
|| joinCollapseLimit | **string** (int64) ||
|| debugParallelQuery | **enum** (DebugParallelQuery)

- `DEBUG_PARALLEL_QUERY_UNSPECIFIED`
- `DEBUG_PARALLEL_QUERY_ON`
- `DEBUG_PARALLEL_QUERY_OFF`
- `DEBUG_PARALLEL_QUERY_REGRESS` ||
|| clientMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_INFO`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinMessages | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_INFO`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinErrorStatement | **enum** (LogLevel)

- `LOG_LEVEL_UNSPECIFIED`
- `LOG_LEVEL_DEBUG5`
- `LOG_LEVEL_DEBUG4`
- `LOG_LEVEL_DEBUG3`
- `LOG_LEVEL_DEBUG2`
- `LOG_LEVEL_DEBUG1`
- `LOG_LEVEL_INFO`
- `LOG_LEVEL_LOG`
- `LOG_LEVEL_NOTICE`
- `LOG_LEVEL_WARNING`
- `LOG_LEVEL_ERROR`
- `LOG_LEVEL_FATAL`
- `LOG_LEVEL_PANIC` ||
|| logMinDurationStatement | **string** (int64)

in milliseconds. ||
|| logCheckpoints | **boolean** ||
|| logConnections | **boolean** ||
|| logDisconnections | **boolean** ||
|| logDuration | **boolean** ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

- `LOG_ERROR_VERBOSITY_UNSPECIFIED`
- `LOG_ERROR_VERBOSITY_TERSE`
- `LOG_ERROR_VERBOSITY_DEFAULT`
- `LOG_ERROR_VERBOSITY_VERBOSE` ||
|| logLockWaits | **boolean** ||
|| logStatement | **enum** (LogStatement)

- `LOG_STATEMENT_UNSPECIFIED`
- `LOG_STATEMENT_NONE`
- `LOG_STATEMENT_DDL`
- `LOG_STATEMENT_MOD`
- `LOG_STATEMENT_ALL` ||
|| logTempFiles | **string** (int64) ||
|| searchPath | **string** ||
|| rowSecurity | **boolean** ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

- `TRANSACTION_ISOLATION_UNSPECIFIED`
- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`
- `TRANSACTION_ISOLATION_READ_COMMITTED`
- `TRANSACTION_ISOLATION_REPEATABLE_READ`
- `TRANSACTION_ISOLATION_SERIALIZABLE` ||
|| statementTimeout | **string** (int64)

in milliseconds. ||
|| lockTimeout | **string** (int64)

in milliseconds. ||
|| idleInTransactionSessionTimeout | **string** (int64)

in milliseconds. ||
|| byteaOutput | **enum** (ByteaOutput)

- `BYTEA_OUTPUT_UNSPECIFIED`
- `BYTEA_OUTPUT_HEX`
- `BYTEA_OUTPUT_ESCAPED` ||
|| xmlbinary | **enum** (XmlBinary)

- `XML_BINARY_UNSPECIFIED`
- `XML_BINARY_BASE64`
- `XML_BINARY_HEX` ||
|| xmloption | **enum** (XmlOption)

- `XML_OPTION_UNSPECIFIED`
- `XML_OPTION_DOCUMENT`
- `XML_OPTION_CONTENT` ||
|| ginPendingListLimit | **string** (int64)

in bytes. ||
|| deadlockTimeout | **string** (int64)

in milliseconds. ||
|| maxLocksPerTransaction | **string** (int64) ||
|| maxPredLocksPerTransaction | **string** (int64) ||
|| arrayNulls | **boolean** ||
|| backslashQuote | **enum** (BackslashQuote)

- `BACKSLASH_QUOTE_UNSPECIFIED`
- `BACKSLASH_QUOTE`
- `BACKSLASH_QUOTE_ON`
- `BACKSLASH_QUOTE_OFF`
- `BACKSLASH_QUOTE_SAFE_ENCODING` ||
|| defaultWithOids | **boolean** ||
|| escapeStringWarning | **boolean** ||
|| loCompatPrivileges | **boolean** ||
|| quoteAllIdentifiers | **boolean** ||
|| standardConformingStrings | **boolean** ||
|| synchronizeSeqscans | **boolean** ||
|| transformNullEquals | **boolean** ||
|| exitOnError | **boolean** ||
|| seqPageCost | **number** (double) ||
|| randomPageCost | **number** (double) ||
|| enableBitmapscan | **boolean** ||
|| enableHashagg | **boolean** ||
|| enableHashjoin | **boolean** ||
|| enableIndexscan | **boolean** ||
|| enableIndexonlyscan | **boolean** ||
|| enableMaterial | **boolean** ||
|| enableMergejoin | **boolean** ||
|| enableNestloop | **boolean** ||
|| enableSeqscan | **boolean** ||
|| enableSort | **boolean** ||
|| enableTidscan | **boolean** ||
|| maxParallelWorkers | **string** (int64) ||
|| maxParallelWorkersPerGather | **string** (int64) ||
|| timezone | **string** ||
|| effectiveIoConcurrency | **string** (int64) ||
|| effectiveCacheSize | **string** (int64) ||
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
  "metadata": {
    "clusterId": "string",
    "hostNames": [
      "string"
    ]
  },
  // Includes only one of the fields `error`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  }
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
|| metadata | **[UpdateClusterHostsMetadata](#yandex.cloud.mdb.postgresql.v1.UpdateClusterHostsMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## UpdateClusterHostsMetadata {#yandex.cloud.mdb.postgresql.v1.UpdateClusterHostsMetadata}

#|
||Field | Description ||
|| clusterId | **string**

ID of the PostgreSQL cluster to update hosts in. ||
|| hostNames[] | **string**

Names of hosts that are being updated. ||
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