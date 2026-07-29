---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/{clusterId}/hosts:batchCreate
    method: post
    path:
      type: object
      properties:
        clusterId:
          description: |-
            **string**
            Required field. ID of the PostgreSQL cluster to add hosts to.
            To get the PostgreSQL cluster ID, use a [ClusterService.List](/docs/managed-postgresql/api-ref/Cluster/list#List) request.
            The maximum string length in characters is 50.
          type: string
      required:
        - clusterId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        hostSpecs:
          description: |-
            **[HostSpec](#yandex.cloud.mdb.postgresql.v1.HostSpec)**
            Configurations for PostgreSQL hosts that should be added to the cluster.
            The number of elements must be greater than 0.
          type: array
          items:
            $ref: '#/definitions/HostSpec'
      additionalProperties: false
    definitions:
      PostgresqlHostConfig11:
        type: object
        properties:
          recoveryMinApplyDelay:
            description: |-
              **string** (int64)
              Sets the minimum delay for applying changes during recovery. In milliseconds.
            type: string
            format: int64
          sharedBuffers:
            description: |-
              **string** (int64)
              Sets the number of shared memory buffers used by the server. In bytes.
            type: string
            format: int64
          tempBuffers:
            description: |-
              **string** (int64)
              Sets the maximum number of temporary buffers used by each session. In bytes.
            type: string
            format: int64
          workMem:
            description: |-
              **string** (int64)
              Sets the maximum memory to be used for query workspaces. This much memory can be used by each
              internal sort operation and hash table before switching to temporary disk files. In bytes.
            type: string
            format: int64
          tempFileLimit:
            description: |-
              **string** (int64)
              Limits the total size of all temporary files used by each process. -1 means no limit. In bytes.
            type: string
            format: int64
          backendFlushAfter:
            description: |-
              **string** (int64)
              Specifies how much data a backend can write before forcing the operating system to issue the writes. In bytes.
              Acceptable values are 0 to 2097152, inclusive.
            type: string
            format: int64
          oldSnapshotThreshold:
            description: |-
              **string** (int64)
              Time before a snapshot is too old to read pages changed after the snapshot was taken.
              A value of -1 disables this feature. In milliseconds.
            type: string
            format: int64
          maxStandbyStreamingDelay:
            description: |-
              **string** (int64)
              Sets the maximum delay before canceling queries when a hot standby server is processing streamed WAL data. In milliseconds.
            type: string
            format: int64
          constraintExclusion:
            description: |-
              **enum** (ConstraintExclusion)
              Enables the planner to use constraints to optimize queries.
              - `CONSTRAINT_EXCLUSION_ON`: Enable planner's use of constraints for all tables.
              - `CONSTRAINT_EXCLUSION_OFF`: Disable planner's use of constraints for all tables
              - `CONSTRAINT_EXCLUSION_PARTITION`: Only use constraints for child tables and UNION ALL clauses.
            type: string
            enum:
              - CONSTRAINT_EXCLUSION_UNSPECIFIED
              - CONSTRAINT_EXCLUSION_ON
              - CONSTRAINT_EXCLUSION_OFF
              - CONSTRAINT_EXCLUSION_PARTITION
          cursorTupleFraction:
            description: |-
              **number** (double)
              Sets the planner's estimate of the fraction of a cursor's rows that will be retrieved.
            type: number
            format: double
          fromCollapseLimit:
            description: |-
              **string** (int64)
              Sets the FROM-list size beyond which subqueries are not collapsed.
              Acceptable values are 1 to 2147483647, inclusive.
            type: string
            format: int64
          joinCollapseLimit:
            description: |-
              **string** (int64)
              Sets the FROM-list size beyond which JOIN constructs are not flattened.
              Acceptable values are 1 to 2147483647, inclusive.
            type: string
            format: int64
          forceParallelMode:
            description: |-
              **enum** (ForceParallelMode)
              Forces use of parallel query facilities. If possible, run query using a parallel worker and with parallel restrictions.
              - `FORCE_PARALLEL_MODE_ON`: Forces parallel mode for queries considered safe, even when no performance benefit is expected.
              - `FORCE_PARALLEL_MODE_OFF`: Uses parallel mode only when the planner expects it to improve performance.
              - `FORCE_PARALLEL_MODE_REGRESS`: Behaves like ON, but hides added Gather nodes in EXPLAIN output and
              suppresses parallel-worker context lines to stabilize regression-test output.
            type: string
            enum:
              - FORCE_PARALLEL_MODE_UNSPECIFIED
              - FORCE_PARALLEL_MODE_ON
              - FORCE_PARALLEL_MODE_OFF
              - FORCE_PARALLEL_MODE_REGRESS
          clientMinMessages:
            description: |-
              **enum** (LogLevel)
              Sets the message levels that are sent to the client.
              - `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
              - `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
              - `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
              - `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
              - `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
              - `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
              - `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
              - `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
              - `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
              - `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
              - `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions.
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
              Sets the message levels that are logged.
              - `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
              - `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
              - `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
              - `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
              - `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
              - `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
              - `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
              - `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
              - `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
              - `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
              - `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions.
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
              Causes all statements generating error at or above this level to be logged.
              - `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
              - `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
              - `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
              - `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
              - `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
              - `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
              - `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
              - `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
              - `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
              - `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
              - `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions.
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
              Sets the minimum execution time above which all statements will be logged. In milliseconds.
            type: string
            format: int64
          logCheckpoints:
            description: |-
              **boolean**
              Logs each checkpoint.
            type: boolean
          logConnections:
            description: |-
              **boolean**
              Logs each successful connection.
            type: boolean
          logDisconnections:
            description: |-
              **boolean**
              Logs end of a session, including duration.
            type: boolean
          logDuration:
            description: |
              **boolean**
              Logs the duration of each completed SQL statement.
            type: boolean
          logErrorVerbosity:
            description: |-
              **enum** (LogErrorVerbosity)
              Sets the verbosity of logged messages.
              - `LOG_ERROR_VERBOSITY_TERSE`: DETAIL, HINT, QUERY, and CONTEXT fields are excluded from the error message.
              - `LOG_ERROR_VERBOSITY_DEFAULT`: Default.
              - `LOG_ERROR_VERBOSITY_VERBOSE`: Error message includes the SQLSTATE error code, source filename, function name, and the line number where the error occurred.
            type: string
            enum:
              - LOG_ERROR_VERBOSITY_UNSPECIFIED
              - LOG_ERROR_VERBOSITY_TERSE
              - LOG_ERROR_VERBOSITY_DEFAULT
              - LOG_ERROR_VERBOSITY_VERBOSE
          logLockWaits:
            description: |-
              **boolean**
              Logs long lock waits.
            type: boolean
          logStatement:
            description: |-
              **enum** (LogStatement)
              Sets the type of statements logged.
              - `LOG_STATEMENT_NONE`: The filter is disabled, no SQL statements are logged.
              - `LOG_STATEMENT_DDL`: System logs DDL statements, e.g., CREATE, ALTER, DROP etc.
              - `LOG_STATEMENT_MOD`: System logs ddl-statements along with data modification commands, e.g., INSERT, UPDATE, etc.
              - `LOG_STATEMENT_ALL`: System logs all SQL statements.
            type: string
            enum:
              - LOG_STATEMENT_UNSPECIFIED
              - LOG_STATEMENT_NONE
              - LOG_STATEMENT_DDL
              - LOG_STATEMENT_MOD
              - LOG_STATEMENT_ALL
          logTempFiles:
            description: |-
              **string** (int64)
              Log the use of temporary files larger than this number of kilobytes.
            type: string
            format: int64
          searchPath:
            description: |-
              **string**
              Sets the schema search order for names that are not schema-qualified.
            type: string
          rowSecurity:
            description: |-
              **boolean**
              Enable row security.
            type: boolean
          defaultTransactionIsolation:
            description: |-
              **enum** (TransactionIsolation)
              Sets the transaction isolation level of each new transaction.
              - `TRANSACTION_ISOLATION_READ_UNCOMMITTED`: This level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.
              - `TRANSACTION_ISOLATION_READ_COMMITTED`: On this level query sees only data committed before the query began.
              - `TRANSACTION_ISOLATION_REPEATABLE_READ`: On this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).
              - `TRANSACTION_ISOLATION_SERIALIZABLE`: This level provides the strictest transaction isolation.
              All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction.
              If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure.
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
              Sets the maximum allowed duration of any statement. In milliseconds.
            type: string
            format: int64
          lockTimeout:
            description: |-
              **string** (int64)
              Sets the maximum allowed duration of any wait for a lock. In milliseconds.
            type: string
            format: int64
          idleInTransactionSessionTimeout:
            description: |-
              **string** (int64)
              Sets the maximum allowed idle time between queries, when in a transaction. In milliseconds.
              Acceptable values are 0 to 2147483647, inclusive.
            type: string
            format: int64
          byteaOutput:
            description: |-
              **enum** (ByteaOutput)
              Sets the output format for bytea.
              - `BYTEA_OUTPUT_HEX`: Each byte is represented by two hexadecimal characters, e.g., 'SELECT '\xDEADBEEF';'.
              - `BYTEA_OUTPUT_ESCAPED`: Standard PostgreSQL format with ASCII characters only.
            type: string
            enum:
              - BYTEA_OUTPUT_UNSPECIFIED
              - BYTEA_OUTPUT_HEX
              - BYTEA_OUTPUT_ESCAPED
          xmlbinary:
            description: |-
              **enum** (XmlBinary)
              Sets how binary values are to be encoded in XML.
              - `XML_BINARY_BASE64`: Encodes binary values using Base64.
              - `XML_BINARY_HEX`: Encodes binary values using hexadecimal notation.
            type: string
            enum:
              - XML_BINARY_UNSPECIFIED
              - XML_BINARY_BASE64
              - XML_BINARY_HEX
          xmloption:
            description: |-
              **enum** (XmlOption)
              Sets whether XML data in implicit parsing and serialization operations is to be considered as documents or content fragments.
              - `XML_OPTION_DOCUMENT`: Treats an XML value as a complete, well-formed document.
              - `XML_OPTION_CONTENT`: Treats an XML value as a content fragment, which may contain multiple top-level elements or character nodes.
            type: string
            enum:
              - XML_OPTION_UNSPECIFIED
              - XML_OPTION_DOCUMENT
              - XML_OPTION_CONTENT
          ginPendingListLimit:
            description: |-
              **string** (int64)
              Sets the maximum size of the pending list for GIN index. In bytes.
            type: string
            format: int64
          deadlockTimeout:
            description: |-
              **string** (int64)
              Sets the time to wait on a lock before checking for deadlock. In milliseconds.
              Acceptable values are 1 to 2147483647, inclusive.
            type: string
            format: int64
          maxLocksPerTransaction:
            description: |-
              **string** (int64)
              Sets the maximum number of locks per transaction. The shared lock table is sized on the assumption that
              at most max_locks_per_transaction * max_connections distinct objects will need to be locked at any one time.
            type: string
            format: int64
          maxPredLocksPerTransaction:
            description: |-
              **string** (int64)
              Sets the maximum number of predicate locks per transaction.The shared predicate lock table is sized on the assumption that
              at most max_pred_locks_per_transaction * max_connections distinct objects will need to be locked at any one time.
            type: string
            format: int64
          arrayNulls:
            description: |-
              **boolean**
              Enable input of NULL elements in arrays. When turned on, unquoted NULL in an array input
              value means a null value; otherwise it is taken literally.
            type: boolean
          backslashQuote:
            description: |-
              **enum** (BackslashQuote)
              Sets whether \"\\'\" is allowed in string literals.
              - `BACKSLASH_QUOTE`: Legacy invalid value. Do not use.
              - `BACKSLASH_QUOTE_ON`: Quotation mark can be represented as \'.
              - `BACKSLASH_QUOTE_OFF`: Quotation mark can only be represented using the standard SQL syntax ''.
              - `BACKSLASH_QUOTE_SAFE_ENCODING`: Representing a quotation mark as \' is only permitted for client encodings where \ is not used for multibyte characters.
            type: string
            enum:
              - BACKSLASH_QUOTE_UNSPECIFIED
              - BACKSLASH_QUOTE
              - BACKSLASH_QUOTE_ON
              - BACKSLASH_QUOTE_OFF
              - BACKSLASH_QUOTE_SAFE_ENCODING
          defaultWithOids:
            description: |-
              **boolean**
              WITH OIDS is no longer supported; this can only be false.
            type: boolean
          escapeStringWarning:
            description: |-
              **boolean**
              Warn about backslash escapes in ordinary string literals.
            type: boolean
          loCompatPrivileges:
            description: |-
              **boolean**
              Enables backward compatibility mode for privilege checks on large objects. Skips privilege checks
              when reading or modifying large objects, for compatibility with PostgreSQL releases prior to 9.0.
            type: boolean
          operatorPrecedenceWarning:
            description: |-
              **boolean**
              Emit a warning for constructs that changed meaning since PostgreSQL 9.4.
            type: boolean
          quoteAllIdentifiers:
            description: |-
              **boolean**
              When generating SQL fragments, quote all identifiers.
            type: boolean
          standardConformingStrings:
            description: |-
              **boolean**
              Causes '...' strings to treat backslashes literally.
            type: boolean
          synchronizeSeqscans:
            description: |-
              **boolean**
              Enable synchronized sequential scans.
            type: boolean
          transformNullEquals:
            description: |-
              **boolean**
              Treats \"expr=NULL\" as \"expr IS NULL\". When turned on, expressions of the form expr = NULL
              (or NULL = expr) are treated as expr IS NULL, that is, they return true if expr evaluates to the
              null value, and false otherwise. The correct behavior of expr = NULL is to always return null (unknown).
            type: boolean
          exitOnError:
            description: |-
              **boolean**
              Terminate session on any error.
            type: boolean
          seqPageCost:
            description: |-
              **number** (double)
              Sets the planner's estimate of the cost of a sequentially fetched disk page.
              The minimum value is 0.
            type: number
            format: double
          randomPageCost:
            description: |-
              **number** (double)
              Sets the planner's estimate of the cost of a nonsequentially fetched disk page.
              The minimum value is 0.
            type: number
            format: double
          enableBitmapscan:
            description: |-
              **boolean**
              Enables the planner's use of bitmap-scan plans.
            type: boolean
          enableHashagg:
            description: |-
              **boolean**
              Enables the planner's use of hashed aggregation plans.
            type: boolean
          enableHashjoin:
            description: |-
              **boolean**
              Enables the planner's use of hash join plans.
            type: boolean
          enableIndexscan:
            description: |-
              **boolean**
              Enables the planner's use of index-scan plans.
            type: boolean
          enableIndexonlyscan:
            description: |-
              **boolean**
              Enables the planner's use of index-only-scan plans.
            type: boolean
          enableMaterial:
            description: |-
              **boolean**
              Enables the planner's use of materialization.
            type: boolean
          enableMergejoin:
            description: |-
              **boolean**
              Enables the planner's use of merge join plans.
            type: boolean
          enableNestloop:
            description: |-
              **boolean**
              Enables the planner's use of nested-loop join plans.
            type: boolean
          enableSeqscan:
            description: |-
              **boolean**
              Enables the planner's use of sequential-scan plans.
            type: boolean
          enableSort:
            description: |-
              **boolean**
              Enables the planner's use of explicit sort steps.
            type: boolean
          enableTidscan:
            description: |-
              **boolean**
              Enables the planner's use of TID scan plans.
            type: boolean
          maxParallelWorkers:
            description: |-
              **string** (int64)
              Sets the maximum number of parallel workers that can be active at one time.
              Acceptable values are 0 to 1024, inclusive.
            type: string
            format: int64
          maxParallelWorkersPerGather:
            description: |-
              **string** (int64)
              Sets the maximum number of parallel processes per executor node.
              Acceptable values are 0 to 1024, inclusive.
            type: string
            format: int64
          timezone:
            description: |-
              **string**
              Sets the time zone for displaying and interpreting time stamps.
            type: string
          effectiveIoConcurrency:
            description: |-
              **string** (int64)
              Number of simultaneous requests that can be handled efficiently by the disk subsystem.
              Acceptable values are 0 to 1000, inclusive.
            type: string
            format: int64
          effectiveCacheSize:
            description: |-
              **string** (int64)
              Sets the planner's assumption about the effective size of the disk cache available to a single query. In bytes.
              Acceptable values are 1048576 to 549755813888, inclusive.
            type: string
            format: int64
      PostgresqlHostConfig12:
        type: object
        properties:
          recoveryMinApplyDelay:
            description: |-
              **string** (int64)
              Sets the minimum delay for applying changes during recovery. In milliseconds.
            type: string
            format: int64
          sharedBuffers:
            description: |-
              **string** (int64)
              Sets the number of shared memory buffers used by the server. In bytes.
            type: string
            format: int64
          tempBuffers:
            description: |-
              **string** (int64)
              Sets the maximum number of temporary buffers used by each session. In bytes.
            type: string
            format: int64
          workMem:
            description: |-
              **string** (int64)
              Sets the maximum memory to be used for query workspaces. This much memory can be used by each
              internal sort operation and hash table before switching to temporary disk files. In bytes.
            type: string
            format: int64
          tempFileLimit:
            description: |-
              **string** (int64)
              Limits the total size of all temporary files used by each process. -1 means no limit. In bytes.
            type: string
            format: int64
          backendFlushAfter:
            description: |-
              **string** (int64)
              Specifies how much data a backend can write before forcing the operating system to issue the writes. In bytes.
              Acceptable values are 0 to 2097152, inclusive.
            type: string
            format: int64
          oldSnapshotThreshold:
            description: |-
              **string** (int64)
              Time before a snapshot is too old to read pages changed after the snapshot was taken.
              A value of -1 disables this feature. In milliseconds.
            type: string
            format: int64
          maxStandbyStreamingDelay:
            description: |-
              **string** (int64)
              Sets the maximum delay before canceling queries when a hot standby server is processing streamed WAL data. In milliseconds.
            type: string
            format: int64
          constraintExclusion:
            description: |-
              **enum** (ConstraintExclusion)
              Enables the planner to use constraints to optimize queries.
              - `CONSTRAINT_EXCLUSION_ON`: Enable planner's use of constraints for all tables.
              - `CONSTRAINT_EXCLUSION_OFF`: Disable planner's use of constraints for all tables
              - `CONSTRAINT_EXCLUSION_PARTITION`: Only use constraints for child tables and UNION ALL clauses.
            type: string
            enum:
              - CONSTRAINT_EXCLUSION_UNSPECIFIED
              - CONSTRAINT_EXCLUSION_ON
              - CONSTRAINT_EXCLUSION_OFF
              - CONSTRAINT_EXCLUSION_PARTITION
          cursorTupleFraction:
            description: |-
              **number** (double)
              Sets the planner's estimate of the fraction of a cursor's rows that will be retrieved.
            type: number
            format: double
          fromCollapseLimit:
            description: |-
              **string** (int64)
              Sets the FROM-list size beyond which subqueries are not collapsed.
              Acceptable values are 1 to 2147483647, inclusive.
            type: string
            format: int64
          joinCollapseLimit:
            description: |-
              **string** (int64)
              Sets the FROM-list size beyond which JOIN constructs are not flattened.
              Acceptable values are 1 to 2147483647, inclusive.
            type: string
            format: int64
          forceParallelMode:
            description: |-
              **enum** (ForceParallelMode)
              Forces use of parallel query facilities. If possible, run query using a parallel worker and with parallel restrictions.
              - `FORCE_PARALLEL_MODE_ON`: Forces parallel mode for queries considered safe, even when no performance benefit is expected.
              - `FORCE_PARALLEL_MODE_OFF`: Uses parallel mode only when the planner expects it to improve performance.
              - `FORCE_PARALLEL_MODE_REGRESS`: Behaves like ON, but hides added Gather nodes in EXPLAIN output and
              suppresses parallel-worker context lines to stabilize regression-test output.
            type: string
            enum:
              - FORCE_PARALLEL_MODE_UNSPECIFIED
              - FORCE_PARALLEL_MODE_ON
              - FORCE_PARALLEL_MODE_OFF
              - FORCE_PARALLEL_MODE_REGRESS
          clientMinMessages:
            description: |-
              **enum** (LogLevel)
              Sets the message levels that are sent to the client.
              - `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
              - `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
              - `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
              - `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
              - `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
              - `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
              - `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
              - `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
              - `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
              - `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
              - `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions.
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
              Sets the message levels that are logged.
              - `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
              - `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
              - `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
              - `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
              - `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
              - `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
              - `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
              - `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
              - `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
              - `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
              - `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions.
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
              Causes all statements generating error at or above this level to be logged.
              - `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
              - `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
              - `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
              - `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
              - `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
              - `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
              - `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
              - `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
              - `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
              - `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
              - `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions.
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
              Sets the minimum execution time above which all statements will be logged. In milliseconds.
            type: string
            format: int64
          logCheckpoints:
            description: |-
              **boolean**
              Logs each checkpoint.
            type: boolean
          logConnections:
            description: |-
              **boolean**
              Logs each successful connection.
            type: boolean
          logDisconnections:
            description: |-
              **boolean**
              Logs end of a session, including duration.
            type: boolean
          logDuration:
            description: |
              **boolean**
              Logs the duration of each completed SQL statement.
            type: boolean
          logErrorVerbosity:
            description: |-
              **enum** (LogErrorVerbosity)
              Sets the verbosity of logged messages.
              - `LOG_ERROR_VERBOSITY_TERSE`: DETAIL, HINT, QUERY, and CONTEXT fields are excluded from the error message.
              - `LOG_ERROR_VERBOSITY_DEFAULT`: Default.
              - `LOG_ERROR_VERBOSITY_VERBOSE`: Error message includes the SQLSTATE error code, source filename, function name, and the line number where the error occurred.
            type: string
            enum:
              - LOG_ERROR_VERBOSITY_UNSPECIFIED
              - LOG_ERROR_VERBOSITY_TERSE
              - LOG_ERROR_VERBOSITY_DEFAULT
              - LOG_ERROR_VERBOSITY_VERBOSE
          logLockWaits:
            description: |-
              **boolean**
              Logs long lock waits.
            type: boolean
          logStatement:
            description: |-
              **enum** (LogStatement)
              Sets the type of statements logged.
              - `LOG_STATEMENT_NONE`: The filter is disabled, no SQL statements are logged.
              - `LOG_STATEMENT_DDL`: System logs DDL statements, e.g., CREATE, ALTER, DROP etc.
              - `LOG_STATEMENT_MOD`: System logs ddl-statements along with data modification commands, e.g., INSERT, UPDATE, etc.
              - `LOG_STATEMENT_ALL`: System logs all SQL statements.
            type: string
            enum:
              - LOG_STATEMENT_UNSPECIFIED
              - LOG_STATEMENT_NONE
              - LOG_STATEMENT_DDL
              - LOG_STATEMENT_MOD
              - LOG_STATEMENT_ALL
          logTempFiles:
            description: |-
              **string** (int64)
              Log the use of temporary files larger than this number of kilobytes.
            type: string
            format: int64
          searchPath:
            description: |-
              **string**
              Sets the schema search order for names that are not schema-qualified.
            type: string
          rowSecurity:
            description: |-
              **boolean**
              Enable row security.
            type: boolean
          defaultTransactionIsolation:
            description: |-
              **enum** (TransactionIsolation)
              Sets the transaction isolation level of each new transaction.
              - `TRANSACTION_ISOLATION_READ_UNCOMMITTED`: This level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.
              - `TRANSACTION_ISOLATION_READ_COMMITTED`: On this level query sees only data committed before the query began.
              - `TRANSACTION_ISOLATION_REPEATABLE_READ`: On this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).
              - `TRANSACTION_ISOLATION_SERIALIZABLE`: This level provides the strictest transaction isolation.
              All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction.
              If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure.
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
              Sets the maximum allowed duration of any statement. In milliseconds.
            type: string
            format: int64
          lockTimeout:
            description: |-
              **string** (int64)
              Sets the maximum allowed duration of any wait for a lock. In milliseconds.
            type: string
            format: int64
          idleInTransactionSessionTimeout:
            description: |-
              **string** (int64)
              Sets the maximum allowed idle time between queries, when in a transaction. In milliseconds.
              Acceptable values are 0 to 2147483647, inclusive.
            type: string
            format: int64
          byteaOutput:
            description: |-
              **enum** (ByteaOutput)
              Sets the output format for bytea.
              - `BYTEA_OUTPUT_HEX`: Each byte is represented by two hexadecimal characters, e.g., 'SELECT '\xDEADBEEF';'.
              - `BYTEA_OUTPUT_ESCAPED`: Standard PostgreSQL format with ASCII characters only.
            type: string
            enum:
              - BYTEA_OUTPUT_UNSPECIFIED
              - BYTEA_OUTPUT_HEX
              - BYTEA_OUTPUT_ESCAPED
          xmlbinary:
            description: |-
              **enum** (XmlBinary)
              Sets how binary values are to be encoded in XML.
              - `XML_BINARY_BASE64`: Encodes binary values using Base64.
              - `XML_BINARY_HEX`: Encodes binary values using hexadecimal notation.
            type: string
            enum:
              - XML_BINARY_UNSPECIFIED
              - XML_BINARY_BASE64
              - XML_BINARY_HEX
          xmloption:
            description: |-
              **enum** (XmlOption)
              Sets whether XML data in implicit parsing and serialization operations is to be considered as documents or content fragments.
              - `XML_OPTION_DOCUMENT`: Treats an XML value as a complete, well-formed document.
              - `XML_OPTION_CONTENT`: Treats an XML value as a content fragment, which may contain multiple top-level elements or character nodes.
            type: string
            enum:
              - XML_OPTION_UNSPECIFIED
              - XML_OPTION_DOCUMENT
              - XML_OPTION_CONTENT
          ginPendingListLimit:
            description: |-
              **string** (int64)
              Sets the maximum size of the pending list for GIN index. In bytes.
            type: string
            format: int64
          deadlockTimeout:
            description: |-
              **string** (int64)
              Sets the time to wait on a lock before checking for deadlock. In milliseconds.
              Acceptable values are 1 to 2147483647, inclusive.
            type: string
            format: int64
          maxLocksPerTransaction:
            description: |-
              **string** (int64)
              Sets the maximum number of locks per transaction. The shared lock table is sized on the assumption that
              at most max_locks_per_transaction * max_connections distinct objects will need to be locked at any one time.
            type: string
            format: int64
          maxPredLocksPerTransaction:
            description: |-
              **string** (int64)
              Sets the maximum number of predicate locks per transaction.The shared predicate lock table is sized on the assumption that
              at most max_pred_locks_per_transaction * max_connections distinct objects will need to be locked at any one time.
            type: string
            format: int64
          arrayNulls:
            description: |-
              **boolean**
              Enable input of NULL elements in arrays. When turned on, unquoted NULL in an array input
              value means a null value; otherwise it is taken literally.
            type: boolean
          backslashQuote:
            description: |-
              **enum** (BackslashQuote)
              Sets whether \"\\'\" is allowed in string literals.
              - `BACKSLASH_QUOTE`: Legacy invalid value. Do not use.
              - `BACKSLASH_QUOTE_ON`: Quotation mark can be represented as \'.
              - `BACKSLASH_QUOTE_OFF`: Quotation mark can only be represented using the standard SQL syntax ''.
              - `BACKSLASH_QUOTE_SAFE_ENCODING`: Representing a quotation mark as \' is only permitted for client encodings where \ is not used for multibyte characters.
            type: string
            enum:
              - BACKSLASH_QUOTE_UNSPECIFIED
              - BACKSLASH_QUOTE
              - BACKSLASH_QUOTE_ON
              - BACKSLASH_QUOTE_OFF
              - BACKSLASH_QUOTE_SAFE_ENCODING
          defaultWithOids:
            description: |-
              **boolean**
              WITH OIDS is no longer supported; this can only be false.
            type: boolean
          escapeStringWarning:
            description: |-
              **boolean**
              Warn about backslash escapes in ordinary string literals.
            type: boolean
          loCompatPrivileges:
            description: |-
              **boolean**
              Enables backward compatibility mode for privilege checks on large objects. Skips privilege checks
              when reading or modifying large objects, for compatibility with PostgreSQL releases prior to 9.0.
            type: boolean
          operatorPrecedenceWarning:
            description: |-
              **boolean**
              Emit a warning for constructs that changed meaning since PostgreSQL 9.4.
            type: boolean
          quoteAllIdentifiers:
            description: |-
              **boolean**
              When generating SQL fragments, quote all identifiers.
            type: boolean
          standardConformingStrings:
            description: |-
              **boolean**
              Causes '...' strings to treat backslashes literally.
            type: boolean
          synchronizeSeqscans:
            description: |-
              **boolean**
              Enable synchronized sequential scans.
            type: boolean
          transformNullEquals:
            description: |-
              **boolean**
              Treats \"expr=NULL\" as \"expr IS NULL\". When turned on, expressions of the form expr = NULL
              (or NULL = expr) are treated as expr IS NULL, that is, they return true if expr evaluates to the
              null value, and false otherwise. The correct behavior of expr = NULL is to always return null (unknown).
            type: boolean
          exitOnError:
            description: |-
              **boolean**
              Terminate session on any error.
            type: boolean
          seqPageCost:
            description: |-
              **number** (double)
              Sets the planner's estimate of the cost of a sequentially fetched disk page.
              The minimum value is 0.
            type: number
            format: double
          randomPageCost:
            description: |-
              **number** (double)
              Sets the planner's estimate of the cost of a nonsequentially fetched disk page.
              The minimum value is 0.
            type: number
            format: double
          enableBitmapscan:
            description: |-
              **boolean**
              Enables the planner's use of bitmap-scan plans.
            type: boolean
          enableHashagg:
            description: |-
              **boolean**
              Enables the planner's use of hashed aggregation plans.
            type: boolean
          enableHashjoin:
            description: |-
              **boolean**
              Enables the planner's use of hash join plans.
            type: boolean
          enableIndexscan:
            description: |-
              **boolean**
              Enables the planner's use of index-scan plans.
            type: boolean
          enableIndexonlyscan:
            description: |-
              **boolean**
              Enables the planner's use of index-only-scan plans.
            type: boolean
          enableMaterial:
            description: |-
              **boolean**
              Enables the planner's use of materialization.
            type: boolean
          enableMergejoin:
            description: |-
              **boolean**
              Enables the planner's use of merge join plans.
            type: boolean
          enableNestloop:
            description: |-
              **boolean**
              Enables the planner's use of nested-loop join plans.
            type: boolean
          enableSeqscan:
            description: |-
              **boolean**
              Enables the planner's use of sequential-scan plans.
            type: boolean
          enableSort:
            description: |-
              **boolean**
              Enables the planner's use of explicit sort steps.
            type: boolean
          enableTidscan:
            description: |-
              **boolean**
              Enables the planner's use of TID scan plans.
            type: boolean
          maxParallelWorkers:
            description: |-
              **string** (int64)
              Sets the maximum number of parallel workers that can be active at one time.
              Acceptable values are 0 to 1024, inclusive.
            type: string
            format: int64
          maxParallelWorkersPerGather:
            description: |-
              **string** (int64)
              Sets the maximum number of parallel processes per executor node.
              Acceptable values are 0 to 1024, inclusive.
            type: string
            format: int64
          timezone:
            description: |-
              **string**
              Sets the time zone for displaying and interpreting time stamps.
            type: string
          effectiveIoConcurrency:
            description: |-
              **string** (int64)
              Number of simultaneous requests that can be handled efficiently by the disk subsystem.
              Acceptable values are 0 to 1000, inclusive.
            type: string
            format: int64
          effectiveCacheSize:
            description: |-
              **string** (int64)
              Sets the planner's assumption about the effective size of the disk cache available to a single query. In bytes.
              Acceptable values are 1048576 to 549755813888, inclusive.
            type: string
            format: int64
      PostgresqlHostConfig13:
        type: object
        properties:
          recoveryMinApplyDelay:
            description: |-
              **string** (int64)
              Sets the minimum delay for applying changes during recovery. In milliseconds.
            type: string
            format: int64
          sharedBuffers:
            description: |-
              **string** (int64)
              Sets the number of shared memory buffers used by the server. In bytes.
            type: string
            format: int64
          tempBuffers:
            description: |-
              **string** (int64)
              Sets the maximum number of temporary buffers used by each session. In bytes.
            type: string
            format: int64
          workMem:
            description: |-
              **string** (int64)
              Sets the maximum memory to be used for query workspaces. This much memory can be used by each
              internal sort operation and hash table before switching to temporary disk files. In bytes.
            type: string
            format: int64
          tempFileLimit:
            description: |-
              **string** (int64)
              Limits the total size of all temporary files used by each process. -1 means no limit. In bytes.
            type: string
            format: int64
          backendFlushAfter:
            description: |-
              **string** (int64)
              Specifies how much data a backend can write before forcing the operating system to issue the writes. In bytes.
              Acceptable values are 0 to 2097152, inclusive.
            type: string
            format: int64
          oldSnapshotThreshold:
            description: |-
              **string** (int64)
              Time before a snapshot is too old to read pages changed after the snapshot was taken.
              A value of -1 disables this feature. In milliseconds.
            type: string
            format: int64
          maxStandbyStreamingDelay:
            description: |-
              **string** (int64)
              Sets the maximum delay before canceling queries when a hot standby server is processing streamed WAL data. In milliseconds.
            type: string
            format: int64
          constraintExclusion:
            description: |-
              **enum** (ConstraintExclusion)
              Enables the planner to use constraints to optimize queries.
              - `CONSTRAINT_EXCLUSION_ON`: Enable planner's use of constraints for all tables.
              - `CONSTRAINT_EXCLUSION_OFF`: Disable planner's use of constraints for all tables
              - `CONSTRAINT_EXCLUSION_PARTITION`: Only use constraints for child tables and UNION ALL clauses.
            type: string
            enum:
              - CONSTRAINT_EXCLUSION_UNSPECIFIED
              - CONSTRAINT_EXCLUSION_ON
              - CONSTRAINT_EXCLUSION_OFF
              - CONSTRAINT_EXCLUSION_PARTITION
          cursorTupleFraction:
            description: |-
              **number** (double)
              Sets the planner's estimate of the fraction of a cursor's rows that will be retrieved.
            type: number
            format: double
          fromCollapseLimit:
            description: |-
              **string** (int64)
              Sets the FROM-list size beyond which subqueries are not collapsed.
              Acceptable values are 1 to 2147483647, inclusive.
            type: string
            format: int64
          joinCollapseLimit:
            description: |-
              **string** (int64)
              Sets the FROM-list size beyond which JOIN constructs are not flattened.
              Acceptable values are 1 to 2147483647, inclusive.
            type: string
            format: int64
          forceParallelMode:
            description: |-
              **enum** (ForceParallelMode)
              Forces use of parallel query facilities. If possible, run query using a parallel worker and with parallel restrictions.
              - `FORCE_PARALLEL_MODE_ON`: Forces parallel mode for queries considered safe, even when no performance benefit is expected.
              - `FORCE_PARALLEL_MODE_OFF`: Uses parallel mode only when the planner expects it to improve performance.
              - `FORCE_PARALLEL_MODE_REGRESS`: Behaves like ON, but hides added Gather nodes in EXPLAIN output and
              suppresses parallel-worker context lines to stabilize regression-test output.
            type: string
            enum:
              - FORCE_PARALLEL_MODE_UNSPECIFIED
              - FORCE_PARALLEL_MODE_ON
              - FORCE_PARALLEL_MODE_OFF
              - FORCE_PARALLEL_MODE_REGRESS
          clientMinMessages:
            description: |-
              **enum** (LogLevel)
              Sets the message levels that are sent to the client.
              - `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
              - `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
              - `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
              - `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
              - `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
              - `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
              - `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
              - `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
              - `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
              - `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
              - `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions.
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
              Sets the message levels that are logged.
              - `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
              - `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
              - `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
              - `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
              - `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
              - `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
              - `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
              - `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
              - `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
              - `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
              - `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions.
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
              Causes all statements generating error at or above this level to be logged.
              - `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
              - `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
              - `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
              - `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
              - `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
              - `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
              - `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
              - `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
              - `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
              - `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
              - `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions.
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
              Sets the minimum execution time above which all statements will be logged. In milliseconds.
            type: string
            format: int64
          logCheckpoints:
            description: |-
              **boolean**
              Logs each checkpoint.
            type: boolean
          logConnections:
            description: |-
              **boolean**
              Logs each successful connection.
            type: boolean
          logDisconnections:
            description: |-
              **boolean**
              Logs end of a session, including duration.
            type: boolean
          logDuration:
            description: |
              **boolean**
              Logs the duration of each completed SQL statement.
            type: boolean
          logErrorVerbosity:
            description: |-
              **enum** (LogErrorVerbosity)
              Sets the verbosity of logged messages.
              - `LOG_ERROR_VERBOSITY_TERSE`: DETAIL, HINT, QUERY, and CONTEXT fields are excluded from the error message.
              - `LOG_ERROR_VERBOSITY_DEFAULT`: Default.
              - `LOG_ERROR_VERBOSITY_VERBOSE`: Error message includes the SQLSTATE error code, source filename, function name, and the line number where the error occurred.
            type: string
            enum:
              - LOG_ERROR_VERBOSITY_UNSPECIFIED
              - LOG_ERROR_VERBOSITY_TERSE
              - LOG_ERROR_VERBOSITY_DEFAULT
              - LOG_ERROR_VERBOSITY_VERBOSE
          logLockWaits:
            description: |-
              **boolean**
              Logs long lock waits.
            type: boolean
          logStatement:
            description: |-
              **enum** (LogStatement)
              Sets the type of statements logged.
              - `LOG_STATEMENT_NONE`: The filter is disabled, no SQL statements are logged.
              - `LOG_STATEMENT_DDL`: System logs DDL statements, e.g., CREATE, ALTER, DROP etc.
              - `LOG_STATEMENT_MOD`: System logs ddl-statements along with data modification commands, e.g., INSERT, UPDATE, etc.
              - `LOG_STATEMENT_ALL`: System logs all SQL statements.
            type: string
            enum:
              - LOG_STATEMENT_UNSPECIFIED
              - LOG_STATEMENT_NONE
              - LOG_STATEMENT_DDL
              - LOG_STATEMENT_MOD
              - LOG_STATEMENT_ALL
          logTempFiles:
            description: |-
              **string** (int64)
              Log the use of temporary files larger than this number of kilobytes.
            type: string
            format: int64
          searchPath:
            description: |-
              **string**
              Sets the schema search order for names that are not schema-qualified.
            type: string
          rowSecurity:
            description: |-
              **boolean**
              Enable row security.
            type: boolean
          defaultTransactionIsolation:
            description: |-
              **enum** (TransactionIsolation)
              Sets the transaction isolation level of each new transaction.
              - `TRANSACTION_ISOLATION_READ_UNCOMMITTED`: This level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.
              - `TRANSACTION_ISOLATION_READ_COMMITTED`: On this level query sees only data committed before the query began.
              - `TRANSACTION_ISOLATION_REPEATABLE_READ`: On this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).
              - `TRANSACTION_ISOLATION_SERIALIZABLE`: This level provides the strictest transaction isolation.
              All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction.
              If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure.
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
              Sets the maximum allowed duration of any statement. In milliseconds.
            type: string
            format: int64
          lockTimeout:
            description: |-
              **string** (int64)
              Sets the maximum allowed duration of any wait for a lock. In milliseconds.
            type: string
            format: int64
          idleInTransactionSessionTimeout:
            description: |-
              **string** (int64)
              Sets the maximum allowed idle time between queries, when in a transaction. In milliseconds.
              Acceptable values are 0 to 2147483647, inclusive.
            type: string
            format: int64
          byteaOutput:
            description: |-
              **enum** (ByteaOutput)
              Sets the output format for bytea.
              - `BYTEA_OUTPUT_HEX`: Each byte is represented by two hexadecimal characters, e.g., 'SELECT '\xDEADBEEF';'.
              - `BYTEA_OUTPUT_ESCAPED`: Standard PostgreSQL format with ASCII characters only.
            type: string
            enum:
              - BYTEA_OUTPUT_UNSPECIFIED
              - BYTEA_OUTPUT_HEX
              - BYTEA_OUTPUT_ESCAPED
          xmlbinary:
            description: |-
              **enum** (XmlBinary)
              Sets how binary values are to be encoded in XML.
              - `XML_BINARY_BASE64`: Encodes binary values using Base64.
              - `XML_BINARY_HEX`: Encodes binary values using hexadecimal notation.
            type: string
            enum:
              - XML_BINARY_UNSPECIFIED
              - XML_BINARY_BASE64
              - XML_BINARY_HEX
          xmloption:
            description: |-
              **enum** (XmlOption)
              Sets whether XML data in implicit parsing and serialization operations is to be considered as documents or content fragments.
              - `XML_OPTION_DOCUMENT`: Treats an XML value as a complete, well-formed document.
              - `XML_OPTION_CONTENT`: Treats an XML value as a content fragment, which may contain multiple top-level elements or character nodes.
            type: string
            enum:
              - XML_OPTION_UNSPECIFIED
              - XML_OPTION_DOCUMENT
              - XML_OPTION_CONTENT
          ginPendingListLimit:
            description: |-
              **string** (int64)
              Sets the maximum size of the pending list for GIN index. In bytes.
            type: string
            format: int64
          deadlockTimeout:
            description: |-
              **string** (int64)
              Sets the time to wait on a lock before checking for deadlock. In milliseconds.
              Acceptable values are 1 to 2147483647, inclusive.
            type: string
            format: int64
          maxLocksPerTransaction:
            description: |-
              **string** (int64)
              Sets the maximum number of locks per transaction. The shared lock table is sized on the assumption that
              at most max_locks_per_transaction * max_connections distinct objects will need to be locked at any one time.
            type: string
            format: int64
          maxPredLocksPerTransaction:
            description: |-
              **string** (int64)
              Sets the maximum number of predicate locks per transaction.The shared predicate lock table is sized on the assumption that
              at most max_pred_locks_per_transaction * max_connections distinct objects will need to be locked at any one time.
            type: string
            format: int64
          arrayNulls:
            description: |-
              **boolean**
              Enable input of NULL elements in arrays. When turned on, unquoted NULL in an array input
              value means a null value; otherwise it is taken literally.
            type: boolean
          backslashQuote:
            description: |-
              **enum** (BackslashQuote)
              Sets whether \"\\'\" is allowed in string literals.
              - `BACKSLASH_QUOTE`: Legacy invalid value. Do not use.
              - `BACKSLASH_QUOTE_ON`: Quotation mark can be represented as \'.
              - `BACKSLASH_QUOTE_OFF`: Quotation mark can only be represented using the standard SQL syntax ''.
              - `BACKSLASH_QUOTE_SAFE_ENCODING`: Representing a quotation mark as \' is only permitted for client encodings where \ is not used for multibyte characters.
            type: string
            enum:
              - BACKSLASH_QUOTE_UNSPECIFIED
              - BACKSLASH_QUOTE
              - BACKSLASH_QUOTE_ON
              - BACKSLASH_QUOTE_OFF
              - BACKSLASH_QUOTE_SAFE_ENCODING
          defaultWithOids:
            description: |-
              **boolean**
              WITH OIDS is no longer supported; this can only be false.
            type: boolean
          escapeStringWarning:
            description: |-
              **boolean**
              Warn about backslash escapes in ordinary string literals.
            type: boolean
          loCompatPrivileges:
            description: |-
              **boolean**
              Enables backward compatibility mode for privilege checks on large objects. Skips privilege checks
              when reading or modifying large objects, for compatibility with PostgreSQL releases prior to 9.0.
            type: boolean
          operatorPrecedenceWarning:
            description: |-
              **boolean**
              Emit a warning for constructs that changed meaning since PostgreSQL 9.4.
            type: boolean
          quoteAllIdentifiers:
            description: |-
              **boolean**
              When generating SQL fragments, quote all identifiers.
            type: boolean
          standardConformingStrings:
            description: |-
              **boolean**
              Causes '...' strings to treat backslashes literally.
            type: boolean
          synchronizeSeqscans:
            description: |-
              **boolean**
              Enable synchronized sequential scans.
            type: boolean
          transformNullEquals:
            description: |-
              **boolean**
              Treats \"expr=NULL\" as \"expr IS NULL\". When turned on, expressions of the form expr = NULL
              (or NULL = expr) are treated as expr IS NULL, that is, they return true if expr evaluates to the
              null value, and false otherwise. The correct behavior of expr = NULL is to always return null (unknown).
            type: boolean
          exitOnError:
            description: |-
              **boolean**
              Terminate session on any error.
            type: boolean
          seqPageCost:
            description: |-
              **number** (double)
              Sets the planner's estimate of the cost of a sequentially fetched disk page.
              The minimum value is 0.
            type: number
            format: double
          randomPageCost:
            description: |-
              **number** (double)
              Sets the planner's estimate of the cost of a nonsequentially fetched disk page.
              The minimum value is 0.
            type: number
            format: double
          enableBitmapscan:
            description: |-
              **boolean**
              Enables the planner's use of bitmap-scan plans.
            type: boolean
          enableHashagg:
            description: |-
              **boolean**
              Enables the planner's use of hashed aggregation plans.
            type: boolean
          enableHashjoin:
            description: |-
              **boolean**
              Enables the planner's use of hash join plans.
            type: boolean
          enableIndexscan:
            description: |-
              **boolean**
              Enables the planner's use of index-scan plans.
            type: boolean
          enableIndexonlyscan:
            description: |-
              **boolean**
              Enables the planner's use of index-only-scan plans.
            type: boolean
          enableMaterial:
            description: |-
              **boolean**
              Enables the planner's use of materialization.
            type: boolean
          enableMergejoin:
            description: |-
              **boolean**
              Enables the planner's use of merge join plans.
            type: boolean
          enableNestloop:
            description: |-
              **boolean**
              Enables the planner's use of nested-loop join plans.
            type: boolean
          enableSeqscan:
            description: |-
              **boolean**
              Enables the planner's use of sequential-scan plans.
            type: boolean
          enableSort:
            description: |-
              **boolean**
              Enables the planner's use of explicit sort steps.
            type: boolean
          enableTidscan:
            description: |-
              **boolean**
              Enables the planner's use of TID scan plans.
            type: boolean
          maxParallelWorkers:
            description: |-
              **string** (int64)
              Sets the maximum number of parallel workers that can be active at one time.
              Acceptable values are 0 to 1024, inclusive.
            type: string
            format: int64
          maxParallelWorkersPerGather:
            description: |-
              **string** (int64)
              Sets the maximum number of parallel processes per executor node.
              Acceptable values are 0 to 1024, inclusive.
            type: string
            format: int64
          timezone:
            description: |-
              **string**
              Sets the time zone for displaying and interpreting time stamps.
            type: string
          effectiveIoConcurrency:
            description: |-
              **string** (int64)
              Number of simultaneous requests that can be handled efficiently by the disk subsystem.
              Acceptable values are 0 to 1000, inclusive.
            type: string
            format: int64
          effectiveCacheSize:
            description: |-
              **string** (int64)
              Sets the planner's assumption about the effective size of the disk cache available to a single query. In bytes.
              Acceptable values are 1048576 to 549755813888, inclusive.
            type: string
            format: int64
      PostgresqlHostConfig13_1C:
        type: object
        properties:
          recoveryMinApplyDelay:
            description: |-
              **string** (int64)
              Sets the minimum delay for applying changes during recovery. In milliseconds.
            type: string
            format: int64
          sharedBuffers:
            description: |-
              **string** (int64)
              Sets the number of shared memory buffers used by the server. In bytes.
            type: string
            format: int64
          tempBuffers:
            description: |-
              **string** (int64)
              Sets the maximum number of temporary buffers used by each session. In bytes.
            type: string
            format: int64
          workMem:
            description: |-
              **string** (int64)
              Sets the maximum memory to be used for query workspaces. This much memory can be used by each
              internal sort operation and hash table before switching to temporary disk files. In bytes.
            type: string
            format: int64
          tempFileLimit:
            description: |-
              **string** (int64)
              Limits the total size of all temporary files used by each process. -1 means no limit. In bytes.
            type: string
            format: int64
          backendFlushAfter:
            description: |-
              **string** (int64)
              Specifies how much data a backend can write before forcing the operating system to issue the writes. In bytes.
              Acceptable values are 0 to 2097152, inclusive.
            type: string
            format: int64
          oldSnapshotThreshold:
            description: |-
              **string** (int64)
              Time before a snapshot is too old to read pages changed after the snapshot was taken.
              A value of -1 disables this feature. In milliseconds.
            type: string
            format: int64
          maxStandbyStreamingDelay:
            description: |-
              **string** (int64)
              Sets the maximum delay before canceling queries when a hot standby server is processing streamed WAL data. In milliseconds.
            type: string
            format: int64
          constraintExclusion:
            description: |-
              **enum** (ConstraintExclusion)
              Enables the planner to use constraints to optimize queries.
              - `CONSTRAINT_EXCLUSION_ON`: Enable planner's use of constraints for all tables.
              - `CONSTRAINT_EXCLUSION_OFF`: Disable planner's use of constraints for all tables
              - `CONSTRAINT_EXCLUSION_PARTITION`: Only use constraints for child tables and UNION ALL clauses.
            type: string
            enum:
              - CONSTRAINT_EXCLUSION_UNSPECIFIED
              - CONSTRAINT_EXCLUSION_ON
              - CONSTRAINT_EXCLUSION_OFF
              - CONSTRAINT_EXCLUSION_PARTITION
          cursorTupleFraction:
            description: |-
              **number** (double)
              Sets the planner's estimate of the fraction of a cursor's rows that will be retrieved.
            type: number
            format: double
          fromCollapseLimit:
            description: |-
              **string** (int64)
              Sets the FROM-list size beyond which subqueries are not collapsed.
              Acceptable values are 1 to 2147483647, inclusive.
            type: string
            format: int64
          joinCollapseLimit:
            description: |-
              **string** (int64)
              Sets the FROM-list size beyond which JOIN constructs are not flattened.
              Acceptable values are 1 to 2147483647, inclusive.
            type: string
            format: int64
          forceParallelMode:
            description: |-
              **enum** (ForceParallelMode)
              Forces use of parallel query facilities. If possible, run query using a parallel worker and with parallel restrictions.
              - `FORCE_PARALLEL_MODE_ON`: Forces parallel mode for queries considered safe, even when no performance benefit is expected.
              - `FORCE_PARALLEL_MODE_OFF`: Uses parallel mode only when the planner expects it to improve performance.
              - `FORCE_PARALLEL_MODE_REGRESS`: Behaves like ON, but hides added Gather nodes in EXPLAIN output and
              suppresses parallel-worker context lines to stabilize regression-test output.
            type: string
            enum:
              - FORCE_PARALLEL_MODE_UNSPECIFIED
              - FORCE_PARALLEL_MODE_ON
              - FORCE_PARALLEL_MODE_OFF
              - FORCE_PARALLEL_MODE_REGRESS
          clientMinMessages:
            description: |-
              **enum** (LogLevel)
              Sets the message levels that are sent to the client.
              - `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
              - `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
              - `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
              - `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
              - `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
              - `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
              - `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
              - `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
              - `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
              - `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
              - `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions.
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
              Sets the message levels that are logged.
              - `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
              - `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
              - `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
              - `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
              - `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
              - `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
              - `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
              - `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
              - `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
              - `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
              - `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions.
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
              Causes all statements generating error at or above this level to be logged.
              - `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
              - `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
              - `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
              - `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
              - `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
              - `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
              - `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
              - `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
              - `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
              - `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
              - `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions.
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
              Sets the minimum execution time above which all statements will be logged. In milliseconds.
            type: string
            format: int64
          logCheckpoints:
            description: |-
              **boolean**
              Logs each checkpoint.
            type: boolean
          logConnections:
            description: |-
              **boolean**
              Logs each successful connection.
            type: boolean
          logDisconnections:
            description: |-
              **boolean**
              Logs end of a session, including duration.
            type: boolean
          logDuration:
            description: |
              **boolean**
              Logs the duration of each completed SQL statement.
            type: boolean
          logErrorVerbosity:
            description: |-
              **enum** (LogErrorVerbosity)
              Sets the verbosity of logged messages.
              - `LOG_ERROR_VERBOSITY_TERSE`: DETAIL, HINT, QUERY, and CONTEXT fields are excluded from the error message.
              - `LOG_ERROR_VERBOSITY_DEFAULT`: Default.
              - `LOG_ERROR_VERBOSITY_VERBOSE`: Error message includes the SQLSTATE error code, source filename, function name, and the line number where the error occurred.
            type: string
            enum:
              - LOG_ERROR_VERBOSITY_UNSPECIFIED
              - LOG_ERROR_VERBOSITY_TERSE
              - LOG_ERROR_VERBOSITY_DEFAULT
              - LOG_ERROR_VERBOSITY_VERBOSE
          logLockWaits:
            description: |-
              **boolean**
              Logs long lock waits.
            type: boolean
          logStatement:
            description: |-
              **enum** (LogStatement)
              Sets the type of statements logged.
              - `LOG_STATEMENT_NONE`: The filter is disabled, no SQL statements are logged.
              - `LOG_STATEMENT_DDL`: System logs DDL statements, e.g., CREATE, ALTER, DROP etc.
              - `LOG_STATEMENT_MOD`: System logs ddl-statements along with data modification commands, e.g., INSERT, UPDATE, etc.
              - `LOG_STATEMENT_ALL`: System logs all SQL statements.
            type: string
            enum:
              - LOG_STATEMENT_UNSPECIFIED
              - LOG_STATEMENT_NONE
              - LOG_STATEMENT_DDL
              - LOG_STATEMENT_MOD
              - LOG_STATEMENT_ALL
          logTempFiles:
            description: |-
              **string** (int64)
              Log the use of temporary files larger than this number of kilobytes.
            type: string
            format: int64
          searchPath:
            description: |-
              **string**
              Sets the schema search order for names that are not schema-qualified.
            type: string
          rowSecurity:
            description: |-
              **boolean**
              Enable row security.
            type: boolean
          defaultTransactionIsolation:
            description: |-
              **enum** (TransactionIsolation)
              Sets the transaction isolation level of each new transaction.
              - `TRANSACTION_ISOLATION_READ_UNCOMMITTED`: This level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.
              - `TRANSACTION_ISOLATION_READ_COMMITTED`: On this level query sees only data committed before the query began.
              - `TRANSACTION_ISOLATION_REPEATABLE_READ`: On this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).
              - `TRANSACTION_ISOLATION_SERIALIZABLE`: This level provides the strictest transaction isolation.
              All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction.
              If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure.
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
              Sets the maximum allowed duration of any statement. In milliseconds.
            type: string
            format: int64
          lockTimeout:
            description: |-
              **string** (int64)
              Sets the maximum allowed duration of any wait for a lock. In milliseconds.
            type: string
            format: int64
          idleInTransactionSessionTimeout:
            description: |-
              **string** (int64)
              Sets the maximum allowed idle time between queries, when in a transaction. In milliseconds.
              Acceptable values are 0 to 2147483647, inclusive.
            type: string
            format: int64
          byteaOutput:
            description: |-
              **enum** (ByteaOutput)
              Sets the output format for bytea.
              - `BYTEA_OUTPUT_HEX`: Each byte is represented by two hexadecimal characters, e.g., 'SELECT '\xDEADBEEF';'.
              - `BYTEA_OUTPUT_ESCAPED`: Standard PostgreSQL format with ASCII characters only.
            type: string
            enum:
              - BYTEA_OUTPUT_UNSPECIFIED
              - BYTEA_OUTPUT_HEX
              - BYTEA_OUTPUT_ESCAPED
          xmlbinary:
            description: |-
              **enum** (XmlBinary)
              Sets how binary values are to be encoded in XML.
              - `XML_BINARY_BASE64`: Encodes binary values using Base64.
              - `XML_BINARY_HEX`: Encodes binary values using hexadecimal notation.
            type: string
            enum:
              - XML_BINARY_UNSPECIFIED
              - XML_BINARY_BASE64
              - XML_BINARY_HEX
          xmloption:
            description: |-
              **enum** (XmlOption)
              Sets whether XML data in implicit parsing and serialization operations is to be considered as documents or content fragments.
              - `XML_OPTION_DOCUMENT`: Treats an XML value as a complete, well-formed document.
              - `XML_OPTION_CONTENT`: Treats an XML value as a content fragment, which may contain multiple top-level elements or character nodes.
            type: string
            enum:
              - XML_OPTION_UNSPECIFIED
              - XML_OPTION_DOCUMENT
              - XML_OPTION_CONTENT
          ginPendingListLimit:
            description: |-
              **string** (int64)
              Sets the maximum size of the pending list for GIN index. In bytes.
            type: string
            format: int64
          deadlockTimeout:
            description: |-
              **string** (int64)
              Sets the time to wait on a lock before checking for deadlock. In milliseconds.
              Acceptable values are 1 to 2147483647, inclusive.
            type: string
            format: int64
          maxLocksPerTransaction:
            description: |-
              **string** (int64)
              Sets the maximum number of locks per transaction. The shared lock table is sized on the assumption that
              at most max_locks_per_transaction * max_connections distinct objects will need to be locked at any one time.
            type: string
            format: int64
          maxPredLocksPerTransaction:
            description: |-
              **string** (int64)
              Sets the maximum number of predicate locks per transaction.The shared predicate lock table is sized on the assumption that
              at most max_pred_locks_per_transaction * max_connections distinct objects will need to be locked at any one time.
            type: string
            format: int64
          arrayNulls:
            description: |-
              **boolean**
              Enable input of NULL elements in arrays. When turned on, unquoted NULL in an array input
              value means a null value; otherwise it is taken literally.
            type: boolean
          backslashQuote:
            description: |-
              **enum** (BackslashQuote)
              Sets whether \"\\'\" is allowed in string literals.
              - `BACKSLASH_QUOTE`: Legacy invalid value. Do not use.
              - `BACKSLASH_QUOTE_ON`: Quotation mark can be represented as \'.
              - `BACKSLASH_QUOTE_OFF`: Quotation mark can only be represented using the standard SQL syntax ''.
              - `BACKSLASH_QUOTE_SAFE_ENCODING`: Representing a quotation mark as \' is only permitted for client encodings where \ is not used for multibyte characters.
            type: string
            enum:
              - BACKSLASH_QUOTE_UNSPECIFIED
              - BACKSLASH_QUOTE
              - BACKSLASH_QUOTE_ON
              - BACKSLASH_QUOTE_OFF
              - BACKSLASH_QUOTE_SAFE_ENCODING
          defaultWithOids:
            description: |-
              **boolean**
              WITH OIDS is no longer supported; this can only be false.
            type: boolean
          escapeStringWarning:
            description: |-
              **boolean**
              Warn about backslash escapes in ordinary string literals.
            type: boolean
          loCompatPrivileges:
            description: |-
              **boolean**
              Enables backward compatibility mode for privilege checks on large objects. Skips privilege checks
              when reading or modifying large objects, for compatibility with PostgreSQL releases prior to 9.0.
            type: boolean
          operatorPrecedenceWarning:
            description: |-
              **boolean**
              Emit a warning for constructs that changed meaning since PostgreSQL 9.4.
            type: boolean
          quoteAllIdentifiers:
            description: |-
              **boolean**
              When generating SQL fragments, quote all identifiers.
            type: boolean
          standardConformingStrings:
            description: |-
              **boolean**
              Causes '...' strings to treat backslashes literally.
            type: boolean
          synchronizeSeqscans:
            description: |-
              **boolean**
              Enable synchronized sequential scans.
            type: boolean
          transformNullEquals:
            description: |-
              **boolean**
              Treats \"expr=NULL\" as \"expr IS NULL\". When turned on, expressions of the form expr = NULL
              (or NULL = expr) are treated as expr IS NULL, that is, they return true if expr evaluates to the
              null value, and false otherwise. The correct behavior of expr = NULL is to always return null (unknown).
            type: boolean
          exitOnError:
            description: |-
              **boolean**
              Terminate session on any error.
            type: boolean
          seqPageCost:
            description: |-
              **number** (double)
              Sets the planner's estimate of the cost of a sequentially fetched disk page.
              The minimum value is 0.
            type: number
            format: double
          randomPageCost:
            description: |-
              **number** (double)
              Sets the planner's estimate of the cost of a nonsequentially fetched disk page.
              The minimum value is 0.
            type: number
            format: double
          enableBitmapscan:
            description: |-
              **boolean**
              Enables the planner's use of bitmap-scan plans.
            type: boolean
          enableHashagg:
            description: |-
              **boolean**
              Enables the planner's use of hashed aggregation plans.
            type: boolean
          enableHashjoin:
            description: |-
              **boolean**
              Enables the planner's use of hash join plans.
            type: boolean
          enableIndexscan:
            description: |-
              **boolean**
              Enables the planner's use of index-scan plans.
            type: boolean
          enableIndexonlyscan:
            description: |-
              **boolean**
              Enables the planner's use of index-only-scan plans.
            type: boolean
          enableMaterial:
            description: |-
              **boolean**
              Enables the planner's use of materialization.
            type: boolean
          enableMergejoin:
            description: |-
              **boolean**
              Enables the planner's use of merge join plans.
            type: boolean
          enableNestloop:
            description: |-
              **boolean**
              Enables the planner's use of nested-loop join plans.
            type: boolean
          enableSeqscan:
            description: |-
              **boolean**
              Enables the planner's use of sequential-scan plans.
            type: boolean
          enableSort:
            description: |-
              **boolean**
              Enables the planner's use of explicit sort steps.
            type: boolean
          enableTidscan:
            description: |-
              **boolean**
              Enables the planner's use of TID scan plans.
            type: boolean
          maxParallelWorkers:
            description: |-
              **string** (int64)
              Sets the maximum number of parallel workers that can be active at one time.
              Acceptable values are 0 to 1024, inclusive.
            type: string
            format: int64
          maxParallelWorkersPerGather:
            description: |-
              **string** (int64)
              Sets the maximum number of parallel processes per executor node.
              Acceptable values are 0 to 1024, inclusive.
            type: string
            format: int64
          timezone:
            description: |-
              **string**
              Sets the time zone for displaying and interpreting time stamps.
            type: string
          effectiveIoConcurrency:
            description: |-
              **string** (int64)
              Number of simultaneous requests that can be handled efficiently by the disk subsystem.
              Acceptable values are 0 to 1000, inclusive.
            type: string
            format: int64
          effectiveCacheSize:
            description: |-
              **string** (int64)
              Sets the planner's assumption about the effective size of the disk cache available to a single query. In bytes.
              Acceptable values are 1048576 to 549755813888, inclusive.
            type: string
            format: int64
      PostgresqlHostConfig14:
        type: object
        properties:
          recoveryMinApplyDelay:
            description: |-
              **string** (int64)
              Sets the minimum delay for applying changes during recovery. In milliseconds.
            type: string
            format: int64
          sharedBuffers:
            description: |-
              **string** (int64)
              Sets the number of shared memory buffers used by the server. In bytes.
            type: string
            format: int64
          tempBuffers:
            description: |-
              **string** (int64)
              Sets the maximum number of temporary buffers used by each session. In bytes.
            type: string
            format: int64
          workMem:
            description: |-
              **string** (int64)
              Sets the maximum memory to be used for query workspaces. This much memory can be used by each
              internal sort operation and hash table before switching to temporary disk files. In bytes.
            type: string
            format: int64
          tempFileLimit:
            description: |-
              **string** (int64)
              Limits the total size of all temporary files used by each process. -1 means no limit. In bytes.
            type: string
            format: int64
          backendFlushAfter:
            description: |-
              **string** (int64)
              Specifies how much data a backend can write before forcing the operating system to issue the writes. In bytes.
              Acceptable values are 0 to 2097152, inclusive.
            type: string
            format: int64
          oldSnapshotThreshold:
            description: |-
              **string** (int64)
              Time before a snapshot is too old to read pages changed after the snapshot was taken.
              A value of -1 disables this feature. In milliseconds.
            type: string
            format: int64
          maxStandbyStreamingDelay:
            description: |-
              **string** (int64)
              Sets the maximum delay before canceling queries when a hot standby server is processing streamed WAL data. In milliseconds.
            type: string
            format: int64
          constraintExclusion:
            description: |-
              **enum** (ConstraintExclusion)
              Enables the planner to use constraints to optimize queries.
              - `CONSTRAINT_EXCLUSION_ON`: Enable planner's use of constraints for all tables.
              - `CONSTRAINT_EXCLUSION_OFF`: Disable planner's use of constraints for all tables
              - `CONSTRAINT_EXCLUSION_PARTITION`: Only use constraints for child tables and UNION ALL clauses.
            type: string
            enum:
              - CONSTRAINT_EXCLUSION_UNSPECIFIED
              - CONSTRAINT_EXCLUSION_ON
              - CONSTRAINT_EXCLUSION_OFF
              - CONSTRAINT_EXCLUSION_PARTITION
          cursorTupleFraction:
            description: |-
              **number** (double)
              Sets the planner's estimate of the fraction of a cursor's rows that will be retrieved.
            type: number
            format: double
          fromCollapseLimit:
            description: |-
              **string** (int64)
              Sets the FROM-list size beyond which subqueries are not collapsed.
              Acceptable values are 1 to 2147483647, inclusive.
            type: string
            format: int64
          joinCollapseLimit:
            description: |-
              **string** (int64)
              Sets the FROM-list size beyond which JOIN constructs are not flattened.
              Acceptable values are 1 to 2147483647, inclusive.
            type: string
            format: int64
          forceParallelMode:
            description: |-
              **enum** (ForceParallelMode)
              Forces use of parallel query facilities. If possible, run query using a parallel worker and with parallel restrictions.
              - `FORCE_PARALLEL_MODE_ON`: Forces parallel mode for queries considered safe, even when no performance benefit is expected.
              - `FORCE_PARALLEL_MODE_OFF`: Uses parallel mode only when the planner expects it to improve performance.
              - `FORCE_PARALLEL_MODE_REGRESS`: Behaves like ON, but hides added Gather nodes in EXPLAIN output and
              suppresses parallel-worker context lines to stabilize regression-test output.
            type: string
            enum:
              - FORCE_PARALLEL_MODE_UNSPECIFIED
              - FORCE_PARALLEL_MODE_ON
              - FORCE_PARALLEL_MODE_OFF
              - FORCE_PARALLEL_MODE_REGRESS
          clientMinMessages:
            description: |-
              **enum** (LogLevel)
              Sets the message levels that are sent to the client.
              - `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
              - `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
              - `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
              - `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
              - `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
              - `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
              - `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
              - `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
              - `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
              - `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
              - `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions.
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
              Sets the message levels that are logged.
              - `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
              - `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
              - `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
              - `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
              - `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
              - `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
              - `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
              - `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
              - `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
              - `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
              - `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions.
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
              Causes all statements generating error at or above this level to be logged.
              - `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
              - `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
              - `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
              - `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
              - `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
              - `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
              - `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
              - `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
              - `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
              - `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
              - `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions.
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
              Sets the minimum execution time above which all statements will be logged. In milliseconds.
            type: string
            format: int64
          logCheckpoints:
            description: |-
              **boolean**
              Logs each checkpoint.
            type: boolean
          logConnections:
            description: |-
              **boolean**
              Logs each successful connection.
            type: boolean
          logDisconnections:
            description: |-
              **boolean**
              Logs end of a session, including duration.
            type: boolean
          logDuration:
            description: |
              **boolean**
              Logs the duration of each completed SQL statement.
            type: boolean
          logErrorVerbosity:
            description: |-
              **enum** (LogErrorVerbosity)
              Sets the verbosity of logged messages.
              - `LOG_ERROR_VERBOSITY_TERSE`: DETAIL, HINT, QUERY, and CONTEXT fields are excluded from the error message.
              - `LOG_ERROR_VERBOSITY_DEFAULT`: Default.
              - `LOG_ERROR_VERBOSITY_VERBOSE`: Error message includes the SQLSTATE error code, source filename, function name, and the line number where the error occurred.
            type: string
            enum:
              - LOG_ERROR_VERBOSITY_UNSPECIFIED
              - LOG_ERROR_VERBOSITY_TERSE
              - LOG_ERROR_VERBOSITY_DEFAULT
              - LOG_ERROR_VERBOSITY_VERBOSE
          logLockWaits:
            description: |-
              **boolean**
              Logs long lock waits.
            type: boolean
          logStatement:
            description: |-
              **enum** (LogStatement)
              Sets the type of statements logged.
              - `LOG_STATEMENT_NONE`: The filter is disabled, no SQL statements are logged.
              - `LOG_STATEMENT_DDL`: System logs DDL statements, e.g., CREATE, ALTER, DROP etc.
              - `LOG_STATEMENT_MOD`: System logs ddl-statements along with data modification commands, e.g., INSERT, UPDATE, etc.
              - `LOG_STATEMENT_ALL`: System logs all SQL statements.
            type: string
            enum:
              - LOG_STATEMENT_UNSPECIFIED
              - LOG_STATEMENT_NONE
              - LOG_STATEMENT_DDL
              - LOG_STATEMENT_MOD
              - LOG_STATEMENT_ALL
          logTempFiles:
            description: |-
              **string** (int64)
              Log the use of temporary files larger than this number of kilobytes.
            type: string
            format: int64
          searchPath:
            description: |-
              **string**
              Sets the schema search order for names that are not schema-qualified.
            type: string
          rowSecurity:
            description: |-
              **boolean**
              Enable row security.
            type: boolean
          defaultTransactionIsolation:
            description: |-
              **enum** (TransactionIsolation)
              Sets the transaction isolation level of each new transaction.
              - `TRANSACTION_ISOLATION_READ_UNCOMMITTED`: This level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.
              - `TRANSACTION_ISOLATION_READ_COMMITTED`: On this level query sees only data committed before the query began.
              - `TRANSACTION_ISOLATION_REPEATABLE_READ`: On this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).
              - `TRANSACTION_ISOLATION_SERIALIZABLE`: This level provides the strictest transaction isolation.
              All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction.
              If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure.
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
              Sets the maximum allowed duration of any statement. In milliseconds.
            type: string
            format: int64
          lockTimeout:
            description: |-
              **string** (int64)
              Sets the maximum allowed duration of any wait for a lock. In milliseconds.
            type: string
            format: int64
          idleInTransactionSessionTimeout:
            description: |-
              **string** (int64)
              Sets the maximum allowed idle time between queries, when in a transaction. In milliseconds.
              Acceptable values are 0 to 2147483647, inclusive.
            type: string
            format: int64
          byteaOutput:
            description: |-
              **enum** (ByteaOutput)
              Sets the output format for bytea.
              - `BYTEA_OUTPUT_HEX`: Each byte is represented by two hexadecimal characters, e.g., 'SELECT '\xDEADBEEF';'.
              - `BYTEA_OUTPUT_ESCAPED`: Standard PostgreSQL format with ASCII characters only.
            type: string
            enum:
              - BYTEA_OUTPUT_UNSPECIFIED
              - BYTEA_OUTPUT_HEX
              - BYTEA_OUTPUT_ESCAPED
          xmlbinary:
            description: |-
              **enum** (XmlBinary)
              Sets how binary values are to be encoded in XML.
              - `XML_BINARY_BASE64`: Encodes binary values using Base64.
              - `XML_BINARY_HEX`: Encodes binary values using hexadecimal notation.
            type: string
            enum:
              - XML_BINARY_UNSPECIFIED
              - XML_BINARY_BASE64
              - XML_BINARY_HEX
          xmloption:
            description: |-
              **enum** (XmlOption)
              Sets whether XML data in implicit parsing and serialization operations is to be considered as documents or content fragments.
              - `XML_OPTION_DOCUMENT`: Treats an XML value as a complete, well-formed document.
              - `XML_OPTION_CONTENT`: Treats an XML value as a content fragment, which may contain multiple top-level elements or character nodes.
            type: string
            enum:
              - XML_OPTION_UNSPECIFIED
              - XML_OPTION_DOCUMENT
              - XML_OPTION_CONTENT
          ginPendingListLimit:
            description: |-
              **string** (int64)
              Sets the maximum size of the pending list for GIN index. In bytes.
            type: string
            format: int64
          deadlockTimeout:
            description: |-
              **string** (int64)
              Sets the time to wait on a lock before checking for deadlock. In milliseconds.
              Acceptable values are 1 to 2147483647, inclusive.
            type: string
            format: int64
          maxLocksPerTransaction:
            description: |-
              **string** (int64)
              Sets the maximum number of locks per transaction. The shared lock table is sized on the assumption that
              at most max_locks_per_transaction * max_connections distinct objects will need to be locked at any one time.
            type: string
            format: int64
          maxPredLocksPerTransaction:
            description: |-
              **string** (int64)
              Sets the maximum number of predicate locks per transaction.The shared predicate lock table is sized on the assumption that
              at most max_pred_locks_per_transaction * max_connections distinct objects will need to be locked at any one time.
            type: string
            format: int64
          arrayNulls:
            description: |-
              **boolean**
              Enable input of NULL elements in arrays. When turned on, unquoted NULL in an array input
              value means a null value; otherwise it is taken literally.
            type: boolean
          backslashQuote:
            description: |-
              **enum** (BackslashQuote)
              Sets whether \"\\'\" is allowed in string literals.
              - `BACKSLASH_QUOTE`: Legacy invalid value. Do not use.
              - `BACKSLASH_QUOTE_ON`: Quotation mark can be represented as \'.
              - `BACKSLASH_QUOTE_OFF`: Quotation mark can only be represented using the standard SQL syntax ''.
              - `BACKSLASH_QUOTE_SAFE_ENCODING`: Representing a quotation mark as \' is only permitted for client encodings where \ is not used for multibyte characters.
            type: string
            enum:
              - BACKSLASH_QUOTE_UNSPECIFIED
              - BACKSLASH_QUOTE
              - BACKSLASH_QUOTE_ON
              - BACKSLASH_QUOTE_OFF
              - BACKSLASH_QUOTE_SAFE_ENCODING
          defaultWithOids:
            description: |-
              **boolean**
              WITH OIDS is no longer supported; this can only be false.
            type: boolean
          escapeStringWarning:
            description: |-
              **boolean**
              Warn about backslash escapes in ordinary string literals.
            type: boolean
          loCompatPrivileges:
            description: |-
              **boolean**
              Enables backward compatibility mode for privilege checks on large objects. Skips privilege checks
              when reading or modifying large objects, for compatibility with PostgreSQL releases prior to 9.0.
            type: boolean
          quoteAllIdentifiers:
            description: |-
              **boolean**
              When generating SQL fragments, quote all identifiers.
            type: boolean
          standardConformingStrings:
            description: |-
              **boolean**
              Causes '...' strings to treat backslashes literally.
            type: boolean
          synchronizeSeqscans:
            description: |-
              **boolean**
              Enable synchronized sequential scans.
            type: boolean
          transformNullEquals:
            description: |-
              **boolean**
              Treats \"expr=NULL\" as \"expr IS NULL\". When turned on, expressions of the form expr = NULL
              (or NULL = expr) are treated as expr IS NULL, that is, they return true if expr evaluates to the
              null value, and false otherwise. The correct behavior of expr = NULL is to always return null (unknown).
            type: boolean
          exitOnError:
            description: |-
              **boolean**
              Terminate session on any error.
            type: boolean
          seqPageCost:
            description: |-
              **number** (double)
              Sets the planner's estimate of the cost of a sequentially fetched disk page.
              The minimum value is 0.
            type: number
            format: double
          randomPageCost:
            description: |-
              **number** (double)
              Sets the planner's estimate of the cost of a nonsequentially fetched disk page.
              The minimum value is 0.
            type: number
            format: double
          enableBitmapscan:
            description: |-
              **boolean**
              Enables the planner's use of bitmap-scan plans.
            type: boolean
          enableHashagg:
            description: |-
              **boolean**
              Enables the planner's use of hashed aggregation plans.
            type: boolean
          enableHashjoin:
            description: |-
              **boolean**
              Enables the planner's use of hash join plans.
            type: boolean
          enableIndexscan:
            description: |-
              **boolean**
              Enables the planner's use of index-scan plans.
            type: boolean
          enableIndexonlyscan:
            description: |-
              **boolean**
              Enables the planner's use of index-only-scan plans.
            type: boolean
          enableMaterial:
            description: |-
              **boolean**
              Enables the planner's use of materialization.
            type: boolean
          enableMergejoin:
            description: |-
              **boolean**
              Enables the planner's use of merge join plans.
            type: boolean
          enableNestloop:
            description: |-
              **boolean**
              Enables the planner's use of nested-loop join plans.
            type: boolean
          enableSeqscan:
            description: |-
              **boolean**
              Enables the planner's use of sequential-scan plans.
            type: boolean
          enableSort:
            description: |-
              **boolean**
              Enables the planner's use of explicit sort steps.
            type: boolean
          enableTidscan:
            description: |-
              **boolean**
              Enables the planner's use of TID scan plans.
            type: boolean
          maxParallelWorkers:
            description: |-
              **string** (int64)
              Sets the maximum number of parallel workers that can be active at one time.
              Acceptable values are 0 to 1024, inclusive.
            type: string
            format: int64
          maxParallelWorkersPerGather:
            description: |-
              **string** (int64)
              Sets the maximum number of parallel processes per executor node.
              Acceptable values are 0 to 1024, inclusive.
            type: string
            format: int64
          timezone:
            description: |-
              **string**
              Sets the time zone for displaying and interpreting time stamps.
            type: string
          effectiveIoConcurrency:
            description: |-
              **string** (int64)
              Number of simultaneous requests that can be handled efficiently by the disk subsystem.
              Acceptable values are 0 to 1000, inclusive.
            type: string
            format: int64
          effectiveCacheSize:
            description: |-
              **string** (int64)
              Sets the planner's assumption about the effective size of the disk cache available to a single query. In bytes.
              Acceptable values are 1048576 to 549755813888, inclusive.
            type: string
            format: int64
          idleSessionTimeout:
            description: |-
              **string** (int64)
              Sets the maximum allowed idle time between queries, when not in a transaction. In milliseconds.
              Acceptable values are 0 to 2147483647, inclusive.
            type: string
            format: int64
      PostgresqlHostConfig14_1C:
        type: object
        properties:
          recoveryMinApplyDelay:
            description: |-
              **string** (int64)
              Sets the minimum delay for applying changes during recovery. In milliseconds.
            type: string
            format: int64
          sharedBuffers:
            description: |-
              **string** (int64)
              Sets the number of shared memory buffers used by the server. In bytes.
            type: string
            format: int64
          tempBuffers:
            description: |-
              **string** (int64)
              Sets the maximum number of temporary buffers used by each session. In bytes.
            type: string
            format: int64
          workMem:
            description: |-
              **string** (int64)
              Sets the maximum memory to be used for query workspaces. This much memory can be used by each
              internal sort operation and hash table before switching to temporary disk files. In bytes.
            type: string
            format: int64
          tempFileLimit:
            description: |-
              **string** (int64)
              Limits the total size of all temporary files used by each process. -1 means no limit. In bytes.
            type: string
            format: int64
          backendFlushAfter:
            description: |-
              **string** (int64)
              Specifies how much data a backend can write before forcing the operating system to issue the writes. In bytes.
              Acceptable values are 0 to 2097152, inclusive.
            type: string
            format: int64
          oldSnapshotThreshold:
            description: |-
              **string** (int64)
              Time before a snapshot is too old to read pages changed after the snapshot was taken.
              A value of -1 disables this feature. In milliseconds.
            type: string
            format: int64
          maxStandbyStreamingDelay:
            description: |-
              **string** (int64)
              Sets the maximum delay before canceling queries when a hot standby server is processing streamed WAL data. In milliseconds.
            type: string
            format: int64
          constraintExclusion:
            description: |-
              **enum** (ConstraintExclusion)
              Enables the planner to use constraints to optimize queries.
              - `CONSTRAINT_EXCLUSION_ON`: Enable planner's use of constraints for all tables.
              - `CONSTRAINT_EXCLUSION_OFF`: Disable planner's use of constraints for all tables
              - `CONSTRAINT_EXCLUSION_PARTITION`: Only use constraints for child tables and UNION ALL clauses.
            type: string
            enum:
              - CONSTRAINT_EXCLUSION_UNSPECIFIED
              - CONSTRAINT_EXCLUSION_ON
              - CONSTRAINT_EXCLUSION_OFF
              - CONSTRAINT_EXCLUSION_PARTITION
          cursorTupleFraction:
            description: |-
              **number** (double)
              Sets the planner's estimate of the fraction of a cursor's rows that will be retrieved.
            type: number
            format: double
          fromCollapseLimit:
            description: |-
              **string** (int64)
              Sets the FROM-list size beyond which subqueries are not collapsed.
              Acceptable values are 1 to 2147483647, inclusive.
            type: string
            format: int64
          joinCollapseLimit:
            description: |-
              **string** (int64)
              Sets the FROM-list size beyond which JOIN constructs are not flattened.
              Acceptable values are 1 to 2147483647, inclusive.
            type: string
            format: int64
          forceParallelMode:
            description: |-
              **enum** (ForceParallelMode)
              Forces use of parallel query facilities. If possible, run query using a parallel worker and with parallel restrictions.
              - `FORCE_PARALLEL_MODE_ON`: Forces parallel mode for queries considered safe, even when no performance benefit is expected.
              - `FORCE_PARALLEL_MODE_OFF`: Uses parallel mode only when the planner expects it to improve performance.
              - `FORCE_PARALLEL_MODE_REGRESS`: Behaves like ON, but hides added Gather nodes in EXPLAIN output and
              suppresses parallel-worker context lines to stabilize regression-test output.
            type: string
            enum:
              - FORCE_PARALLEL_MODE_UNSPECIFIED
              - FORCE_PARALLEL_MODE_ON
              - FORCE_PARALLEL_MODE_OFF
              - FORCE_PARALLEL_MODE_REGRESS
          clientMinMessages:
            description: |-
              **enum** (LogLevel)
              Sets the message levels that are sent to the client.
              - `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
              - `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
              - `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
              - `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
              - `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
              - `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
              - `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
              - `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
              - `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
              - `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
              - `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions.
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
              Sets the message levels that are logged.
              - `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
              - `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
              - `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
              - `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
              - `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
              - `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
              - `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
              - `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
              - `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
              - `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
              - `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions.
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
              Causes all statements generating error at or above this level to be logged.
              - `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
              - `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
              - `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
              - `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
              - `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
              - `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
              - `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
              - `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
              - `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
              - `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
              - `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions.
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
              Sets the minimum execution time above which all statements will be logged. In milliseconds.
            type: string
            format: int64
          logCheckpoints:
            description: |-
              **boolean**
              Logs each checkpoint.
            type: boolean
          logConnections:
            description: |-
              **boolean**
              Logs each successful connection.
            type: boolean
          logDisconnections:
            description: |-
              **boolean**
              Logs end of a session, including duration.
            type: boolean
          logDuration:
            description: |
              **boolean**
              Logs the duration of each completed SQL statement.
            type: boolean
          logErrorVerbosity:
            description: |-
              **enum** (LogErrorVerbosity)
              Sets the verbosity of logged messages.
              - `LOG_ERROR_VERBOSITY_TERSE`: DETAIL, HINT, QUERY, and CONTEXT fields are excluded from the error message.
              - `LOG_ERROR_VERBOSITY_DEFAULT`: Default.
              - `LOG_ERROR_VERBOSITY_VERBOSE`: Error message includes the SQLSTATE error code, source filename, function name, and the line number where the error occurred.
            type: string
            enum:
              - LOG_ERROR_VERBOSITY_UNSPECIFIED
              - LOG_ERROR_VERBOSITY_TERSE
              - LOG_ERROR_VERBOSITY_DEFAULT
              - LOG_ERROR_VERBOSITY_VERBOSE
          logLockWaits:
            description: |-
              **boolean**
              Logs long lock waits.
            type: boolean
          logStatement:
            description: |-
              **enum** (LogStatement)
              Sets the type of statements logged.
              - `LOG_STATEMENT_NONE`: The filter is disabled, no SQL statements are logged.
              - `LOG_STATEMENT_DDL`: System logs DDL statements, e.g., CREATE, ALTER, DROP etc.
              - `LOG_STATEMENT_MOD`: System logs ddl-statements along with data modification commands, e.g., INSERT, UPDATE, etc.
              - `LOG_STATEMENT_ALL`: System logs all SQL statements.
            type: string
            enum:
              - LOG_STATEMENT_UNSPECIFIED
              - LOG_STATEMENT_NONE
              - LOG_STATEMENT_DDL
              - LOG_STATEMENT_MOD
              - LOG_STATEMENT_ALL
          logTempFiles:
            description: |-
              **string** (int64)
              Log the use of temporary files larger than this number of kilobytes.
            type: string
            format: int64
          searchPath:
            description: |-
              **string**
              Sets the schema search order for names that are not schema-qualified.
            type: string
          rowSecurity:
            description: |-
              **boolean**
              Enable row security.
            type: boolean
          defaultTransactionIsolation:
            description: |-
              **enum** (TransactionIsolation)
              Sets the transaction isolation level of each new transaction.
              - `TRANSACTION_ISOLATION_READ_UNCOMMITTED`: This level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.
              - `TRANSACTION_ISOLATION_READ_COMMITTED`: On this level query sees only data committed before the query began.
              - `TRANSACTION_ISOLATION_REPEATABLE_READ`: On this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).
              - `TRANSACTION_ISOLATION_SERIALIZABLE`: This level provides the strictest transaction isolation.
              All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction.
              If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure.
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
              Sets the maximum allowed duration of any statement. In milliseconds.
            type: string
            format: int64
          lockTimeout:
            description: |-
              **string** (int64)
              Sets the maximum allowed duration of any wait for a lock. In milliseconds.
            type: string
            format: int64
          idleInTransactionSessionTimeout:
            description: |-
              **string** (int64)
              Sets the maximum allowed idle time between queries, when in a transaction. In milliseconds.
              Acceptable values are 0 to 2147483647, inclusive.
            type: string
            format: int64
          byteaOutput:
            description: |-
              **enum** (ByteaOutput)
              Sets the output format for bytea.
              - `BYTEA_OUTPUT_HEX`: Each byte is represented by two hexadecimal characters, e.g., 'SELECT '\xDEADBEEF';'.
              - `BYTEA_OUTPUT_ESCAPED`: Standard PostgreSQL format with ASCII characters only.
            type: string
            enum:
              - BYTEA_OUTPUT_UNSPECIFIED
              - BYTEA_OUTPUT_HEX
              - BYTEA_OUTPUT_ESCAPED
          xmlbinary:
            description: |-
              **enum** (XmlBinary)
              Sets how binary values are to be encoded in XML.
              - `XML_BINARY_BASE64`: Encodes binary values using Base64.
              - `XML_BINARY_HEX`: Encodes binary values using hexadecimal notation.
            type: string
            enum:
              - XML_BINARY_UNSPECIFIED
              - XML_BINARY_BASE64
              - XML_BINARY_HEX
          xmloption:
            description: |-
              **enum** (XmlOption)
              Sets whether XML data in implicit parsing and serialization operations is to be considered as documents or content fragments.
              - `XML_OPTION_DOCUMENT`: Treats an XML value as a complete, well-formed document.
              - `XML_OPTION_CONTENT`: Treats an XML value as a content fragment, which may contain multiple top-level elements or character nodes.
            type: string
            enum:
              - XML_OPTION_UNSPECIFIED
              - XML_OPTION_DOCUMENT
              - XML_OPTION_CONTENT
          ginPendingListLimit:
            description: |-
              **string** (int64)
              Sets the maximum size of the pending list for GIN index. In bytes.
            type: string
            format: int64
          deadlockTimeout:
            description: |-
              **string** (int64)
              Sets the time to wait on a lock before checking for deadlock. In milliseconds.
              Acceptable values are 1 to 2147483647, inclusive.
            type: string
            format: int64
          maxLocksPerTransaction:
            description: |-
              **string** (int64)
              Sets the maximum number of locks per transaction. The shared lock table is sized on the assumption that
              at most max_locks_per_transaction * max_connections distinct objects will need to be locked at any one time.
            type: string
            format: int64
          maxPredLocksPerTransaction:
            description: |-
              **string** (int64)
              Sets the maximum number of predicate locks per transaction.The shared predicate lock table is sized on the assumption that
              at most max_pred_locks_per_transaction * max_connections distinct objects will need to be locked at any one time.
            type: string
            format: int64
          arrayNulls:
            description: |-
              **boolean**
              Enable input of NULL elements in arrays. When turned on, unquoted NULL in an array input
              value means a null value; otherwise it is taken literally.
            type: boolean
          backslashQuote:
            description: |-
              **enum** (BackslashQuote)
              Sets whether \"\\'\" is allowed in string literals.
              - `BACKSLASH_QUOTE`: Legacy invalid value. Do not use.
              - `BACKSLASH_QUOTE_ON`: Quotation mark can be represented as \'.
              - `BACKSLASH_QUOTE_OFF`: Quotation mark can only be represented using the standard SQL syntax ''.
              - `BACKSLASH_QUOTE_SAFE_ENCODING`: Representing a quotation mark as \' is only permitted for client encodings where \ is not used for multibyte characters.
            type: string
            enum:
              - BACKSLASH_QUOTE_UNSPECIFIED
              - BACKSLASH_QUOTE
              - BACKSLASH_QUOTE_ON
              - BACKSLASH_QUOTE_OFF
              - BACKSLASH_QUOTE_SAFE_ENCODING
          defaultWithOids:
            description: |-
              **boolean**
              WITH OIDS is no longer supported; this can only be false.
            type: boolean
          escapeStringWarning:
            description: |-
              **boolean**
              Warn about backslash escapes in ordinary string literals.
            type: boolean
          loCompatPrivileges:
            description: |-
              **boolean**
              Enables backward compatibility mode for privilege checks on large objects. Skips privilege checks
              when reading or modifying large objects, for compatibility with PostgreSQL releases prior to 9.0.
            type: boolean
          quoteAllIdentifiers:
            description: |-
              **boolean**
              When generating SQL fragments, quote all identifiers.
            type: boolean
          standardConformingStrings:
            description: |-
              **boolean**
              Causes '...' strings to treat backslashes literally.
            type: boolean
          synchronizeSeqscans:
            description: |-
              **boolean**
              Enable synchronized sequential scans.
            type: boolean
          transformNullEquals:
            description: |-
              **boolean**
              Treats \"expr=NULL\" as \"expr IS NULL\". When turned on, expressions of the form expr = NULL
              (or NULL = expr) are treated as expr IS NULL, that is, they return true if expr evaluates to the
              null value, and false otherwise. The correct behavior of expr = NULL is to always return null (unknown).
            type: boolean
          exitOnError:
            description: |-
              **boolean**
              Terminate session on any error.
            type: boolean
          seqPageCost:
            description: |-
              **number** (double)
              Sets the planner's estimate of the cost of a sequentially fetched disk page.
              The minimum value is 0.
            type: number
            format: double
          randomPageCost:
            description: |-
              **number** (double)
              Sets the planner's estimate of the cost of a nonsequentially fetched disk page.
              The minimum value is 0.
            type: number
            format: double
          enableBitmapscan:
            description: |-
              **boolean**
              Enables the planner's use of bitmap-scan plans.
            type: boolean
          enableHashagg:
            description: |-
              **boolean**
              Enables the planner's use of hashed aggregation plans.
            type: boolean
          enableHashjoin:
            description: |-
              **boolean**
              Enables the planner's use of hash join plans.
            type: boolean
          enableIndexscan:
            description: |-
              **boolean**
              Enables the planner's use of index-scan plans.
            type: boolean
          enableIndexonlyscan:
            description: |-
              **boolean**
              Enables the planner's use of index-only-scan plans.
            type: boolean
          enableMaterial:
            description: |-
              **boolean**
              Enables the planner's use of materialization.
            type: boolean
          enableMergejoin:
            description: |-
              **boolean**
              Enables the planner's use of merge join plans.
            type: boolean
          enableNestloop:
            description: |-
              **boolean**
              Enables the planner's use of nested-loop join plans.
            type: boolean
          enableSeqscan:
            description: |-
              **boolean**
              Enables the planner's use of sequential-scan plans.
            type: boolean
          enableSort:
            description: |-
              **boolean**
              Enables the planner's use of explicit sort steps.
            type: boolean
          enableTidscan:
            description: |-
              **boolean**
              Enables the planner's use of TID scan plans.
            type: boolean
          maxParallelWorkers:
            description: |-
              **string** (int64)
              Sets the maximum number of parallel workers that can be active at one time.
              Acceptable values are 0 to 1024, inclusive.
            type: string
            format: int64
          maxParallelWorkersPerGather:
            description: |-
              **string** (int64)
              Sets the maximum number of parallel processes per executor node.
              Acceptable values are 0 to 1024, inclusive.
            type: string
            format: int64
          timezone:
            description: |-
              **string**
              Sets the time zone for displaying and interpreting time stamps.
            type: string
          effectiveIoConcurrency:
            description: |-
              **string** (int64)
              Number of simultaneous requests that can be handled efficiently by the disk subsystem.
              Acceptable values are 0 to 1000, inclusive.
            type: string
            format: int64
          effectiveCacheSize:
            description: |-
              **string** (int64)
              Sets the planner's assumption about the effective size of the disk cache available to a single query. In bytes.
              Acceptable values are 1048576 to 549755813888, inclusive.
            type: string
            format: int64
          idleSessionTimeout:
            description: |-
              **string** (int64)
              Sets the maximum allowed idle time between queries, when not in a transaction. In milliseconds.
              Acceptable values are 0 to 2147483647, inclusive.
            type: string
            format: int64
      PostgresqlHostConfig15:
        type: object
        properties:
          recoveryMinApplyDelay:
            description: |-
              **string** (int64)
              Sets the minimum delay for applying changes during recovery. In milliseconds.
            type: string
            format: int64
          sharedBuffers:
            description: |-
              **string** (int64)
              Sets the number of shared memory buffers used by the server. In bytes.
            type: string
            format: int64
          tempBuffers:
            description: |-
              **string** (int64)
              Sets the maximum number of temporary buffers used by each session. In bytes.
            type: string
            format: int64
          workMem:
            description: |-
              **string** (int64)
              Sets the maximum memory to be used for query workspaces. This much memory can be used by each
              internal sort operation and hash table before switching to temporary disk files. In bytes.
            type: string
            format: int64
          tempFileLimit:
            description: |-
              **string** (int64)
              Limits the total size of all temporary files used by each process. -1 means no limit. In bytes.
            type: string
            format: int64
          backendFlushAfter:
            description: |-
              **string** (int64)
              Specifies how much data a backend can write before forcing the operating system to issue the writes. In bytes.
              Acceptable values are 0 to 2097152, inclusive.
            type: string
            format: int64
          oldSnapshotThreshold:
            description: |-
              **string** (int64)
              Time before a snapshot is too old to read pages changed after the snapshot was taken.
              A value of -1 disables this feature. In milliseconds.
            type: string
            format: int64
          maxStandbyStreamingDelay:
            description: |-
              **string** (int64)
              Sets the maximum delay before canceling queries when a hot standby server is processing streamed WAL data. In milliseconds.
            type: string
            format: int64
          constraintExclusion:
            description: |-
              **enum** (ConstraintExclusion)
              Enables the planner to use constraints to optimize queries.
              - `CONSTRAINT_EXCLUSION_ON`: Enable planner's use of constraints for all tables.
              - `CONSTRAINT_EXCLUSION_OFF`: Disable planner's use of constraints for all tables
              - `CONSTRAINT_EXCLUSION_PARTITION`: Only use constraints for child tables and UNION ALL clauses.
            type: string
            enum:
              - CONSTRAINT_EXCLUSION_UNSPECIFIED
              - CONSTRAINT_EXCLUSION_ON
              - CONSTRAINT_EXCLUSION_OFF
              - CONSTRAINT_EXCLUSION_PARTITION
          cursorTupleFraction:
            description: |-
              **number** (double)
              Sets the planner's estimate of the fraction of a cursor's rows that will be retrieved.
            type: number
            format: double
          fromCollapseLimit:
            description: |-
              **string** (int64)
              Sets the FROM-list size beyond which subqueries are not collapsed.
              Acceptable values are 1 to 2147483647, inclusive.
            type: string
            format: int64
          joinCollapseLimit:
            description: |-
              **string** (int64)
              Sets the FROM-list size beyond which JOIN constructs are not flattened.
              Acceptable values are 1 to 2147483647, inclusive.
            type: string
            format: int64
          forceParallelMode:
            description: |-
              **enum** (ForceParallelMode)
              Forces use of parallel query facilities. If possible, run query using a parallel worker and with parallel restrictions.
              - `FORCE_PARALLEL_MODE_ON`: Forces parallel mode for queries considered safe, even when no performance benefit is expected.
              - `FORCE_PARALLEL_MODE_OFF`: Uses parallel mode only when the planner expects it to improve performance.
              - `FORCE_PARALLEL_MODE_REGRESS`: Behaves like ON, but hides added Gather nodes in EXPLAIN output and
              suppresses parallel-worker context lines to stabilize regression-test output.
            type: string
            enum:
              - FORCE_PARALLEL_MODE_UNSPECIFIED
              - FORCE_PARALLEL_MODE_ON
              - FORCE_PARALLEL_MODE_OFF
              - FORCE_PARALLEL_MODE_REGRESS
          clientMinMessages:
            description: |-
              **enum** (LogLevel)
              Sets the message levels that are sent to the client.
              - `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
              - `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
              - `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
              - `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
              - `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
              - `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
              - `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
              - `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
              - `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
              - `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
              - `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions.
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
              Sets the message levels that are logged.
              - `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
              - `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
              - `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
              - `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
              - `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
              - `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
              - `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
              - `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
              - `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
              - `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
              - `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions.
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
              Causes all statements generating error at or above this level to be logged.
              - `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
              - `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
              - `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
              - `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
              - `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
              - `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
              - `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
              - `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
              - `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
              - `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
              - `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions.
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
              Sets the minimum execution time above which all statements will be logged. In milliseconds.
            type: string
            format: int64
          logCheckpoints:
            description: |-
              **boolean**
              Logs each checkpoint.
            type: boolean
          logConnections:
            description: |-
              **boolean**
              Logs each successful connection.
            type: boolean
          logDisconnections:
            description: |-
              **boolean**
              Logs end of a session, including duration.
            type: boolean
          logDuration:
            description: |
              **boolean**
              Logs the duration of each completed SQL statement.
            type: boolean
          logErrorVerbosity:
            description: |-
              **enum** (LogErrorVerbosity)
              Sets the verbosity of logged messages.
              - `LOG_ERROR_VERBOSITY_TERSE`: DETAIL, HINT, QUERY, and CONTEXT fields are excluded from the error message.
              - `LOG_ERROR_VERBOSITY_DEFAULT`: Default.
              - `LOG_ERROR_VERBOSITY_VERBOSE`: Error message includes the SQLSTATE error code, source filename, function name, and the line number where the error occurred.
            type: string
            enum:
              - LOG_ERROR_VERBOSITY_UNSPECIFIED
              - LOG_ERROR_VERBOSITY_TERSE
              - LOG_ERROR_VERBOSITY_DEFAULT
              - LOG_ERROR_VERBOSITY_VERBOSE
          logLockWaits:
            description: |-
              **boolean**
              Logs long lock waits.
            type: boolean
          logStatement:
            description: |-
              **enum** (LogStatement)
              Sets the type of statements logged.
              - `LOG_STATEMENT_NONE`: The filter is disabled, no SQL statements are logged.
              - `LOG_STATEMENT_DDL`: System logs DDL statements, e.g., CREATE, ALTER, DROP etc.
              - `LOG_STATEMENT_MOD`: System logs ddl-statements along with data modification commands, e.g., INSERT, UPDATE, etc.
              - `LOG_STATEMENT_ALL`: System logs all SQL statements.
            type: string
            enum:
              - LOG_STATEMENT_UNSPECIFIED
              - LOG_STATEMENT_NONE
              - LOG_STATEMENT_DDL
              - LOG_STATEMENT_MOD
              - LOG_STATEMENT_ALL
          logTempFiles:
            description: |-
              **string** (int64)
              Log the use of temporary files larger than this number of kilobytes.
            type: string
            format: int64
          searchPath:
            description: |-
              **string**
              Sets the schema search order for names that are not schema-qualified.
            type: string
          rowSecurity:
            description: |-
              **boolean**
              Enable row security.
            type: boolean
          defaultTransactionIsolation:
            description: |-
              **enum** (TransactionIsolation)
              Sets the transaction isolation level of each new transaction.
              - `TRANSACTION_ISOLATION_READ_UNCOMMITTED`: This level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.
              - `TRANSACTION_ISOLATION_READ_COMMITTED`: On this level query sees only data committed before the query began.
              - `TRANSACTION_ISOLATION_REPEATABLE_READ`: On this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).
              - `TRANSACTION_ISOLATION_SERIALIZABLE`: This level provides the strictest transaction isolation.
              All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction.
              If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure.
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
              Sets the maximum allowed duration of any statement. In milliseconds.
            type: string
            format: int64
          lockTimeout:
            description: |-
              **string** (int64)
              Sets the maximum allowed duration of any wait for a lock. In milliseconds.
            type: string
            format: int64
          idleInTransactionSessionTimeout:
            description: |-
              **string** (int64)
              Sets the maximum allowed idle time between queries, when in a transaction. In milliseconds.
              Acceptable values are 0 to 2147483647, inclusive.
            type: string
            format: int64
          byteaOutput:
            description: |-
              **enum** (ByteaOutput)
              Sets the output format for bytea.
              - `BYTEA_OUTPUT_HEX`: Each byte is represented by two hexadecimal characters, e.g., 'SELECT '\xDEADBEEF';'.
              - `BYTEA_OUTPUT_ESCAPED`: Standard PostgreSQL format with ASCII characters only.
            type: string
            enum:
              - BYTEA_OUTPUT_UNSPECIFIED
              - BYTEA_OUTPUT_HEX
              - BYTEA_OUTPUT_ESCAPED
          xmlbinary:
            description: |-
              **enum** (XmlBinary)
              Sets how binary values are to be encoded in XML.
              - `XML_BINARY_BASE64`: Encodes binary values using Base64.
              - `XML_BINARY_HEX`: Encodes binary values using hexadecimal notation.
            type: string
            enum:
              - XML_BINARY_UNSPECIFIED
              - XML_BINARY_BASE64
              - XML_BINARY_HEX
          xmloption:
            description: |-
              **enum** (XmlOption)
              Sets whether XML data in implicit parsing and serialization operations is to be considered as documents or content fragments.
              - `XML_OPTION_DOCUMENT`: Treats an XML value as a complete, well-formed document.
              - `XML_OPTION_CONTENT`: Treats an XML value as a content fragment, which may contain multiple top-level elements or character nodes.
            type: string
            enum:
              - XML_OPTION_UNSPECIFIED
              - XML_OPTION_DOCUMENT
              - XML_OPTION_CONTENT
          ginPendingListLimit:
            description: |-
              **string** (int64)
              Sets the maximum size of the pending list for GIN index. In bytes.
            type: string
            format: int64
          deadlockTimeout:
            description: |-
              **string** (int64)
              Sets the time to wait on a lock before checking for deadlock. In milliseconds.
              Acceptable values are 1 to 2147483647, inclusive.
            type: string
            format: int64
          maxLocksPerTransaction:
            description: |-
              **string** (int64)
              Sets the maximum number of locks per transaction. The shared lock table is sized on the assumption that
              at most max_locks_per_transaction * max_connections distinct objects will need to be locked at any one time.
            type: string
            format: int64
          maxPredLocksPerTransaction:
            description: |-
              **string** (int64)
              Sets the maximum number of predicate locks per transaction.The shared predicate lock table is sized on the assumption that
              at most max_pred_locks_per_transaction * max_connections distinct objects will need to be locked at any one time.
            type: string
            format: int64
          arrayNulls:
            description: |-
              **boolean**
              Enable input of NULL elements in arrays. When turned on, unquoted NULL in an array input
              value means a null value; otherwise it is taken literally.
            type: boolean
          backslashQuote:
            description: |-
              **enum** (BackslashQuote)
              Sets whether \"\\'\" is allowed in string literals.
              - `BACKSLASH_QUOTE`: Legacy invalid value. Do not use.
              - `BACKSLASH_QUOTE_ON`: Quotation mark can be represented as \'.
              - `BACKSLASH_QUOTE_OFF`: Quotation mark can only be represented using the standard SQL syntax ''.
              - `BACKSLASH_QUOTE_SAFE_ENCODING`: Representing a quotation mark as \' is only permitted for client encodings where \ is not used for multibyte characters.
            type: string
            enum:
              - BACKSLASH_QUOTE_UNSPECIFIED
              - BACKSLASH_QUOTE
              - BACKSLASH_QUOTE_ON
              - BACKSLASH_QUOTE_OFF
              - BACKSLASH_QUOTE_SAFE_ENCODING
          defaultWithOids:
            description: |-
              **boolean**
              WITH OIDS is no longer supported; this can only be false.
            type: boolean
          escapeStringWarning:
            description: |-
              **boolean**
              Warn about backslash escapes in ordinary string literals.
            type: boolean
          loCompatPrivileges:
            description: |-
              **boolean**
              Enables backward compatibility mode for privilege checks on large objects. Skips privilege checks
              when reading or modifying large objects, for compatibility with PostgreSQL releases prior to 9.0.
            type: boolean
          quoteAllIdentifiers:
            description: |-
              **boolean**
              When generating SQL fragments, quote all identifiers.
            type: boolean
          standardConformingStrings:
            description: |-
              **boolean**
              Causes '...' strings to treat backslashes literally.
            type: boolean
          synchronizeSeqscans:
            description: |-
              **boolean**
              Enable synchronized sequential scans.
            type: boolean
          transformNullEquals:
            description: |-
              **boolean**
              Treats \"expr=NULL\" as \"expr IS NULL\". When turned on, expressions of the form expr = NULL
              (or NULL = expr) are treated as expr IS NULL, that is, they return true if expr evaluates to the
              null value, and false otherwise. The correct behavior of expr = NULL is to always return null (unknown).
            type: boolean
          exitOnError:
            description: |-
              **boolean**
              Terminate session on any error.
            type: boolean
          seqPageCost:
            description: |-
              **number** (double)
              Sets the planner's estimate of the cost of a sequentially fetched disk page.
              The minimum value is 0.
            type: number
            format: double
          randomPageCost:
            description: |-
              **number** (double)
              Sets the planner's estimate of the cost of a nonsequentially fetched disk page.
              The minimum value is 0.
            type: number
            format: double
          enableBitmapscan:
            description: |-
              **boolean**
              Enables the planner's use of bitmap-scan plans.
            type: boolean
          enableHashagg:
            description: |-
              **boolean**
              Enables the planner's use of hashed aggregation plans.
            type: boolean
          enableHashjoin:
            description: |-
              **boolean**
              Enables the planner's use of hash join plans.
            type: boolean
          enableIndexscan:
            description: |-
              **boolean**
              Enables the planner's use of index-scan plans.
            type: boolean
          enableIndexonlyscan:
            description: |-
              **boolean**
              Enables the planner's use of index-only-scan plans.
            type: boolean
          enableMaterial:
            description: |-
              **boolean**
              Enables the planner's use of materialization.
            type: boolean
          enableMergejoin:
            description: |-
              **boolean**
              Enables the planner's use of merge join plans.
            type: boolean
          enableNestloop:
            description: |-
              **boolean**
              Enables the planner's use of nested-loop join plans.
            type: boolean
          enableSeqscan:
            description: |-
              **boolean**
              Enables the planner's use of sequential-scan plans.
            type: boolean
          enableSort:
            description: |-
              **boolean**
              Enables the planner's use of explicit sort steps.
            type: boolean
          enableTidscan:
            description: |-
              **boolean**
              Enables the planner's use of TID scan plans.
            type: boolean
          maxParallelWorkers:
            description: |-
              **string** (int64)
              Sets the maximum number of parallel workers that can be active at one time.
              Acceptable values are 0 to 1024, inclusive.
            type: string
            format: int64
          maxParallelWorkersPerGather:
            description: |-
              **string** (int64)
              Sets the maximum number of parallel processes per executor node.
              Acceptable values are 0 to 1024, inclusive.
            type: string
            format: int64
          timezone:
            description: |-
              **string**
              Sets the time zone for displaying and interpreting time stamps.
            type: string
          effectiveIoConcurrency:
            description: |-
              **string** (int64)
              Number of simultaneous requests that can be handled efficiently by the disk subsystem.
              Acceptable values are 0 to 1000, inclusive.
            type: string
            format: int64
          effectiveCacheSize:
            description: |-
              **string** (int64)
              Sets the planner's assumption about the effective size of the disk cache available to a single query. In bytes.
              Acceptable values are 1048576 to 549755813888, inclusive.
            type: string
            format: int64
          idleSessionTimeout:
            description: |-
              **string** (int64)
              Sets the maximum allowed idle time between queries, when not in a transaction. In milliseconds.
              Acceptable values are 0 to 2147483647, inclusive.
            type: string
            format: int64
      PostgresqlHostConfig15_1C:
        type: object
        properties:
          recoveryMinApplyDelay:
            description: |-
              **string** (int64)
              Sets the minimum delay for applying changes during recovery. In milliseconds.
            type: string
            format: int64
          sharedBuffers:
            description: |-
              **string** (int64)
              Sets the number of shared memory buffers used by the server. In bytes.
            type: string
            format: int64
          tempBuffers:
            description: |-
              **string** (int64)
              Sets the maximum number of temporary buffers used by each session. In bytes.
            type: string
            format: int64
          workMem:
            description: |-
              **string** (int64)
              Sets the maximum memory to be used for query workspaces. This much memory can be used by each
              internal sort operation and hash table before switching to temporary disk files. In bytes.
            type: string
            format: int64
          tempFileLimit:
            description: |-
              **string** (int64)
              Limits the total size of all temporary files used by each process. -1 means no limit. In bytes.
            type: string
            format: int64
          backendFlushAfter:
            description: |-
              **string** (int64)
              Specifies how much data a backend can write before forcing the operating system to issue the writes. In bytes.
              Acceptable values are 0 to 2097152, inclusive.
            type: string
            format: int64
          oldSnapshotThreshold:
            description: |-
              **string** (int64)
              Time before a snapshot is too old to read pages changed after the snapshot was taken.
              A value of -1 disables this feature. In milliseconds.
            type: string
            format: int64
          maxStandbyStreamingDelay:
            description: |-
              **string** (int64)
              Sets the maximum delay before canceling queries when a hot standby server is processing streamed WAL data. In milliseconds.
            type: string
            format: int64
          constraintExclusion:
            description: |-
              **enum** (ConstraintExclusion)
              Enables the planner to use constraints to optimize queries.
              - `CONSTRAINT_EXCLUSION_ON`: Enable planner's use of constraints for all tables.
              - `CONSTRAINT_EXCLUSION_OFF`: Disable planner's use of constraints for all tables
              - `CONSTRAINT_EXCLUSION_PARTITION`: Only use constraints for child tables and UNION ALL clauses.
            type: string
            enum:
              - CONSTRAINT_EXCLUSION_UNSPECIFIED
              - CONSTRAINT_EXCLUSION_ON
              - CONSTRAINT_EXCLUSION_OFF
              - CONSTRAINT_EXCLUSION_PARTITION
          cursorTupleFraction:
            description: |-
              **number** (double)
              Sets the planner's estimate of the fraction of a cursor's rows that will be retrieved.
            type: number
            format: double
          fromCollapseLimit:
            description: |-
              **string** (int64)
              Sets the FROM-list size beyond which subqueries are not collapsed.
              Acceptable values are 1 to 2147483647, inclusive.
            type: string
            format: int64
          joinCollapseLimit:
            description: |-
              **string** (int64)
              Sets the FROM-list size beyond which JOIN constructs are not flattened.
              Acceptable values are 1 to 2147483647, inclusive.
            type: string
            format: int64
          forceParallelMode:
            description: |-
              **enum** (ForceParallelMode)
              Forces use of parallel query facilities. If possible, run query using a parallel worker and with parallel restrictions.
              - `FORCE_PARALLEL_MODE_ON`: Forces parallel mode for queries considered safe, even when no performance benefit is expected.
              - `FORCE_PARALLEL_MODE_OFF`: Uses parallel mode only when the planner expects it to improve performance.
              - `FORCE_PARALLEL_MODE_REGRESS`: Behaves like ON, but hides added Gather nodes in EXPLAIN output and
              suppresses parallel-worker context lines to stabilize regression-test output.
            type: string
            enum:
              - FORCE_PARALLEL_MODE_UNSPECIFIED
              - FORCE_PARALLEL_MODE_ON
              - FORCE_PARALLEL_MODE_OFF
              - FORCE_PARALLEL_MODE_REGRESS
          clientMinMessages:
            description: |-
              **enum** (LogLevel)
              Sets the message levels that are sent to the client.
              - `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
              - `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
              - `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
              - `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
              - `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
              - `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
              - `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
              - `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
              - `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
              - `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
              - `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions.
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
              Sets the message levels that are logged.
              - `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
              - `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
              - `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
              - `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
              - `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
              - `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
              - `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
              - `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
              - `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
              - `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
              - `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions.
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
              Causes all statements generating error at or above this level to be logged.
              - `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
              - `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
              - `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
              - `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
              - `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
              - `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
              - `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
              - `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
              - `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
              - `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
              - `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions.
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
              Sets the minimum execution time above which all statements will be logged. In milliseconds.
            type: string
            format: int64
          logCheckpoints:
            description: |-
              **boolean**
              Logs each checkpoint.
            type: boolean
          logConnections:
            description: |-
              **boolean**
              Logs each successful connection.
            type: boolean
          logDisconnections:
            description: |-
              **boolean**
              Logs end of a session, including duration.
            type: boolean
          logDuration:
            description: |
              **boolean**
              Logs the duration of each completed SQL statement.
            type: boolean
          logErrorVerbosity:
            description: |-
              **enum** (LogErrorVerbosity)
              Sets the verbosity of logged messages.
              - `LOG_ERROR_VERBOSITY_TERSE`: DETAIL, HINT, QUERY, and CONTEXT fields are excluded from the error message.
              - `LOG_ERROR_VERBOSITY_DEFAULT`: Default.
              - `LOG_ERROR_VERBOSITY_VERBOSE`: Error message includes the SQLSTATE error code, source filename, function name, and the line number where the error occurred.
            type: string
            enum:
              - LOG_ERROR_VERBOSITY_UNSPECIFIED
              - LOG_ERROR_VERBOSITY_TERSE
              - LOG_ERROR_VERBOSITY_DEFAULT
              - LOG_ERROR_VERBOSITY_VERBOSE
          logLockWaits:
            description: |-
              **boolean**
              Logs long lock waits.
            type: boolean
          logStatement:
            description: |-
              **enum** (LogStatement)
              Sets the type of statements logged.
              - `LOG_STATEMENT_NONE`: The filter is disabled, no SQL statements are logged.
              - `LOG_STATEMENT_DDL`: System logs DDL statements, e.g., CREATE, ALTER, DROP etc.
              - `LOG_STATEMENT_MOD`: System logs ddl-statements along with data modification commands, e.g., INSERT, UPDATE, etc.
              - `LOG_STATEMENT_ALL`: System logs all SQL statements.
            type: string
            enum:
              - LOG_STATEMENT_UNSPECIFIED
              - LOG_STATEMENT_NONE
              - LOG_STATEMENT_DDL
              - LOG_STATEMENT_MOD
              - LOG_STATEMENT_ALL
          logTempFiles:
            description: |-
              **string** (int64)
              Log the use of temporary files larger than this number of kilobytes.
            type: string
            format: int64
          searchPath:
            description: |-
              **string**
              Sets the schema search order for names that are not schema-qualified.
            type: string
          rowSecurity:
            description: |-
              **boolean**
              Enable row security.
            type: boolean
          defaultTransactionIsolation:
            description: |-
              **enum** (TransactionIsolation)
              Sets the transaction isolation level of each new transaction.
              - `TRANSACTION_ISOLATION_READ_UNCOMMITTED`: This level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.
              - `TRANSACTION_ISOLATION_READ_COMMITTED`: On this level query sees only data committed before the query began.
              - `TRANSACTION_ISOLATION_REPEATABLE_READ`: On this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).
              - `TRANSACTION_ISOLATION_SERIALIZABLE`: This level provides the strictest transaction isolation.
              All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction.
              If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure.
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
              Sets the maximum allowed duration of any statement. In milliseconds.
            type: string
            format: int64
          lockTimeout:
            description: |-
              **string** (int64)
              Sets the maximum allowed duration of any wait for a lock. In milliseconds.
            type: string
            format: int64
          idleInTransactionSessionTimeout:
            description: |-
              **string** (int64)
              Sets the maximum allowed idle time between queries, when in a transaction. In milliseconds.
              Acceptable values are 0 to 2147483647, inclusive.
            type: string
            format: int64
          byteaOutput:
            description: |-
              **enum** (ByteaOutput)
              Sets the output format for bytea.
              - `BYTEA_OUTPUT_HEX`: Each byte is represented by two hexadecimal characters, e.g., 'SELECT '\xDEADBEEF';'.
              - `BYTEA_OUTPUT_ESCAPED`: Standard PostgreSQL format with ASCII characters only.
            type: string
            enum:
              - BYTEA_OUTPUT_UNSPECIFIED
              - BYTEA_OUTPUT_HEX
              - BYTEA_OUTPUT_ESCAPED
          xmlbinary:
            description: |-
              **enum** (XmlBinary)
              Sets how binary values are to be encoded in XML.
              - `XML_BINARY_BASE64`: Encodes binary values using Base64.
              - `XML_BINARY_HEX`: Encodes binary values using hexadecimal notation.
            type: string
            enum:
              - XML_BINARY_UNSPECIFIED
              - XML_BINARY_BASE64
              - XML_BINARY_HEX
          xmloption:
            description: |-
              **enum** (XmlOption)
              Sets whether XML data in implicit parsing and serialization operations is to be considered as documents or content fragments.
              - `XML_OPTION_DOCUMENT`: Treats an XML value as a complete, well-formed document.
              - `XML_OPTION_CONTENT`: Treats an XML value as a content fragment, which may contain multiple top-level elements or character nodes.
            type: string
            enum:
              - XML_OPTION_UNSPECIFIED
              - XML_OPTION_DOCUMENT
              - XML_OPTION_CONTENT
          ginPendingListLimit:
            description: |-
              **string** (int64)
              Sets the maximum size of the pending list for GIN index. In bytes.
            type: string
            format: int64
          deadlockTimeout:
            description: |-
              **string** (int64)
              Sets the time to wait on a lock before checking for deadlock. In milliseconds.
              Acceptable values are 1 to 2147483647, inclusive.
            type: string
            format: int64
          maxLocksPerTransaction:
            description: |-
              **string** (int64)
              Sets the maximum number of locks per transaction. The shared lock table is sized on the assumption that
              at most max_locks_per_transaction * max_connections distinct objects will need to be locked at any one time.
            type: string
            format: int64
          maxPredLocksPerTransaction:
            description: |-
              **string** (int64)
              Sets the maximum number of predicate locks per transaction.The shared predicate lock table is sized on the assumption that
              at most max_pred_locks_per_transaction * max_connections distinct objects will need to be locked at any one time.
            type: string
            format: int64
          arrayNulls:
            description: |-
              **boolean**
              Enable input of NULL elements in arrays. When turned on, unquoted NULL in an array input
              value means a null value; otherwise it is taken literally.
            type: boolean
          backslashQuote:
            description: |-
              **enum** (BackslashQuote)
              Sets whether \"\\'\" is allowed in string literals.
              - `BACKSLASH_QUOTE`: Legacy invalid value. Do not use.
              - `BACKSLASH_QUOTE_ON`: Quotation mark can be represented as \'.
              - `BACKSLASH_QUOTE_OFF`: Quotation mark can only be represented using the standard SQL syntax ''.
              - `BACKSLASH_QUOTE_SAFE_ENCODING`: Representing a quotation mark as \' is only permitted for client encodings where \ is not used for multibyte characters.
            type: string
            enum:
              - BACKSLASH_QUOTE_UNSPECIFIED
              - BACKSLASH_QUOTE
              - BACKSLASH_QUOTE_ON
              - BACKSLASH_QUOTE_OFF
              - BACKSLASH_QUOTE_SAFE_ENCODING
          defaultWithOids:
            description: |-
              **boolean**
              WITH OIDS is no longer supported; this can only be false.
            type: boolean
          escapeStringWarning:
            description: |-
              **boolean**
              Warn about backslash escapes in ordinary string literals.
            type: boolean
          loCompatPrivileges:
            description: |-
              **boolean**
              Enables backward compatibility mode for privilege checks on large objects. Skips privilege checks
              when reading or modifying large objects, for compatibility with PostgreSQL releases prior to 9.0.
            type: boolean
          quoteAllIdentifiers:
            description: |-
              **boolean**
              When generating SQL fragments, quote all identifiers.
            type: boolean
          standardConformingStrings:
            description: |-
              **boolean**
              Causes '...' strings to treat backslashes literally.
            type: boolean
          synchronizeSeqscans:
            description: |-
              **boolean**
              Enable synchronized sequential scans.
            type: boolean
          transformNullEquals:
            description: |-
              **boolean**
              Treats \"expr=NULL\" as \"expr IS NULL\". When turned on, expressions of the form expr = NULL
              (or NULL = expr) are treated as expr IS NULL, that is, they return true if expr evaluates to the
              null value, and false otherwise. The correct behavior of expr = NULL is to always return null (unknown).
            type: boolean
          exitOnError:
            description: |-
              **boolean**
              Terminate session on any error.
            type: boolean
          seqPageCost:
            description: |-
              **number** (double)
              Sets the planner's estimate of the cost of a sequentially fetched disk page.
              The minimum value is 0.
            type: number
            format: double
          randomPageCost:
            description: |-
              **number** (double)
              Sets the planner's estimate of the cost of a nonsequentially fetched disk page.
              The minimum value is 0.
            type: number
            format: double
          enableBitmapscan:
            description: |-
              **boolean**
              Enables the planner's use of bitmap-scan plans.
            type: boolean
          enableHashagg:
            description: |-
              **boolean**
              Enables the planner's use of hashed aggregation plans.
            type: boolean
          enableHashjoin:
            description: |-
              **boolean**
              Enables the planner's use of hash join plans.
            type: boolean
          enableIndexscan:
            description: |-
              **boolean**
              Enables the planner's use of index-scan plans.
            type: boolean
          enableIndexonlyscan:
            description: |-
              **boolean**
              Enables the planner's use of index-only-scan plans.
            type: boolean
          enableMaterial:
            description: |-
              **boolean**
              Enables the planner's use of materialization.
            type: boolean
          enableMergejoin:
            description: |-
              **boolean**
              Enables the planner's use of merge join plans.
            type: boolean
          enableNestloop:
            description: |-
              **boolean**
              Enables the planner's use of nested-loop join plans.
            type: boolean
          enableSeqscan:
            description: |-
              **boolean**
              Enables the planner's use of sequential-scan plans.
            type: boolean
          enableSort:
            description: |-
              **boolean**
              Enables the planner's use of explicit sort steps.
            type: boolean
          enableTidscan:
            description: |-
              **boolean**
              Enables the planner's use of TID scan plans.
            type: boolean
          maxParallelWorkers:
            description: |-
              **string** (int64)
              Sets the maximum number of parallel workers that can be active at one time.
              Acceptable values are 0 to 1024, inclusive.
            type: string
            format: int64
          maxParallelWorkersPerGather:
            description: |-
              **string** (int64)
              Sets the maximum number of parallel processes per executor node.
              Acceptable values are 0 to 1024, inclusive.
            type: string
            format: int64
          timezone:
            description: |-
              **string**
              Sets the time zone for displaying and interpreting time stamps.
            type: string
          effectiveIoConcurrency:
            description: |-
              **string** (int64)
              Number of simultaneous requests that can be handled efficiently by the disk subsystem.
              Acceptable values are 0 to 1000, inclusive.
            type: string
            format: int64
          effectiveCacheSize:
            description: |-
              **string** (int64)
              Sets the planner's assumption about the effective size of the disk cache available to a single query. In bytes.
              Acceptable values are 1048576 to 549755813888, inclusive.
            type: string
            format: int64
          idleSessionTimeout:
            description: |-
              **string** (int64)
              Sets the maximum allowed idle time between queries, when not in a transaction. In milliseconds.
              Acceptable values are 0 to 2147483647, inclusive.
            type: string
            format: int64
      PostgresqlHostConfig16:
        type: object
        properties:
          recoveryMinApplyDelay:
            description: |-
              **string** (int64)
              Sets the minimum delay for applying changes during recovery. In milliseconds.
            type: string
            format: int64
          sharedBuffers:
            description: |-
              **string** (int64)
              Sets the number of shared memory buffers used by the server. In bytes.
            type: string
            format: int64
          tempBuffers:
            description: |-
              **string** (int64)
              Sets the maximum number of temporary buffers used by each session. In bytes.
            type: string
            format: int64
          workMem:
            description: |-
              **string** (int64)
              Sets the maximum memory to be used for query workspaces. This much memory can be used by each
              internal sort operation and hash table before switching to temporary disk files. In bytes.
            type: string
            format: int64
          tempFileLimit:
            description: |-
              **string** (int64)
              Limits the total size of all temporary files used by each process. -1 means no limit. In bytes.
            type: string
            format: int64
          backendFlushAfter:
            description: |-
              **string** (int64)
              Specifies how much data a backend can write before forcing the operating system to issue the writes. In bytes.
              Acceptable values are 0 to 2097152, inclusive.
            type: string
            format: int64
          oldSnapshotThreshold:
            description: |-
              **string** (int64)
              Time before a snapshot is too old to read pages changed after the snapshot was taken.
              A value of -1 disables this feature. In milliseconds.
            type: string
            format: int64
          maxStandbyStreamingDelay:
            description: |-
              **string** (int64)
              Sets the maximum delay before canceling queries when a hot standby server is processing streamed WAL data. In milliseconds.
            type: string
            format: int64
          constraintExclusion:
            description: |-
              **enum** (ConstraintExclusion)
              Enables the planner to use constraints to optimize queries.
              - `CONSTRAINT_EXCLUSION_ON`: Enable planner's use of constraints for all tables.
              - `CONSTRAINT_EXCLUSION_OFF`: Disable planner's use of constraints for all tables
              - `CONSTRAINT_EXCLUSION_PARTITION`: Only use constraints for child tables and UNION ALL clauses.
            type: string
            enum:
              - CONSTRAINT_EXCLUSION_UNSPECIFIED
              - CONSTRAINT_EXCLUSION_ON
              - CONSTRAINT_EXCLUSION_OFF
              - CONSTRAINT_EXCLUSION_PARTITION
          cursorTupleFraction:
            description: |-
              **number** (double)
              Sets the planner's estimate of the fraction of a cursor's rows that will be retrieved.
            type: number
            format: double
          fromCollapseLimit:
            description: |-
              **string** (int64)
              Sets the FROM-list size beyond which subqueries are not collapsed.
              Acceptable values are 1 to 2147483647, inclusive.
            type: string
            format: int64
          joinCollapseLimit:
            description: |-
              **string** (int64)
              Sets the FROM-list size beyond which JOIN constructs are not flattened.
              Acceptable values are 1 to 2147483647, inclusive.
            type: string
            format: int64
          debugParallelQuery:
            description: |-
              **enum** (DebugParallelQuery)
              Forces the planner to use parallel query nodes.
              - `DEBUG_PARALLEL_QUERY_ON`: Forces parallel mode for queries considered safe, even when no performance benefit is expected.
              - `DEBUG_PARALLEL_QUERY_OFF`: Uses parallel mode only when the planner expects it to improve performance.
              - `DEBUG_PARALLEL_QUERY_REGRESS`: Behaves like ON, but hides added Gather nodes in EXPLAIN output and
              suppresses parallel-worker context lines to stabilize regression-test output.
            type: string
            enum:
              - DEBUG_PARALLEL_QUERY_UNSPECIFIED
              - DEBUG_PARALLEL_QUERY_ON
              - DEBUG_PARALLEL_QUERY_OFF
              - DEBUG_PARALLEL_QUERY_REGRESS
          clientMinMessages:
            description: |-
              **enum** (LogLevel)
              Sets the message levels that are sent to the client.
              - `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
              - `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
              - `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
              - `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
              - `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
              - `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
              - `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
              - `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
              - `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
              - `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
              - `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions.
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
              Sets the message levels that are logged.
              - `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
              - `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
              - `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
              - `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
              - `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
              - `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
              - `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
              - `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
              - `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
              - `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
              - `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions.
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
              Causes all statements generating error at or above this level to be logged.
              - `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
              - `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
              - `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
              - `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
              - `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
              - `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
              - `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
              - `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
              - `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
              - `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
              - `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions.
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
              Sets the minimum execution time above which all statements will be logged. In milliseconds.
            type: string
            format: int64
          logCheckpoints:
            description: |-
              **boolean**
              Logs each checkpoint.
            type: boolean
          logConnections:
            description: |-
              **boolean**
              Logs each successful connection.
            type: boolean
          logDisconnections:
            description: |-
              **boolean**
              Logs end of a session, including duration.
            type: boolean
          logDuration:
            description: |
              **boolean**
              Logs the duration of each completed SQL statement.
            type: boolean
          logErrorVerbosity:
            description: |-
              **enum** (LogErrorVerbosity)
              Sets the verbosity of logged messages.
              - `LOG_ERROR_VERBOSITY_TERSE`: DETAIL, HINT, QUERY, and CONTEXT fields are excluded from the error message.
              - `LOG_ERROR_VERBOSITY_DEFAULT`: Default.
              - `LOG_ERROR_VERBOSITY_VERBOSE`: Error message includes the SQLSTATE error code, source filename, function name, and the line number where the error occurred.
            type: string
            enum:
              - LOG_ERROR_VERBOSITY_UNSPECIFIED
              - LOG_ERROR_VERBOSITY_TERSE
              - LOG_ERROR_VERBOSITY_DEFAULT
              - LOG_ERROR_VERBOSITY_VERBOSE
          logLockWaits:
            description: |-
              **boolean**
              Logs long lock waits.
            type: boolean
          logStatement:
            description: |-
              **enum** (LogStatement)
              Sets the type of statements logged.
              - `LOG_STATEMENT_NONE`: The filter is disabled, no SQL statements are logged.
              - `LOG_STATEMENT_DDL`: System logs DDL statements, e.g., CREATE, ALTER, DROP etc.
              - `LOG_STATEMENT_MOD`: System logs ddl-statements along with data modification commands, e.g., INSERT, UPDATE, etc.
              - `LOG_STATEMENT_ALL`: System logs all SQL statements.
            type: string
            enum:
              - LOG_STATEMENT_UNSPECIFIED
              - LOG_STATEMENT_NONE
              - LOG_STATEMENT_DDL
              - LOG_STATEMENT_MOD
              - LOG_STATEMENT_ALL
          logTempFiles:
            description: |-
              **string** (int64)
              Log the use of temporary files larger than this number of kilobytes.
            type: string
            format: int64
          searchPath:
            description: |-
              **string**
              Sets the schema search order for names that are not schema-qualified.
            type: string
          rowSecurity:
            description: |-
              **boolean**
              Enable row security.
            type: boolean
          defaultTransactionIsolation:
            description: |-
              **enum** (TransactionIsolation)
              Sets the transaction isolation level of each new transaction.
              - `TRANSACTION_ISOLATION_READ_UNCOMMITTED`: This level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.
              - `TRANSACTION_ISOLATION_READ_COMMITTED`: On this level query sees only data committed before the query began.
              - `TRANSACTION_ISOLATION_REPEATABLE_READ`: On this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).
              - `TRANSACTION_ISOLATION_SERIALIZABLE`: This level provides the strictest transaction isolation.
              All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction.
              If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure.
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
              Sets the maximum allowed duration of any statement. In milliseconds.
            type: string
            format: int64
          lockTimeout:
            description: |-
              **string** (int64)
              Sets the maximum allowed duration of any wait for a lock. In milliseconds.
            type: string
            format: int64
          idleInTransactionSessionTimeout:
            description: |-
              **string** (int64)
              Sets the maximum allowed idle time between queries, when in a transaction. In milliseconds.
              Acceptable values are 0 to 2147483647, inclusive.
            type: string
            format: int64
          byteaOutput:
            description: |-
              **enum** (ByteaOutput)
              Sets the output format for bytea.
              - `BYTEA_OUTPUT_HEX`: Each byte is represented by two hexadecimal characters, e.g., 'SELECT '\xDEADBEEF';'.
              - `BYTEA_OUTPUT_ESCAPED`: Standard PostgreSQL format with ASCII characters only.
            type: string
            enum:
              - BYTEA_OUTPUT_UNSPECIFIED
              - BYTEA_OUTPUT_HEX
              - BYTEA_OUTPUT_ESCAPED
          xmlbinary:
            description: |-
              **enum** (XmlBinary)
              Sets how binary values are to be encoded in XML.
              - `XML_BINARY_BASE64`: Encodes binary values using Base64.
              - `XML_BINARY_HEX`: Encodes binary values using hexadecimal notation.
            type: string
            enum:
              - XML_BINARY_UNSPECIFIED
              - XML_BINARY_BASE64
              - XML_BINARY_HEX
          xmloption:
            description: |-
              **enum** (XmlOption)
              Sets whether XML data in implicit parsing and serialization operations is to be considered as documents or content fragments.
              - `XML_OPTION_DOCUMENT`: Treats an XML value as a complete, well-formed document.
              - `XML_OPTION_CONTENT`: Treats an XML value as a content fragment, which may contain multiple top-level elements or character nodes.
            type: string
            enum:
              - XML_OPTION_UNSPECIFIED
              - XML_OPTION_DOCUMENT
              - XML_OPTION_CONTENT
          ginPendingListLimit:
            description: |-
              **string** (int64)
              Sets the maximum size of the pending list for GIN index. In bytes.
            type: string
            format: int64
          deadlockTimeout:
            description: |-
              **string** (int64)
              Sets the time to wait on a lock before checking for deadlock. In milliseconds.
              Acceptable values are 1 to 2147483647, inclusive.
            type: string
            format: int64
          maxLocksPerTransaction:
            description: |-
              **string** (int64)
              Sets the maximum number of locks per transaction. The shared lock table is sized on the assumption that
              at most max_locks_per_transaction * max_connections distinct objects will need to be locked at any one time.
            type: string
            format: int64
          maxPredLocksPerTransaction:
            description: |-
              **string** (int64)
              Sets the maximum number of predicate locks per transaction.The shared predicate lock table is sized on the assumption that
              at most max_pred_locks_per_transaction * max_connections distinct objects will need to be locked at any one time.
            type: string
            format: int64
          arrayNulls:
            description: |-
              **boolean**
              Enable input of NULL elements in arrays. When turned on, unquoted NULL in an array input
              value means a null value; otherwise it is taken literally.
            type: boolean
          backslashQuote:
            description: |-
              **enum** (BackslashQuote)
              Sets whether \"\\'\" is allowed in string literals.
              - `BACKSLASH_QUOTE`: Legacy invalid value. Do not use.
              - `BACKSLASH_QUOTE_ON`: Quotation mark can be represented as \'.
              - `BACKSLASH_QUOTE_OFF`: Quotation mark can only be represented using the standard SQL syntax ''.
              - `BACKSLASH_QUOTE_SAFE_ENCODING`: Representing a quotation mark as \' is only permitted for client encodings where \ is not used for multibyte characters.
            type: string
            enum:
              - BACKSLASH_QUOTE_UNSPECIFIED
              - BACKSLASH_QUOTE
              - BACKSLASH_QUOTE_ON
              - BACKSLASH_QUOTE_OFF
              - BACKSLASH_QUOTE_SAFE_ENCODING
          defaultWithOids:
            description: |-
              **boolean**
              WITH OIDS is no longer supported; this can only be false.
            type: boolean
          escapeStringWarning:
            description: |-
              **boolean**
              Warn about backslash escapes in ordinary string literals.
            type: boolean
          loCompatPrivileges:
            description: |-
              **boolean**
              Enables backward compatibility mode for privilege checks on large objects. Skips privilege checks
              when reading or modifying large objects, for compatibility with PostgreSQL releases prior to 9.0.
            type: boolean
          quoteAllIdentifiers:
            description: |-
              **boolean**
              When generating SQL fragments, quote all identifiers.
            type: boolean
          standardConformingStrings:
            description: |-
              **boolean**
              Causes '...' strings to treat backslashes literally.
            type: boolean
          synchronizeSeqscans:
            description: |-
              **boolean**
              Enable synchronized sequential scans.
            type: boolean
          transformNullEquals:
            description: |-
              **boolean**
              Treats \"expr=NULL\" as \"expr IS NULL\". When turned on, expressions of the form expr = NULL
              (or NULL = expr) are treated as expr IS NULL, that is, they return true if expr evaluates to the
              null value, and false otherwise. The correct behavior of expr = NULL is to always return null (unknown).
            type: boolean
          exitOnError:
            description: |-
              **boolean**
              Terminate session on any error.
            type: boolean
          seqPageCost:
            description: |-
              **number** (double)
              Sets the planner's estimate of the cost of a sequentially fetched disk page.
              The minimum value is 0.
            type: number
            format: double
          randomPageCost:
            description: |-
              **number** (double)
              Sets the planner's estimate of the cost of a nonsequentially fetched disk page.
              The minimum value is 0.
            type: number
            format: double
          enableBitmapscan:
            description: |-
              **boolean**
              Enables the planner's use of bitmap-scan plans.
            type: boolean
          enableHashagg:
            description: |-
              **boolean**
              Enables the planner's use of hashed aggregation plans.
            type: boolean
          enableHashjoin:
            description: |-
              **boolean**
              Enables the planner's use of hash join plans.
            type: boolean
          enableIndexscan:
            description: |-
              **boolean**
              Enables the planner's use of index-scan plans.
            type: boolean
          enableIndexonlyscan:
            description: |-
              **boolean**
              Enables the planner's use of index-only-scan plans.
            type: boolean
          enableMaterial:
            description: |-
              **boolean**
              Enables the planner's use of materialization.
            type: boolean
          enableMergejoin:
            description: |-
              **boolean**
              Enables the planner's use of merge join plans.
            type: boolean
          enableNestloop:
            description: |-
              **boolean**
              Enables the planner's use of nested-loop join plans.
            type: boolean
          enableSeqscan:
            description: |-
              **boolean**
              Enables the planner's use of sequential-scan plans.
            type: boolean
          enableSort:
            description: |-
              **boolean**
              Enables the planner's use of explicit sort steps.
            type: boolean
          enableTidscan:
            description: |-
              **boolean**
              Enables the planner's use of TID scan plans.
            type: boolean
          maxParallelWorkers:
            description: |-
              **string** (int64)
              Sets the maximum number of parallel workers that can be active at one time.
              Acceptable values are 0 to 1024, inclusive.
            type: string
            format: int64
          maxParallelWorkersPerGather:
            description: |-
              **string** (int64)
              Sets the maximum number of parallel processes per executor node.
              Acceptable values are 0 to 1024, inclusive.
            type: string
            format: int64
          timezone:
            description: |-
              **string**
              Sets the time zone for displaying and interpreting time stamps.
            type: string
          effectiveIoConcurrency:
            description: |-
              **string** (int64)
              Number of simultaneous requests that can be handled efficiently by the disk subsystem.
              Acceptable values are 0 to 1000, inclusive.
            type: string
            format: int64
          effectiveCacheSize:
            description: |-
              **string** (int64)
              Sets the planner's assumption about the effective size of the disk cache available to a single query. In bytes.
              Acceptable values are 1048576 to 549755813888, inclusive.
            type: string
            format: int64
          idleSessionTimeout:
            description: |-
              **string** (int64)
              Sets the maximum allowed idle time between queries, when not in a transaction. In milliseconds.
              Acceptable values are 0 to 2147483647, inclusive.
            type: string
            format: int64
      PostgresqlHostConfig16_1C:
        type: object
        properties:
          recoveryMinApplyDelay:
            description: |-
              **string** (int64)
              Sets the minimum delay for applying changes during recovery. In milliseconds.
            type: string
            format: int64
          sharedBuffers:
            description: |-
              **string** (int64)
              Sets the number of shared memory buffers used by the server. In bytes.
            type: string
            format: int64
          tempBuffers:
            description: |-
              **string** (int64)
              Sets the maximum number of temporary buffers used by each session. In bytes.
            type: string
            format: int64
          workMem:
            description: |-
              **string** (int64)
              Sets the maximum memory to be used for query workspaces. This much memory can be used by each
              internal sort operation and hash table before switching to temporary disk files. In bytes.
            type: string
            format: int64
          tempFileLimit:
            description: |-
              **string** (int64)
              Limits the total size of all temporary files used by each process. -1 means no limit. In bytes.
            type: string
            format: int64
          backendFlushAfter:
            description: |-
              **string** (int64)
              Specifies how much data a backend can write before forcing the operating system to issue the writes. In bytes.
              Acceptable values are 0 to 2097152, inclusive.
            type: string
            format: int64
          oldSnapshotThreshold:
            description: |-
              **string** (int64)
              Time before a snapshot is too old to read pages changed after the snapshot was taken.
              A value of -1 disables this feature. In milliseconds.
            type: string
            format: int64
          maxStandbyStreamingDelay:
            description: |-
              **string** (int64)
              Sets the maximum delay before canceling queries when a hot standby server is processing streamed WAL data. In milliseconds.
            type: string
            format: int64
          constraintExclusion:
            description: |-
              **enum** (ConstraintExclusion)
              Enables the planner to use constraints to optimize queries.
              - `CONSTRAINT_EXCLUSION_ON`: Enable planner's use of constraints for all tables.
              - `CONSTRAINT_EXCLUSION_OFF`: Disable planner's use of constraints for all tables
              - `CONSTRAINT_EXCLUSION_PARTITION`: Only use constraints for child tables and UNION ALL clauses.
            type: string
            enum:
              - CONSTRAINT_EXCLUSION_UNSPECIFIED
              - CONSTRAINT_EXCLUSION_ON
              - CONSTRAINT_EXCLUSION_OFF
              - CONSTRAINT_EXCLUSION_PARTITION
          cursorTupleFraction:
            description: |-
              **number** (double)
              Sets the planner's estimate of the fraction of a cursor's rows that will be retrieved.
            type: number
            format: double
          fromCollapseLimit:
            description: |-
              **string** (int64)
              Sets the FROM-list size beyond which subqueries are not collapsed.
              Acceptable values are 1 to 2147483647, inclusive.
            type: string
            format: int64
          joinCollapseLimit:
            description: |-
              **string** (int64)
              Sets the FROM-list size beyond which JOIN constructs are not flattened.
              Acceptable values are 1 to 2147483647, inclusive.
            type: string
            format: int64
          debugParallelQuery:
            description: |-
              **enum** (DebugParallelQuery)
              Forces the planner to use parallel query nodes.
              - `DEBUG_PARALLEL_QUERY_ON`: Forces parallel mode for queries considered safe, even when no performance benefit is expected.
              - `DEBUG_PARALLEL_QUERY_OFF`: Uses parallel mode only when the planner expects it to improve performance.
              - `DEBUG_PARALLEL_QUERY_REGRESS`: Behaves like ON, but hides added Gather nodes in EXPLAIN output and
              suppresses parallel-worker context lines to stabilize regression-test output.
            type: string
            enum:
              - DEBUG_PARALLEL_QUERY_UNSPECIFIED
              - DEBUG_PARALLEL_QUERY_ON
              - DEBUG_PARALLEL_QUERY_OFF
              - DEBUG_PARALLEL_QUERY_REGRESS
          clientMinMessages:
            description: |-
              **enum** (LogLevel)
              Sets the message levels that are sent to the client.
              - `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
              - `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
              - `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
              - `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
              - `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
              - `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
              - `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
              - `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
              - `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
              - `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
              - `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions.
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
              Sets the message levels that are logged.
              - `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
              - `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
              - `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
              - `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
              - `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
              - `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
              - `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
              - `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
              - `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
              - `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
              - `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions.
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
              Causes all statements generating error at or above this level to be logged.
              - `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
              - `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
              - `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
              - `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
              - `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
              - `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
              - `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
              - `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
              - `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
              - `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
              - `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions.
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
              Sets the minimum execution time above which all statements will be logged. In milliseconds.
            type: string
            format: int64
          logCheckpoints:
            description: |-
              **boolean**
              Logs each checkpoint.
            type: boolean
          logConnections:
            description: |-
              **boolean**
              Logs each successful connection.
            type: boolean
          logDisconnections:
            description: |-
              **boolean**
              Logs end of a session, including duration.
            type: boolean
          logDuration:
            description: |
              **boolean**
              Logs the duration of each completed SQL statement.
            type: boolean
          logErrorVerbosity:
            description: |-
              **enum** (LogErrorVerbosity)
              Sets the verbosity of logged messages.
              - `LOG_ERROR_VERBOSITY_TERSE`: DETAIL, HINT, QUERY, and CONTEXT fields are excluded from the error message.
              - `LOG_ERROR_VERBOSITY_DEFAULT`: Default.
              - `LOG_ERROR_VERBOSITY_VERBOSE`: Error message includes the SQLSTATE error code, source filename, function name, and the line number where the error occurred.
            type: string
            enum:
              - LOG_ERROR_VERBOSITY_UNSPECIFIED
              - LOG_ERROR_VERBOSITY_TERSE
              - LOG_ERROR_VERBOSITY_DEFAULT
              - LOG_ERROR_VERBOSITY_VERBOSE
          logLockWaits:
            description: |-
              **boolean**
              Logs long lock waits.
            type: boolean
          logStatement:
            description: |-
              **enum** (LogStatement)
              Sets the type of statements logged.
              - `LOG_STATEMENT_NONE`: The filter is disabled, no SQL statements are logged.
              - `LOG_STATEMENT_DDL`: System logs DDL statements, e.g., CREATE, ALTER, DROP etc.
              - `LOG_STATEMENT_MOD`: System logs ddl-statements along with data modification commands, e.g., INSERT, UPDATE, etc.
              - `LOG_STATEMENT_ALL`: System logs all SQL statements.
            type: string
            enum:
              - LOG_STATEMENT_UNSPECIFIED
              - LOG_STATEMENT_NONE
              - LOG_STATEMENT_DDL
              - LOG_STATEMENT_MOD
              - LOG_STATEMENT_ALL
          logTempFiles:
            description: |-
              **string** (int64)
              Log the use of temporary files larger than this number of kilobytes.
            type: string
            format: int64
          searchPath:
            description: |-
              **string**
              Sets the schema search order for names that are not schema-qualified.
            type: string
          rowSecurity:
            description: |-
              **boolean**
              Enable row security.
            type: boolean
          defaultTransactionIsolation:
            description: |-
              **enum** (TransactionIsolation)
              Sets the transaction isolation level of each new transaction.
              - `TRANSACTION_ISOLATION_READ_UNCOMMITTED`: This level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.
              - `TRANSACTION_ISOLATION_READ_COMMITTED`: On this level query sees only data committed before the query began.
              - `TRANSACTION_ISOLATION_REPEATABLE_READ`: On this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).
              - `TRANSACTION_ISOLATION_SERIALIZABLE`: This level provides the strictest transaction isolation.
              All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction.
              If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure.
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
              Sets the maximum allowed duration of any statement. In milliseconds.
            type: string
            format: int64
          lockTimeout:
            description: |-
              **string** (int64)
              Sets the maximum allowed duration of any wait for a lock. In milliseconds.
            type: string
            format: int64
          idleInTransactionSessionTimeout:
            description: |-
              **string** (int64)
              Sets the maximum allowed idle time between queries, when in a transaction. In milliseconds.
              Acceptable values are 0 to 2147483647, inclusive.
            type: string
            format: int64
          byteaOutput:
            description: |-
              **enum** (ByteaOutput)
              Sets the output format for bytea.
              - `BYTEA_OUTPUT_HEX`: Each byte is represented by two hexadecimal characters, e.g., 'SELECT '\xDEADBEEF';'.
              - `BYTEA_OUTPUT_ESCAPED`: Standard PostgreSQL format with ASCII characters only.
            type: string
            enum:
              - BYTEA_OUTPUT_UNSPECIFIED
              - BYTEA_OUTPUT_HEX
              - BYTEA_OUTPUT_ESCAPED
          xmlbinary:
            description: |-
              **enum** (XmlBinary)
              Sets how binary values are to be encoded in XML.
              - `XML_BINARY_BASE64`: Encodes binary values using Base64.
              - `XML_BINARY_HEX`: Encodes binary values using hexadecimal notation.
            type: string
            enum:
              - XML_BINARY_UNSPECIFIED
              - XML_BINARY_BASE64
              - XML_BINARY_HEX
          xmloption:
            description: |-
              **enum** (XmlOption)
              Sets whether XML data in implicit parsing and serialization operations is to be considered as documents or content fragments.
              - `XML_OPTION_DOCUMENT`: Treats an XML value as a complete, well-formed document.
              - `XML_OPTION_CONTENT`: Treats an XML value as a content fragment, which may contain multiple top-level elements or character nodes.
            type: string
            enum:
              - XML_OPTION_UNSPECIFIED
              - XML_OPTION_DOCUMENT
              - XML_OPTION_CONTENT
          ginPendingListLimit:
            description: |-
              **string** (int64)
              Sets the maximum size of the pending list for GIN index. In bytes.
            type: string
            format: int64
          deadlockTimeout:
            description: |-
              **string** (int64)
              Sets the time to wait on a lock before checking for deadlock. In milliseconds.
              Acceptable values are 1 to 2147483647, inclusive.
            type: string
            format: int64
          maxLocksPerTransaction:
            description: |-
              **string** (int64)
              Sets the maximum number of locks per transaction. The shared lock table is sized on the assumption that
              at most max_locks_per_transaction * max_connections distinct objects will need to be locked at any one time.
            type: string
            format: int64
          maxPredLocksPerTransaction:
            description: |-
              **string** (int64)
              Sets the maximum number of predicate locks per transaction.The shared predicate lock table is sized on the assumption that
              at most max_pred_locks_per_transaction * max_connections distinct objects will need to be locked at any one time.
            type: string
            format: int64
          arrayNulls:
            description: |-
              **boolean**
              Enable input of NULL elements in arrays. When turned on, unquoted NULL in an array input
              value means a null value; otherwise it is taken literally.
            type: boolean
          backslashQuote:
            description: |-
              **enum** (BackslashQuote)
              Sets whether \"\\'\" is allowed in string literals.
              - `BACKSLASH_QUOTE`: Legacy invalid value. Do not use.
              - `BACKSLASH_QUOTE_ON`: Quotation mark can be represented as \'.
              - `BACKSLASH_QUOTE_OFF`: Quotation mark can only be represented using the standard SQL syntax ''.
              - `BACKSLASH_QUOTE_SAFE_ENCODING`: Representing a quotation mark as \' is only permitted for client encodings where \ is not used for multibyte characters.
            type: string
            enum:
              - BACKSLASH_QUOTE_UNSPECIFIED
              - BACKSLASH_QUOTE
              - BACKSLASH_QUOTE_ON
              - BACKSLASH_QUOTE_OFF
              - BACKSLASH_QUOTE_SAFE_ENCODING
          defaultWithOids:
            description: |-
              **boolean**
              WITH OIDS is no longer supported; this can only be false.
            type: boolean
          escapeStringWarning:
            description: |-
              **boolean**
              Warn about backslash escapes in ordinary string literals.
            type: boolean
          loCompatPrivileges:
            description: |-
              **boolean**
              Enables backward compatibility mode for privilege checks on large objects. Skips privilege checks
              when reading or modifying large objects, for compatibility with PostgreSQL releases prior to 9.0.
            type: boolean
          quoteAllIdentifiers:
            description: |-
              **boolean**
              When generating SQL fragments, quote all identifiers.
            type: boolean
          standardConformingStrings:
            description: |-
              **boolean**
              Causes '...' strings to treat backslashes literally.
            type: boolean
          synchronizeSeqscans:
            description: |-
              **boolean**
              Enable synchronized sequential scans.
            type: boolean
          transformNullEquals:
            description: |-
              **boolean**
              Treats \"expr=NULL\" as \"expr IS NULL\". When turned on, expressions of the form expr = NULL
              (or NULL = expr) are treated as expr IS NULL, that is, they return true if expr evaluates to the
              null value, and false otherwise. The correct behavior of expr = NULL is to always return null (unknown).
            type: boolean
          exitOnError:
            description: |-
              **boolean**
              Terminate session on any error.
            type: boolean
          seqPageCost:
            description: |-
              **number** (double)
              Sets the planner's estimate of the cost of a sequentially fetched disk page.
              The minimum value is 0.
            type: number
            format: double
          randomPageCost:
            description: |-
              **number** (double)
              Sets the planner's estimate of the cost of a nonsequentially fetched disk page.
              The minimum value is 0.
            type: number
            format: double
          enableBitmapscan:
            description: |-
              **boolean**
              Enables the planner's use of bitmap-scan plans.
            type: boolean
          enableHashagg:
            description: |-
              **boolean**
              Enables the planner's use of hashed aggregation plans.
            type: boolean
          enableHashjoin:
            description: |-
              **boolean**
              Enables the planner's use of hash join plans.
            type: boolean
          enableIndexscan:
            description: |-
              **boolean**
              Enables the planner's use of index-scan plans.
            type: boolean
          enableIndexonlyscan:
            description: |-
              **boolean**
              Enables the planner's use of index-only-scan plans.
            type: boolean
          enableMaterial:
            description: |-
              **boolean**
              Enables the planner's use of materialization.
            type: boolean
          enableMergejoin:
            description: |-
              **boolean**
              Enables the planner's use of merge join plans.
            type: boolean
          enableNestloop:
            description: |-
              **boolean**
              Enables the planner's use of nested-loop join plans.
            type: boolean
          enableSeqscan:
            description: |-
              **boolean**
              Enables the planner's use of sequential-scan plans.
            type: boolean
          enableSort:
            description: |-
              **boolean**
              Enables the planner's use of explicit sort steps.
            type: boolean
          enableTidscan:
            description: |-
              **boolean**
              Enables the planner's use of TID scan plans.
            type: boolean
          maxParallelWorkers:
            description: |-
              **string** (int64)
              Sets the maximum number of parallel workers that can be active at one time.
              Acceptable values are 0 to 1024, inclusive.
            type: string
            format: int64
          maxParallelWorkersPerGather:
            description: |-
              **string** (int64)
              Sets the maximum number of parallel processes per executor node.
              Acceptable values are 0 to 1024, inclusive.
            type: string
            format: int64
          timezone:
            description: |-
              **string**
              Sets the time zone for displaying and interpreting time stamps.
            type: string
          effectiveIoConcurrency:
            description: |-
              **string** (int64)
              Number of simultaneous requests that can be handled efficiently by the disk subsystem.
              Acceptable values are 0 to 1000, inclusive.
            type: string
            format: int64
          effectiveCacheSize:
            description: |-
              **string** (int64)
              Sets the planner's assumption about the effective size of the disk cache available to a single query. In bytes.
              Acceptable values are 1048576 to 549755813888, inclusive.
            type: string
            format: int64
          idleSessionTimeout:
            description: |-
              **string** (int64)
              Sets the maximum allowed idle time between queries, when not in a transaction. In milliseconds.
              Acceptable values are 0 to 2147483647, inclusive.
            type: string
            format: int64
      PostgresqlHostConfig17:
        type: object
        properties:
          recoveryMinApplyDelay:
            description: |-
              **string** (int64)
              Sets the minimum delay for applying changes during recovery. In milliseconds.
            type: string
            format: int64
          sharedBuffers:
            description: |-
              **string** (int64)
              Sets the number of shared memory buffers used by the server. In bytes.
            type: string
            format: int64
          tempBuffers:
            description: |-
              **string** (int64)
              Sets the maximum number of temporary buffers used by each session. In bytes.
            type: string
            format: int64
          workMem:
            description: |-
              **string** (int64)
              Sets the maximum memory to be used for query workspaces. This much memory can be used by each
              internal sort operation and hash table before switching to temporary disk files. In bytes.
            type: string
            format: int64
          tempFileLimit:
            description: |-
              **string** (int64)
              Limits the total size of all temporary files used by each process. -1 means no limit. In bytes.
            type: string
            format: int64
          backendFlushAfter:
            description: |-
              **string** (int64)
              Specifies how much data a backend can write before forcing the operating system to issue the writes. In bytes.
              Acceptable values are 0 to 2097152, inclusive.
            type: string
            format: int64
          maxStandbyStreamingDelay:
            description: |-
              **string** (int64)
              Sets the maximum delay before canceling queries when a hot standby server is processing streamed WAL data. In milliseconds.
            type: string
            format: int64
          constraintExclusion:
            description: |-
              **enum** (ConstraintExclusion)
              Enables the planner to use constraints to optimize queries.
              - `CONSTRAINT_EXCLUSION_ON`: Enable planner's use of constraints for all tables.
              - `CONSTRAINT_EXCLUSION_OFF`: Disable planner's use of constraints for all tables
              - `CONSTRAINT_EXCLUSION_PARTITION`: Only use constraints for child tables and UNION ALL clauses.
            type: string
            enum:
              - CONSTRAINT_EXCLUSION_UNSPECIFIED
              - CONSTRAINT_EXCLUSION_ON
              - CONSTRAINT_EXCLUSION_OFF
              - CONSTRAINT_EXCLUSION_PARTITION
          cursorTupleFraction:
            description: |-
              **number** (double)
              Sets the planner's estimate of the fraction of a cursor's rows that will be retrieved.
            type: number
            format: double
          fromCollapseLimit:
            description: |-
              **string** (int64)
              Sets the FROM-list size beyond which subqueries are not collapsed.
              Acceptable values are 1 to 2147483647, inclusive.
            type: string
            format: int64
          joinCollapseLimit:
            description: |-
              **string** (int64)
              Sets the FROM-list size beyond which JOIN constructs are not flattened.
              Acceptable values are 1 to 2147483647, inclusive.
            type: string
            format: int64
          debugParallelQuery:
            description: |-
              **enum** (DebugParallelQuery)
              Forces the planner's use parallel query nodes.
              - `DEBUG_PARALLEL_QUERY_ON`: Forces parallel mode for queries considered safe, even when no performance benefit is expected.
              - `DEBUG_PARALLEL_QUERY_OFF`: Uses parallel mode only when the planner expects it to improve performance.
              - `DEBUG_PARALLEL_QUERY_REGRESS`: Behaves like ON, but hides added Gather nodes in EXPLAIN output and
              suppresses parallel-worker context lines to stabilize regression-test output.
            type: string
            enum:
              - DEBUG_PARALLEL_QUERY_UNSPECIFIED
              - DEBUG_PARALLEL_QUERY_ON
              - DEBUG_PARALLEL_QUERY_OFF
              - DEBUG_PARALLEL_QUERY_REGRESS
          clientMinMessages:
            description: |-
              **enum** (LogLevel)
              Sets the message levels that are sent to the client.
              - `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
              - `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
              - `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
              - `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
              - `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
              - `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
              - `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
              - `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
              - `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
              - `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
              - `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions.
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
              Sets the message levels that are logged.
              - `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
              - `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
              - `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
              - `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
              - `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
              - `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
              - `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
              - `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
              - `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
              - `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
              - `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions.
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
              Causes all statements generating error at or above this level to be logged.
              - `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
              - `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
              - `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
              - `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
              - `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
              - `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
              - `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
              - `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
              - `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
              - `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
              - `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions.
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
              Sets the minimum execution time above which all statements will be logged. In milliseconds.
            type: string
            format: int64
          logCheckpoints:
            description: |-
              **boolean**
              Logs each checkpoint.
            type: boolean
          logConnections:
            description: |-
              **boolean**
              Logs each successful connection.
            type: boolean
          logDisconnections:
            description: |-
              **boolean**
              Logs end of a session, including duration.
            type: boolean
          logDuration:
            description: |
              **boolean**
              Logs the duration of each completed SQL statement.
            type: boolean
          logErrorVerbosity:
            description: |-
              **enum** (LogErrorVerbosity)
              Sets the verbosity of logged messages.
              - `LOG_ERROR_VERBOSITY_TERSE`: DETAIL, HINT, QUERY, and CONTEXT fields are excluded from the error message.
              - `LOG_ERROR_VERBOSITY_DEFAULT`: Default.
              - `LOG_ERROR_VERBOSITY_VERBOSE`: Error message includes the SQLSTATE error code, source filename, function name, and the line number where the error occurred.
            type: string
            enum:
              - LOG_ERROR_VERBOSITY_UNSPECIFIED
              - LOG_ERROR_VERBOSITY_TERSE
              - LOG_ERROR_VERBOSITY_DEFAULT
              - LOG_ERROR_VERBOSITY_VERBOSE
          logLockWaits:
            description: |-
              **boolean**
              Logs long lock waits.
            type: boolean
          logStatement:
            description: |-
              **enum** (LogStatement)
              Sets the type of statements logged.
              - `LOG_STATEMENT_NONE`: The filter is disabled, no SQL statements are logged.
              - `LOG_STATEMENT_DDL`: System logs DDL statements, e.g., CREATE, ALTER, DROP etc.
              - `LOG_STATEMENT_MOD`: System logs ddl-statements along with data modification commands, e.g., INSERT, UPDATE, etc.
              - `LOG_STATEMENT_ALL`: System logs all SQL statements.
            type: string
            enum:
              - LOG_STATEMENT_UNSPECIFIED
              - LOG_STATEMENT_NONE
              - LOG_STATEMENT_DDL
              - LOG_STATEMENT_MOD
              - LOG_STATEMENT_ALL
          logTempFiles:
            description: |-
              **string** (int64)
              Log the use of temporary files larger than this number of kilobytes.
            type: string
            format: int64
          searchPath:
            description: |-
              **string**
              Sets the schema search order for names that are not schema-qualified.
            type: string
          rowSecurity:
            description: |-
              **boolean**
              Enable row security.
            type: boolean
          defaultTransactionIsolation:
            description: |-
              **enum** (TransactionIsolation)
              Sets the transaction isolation level of each new transaction.
              - `TRANSACTION_ISOLATION_READ_UNCOMMITTED`: This level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.
              - `TRANSACTION_ISOLATION_READ_COMMITTED`: On this level query sees only data committed before the query began.
              - `TRANSACTION_ISOLATION_REPEATABLE_READ`: On this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).
              - `TRANSACTION_ISOLATION_SERIALIZABLE`: This level provides the strictest transaction isolation.
              All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction.
              If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure.
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
              Sets the maximum allowed duration of any statement. In milliseconds.
            type: string
            format: int64
          lockTimeout:
            description: |-
              **string** (int64)
              Sets the maximum allowed duration of any wait for a lock. In milliseconds.
              Acceptable values are 0 to 2147483647, inclusive.
            type: string
            format: int64
          idleInTransactionSessionTimeout:
            description: |-
              **string** (int64)
              Sets the maximum allowed idle time between queries, when in a transaction. In milliseconds.
              Acceptable values are 0 to 2147483647, inclusive.
            type: string
            format: int64
          byteaOutput:
            description: |-
              **enum** (ByteaOutput)
              Sets the output format for bytea.
              - `BYTEA_OUTPUT_HEX`: Each byte is represented by two hexadecimal characters, e.g., 'SELECT '\xDEADBEEF';'.
              - `BYTEA_OUTPUT_ESCAPED`: Standard PostgreSQL format with ASCII characters only.
            type: string
            enum:
              - BYTEA_OUTPUT_UNSPECIFIED
              - BYTEA_OUTPUT_HEX
              - BYTEA_OUTPUT_ESCAPED
          xmlbinary:
            description: |-
              **enum** (XmlBinary)
              Sets how binary values are to be encoded in XML.
              - `XML_BINARY_BASE64`: Encodes binary values using Base64.
              - `XML_BINARY_HEX`: Encodes binary values using hexadecimal notation.
            type: string
            enum:
              - XML_BINARY_UNSPECIFIED
              - XML_BINARY_BASE64
              - XML_BINARY_HEX
          xmloption:
            description: |-
              **enum** (XmlOption)
              Sets whether XML data in implicit parsing and serialization operations is to be considered as documents or content fragments.
              - `XML_OPTION_DOCUMENT`: Treats an XML value as a complete, well-formed document.
              - `XML_OPTION_CONTENT`: Treats an XML value as a content fragment, which may contain multiple top-level elements or character nodes.
            type: string
            enum:
              - XML_OPTION_UNSPECIFIED
              - XML_OPTION_DOCUMENT
              - XML_OPTION_CONTENT
          ginPendingListLimit:
            description: |-
              **string** (int64)
              Sets the maximum size of the pending list for GIN index. In bytes.
            type: string
            format: int64
          deadlockTimeout:
            description: |-
              **string** (int64)
              Sets the time to wait on a lock before checking for deadlock. In milliseconds.
              Acceptable values are 1 to 2147483647, inclusive.
            type: string
            format: int64
          maxLocksPerTransaction:
            description: |-
              **string** (int64)
              Sets the maximum number of locks per transaction. The shared lock table is sized on the assumption that
              at most max_locks_per_transaction * max_connections distinct objects will need to be locked at any one time.
            type: string
            format: int64
          maxPredLocksPerTransaction:
            description: |-
              **string** (int64)
              Sets the maximum number of predicate locks per transaction.The shared predicate lock table is sized on the assumption that
              at most max_pred_locks_per_transaction * max_connections distinct objects will need to be locked at any one time.
            type: string
            format: int64
          arrayNulls:
            description: |-
              **boolean**
              Enable input of NULL elements in arrays. When turned on, unquoted NULL in an array input
              value means a null value; otherwise it is taken literally.
            type: boolean
          backslashQuote:
            description: |-
              **enum** (BackslashQuote)
              Sets whether \"\\'\" is allowed in string literals.
              - `BACKSLASH_QUOTE`: Legacy invalid value. Do not use.
              - `BACKSLASH_QUOTE_ON`: Quotation mark can be represented as \'.
              - `BACKSLASH_QUOTE_OFF`: Quotation mark can only be represented using the standard SQL syntax ''.
              - `BACKSLASH_QUOTE_SAFE_ENCODING`: Representing a quotation mark as \' is only permitted for client encodings where \ is not used for multibyte characters.
            type: string
            enum:
              - BACKSLASH_QUOTE_UNSPECIFIED
              - BACKSLASH_QUOTE
              - BACKSLASH_QUOTE_ON
              - BACKSLASH_QUOTE_OFF
              - BACKSLASH_QUOTE_SAFE_ENCODING
          defaultWithOids:
            description: |-
              **boolean**
              WITH OIDS is no longer supported; this can only be false.
            type: boolean
          escapeStringWarning:
            description: |-
              **boolean**
              Warn about backslash escapes in ordinary string literals.
            type: boolean
          loCompatPrivileges:
            description: |-
              **boolean**
              Enables backward compatibility mode for privilege checks on large objects. Skips privilege checks
              when reading or modifying large objects, for compatibility with PostgreSQL releases prior to 9.0.
            type: boolean
          quoteAllIdentifiers:
            description: |-
              **boolean**
              When generating SQL fragments, quote all identifiers.
            type: boolean
          standardConformingStrings:
            description: |-
              **boolean**
              Causes '...' strings to treat backslashes literally.
            type: boolean
          synchronizeSeqscans:
            description: |-
              **boolean**
              Enable synchronized sequential scans.
            type: boolean
          transformNullEquals:
            description: |-
              **boolean**
              Treats \"expr=NULL\" as \"expr IS NULL\". When turned on, expressions of the form expr = NULL
              (or NULL = expr) are treated as expr IS NULL, that is, they return true if expr evaluates to the
              null value, and false otherwise. The correct behavior of expr = NULL is to always return null (unknown).
            type: boolean
          exitOnError:
            description: |-
              **boolean**
              Terminate session on any error.
            type: boolean
          seqPageCost:
            description: |-
              **number** (double)
              Sets the planner's estimate of the cost of a sequentially fetched disk page.
              The minimum value is 0.
            type: number
            format: double
          randomPageCost:
            description: |-
              **number** (double)
              Sets the planner's estimate of the cost of a nonsequentially fetched disk page.
              The minimum value is 0.
            type: number
            format: double
          enableBitmapscan:
            description: |-
              **boolean**
              Enables the planner's use of bitmap-scan plans.
            type: boolean
          enableHashagg:
            description: |-
              **boolean**
              Enables the planner's use of hashed aggregation plans.
            type: boolean
          enableHashjoin:
            description: |-
              **boolean**
              Enables the planner's use of hash join plans.
            type: boolean
          enableIndexscan:
            description: |-
              **boolean**
              Enables the planner's use of index-scan plans.
            type: boolean
          enableIndexonlyscan:
            description: |-
              **boolean**
              Enables the planner's use of index-only-scan plans.
            type: boolean
          enableMaterial:
            description: |-
              **boolean**
              Enables the planner's use of materialization.
            type: boolean
          enableMergejoin:
            description: |-
              **boolean**
              Enables the planner's use of merge join plans.
            type: boolean
          enableNestloop:
            description: |-
              **boolean**
              Enables the planner's use of nested-loop join plans.
            type: boolean
          enableSeqscan:
            description: |-
              **boolean**
              Enables the planner's use of sequential-scan plans.
            type: boolean
          enableSort:
            description: |-
              **boolean**
              Enables the planner's use of explicit sort steps.
            type: boolean
          enableTidscan:
            description: |-
              **boolean**
              Enables the planner's use of TID scan plans.
            type: boolean
          maxParallelWorkers:
            description: |-
              **string** (int64)
              Sets the maximum number of parallel workers that can be active at one time.
              Acceptable values are 0 to 1024, inclusive.
            type: string
            format: int64
          maxParallelWorkersPerGather:
            description: |-
              **string** (int64)
              Sets the maximum number of parallel processes per executor node.
              Acceptable values are 0 to 1024, inclusive.
            type: string
            format: int64
          timezone:
            description: |-
              **string**
              Sets the time zone for displaying and interpreting time stamps.
            type: string
          effectiveIoConcurrency:
            description: |-
              **string** (int64)
              Number of simultaneous requests that can be handled efficiently by the disk subsystem.
              Acceptable values are 0 to 1000, inclusive.
            type: string
            format: int64
          effectiveCacheSize:
            description: |-
              **string** (int64)
              Sets the planner's assumption about the effective size of the disk cache available to a single query. In bytes.
              Acceptable values are 1048576 to 549755813888, inclusive.
            type: string
            format: int64
          idleSessionTimeout:
            description: |-
              **string** (int64)
              Sets the maximum allowed idle time between queries, when not in a transaction. In milliseconds.
              Acceptable values are 0 to 2147483647, inclusive.
            type: string
            format: int64
      PostgresqlHostConfig17_1C:
        type: object
        properties:
          recoveryMinApplyDelay:
            description: |-
              **string** (int64)
              Sets the minimum delay for applying changes during recovery. In milliseconds.
            type: string
            format: int64
          sharedBuffers:
            description: |-
              **string** (int64)
              Sets the number of shared memory buffers used by the server. In bytes.
            type: string
            format: int64
          tempBuffers:
            description: |-
              **string** (int64)
              Sets the maximum number of temporary buffers used by each session. In bytes.
            type: string
            format: int64
          workMem:
            description: |-
              **string** (int64)
              Sets the maximum memory to be used for query workspaces. This much memory can be used by each
              internal sort operation and hash table before switching to temporary disk files. In bytes.
            type: string
            format: int64
          tempFileLimit:
            description: |-
              **string** (int64)
              Limits the total size of all temporary files used by each process. -1 means no limit. In bytes.
            type: string
            format: int64
          backendFlushAfter:
            description: |-
              **string** (int64)
              Specifies how much data a backend can write before forcing the operating system to issue the writes. In bytes.
              Acceptable values are 0 to 2097152, inclusive.
            type: string
            format: int64
          maxStandbyStreamingDelay:
            description: |-
              **string** (int64)
              Sets the maximum delay before canceling queries when a hot standby server is processing streamed WAL data. In milliseconds.
            type: string
            format: int64
          constraintExclusion:
            description: |-
              **enum** (ConstraintExclusion)
              Enables the planner to use constraints to optimize queries.
              - `CONSTRAINT_EXCLUSION_ON`: Enable planner's use of constraints for all tables.
              - `CONSTRAINT_EXCLUSION_OFF`: Disable planner's use of constraints for all tables
              - `CONSTRAINT_EXCLUSION_PARTITION`: Only use constraints for child tables and UNION ALL clauses.
            type: string
            enum:
              - CONSTRAINT_EXCLUSION_UNSPECIFIED
              - CONSTRAINT_EXCLUSION_ON
              - CONSTRAINT_EXCLUSION_OFF
              - CONSTRAINT_EXCLUSION_PARTITION
          cursorTupleFraction:
            description: |-
              **number** (double)
              Sets the planner's estimate of the fraction of a cursor's rows that will be retrieved.
            type: number
            format: double
          fromCollapseLimit:
            description: |-
              **string** (int64)
              Sets the FROM-list size beyond which subqueries are not collapsed.
              Acceptable values are 1 to 2147483647, inclusive.
            type: string
            format: int64
          joinCollapseLimit:
            description: |-
              **string** (int64)
              Sets the FROM-list size beyond which JOIN constructs are not flattened.
              Acceptable values are 1 to 2147483647, inclusive.
            type: string
            format: int64
          debugParallelQuery:
            description: |-
              **enum** (DebugParallelQuery)
              Forces the planner's use parallel query nodes.
              - `DEBUG_PARALLEL_QUERY_ON`: Forces parallel mode for queries considered safe, even when no performance benefit is expected.
              - `DEBUG_PARALLEL_QUERY_OFF`: Uses parallel mode only when the planner expects it to improve performance.
              - `DEBUG_PARALLEL_QUERY_REGRESS`: Behaves like ON, but hides added Gather nodes in EXPLAIN output and
              suppresses parallel-worker context lines to stabilize regression-test output.
            type: string
            enum:
              - DEBUG_PARALLEL_QUERY_UNSPECIFIED
              - DEBUG_PARALLEL_QUERY_ON
              - DEBUG_PARALLEL_QUERY_OFF
              - DEBUG_PARALLEL_QUERY_REGRESS
          clientMinMessages:
            description: |-
              **enum** (LogLevel)
              Sets the message levels that are sent to the client.
              - `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
              - `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
              - `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
              - `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
              - `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
              - `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
              - `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
              - `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
              - `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
              - `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
              - `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions.
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
              Sets the message levels that are logged.
              - `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
              - `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
              - `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
              - `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
              - `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
              - `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
              - `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
              - `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
              - `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
              - `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
              - `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions.
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
              Causes all statements generating error at or above this level to be logged.
              - `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
              - `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
              - `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
              - `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
              - `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
              - `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
              - `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
              - `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
              - `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
              - `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
              - `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions.
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
              Sets the minimum execution time above which all statements will be logged. In milliseconds.
            type: string
            format: int64
          logCheckpoints:
            description: |-
              **boolean**
              Logs each checkpoint.
            type: boolean
          logConnections:
            description: |-
              **boolean**
              Logs each successful connection.
            type: boolean
          logDisconnections:
            description: |-
              **boolean**
              Logs end of a session, including duration.
            type: boolean
          logDuration:
            description: |
              **boolean**
              Logs the duration of each completed SQL statement.
            type: boolean
          logErrorVerbosity:
            description: |-
              **enum** (LogErrorVerbosity)
              Sets the verbosity of logged messages.
              - `LOG_ERROR_VERBOSITY_TERSE`: DETAIL, HINT, QUERY, and CONTEXT fields are excluded from the error message.
              - `LOG_ERROR_VERBOSITY_DEFAULT`: Default.
              - `LOG_ERROR_VERBOSITY_VERBOSE`: Error message includes the SQLSTATE error code, source filename, function name, and the line number where the error occurred.
            type: string
            enum:
              - LOG_ERROR_VERBOSITY_UNSPECIFIED
              - LOG_ERROR_VERBOSITY_TERSE
              - LOG_ERROR_VERBOSITY_DEFAULT
              - LOG_ERROR_VERBOSITY_VERBOSE
          logLockWaits:
            description: |-
              **boolean**
              Logs long lock waits.
            type: boolean
          logStatement:
            description: |-
              **enum** (LogStatement)
              Sets the type of statements logged.
              - `LOG_STATEMENT_NONE`: The filter is disabled, no SQL statements are logged.
              - `LOG_STATEMENT_DDL`: System logs DDL statements, e.g., CREATE, ALTER, DROP etc.
              - `LOG_STATEMENT_MOD`: System logs ddl-statements along with data modification commands, e.g., INSERT, UPDATE, etc.
              - `LOG_STATEMENT_ALL`: System logs all SQL statements.
            type: string
            enum:
              - LOG_STATEMENT_UNSPECIFIED
              - LOG_STATEMENT_NONE
              - LOG_STATEMENT_DDL
              - LOG_STATEMENT_MOD
              - LOG_STATEMENT_ALL
          logTempFiles:
            description: |-
              **string** (int64)
              Log the use of temporary files larger than this number of kilobytes.
            type: string
            format: int64
          searchPath:
            description: |-
              **string**
              Sets the schema search order for names that are not schema-qualified.
            type: string
          rowSecurity:
            description: |-
              **boolean**
              Enable row security.
            type: boolean
          defaultTransactionIsolation:
            description: |-
              **enum** (TransactionIsolation)
              Sets the transaction isolation level of each new transaction.
              - `TRANSACTION_ISOLATION_READ_UNCOMMITTED`: This level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.
              - `TRANSACTION_ISOLATION_READ_COMMITTED`: On this level query sees only data committed before the query began.
              - `TRANSACTION_ISOLATION_REPEATABLE_READ`: On this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).
              - `TRANSACTION_ISOLATION_SERIALIZABLE`: This level provides the strictest transaction isolation.
              All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction.
              If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure.
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
              Sets the maximum allowed duration of any statement. In milliseconds.
            type: string
            format: int64
          lockTimeout:
            description: |-
              **string** (int64)
              Sets the maximum allowed duration of any wait for a lock. In milliseconds.
              Acceptable values are 0 to 2147483647, inclusive.
            type: string
            format: int64
          idleInTransactionSessionTimeout:
            description: |-
              **string** (int64)
              Sets the maximum allowed idle time between queries, when in a transaction. In milliseconds.
              Acceptable values are 0 to 2147483647, inclusive.
            type: string
            format: int64
          byteaOutput:
            description: |-
              **enum** (ByteaOutput)
              Sets the output format for bytea.
              - `BYTEA_OUTPUT_HEX`: Each byte is represented by two hexadecimal characters, e.g., 'SELECT '\xDEADBEEF';'.
              - `BYTEA_OUTPUT_ESCAPED`: Standard PostgreSQL format with ASCII characters only.
            type: string
            enum:
              - BYTEA_OUTPUT_UNSPECIFIED
              - BYTEA_OUTPUT_HEX
              - BYTEA_OUTPUT_ESCAPED
          xmlbinary:
            description: |-
              **enum** (XmlBinary)
              Sets how binary values are to be encoded in XML.
              - `XML_BINARY_BASE64`: Encodes binary values using Base64.
              - `XML_BINARY_HEX`: Encodes binary values using hexadecimal notation.
            type: string
            enum:
              - XML_BINARY_UNSPECIFIED
              - XML_BINARY_BASE64
              - XML_BINARY_HEX
          xmloption:
            description: |-
              **enum** (XmlOption)
              Sets whether XML data in implicit parsing and serialization operations is to be considered as documents or content fragments.
              - `XML_OPTION_DOCUMENT`: Treats an XML value as a complete, well-formed document.
              - `XML_OPTION_CONTENT`: Treats an XML value as a content fragment, which may contain multiple top-level elements or character nodes.
            type: string
            enum:
              - XML_OPTION_UNSPECIFIED
              - XML_OPTION_DOCUMENT
              - XML_OPTION_CONTENT
          ginPendingListLimit:
            description: |-
              **string** (int64)
              Sets the maximum size of the pending list for GIN index. In bytes.
            type: string
            format: int64
          deadlockTimeout:
            description: |-
              **string** (int64)
              Sets the time to wait on a lock before checking for deadlock. In milliseconds.
              Acceptable values are 1 to 2147483647, inclusive.
            type: string
            format: int64
          maxLocksPerTransaction:
            description: |-
              **string** (int64)
              Sets the maximum number of locks per transaction. The shared lock table is sized on the assumption that
              at most max_locks_per_transaction * max_connections distinct objects will need to be locked at any one time.
            type: string
            format: int64
          maxPredLocksPerTransaction:
            description: |-
              **string** (int64)
              Sets the maximum number of predicate locks per transaction.The shared predicate lock table is sized on the assumption that
              at most max_pred_locks_per_transaction * max_connections distinct objects will need to be locked at any one time.
            type: string
            format: int64
          arrayNulls:
            description: |-
              **boolean**
              Enable input of NULL elements in arrays. When turned on, unquoted NULL in an array input
              value means a null value; otherwise it is taken literally.
            type: boolean
          backslashQuote:
            description: |-
              **enum** (BackslashQuote)
              Sets whether \"\\'\" is allowed in string literals.
              - `BACKSLASH_QUOTE`: Legacy invalid value. Do not use.
              - `BACKSLASH_QUOTE_ON`: Quotation mark can be represented as \'.
              - `BACKSLASH_QUOTE_OFF`: Quotation mark can only be represented using the standard SQL syntax ''.
              - `BACKSLASH_QUOTE_SAFE_ENCODING`: Representing a quotation mark as \' is only permitted for client encodings where \ is not used for multibyte characters.
            type: string
            enum:
              - BACKSLASH_QUOTE_UNSPECIFIED
              - BACKSLASH_QUOTE
              - BACKSLASH_QUOTE_ON
              - BACKSLASH_QUOTE_OFF
              - BACKSLASH_QUOTE_SAFE_ENCODING
          defaultWithOids:
            description: |-
              **boolean**
              WITH OIDS is no longer supported; this can only be false.
            type: boolean
          escapeStringWarning:
            description: |-
              **boolean**
              Warn about backslash escapes in ordinary string literals.
            type: boolean
          loCompatPrivileges:
            description: |-
              **boolean**
              Enables backward compatibility mode for privilege checks on large objects. Skips privilege checks
              when reading or modifying large objects, for compatibility with PostgreSQL releases prior to 9.0.
            type: boolean
          quoteAllIdentifiers:
            description: |-
              **boolean**
              When generating SQL fragments, quote all identifiers.
            type: boolean
          standardConformingStrings:
            description: |-
              **boolean**
              Causes '...' strings to treat backslashes literally.
            type: boolean
          synchronizeSeqscans:
            description: |-
              **boolean**
              Enable synchronized sequential scans.
            type: boolean
          transformNullEquals:
            description: |-
              **boolean**
              Treats \"expr=NULL\" as \"expr IS NULL\". When turned on, expressions of the form expr = NULL
              (or NULL = expr) are treated as expr IS NULL, that is, they return true if expr evaluates to the
              null value, and false otherwise. The correct behavior of expr = NULL is to always return null (unknown).
            type: boolean
          exitOnError:
            description: |-
              **boolean**
              Terminate session on any error.
            type: boolean
          seqPageCost:
            description: |-
              **number** (double)
              Sets the planner's estimate of the cost of a sequentially fetched disk page.
              The minimum value is 0.
            type: number
            format: double
          randomPageCost:
            description: |-
              **number** (double)
              Sets the planner's estimate of the cost of a nonsequentially fetched disk page.
              The minimum value is 0.
            type: number
            format: double
          enableBitmapscan:
            description: |-
              **boolean**
              Enables the planner's use of bitmap-scan plans.
            type: boolean
          enableHashagg:
            description: |-
              **boolean**
              Enables the planner's use of hashed aggregation plans.
            type: boolean
          enableHashjoin:
            description: |-
              **boolean**
              Enables the planner's use of hash join plans.
            type: boolean
          enableIndexscan:
            description: |-
              **boolean**
              Enables the planner's use of index-scan plans.
            type: boolean
          enableIndexonlyscan:
            description: |-
              **boolean**
              Enables the planner's use of index-only-scan plans.
            type: boolean
          enableMaterial:
            description: |-
              **boolean**
              Enables the planner's use of materialization.
            type: boolean
          enableMergejoin:
            description: |-
              **boolean**
              Enables the planner's use of merge join plans.
            type: boolean
          enableNestloop:
            description: |-
              **boolean**
              Enables the planner's use of nested-loop join plans.
            type: boolean
          enableSeqscan:
            description: |-
              **boolean**
              Enables the planner's use of sequential-scan plans.
            type: boolean
          enableSort:
            description: |-
              **boolean**
              Enables the planner's use of explicit sort steps.
            type: boolean
          enableTidscan:
            description: |-
              **boolean**
              Enables the planner's use of TID scan plans.
            type: boolean
          maxParallelWorkers:
            description: |-
              **string** (int64)
              Sets the maximum number of parallel workers that can be active at one time.
              Acceptable values are 0 to 1024, inclusive.
            type: string
            format: int64
          maxParallelWorkersPerGather:
            description: |-
              **string** (int64)
              Sets the maximum number of parallel processes per executor node.
              Acceptable values are 0 to 1024, inclusive.
            type: string
            format: int64
          timezone:
            description: |-
              **string**
              Sets the time zone for displaying and interpreting time stamps.
            type: string
          effectiveIoConcurrency:
            description: |-
              **string** (int64)
              Number of simultaneous requests that can be handled efficiently by the disk subsystem.
              Acceptable values are 0 to 1000, inclusive.
            type: string
            format: int64
          effectiveCacheSize:
            description: |-
              **string** (int64)
              Sets the planner's assumption about the effective size of the disk cache available to a single query. In bytes.
              Acceptable values are 1048576 to 549755813888, inclusive.
            type: string
            format: int64
          idleSessionTimeout:
            description: |-
              **string** (int64)
              Sets the maximum allowed idle time between queries, when not in a transaction. In milliseconds.
              Acceptable values are 0 to 2147483647, inclusive.
            type: string
            format: int64
      PostgresqlHostConfig18:
        type: object
        properties:
          recoveryMinApplyDelay:
            description: |-
              **string** (int64)
              Sets the minimum delay for applying changes during recovery. In milliseconds.
            type: string
            format: int64
          sharedBuffers:
            description: |-
              **string** (int64)
              Sets the number of shared memory buffers used by the server. In bytes.
            type: string
            format: int64
          tempBuffers:
            description: |-
              **string** (int64)
              Sets the maximum number of temporary buffers used by each session. In bytes.
            type: string
            format: int64
          workMem:
            description: |-
              **string** (int64)
              Sets the maximum memory to be used for query workspaces. This much memory can be used by each
              internal sort operation and hash table before switching to temporary disk files. In bytes.
            type: string
            format: int64
          tempFileLimit:
            description: |-
              **string** (int64)
              Limits the total size of all temporary files used by each process. -1 means no limit. In bytes.
            type: string
            format: int64
          backendFlushAfter:
            description: |-
              **string** (int64)
              Specifies how much data a backend can write before forcing the operating system to issue the writes. In bytes.
              Acceptable values are 0 to 2097152, inclusive.
            type: string
            format: int64
          maxStandbyStreamingDelay:
            description: |-
              **string** (int64)
              Sets the maximum delay before canceling queries when a hot standby server is processing streamed WAL data. In milliseconds.
            type: string
            format: int64
          constraintExclusion:
            description: |-
              **enum** (ConstraintExclusion)
              Enables the planner to use constraints to optimize queries.
              - `CONSTRAINT_EXCLUSION_ON`: Enable planner's use of constraints for all tables.
              - `CONSTRAINT_EXCLUSION_OFF`: Disable planner's use of constraints for all tables
              - `CONSTRAINT_EXCLUSION_PARTITION`: Only use constraints for child tables and UNION ALL clauses.
            type: string
            enum:
              - CONSTRAINT_EXCLUSION_UNSPECIFIED
              - CONSTRAINT_EXCLUSION_ON
              - CONSTRAINT_EXCLUSION_OFF
              - CONSTRAINT_EXCLUSION_PARTITION
          cursorTupleFraction:
            description: |-
              **number** (double)
              Sets the planner's estimate of the fraction of a cursor's rows that will be retrieved.
            type: number
            format: double
          fromCollapseLimit:
            description: |-
              **string** (int64)
              Sets the FROM-list size beyond which subqueries are not collapsed.
              Acceptable values are 1 to 2147483647, inclusive.
            type: string
            format: int64
          joinCollapseLimit:
            description: |-
              **string** (int64)
              Sets the FROM-list size beyond which JOIN constructs are not flattened.
              Acceptable values are 1 to 2147483647, inclusive.
            type: string
            format: int64
          debugParallelQuery:
            description: |-
              **enum** (DebugParallelQuery)
              Forces the planner's use parallel query nodes.
              - `DEBUG_PARALLEL_QUERY_ON`: Forces parallel mode for queries considered safe, even when no performance benefit is expected.
              - `DEBUG_PARALLEL_QUERY_OFF`: Uses parallel mode only when the planner expects it to improve performance.
              - `DEBUG_PARALLEL_QUERY_REGRESS`: Behaves like ON, but hides added Gather nodes in EXPLAIN output and
              suppresses parallel-worker context lines to stabilize regression-test output.
            type: string
            enum:
              - DEBUG_PARALLEL_QUERY_UNSPECIFIED
              - DEBUG_PARALLEL_QUERY_ON
              - DEBUG_PARALLEL_QUERY_OFF
              - DEBUG_PARALLEL_QUERY_REGRESS
          clientMinMessages:
            description: |-
              **enum** (LogLevel)
              Sets the message levels that are sent to the client.
              - `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
              - `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
              - `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
              - `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
              - `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
              - `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
              - `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
              - `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
              - `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
              - `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
              - `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions.
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
              Sets the message levels that are logged.
              - `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
              - `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
              - `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
              - `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
              - `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
              - `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
              - `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
              - `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
              - `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
              - `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
              - `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions.
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
              Causes all statements generating error at or above this level to be logged.
              - `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
              - `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
              - `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
              - `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
              - `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
              - `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
              - `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
              - `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
              - `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
              - `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
              - `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions.
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
              Sets the minimum execution time above which all statements will be logged. In milliseconds.
            type: string
            format: int64
          logCheckpoints:
            description: |-
              **boolean**
              Logs each checkpoint.
            type: boolean
          logConnections:
            description: |-
              **boolean**
              Logs each successful connection.
            type: boolean
          logDisconnections:
            description: |-
              **boolean**
              Logs end of a session, including duration.
            type: boolean
          logDuration:
            description: |
              **boolean**
              Logs the duration of each completed SQL statement.
            type: boolean
          logErrorVerbosity:
            description: |-
              **enum** (LogErrorVerbosity)
              Sets the verbosity of logged messages.
              - `LOG_ERROR_VERBOSITY_TERSE`: DETAIL, HINT, QUERY, and CONTEXT fields are excluded from the error message.
              - `LOG_ERROR_VERBOSITY_DEFAULT`: Default.
              - `LOG_ERROR_VERBOSITY_VERBOSE`: Error message includes the SQLSTATE error code, source filename, function name, and the line number where the error occurred.
            type: string
            enum:
              - LOG_ERROR_VERBOSITY_UNSPECIFIED
              - LOG_ERROR_VERBOSITY_TERSE
              - LOG_ERROR_VERBOSITY_DEFAULT
              - LOG_ERROR_VERBOSITY_VERBOSE
          logLockWaits:
            description: |-
              **boolean**
              Logs long lock waits.
            type: boolean
          logStatement:
            description: |-
              **enum** (LogStatement)
              Sets the type of statements logged.
              - `LOG_STATEMENT_NONE`: The filter is disabled, no SQL statements are logged.
              - `LOG_STATEMENT_DDL`: System logs DDL statements, e.g., CREATE, ALTER, DROP etc.
              - `LOG_STATEMENT_MOD`: System logs ddl-statements along with data modification commands, e.g., INSERT, UPDATE, etc.
              - `LOG_STATEMENT_ALL`: System logs all SQL statements.
            type: string
            enum:
              - LOG_STATEMENT_UNSPECIFIED
              - LOG_STATEMENT_NONE
              - LOG_STATEMENT_DDL
              - LOG_STATEMENT_MOD
              - LOG_STATEMENT_ALL
          logTempFiles:
            description: |-
              **string** (int64)
              Log the use of temporary files larger than this number of kilobytes.
            type: string
            format: int64
          searchPath:
            description: |-
              **string**
              Sets the schema search order for names that are not schema-qualified.
            type: string
          rowSecurity:
            description: |-
              **boolean**
              Enable row security.
            type: boolean
          defaultTransactionIsolation:
            description: |-
              **enum** (TransactionIsolation)
              Sets the transaction isolation level of each new transaction.
              - `TRANSACTION_ISOLATION_READ_UNCOMMITTED`: This level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.
              - `TRANSACTION_ISOLATION_READ_COMMITTED`: On this level query sees only data committed before the query began.
              - `TRANSACTION_ISOLATION_REPEATABLE_READ`: On this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).
              - `TRANSACTION_ISOLATION_SERIALIZABLE`: This level provides the strictest transaction isolation.
              All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction.
              If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure.
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
              Sets the maximum allowed duration of any statement. In milliseconds.
            type: string
            format: int64
          lockTimeout:
            description: |-
              **string** (int64)
              Sets the maximum allowed duration of any wait for a lock. In milliseconds.
              Acceptable values are 0 to 2147483647, inclusive.
            type: string
            format: int64
          idleInTransactionSessionTimeout:
            description: |-
              **string** (int64)
              Sets the maximum allowed idle time between queries, when in a transaction. In milliseconds.
              Acceptable values are 0 to 2147483647, inclusive.
            type: string
            format: int64
          byteaOutput:
            description: |-
              **enum** (ByteaOutput)
              Sets the output format for bytea.
              - `BYTEA_OUTPUT_HEX`: Each byte is represented by two hexadecimal characters, e.g., 'SELECT '\xDEADBEEF';'.
              - `BYTEA_OUTPUT_ESCAPED`: Standard PostgreSQL format with ASCII characters only.
            type: string
            enum:
              - BYTEA_OUTPUT_UNSPECIFIED
              - BYTEA_OUTPUT_HEX
              - BYTEA_OUTPUT_ESCAPED
          xmlbinary:
            description: |-
              **enum** (XmlBinary)
              Sets how binary values are to be encoded in XML.
              - `XML_BINARY_BASE64`: Encodes binary values using Base64.
              - `XML_BINARY_HEX`: Encodes binary values using hexadecimal notation.
            type: string
            enum:
              - XML_BINARY_UNSPECIFIED
              - XML_BINARY_BASE64
              - XML_BINARY_HEX
          xmloption:
            description: |-
              **enum** (XmlOption)
              Sets whether XML data in implicit parsing and serialization operations is to be considered as documents or content fragments.
              - `XML_OPTION_DOCUMENT`: Treats an XML value as a complete, well-formed document.
              - `XML_OPTION_CONTENT`: Treats an XML value as a content fragment, which may contain multiple top-level elements or character nodes.
            type: string
            enum:
              - XML_OPTION_UNSPECIFIED
              - XML_OPTION_DOCUMENT
              - XML_OPTION_CONTENT
          ginPendingListLimit:
            description: |-
              **string** (int64)
              Sets the maximum size of the pending list for GIN index. In bytes.
            type: string
            format: int64
          deadlockTimeout:
            description: |-
              **string** (int64)
              Sets the time to wait on a lock before checking for deadlock. In milliseconds.
              Acceptable values are 1 to 2147483647, inclusive.
            type: string
            format: int64
          maxLocksPerTransaction:
            description: |-
              **string** (int64)
              Sets the maximum number of locks per transaction. The shared lock table is sized on the assumption that
              at most max_locks_per_transaction * max_connections distinct objects will need to be locked at any one time.
            type: string
            format: int64
          maxPredLocksPerTransaction:
            description: |-
              **string** (int64)
              Sets the maximum number of predicate locks per transaction.The shared predicate lock table is sized on the assumption that
              at most max_pred_locks_per_transaction * max_connections distinct objects will need to be locked at any one time.
            type: string
            format: int64
          arrayNulls:
            description: |-
              **boolean**
              Enable input of NULL elements in arrays. When turned on, unquoted NULL in an array input
              value means a null value; otherwise it is taken literally.
            type: boolean
          backslashQuote:
            description: |-
              **enum** (BackslashQuote)
              Sets whether \"\\'\" is allowed in string literals.
              - `BACKSLASH_QUOTE`: Legacy invalid value. Do not use.
              - `BACKSLASH_QUOTE_ON`: Quotation mark can be represented as \'.
              - `BACKSLASH_QUOTE_OFF`: Quotation mark can only be represented using the standard SQL syntax ''.
              - `BACKSLASH_QUOTE_SAFE_ENCODING`: Representing a quotation mark as \' is only permitted for client encodings where \ is not used for multibyte characters.
            type: string
            enum:
              - BACKSLASH_QUOTE_UNSPECIFIED
              - BACKSLASH_QUOTE
              - BACKSLASH_QUOTE_ON
              - BACKSLASH_QUOTE_OFF
              - BACKSLASH_QUOTE_SAFE_ENCODING
          defaultWithOids:
            description: |-
              **boolean**
              WITH OIDS is no longer supported; this can only be false.
            type: boolean
          escapeStringWarning:
            description: |-
              **boolean**
              Warn about backslash escapes in ordinary string literals.
            type: boolean
          loCompatPrivileges:
            description: |-
              **boolean**
              Enables backward compatibility mode for privilege checks on large objects. Skips privilege checks
              when reading or modifying large objects, for compatibility with PostgreSQL releases prior to 9.0.
            type: boolean
          quoteAllIdentifiers:
            description: |-
              **boolean**
              When generating SQL fragments, quote all identifiers.
            type: boolean
          standardConformingStrings:
            description: |-
              **boolean**
              Causes '...' strings to treat backslashes literally.
            type: boolean
          synchronizeSeqscans:
            description: |-
              **boolean**
              Enable synchronized sequential scans.
            type: boolean
          transformNullEquals:
            description: |-
              **boolean**
              Treats \"expr=NULL\" as \"expr IS NULL\". When turned on, expressions of the form expr = NULL
              (or NULL = expr) are treated as expr IS NULL, that is, they return true if expr evaluates to the
              null value, and false otherwise. The correct behavior of expr = NULL is to always return null (unknown).
            type: boolean
          exitOnError:
            description: |-
              **boolean**
              Terminate session on any error.
            type: boolean
          seqPageCost:
            description: |-
              **number** (double)
              Sets the planner's estimate of the cost of a sequentially fetched disk page.
              The minimum value is 0.
            type: number
            format: double
          randomPageCost:
            description: |-
              **number** (double)
              Sets the planner's estimate of the cost of a nonsequentially fetched disk page.
              The minimum value is 0.
            type: number
            format: double
          enableBitmapscan:
            description: |-
              **boolean**
              Enables the planner's use of bitmap-scan plans.
            type: boolean
          enableHashagg:
            description: |-
              **boolean**
              Enables the planner's use of hashed aggregation plans.
            type: boolean
          enableHashjoin:
            description: |-
              **boolean**
              Enables the planner's use of hash join plans.
            type: boolean
          enableIndexscan:
            description: |-
              **boolean**
              Enables the planner's use of index-scan plans.
            type: boolean
          enableIndexonlyscan:
            description: |-
              **boolean**
              Enables the planner's use of index-only-scan plans.
            type: boolean
          enableMaterial:
            description: |-
              **boolean**
              Enables the planner's use of materialization.
            type: boolean
          enableMergejoin:
            description: |-
              **boolean**
              Enables the planner's use of merge join plans.
            type: boolean
          enableNestloop:
            description: |-
              **boolean**
              Enables the planner's use of nested-loop join plans.
            type: boolean
          enableSeqscan:
            description: |-
              **boolean**
              Enables the planner's use of sequential-scan plans.
            type: boolean
          enableSort:
            description: |-
              **boolean**
              Enables the planner's use of explicit sort steps.
            type: boolean
          enableTidscan:
            description: |-
              **boolean**
              Enables the planner's use of TID scan plans.
            type: boolean
          maxParallelWorkers:
            description: |-
              **string** (int64)
              Sets the maximum number of parallel workers that can be active at one time.
              Acceptable values are 0 to 1024, inclusive.
            type: string
            format: int64
          maxParallelWorkersPerGather:
            description: |-
              **string** (int64)
              Sets the maximum number of parallel processes per executor node.
              Acceptable values are 0 to 1024, inclusive.
            type: string
            format: int64
          timezone:
            description: |-
              **string**
              Sets the time zone for displaying and interpreting time stamps.
            type: string
          effectiveIoConcurrency:
            description: |-
              **string** (int64)
              Number of simultaneous requests that can be handled efficiently by the disk subsystem.
              Acceptable values are 0 to 1000, inclusive.
            type: string
            format: int64
          effectiveCacheSize:
            description: |-
              **string** (int64)
              Sets the planner's assumption about the effective size of the disk cache available to a single query. In bytes.
              Acceptable values are 1048576 to 549755813888, inclusive.
            type: string
            format: int64
          idleSessionTimeout:
            description: |-
              **string** (int64)
              Sets the maximum allowed idle time between queries, when not in a transaction. In milliseconds.
              Acceptable values are 0 to 2147483647, inclusive.
            type: string
            format: int64
      PostgresqlHostConfig18_1C:
        type: object
        properties:
          recoveryMinApplyDelay:
            description: |-
              **string** (int64)
              Sets the minimum delay for applying changes during recovery. In milliseconds.
            type: string
            format: int64
          sharedBuffers:
            description: |-
              **string** (int64)
              Sets the number of shared memory buffers used by the server. In bytes.
            type: string
            format: int64
          tempBuffers:
            description: |-
              **string** (int64)
              Sets the maximum number of temporary buffers used by each session. In bytes.
            type: string
            format: int64
          workMem:
            description: |-
              **string** (int64)
              Sets the maximum memory to be used for query workspaces. This much memory can be used by each
              internal sort operation and hash table before switching to temporary disk files. In bytes.
            type: string
            format: int64
          tempFileLimit:
            description: |-
              **string** (int64)
              Limits the total size of all temporary files used by each process. -1 means no limit. In bytes.
            type: string
            format: int64
          backendFlushAfter:
            description: |-
              **string** (int64)
              Specifies how much data a backend can write before forcing the operating system to issue the writes. In bytes.
              Acceptable values are 0 to 2097152, inclusive.
            type: string
            format: int64
          maxStandbyStreamingDelay:
            description: |-
              **string** (int64)
              Sets the maximum delay before canceling queries when a hot standby server is processing streamed WAL data. In milliseconds.
            type: string
            format: int64
          constraintExclusion:
            description: |-
              **enum** (ConstraintExclusion)
              Enables the planner to use constraints to optimize queries.
              - `CONSTRAINT_EXCLUSION_ON`: Enable planner's use of constraints for all tables.
              - `CONSTRAINT_EXCLUSION_OFF`: Disable planner's use of constraints for all tables
              - `CONSTRAINT_EXCLUSION_PARTITION`: Only use constraints for child tables and UNION ALL clauses.
            type: string
            enum:
              - CONSTRAINT_EXCLUSION_UNSPECIFIED
              - CONSTRAINT_EXCLUSION_ON
              - CONSTRAINT_EXCLUSION_OFF
              - CONSTRAINT_EXCLUSION_PARTITION
          cursorTupleFraction:
            description: |-
              **number** (double)
              Sets the planner's estimate of the fraction of a cursor's rows that will be retrieved.
            type: number
            format: double
          fromCollapseLimit:
            description: |-
              **string** (int64)
              Sets the FROM-list size beyond which subqueries are not collapsed.
              Acceptable values are 1 to 2147483647, inclusive.
            type: string
            format: int64
          joinCollapseLimit:
            description: |-
              **string** (int64)
              Sets the FROM-list size beyond which JOIN constructs are not flattened.
              Acceptable values are 1 to 2147483647, inclusive.
            type: string
            format: int64
          debugParallelQuery:
            description: |-
              **enum** (DebugParallelQuery)
              Forces the planner's use parallel query nodes.
              - `DEBUG_PARALLEL_QUERY_ON`: Forces parallel mode for queries considered safe, even when no performance benefit is expected.
              - `DEBUG_PARALLEL_QUERY_OFF`: Uses parallel mode only when the planner expects it to improve performance.
              - `DEBUG_PARALLEL_QUERY_REGRESS`: Behaves like ON, but hides added Gather nodes in EXPLAIN output and
              suppresses parallel-worker context lines to stabilize regression-test output.
            type: string
            enum:
              - DEBUG_PARALLEL_QUERY_UNSPECIFIED
              - DEBUG_PARALLEL_QUERY_ON
              - DEBUG_PARALLEL_QUERY_OFF
              - DEBUG_PARALLEL_QUERY_REGRESS
          clientMinMessages:
            description: |-
              **enum** (LogLevel)
              Sets the message levels that are sent to the client.
              - `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
              - `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
              - `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
              - `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
              - `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
              - `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
              - `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
              - `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
              - `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
              - `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
              - `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions.
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
              Sets the message levels that are logged.
              - `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
              - `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
              - `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
              - `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
              - `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
              - `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
              - `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
              - `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
              - `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
              - `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
              - `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions.
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
              Causes all statements generating error at or above this level to be logged.
              - `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
              - `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
              - `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
              - `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
              - `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
              - `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
              - `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
              - `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
              - `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
              - `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
              - `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions.
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
              Sets the minimum execution time above which all statements will be logged. In milliseconds.
            type: string
            format: int64
          logCheckpoints:
            description: |-
              **boolean**
              Logs each checkpoint.
            type: boolean
          logConnections:
            description: |-
              **boolean**
              Logs each successful connection.
            type: boolean
          logDisconnections:
            description: |-
              **boolean**
              Logs end of a session, including duration.
            type: boolean
          logDuration:
            description: |
              **boolean**
              Logs the duration of each completed SQL statement.
            type: boolean
          logErrorVerbosity:
            description: |-
              **enum** (LogErrorVerbosity)
              Sets the verbosity of logged messages.
              - `LOG_ERROR_VERBOSITY_TERSE`: DETAIL, HINT, QUERY, and CONTEXT fields are excluded from the error message.
              - `LOG_ERROR_VERBOSITY_DEFAULT`: Default.
              - `LOG_ERROR_VERBOSITY_VERBOSE`: Error message includes the SQLSTATE error code, source filename, function name, and the line number where the error occurred.
            type: string
            enum:
              - LOG_ERROR_VERBOSITY_UNSPECIFIED
              - LOG_ERROR_VERBOSITY_TERSE
              - LOG_ERROR_VERBOSITY_DEFAULT
              - LOG_ERROR_VERBOSITY_VERBOSE
          logLockWaits:
            description: |-
              **boolean**
              Logs long lock waits.
            type: boolean
          logStatement:
            description: |-
              **enum** (LogStatement)
              Sets the type of statements logged.
              - `LOG_STATEMENT_NONE`: The filter is disabled, no SQL statements are logged.
              - `LOG_STATEMENT_DDL`: System logs DDL statements, e.g., CREATE, ALTER, DROP etc.
              - `LOG_STATEMENT_MOD`: System logs ddl-statements along with data modification commands, e.g., INSERT, UPDATE, etc.
              - `LOG_STATEMENT_ALL`: System logs all SQL statements.
            type: string
            enum:
              - LOG_STATEMENT_UNSPECIFIED
              - LOG_STATEMENT_NONE
              - LOG_STATEMENT_DDL
              - LOG_STATEMENT_MOD
              - LOG_STATEMENT_ALL
          logTempFiles:
            description: |-
              **string** (int64)
              Log the use of temporary files larger than this number of kilobytes.
            type: string
            format: int64
          searchPath:
            description: |-
              **string**
              Sets the schema search order for names that are not schema-qualified.
            type: string
          rowSecurity:
            description: |-
              **boolean**
              Enable row security.
            type: boolean
          defaultTransactionIsolation:
            description: |-
              **enum** (TransactionIsolation)
              Sets the transaction isolation level of each new transaction.
              - `TRANSACTION_ISOLATION_READ_UNCOMMITTED`: This level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.
              - `TRANSACTION_ISOLATION_READ_COMMITTED`: On this level query sees only data committed before the query began.
              - `TRANSACTION_ISOLATION_REPEATABLE_READ`: On this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).
              - `TRANSACTION_ISOLATION_SERIALIZABLE`: This level provides the strictest transaction isolation.
              All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction.
              If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure.
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
              Sets the maximum allowed duration of any statement. In milliseconds.
            type: string
            format: int64
          lockTimeout:
            description: |-
              **string** (int64)
              Sets the maximum allowed duration of any wait for a lock. In milliseconds.
              Acceptable values are 0 to 2147483647, inclusive.
            type: string
            format: int64
          idleInTransactionSessionTimeout:
            description: |-
              **string** (int64)
              Sets the maximum allowed idle time between queries, when in a transaction. In milliseconds.
              Acceptable values are 0 to 2147483647, inclusive.
            type: string
            format: int64
          byteaOutput:
            description: |-
              **enum** (ByteaOutput)
              Sets the output format for bytea.
              - `BYTEA_OUTPUT_HEX`: Each byte is represented by two hexadecimal characters, e.g., 'SELECT '\xDEADBEEF';'.
              - `BYTEA_OUTPUT_ESCAPED`: Standard PostgreSQL format with ASCII characters only.
            type: string
            enum:
              - BYTEA_OUTPUT_UNSPECIFIED
              - BYTEA_OUTPUT_HEX
              - BYTEA_OUTPUT_ESCAPED
          xmlbinary:
            description: |-
              **enum** (XmlBinary)
              Sets how binary values are to be encoded in XML.
              - `XML_BINARY_BASE64`: Encodes binary values using Base64.
              - `XML_BINARY_HEX`: Encodes binary values using hexadecimal notation.
            type: string
            enum:
              - XML_BINARY_UNSPECIFIED
              - XML_BINARY_BASE64
              - XML_BINARY_HEX
          xmloption:
            description: |-
              **enum** (XmlOption)
              Sets whether XML data in implicit parsing and serialization operations is to be considered as documents or content fragments.
              - `XML_OPTION_DOCUMENT`: Treats an XML value as a complete, well-formed document.
              - `XML_OPTION_CONTENT`: Treats an XML value as a content fragment, which may contain multiple top-level elements or character nodes.
            type: string
            enum:
              - XML_OPTION_UNSPECIFIED
              - XML_OPTION_DOCUMENT
              - XML_OPTION_CONTENT
          ginPendingListLimit:
            description: |-
              **string** (int64)
              Sets the maximum size of the pending list for GIN index. In bytes.
            type: string
            format: int64
          deadlockTimeout:
            description: |-
              **string** (int64)
              Sets the time to wait on a lock before checking for deadlock. In milliseconds.
              Acceptable values are 1 to 2147483647, inclusive.
            type: string
            format: int64
          maxLocksPerTransaction:
            description: |-
              **string** (int64)
              Sets the maximum number of locks per transaction. The shared lock table is sized on the assumption that
              at most max_locks_per_transaction * max_connections distinct objects will need to be locked at any one time.
            type: string
            format: int64
          maxPredLocksPerTransaction:
            description: |-
              **string** (int64)
              Sets the maximum number of predicate locks per transaction.The shared predicate lock table is sized on the assumption that
              at most max_pred_locks_per_transaction * max_connections distinct objects will need to be locked at any one time.
            type: string
            format: int64
          arrayNulls:
            description: |-
              **boolean**
              Enable input of NULL elements in arrays. When turned on, unquoted NULL in an array input
              value means a null value; otherwise it is taken literally.
            type: boolean
          backslashQuote:
            description: |-
              **enum** (BackslashQuote)
              Sets whether \"\\'\" is allowed in string literals.
              - `BACKSLASH_QUOTE`: Legacy invalid value. Do not use.
              - `BACKSLASH_QUOTE_ON`: Quotation mark can be represented as \'.
              - `BACKSLASH_QUOTE_OFF`: Quotation mark can only be represented using the standard SQL syntax ''.
              - `BACKSLASH_QUOTE_SAFE_ENCODING`: Representing a quotation mark as \' is only permitted for client encodings where \ is not used for multibyte characters.
            type: string
            enum:
              - BACKSLASH_QUOTE_UNSPECIFIED
              - BACKSLASH_QUOTE
              - BACKSLASH_QUOTE_ON
              - BACKSLASH_QUOTE_OFF
              - BACKSLASH_QUOTE_SAFE_ENCODING
          defaultWithOids:
            description: |-
              **boolean**
              WITH OIDS is no longer supported; this can only be false.
            type: boolean
          escapeStringWarning:
            description: |-
              **boolean**
              Warn about backslash escapes in ordinary string literals.
            type: boolean
          loCompatPrivileges:
            description: |-
              **boolean**
              Enables backward compatibility mode for privilege checks on large objects. Skips privilege checks
              when reading or modifying large objects, for compatibility with PostgreSQL releases prior to 9.0.
            type: boolean
          quoteAllIdentifiers:
            description: |-
              **boolean**
              When generating SQL fragments, quote all identifiers.
            type: boolean
          standardConformingStrings:
            description: |-
              **boolean**
              Causes '...' strings to treat backslashes literally.
            type: boolean
          synchronizeSeqscans:
            description: |-
              **boolean**
              Enable synchronized sequential scans.
            type: boolean
          transformNullEquals:
            description: |-
              **boolean**
              Treats \"expr=NULL\" as \"expr IS NULL\". When turned on, expressions of the form expr = NULL
              (or NULL = expr) are treated as expr IS NULL, that is, they return true if expr evaluates to the
              null value, and false otherwise. The correct behavior of expr = NULL is to always return null (unknown).
            type: boolean
          exitOnError:
            description: |-
              **boolean**
              Terminate session on any error.
            type: boolean
          seqPageCost:
            description: |-
              **number** (double)
              Sets the planner's estimate of the cost of a sequentially fetched disk page.
              The minimum value is 0.
            type: number
            format: double
          randomPageCost:
            description: |-
              **number** (double)
              Sets the planner's estimate of the cost of a nonsequentially fetched disk page.
              The minimum value is 0.
            type: number
            format: double
          enableBitmapscan:
            description: |-
              **boolean**
              Enables the planner's use of bitmap-scan plans.
            type: boolean
          enableHashagg:
            description: |-
              **boolean**
              Enables the planner's use of hashed aggregation plans.
            type: boolean
          enableHashjoin:
            description: |-
              **boolean**
              Enables the planner's use of hash join plans.
            type: boolean
          enableIndexscan:
            description: |-
              **boolean**
              Enables the planner's use of index-scan plans.
            type: boolean
          enableIndexonlyscan:
            description: |-
              **boolean**
              Enables the planner's use of index-only-scan plans.
            type: boolean
          enableMaterial:
            description: |-
              **boolean**
              Enables the planner's use of materialization.
            type: boolean
          enableMergejoin:
            description: |-
              **boolean**
              Enables the planner's use of merge join plans.
            type: boolean
          enableNestloop:
            description: |-
              **boolean**
              Enables the planner's use of nested-loop join plans.
            type: boolean
          enableSeqscan:
            description: |-
              **boolean**
              Enables the planner's use of sequential-scan plans.
            type: boolean
          enableSort:
            description: |-
              **boolean**
              Enables the planner's use of explicit sort steps.
            type: boolean
          enableTidscan:
            description: |-
              **boolean**
              Enables the planner's use of TID scan plans.
            type: boolean
          maxParallelWorkers:
            description: |-
              **string** (int64)
              Sets the maximum number of parallel workers that can be active at one time.
              Acceptable values are 0 to 1024, inclusive.
            type: string
            format: int64
          maxParallelWorkersPerGather:
            description: |-
              **string** (int64)
              Sets the maximum number of parallel processes per executor node.
              Acceptable values are 0 to 1024, inclusive.
            type: string
            format: int64
          timezone:
            description: |-
              **string**
              Sets the time zone for displaying and interpreting time stamps.
            type: string
          effectiveIoConcurrency:
            description: |-
              **string** (int64)
              Number of simultaneous requests that can be handled efficiently by the disk subsystem.
              Acceptable values are 0 to 1000, inclusive.
            type: string
            format: int64
          effectiveCacheSize:
            description: |-
              **string** (int64)
              Sets the planner's assumption about the effective size of the disk cache available to a single query. In bytes.
              Acceptable values are 1048576 to 549755813888, inclusive.
            type: string
            format: int64
          idleSessionTimeout:
            description: |-
              **string** (int64)
              Sets the maximum allowed idle time between queries, when not in a transaction. In milliseconds.
              Acceptable values are 0 to 2147483647, inclusive.
            type: string
            format: int64
      ConfigHostSpec:
        type: object
        properties:
          postgresqlConfig_11:
            description: |-
              **[PostgresqlHostConfig11](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig11)**
              Configuration for a host with PostgreSQL 11 server deployed.
              Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`.
            $ref: '#/definitions/PostgresqlHostConfig11'
          postgresqlConfig_12:
            description: |-
              **[PostgresqlHostConfig12](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig12)**
              Configuration for a host with PostgreSQL 12 server deployed.
              Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`.
            $ref: '#/definitions/PostgresqlHostConfig12'
          postgresqlConfig_13:
            description: |-
              **[PostgresqlHostConfig13](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig13)**
              Configuration for a host with PostgreSQL 13 server deployed.
              Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`.
            $ref: '#/definitions/PostgresqlHostConfig13'
          postgresqlConfig_13_1c:
            description: |-
              **[PostgresqlHostConfig13_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig13_1C)**
              Configuration for a host with PostgreSQL 13 1C server deployed.
              Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`.
            $ref: '#/definitions/PostgresqlHostConfig13_1C'
          postgresqlConfig_14:
            description: |-
              **[PostgresqlHostConfig14](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig14)**
              Configuration for a host with PostgreSQL 14 server deployed.
              Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`.
            $ref: '#/definitions/PostgresqlHostConfig14'
          postgresqlConfig_14_1c:
            description: |-
              **[PostgresqlHostConfig14_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig14_1C)**
              Configuration for a host with PostgreSQL 14 1C server deployed.
              Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`.
            $ref: '#/definitions/PostgresqlHostConfig14_1C'
          postgresqlConfig_15:
            description: |-
              **[PostgresqlHostConfig15](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig15)**
              Configuration for a host with PostgreSQL 15 server deployed.
              Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`.
            $ref: '#/definitions/PostgresqlHostConfig15'
          postgresqlConfig_15_1c:
            description: |-
              **[PostgresqlHostConfig15_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig15_1C)**
              Configuration for a host with PostgreSQL 15 1C server deployed.
              Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`.
            $ref: '#/definitions/PostgresqlHostConfig15_1C'
          postgresqlConfig_16:
            description: |-
              **[PostgresqlHostConfig16](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig16)**
              Configuration for a host with PostgreSQL 16 server deployed.
              Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`.
            $ref: '#/definitions/PostgresqlHostConfig16'
          postgresqlConfig_16_1c:
            description: |-
              **[PostgresqlHostConfig16_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig16_1C)**
              Configuration for a host with PostgreSQL 16 1C server deployed.
              Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`.
            $ref: '#/definitions/PostgresqlHostConfig16_1C'
          postgresqlConfig_17:
            description: |-
              **[PostgresqlHostConfig17](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig17)**
              Configuration for a host with PostgreSQL 17 1C server deployed.
              Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`.
            $ref: '#/definitions/PostgresqlHostConfig17'
          postgresqlConfig_17_1c:
            description: |-
              **[PostgresqlHostConfig17_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig17_1C)**
              Configuration for a host with PostgreSQL 17 1C server deployed.
              Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`.
            $ref: '#/definitions/PostgresqlHostConfig17_1C'
          postgresqlConfig_18:
            description: |-
              **[PostgresqlHostConfig18](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig18)**
              Configuration for a host with PostgreSQL 18 1C server deployed.
              Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`.
            $ref: '#/definitions/PostgresqlHostConfig18'
          postgresqlConfig_18_1c:
            description: |-
              **[PostgresqlHostConfig18_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig18_1C)**
              Configuration for a host with PostgreSQL 18 1C server deployed.
              Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`.
            $ref: '#/definitions/PostgresqlHostConfig18_1C'
        oneOf:
          - required:
              - postgresqlConfig_11
          - required:
              - postgresqlConfig_12
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
              The ID of the network is set in the field [Cluster.networkId](/docs/managed-postgresql/api-ref/Cluster/get#yandex.cloud.mdb.postgresql.v1.Cluster).
              The maximum string length in characters is 50.
            type: string
          assignPublicIp:
            description: |-
              **boolean**
              Whether the host should get a public IP address on creation.
              After a host has been created, this setting cannot be changed. To remove an assigned public IP, or to assign
              a public IP to a host without one, recreate the host with [assignPublicIp](/docs/managed-postgresql/api-ref/Cluster/updateHosts#yandex.cloud.mdb.postgresql.v1.UpdateHostSpec) set as needed.
              Possible values:
              * false - don't assign a public IP to the host.
              * true - the host should have a public IP address.
            type: boolean
          replicationSource:
            description: |-
              **string**
              [Host.name](/docs/managed-postgresql/api-ref/Cluster/listHosts#yandex.cloud.mdb.postgresql.v1.Host) of the host to be used as the replication source (for cascading replication).
            type: string
          priority:
            description: |-
              **string** (int64)
              Priority of the host as a replica. A higher value corresponds to higher priority.
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
---

# Managed Service for PostgreSQL API, REST: Cluster.AddHosts

Creates new hosts for a cluster.

## HTTP request

```
POST https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/{clusterId}/hosts:batchCreate
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the PostgreSQL cluster to add hosts to.
To get the PostgreSQL cluster ID, use a [ClusterService.List](/docs/managed-postgresql/api-ref/Cluster/list#List) request.

The maximum string length in characters is 50. ||
|#

## Body parameters {#yandex.cloud.mdb.postgresql.v1.AddClusterHostsRequest}

```json
{
  "hostSpecs": [
    {
      "zoneId": "string",
      "subnetId": "string",
      "assignPublicIp": "boolean",
      "replicationSource": "string",
      "priority": "string",
      "configSpec": {
        // Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`
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
          "effectiveCacheSize": "string",
          "idleSessionTimeout": "string"
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
          "effectiveCacheSize": "string",
          "idleSessionTimeout": "string"
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
          "effectiveCacheSize": "string",
          "idleSessionTimeout": "string"
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
          "effectiveCacheSize": "string",
          "idleSessionTimeout": "string"
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
          "effectiveCacheSize": "string",
          "idleSessionTimeout": "string"
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
          "effectiveCacheSize": "string",
          "idleSessionTimeout": "string"
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
          "effectiveCacheSize": "string",
          "idleSessionTimeout": "string"
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
          "effectiveCacheSize": "string",
          "idleSessionTimeout": "string"
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
          "effectiveCacheSize": "string",
          "idleSessionTimeout": "string"
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
          "effectiveCacheSize": "string",
          "idleSessionTimeout": "string"
        }
        // end of the list of possible fields
      }
    }
  ]
}
```

#|
||Field | Description ||
|| hostSpecs[] | **[HostSpec](#yandex.cloud.mdb.postgresql.v1.HostSpec)**

Configurations for PostgreSQL hosts that should be added to the cluster.

The number of elements must be greater than 0. ||
|#

## HostSpec {#yandex.cloud.mdb.postgresql.v1.HostSpec}

#|
||Field | Description ||
|| zoneId | **string**

ID of the availability zone where the host resides.
To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/Zone/list#List) request.

The maximum string length in characters is 50. ||
|| subnetId | **string**

ID of the subnet that the host should belong to. This subnet should be a part
of the network that the cluster belongs to.
The ID of the network is set in the field [Cluster.networkId](/docs/managed-postgresql/api-ref/Cluster/get#yandex.cloud.mdb.postgresql.v1.Cluster).

The maximum string length in characters is 50. ||
|| assignPublicIp | **boolean**

Whether the host should get a public IP address on creation.

After a host has been created, this setting cannot be changed. To remove an assigned public IP, or to assign
a public IP to a host without one, recreate the host with `assignPublicIp` set as needed.

Possible values:
* false - don't assign a public IP to the host.
* true - the host should have a public IP address. ||
|| replicationSource | **string**

[Host.name](/docs/managed-postgresql/api-ref/Cluster/listHosts#yandex.cloud.mdb.postgresql.v1.Host) of the host to be used as the replication source (for cascading replication). ||
|| priority | **string** (int64)

Priority of the host as a replica. A higher value corresponds to higher priority.

The host with the highest priority is the synchronous replica. All others are asynchronous.
The synchronous replica replaces the master when needed.

When a replica becomes the master, its priority is ignored. ||
|| configSpec | **[ConfigHostSpec](#yandex.cloud.mdb.postgresql.v1.ConfigHostSpec)**

Configuration of a PostgreSQL server for the host. ||
|#

## ConfigHostSpec {#yandex.cloud.mdb.postgresql.v1.ConfigHostSpec}

#|
||Field | Description ||
|| postgresqlConfig_11 | **[PostgresqlHostConfig11](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig11)**

Configuration for a host with PostgreSQL 11 server deployed.

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`. ||
|| postgresqlConfig_12 | **[PostgresqlHostConfig12](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig12)**

Configuration for a host with PostgreSQL 12 server deployed.

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`. ||
|| postgresqlConfig_13 | **[PostgresqlHostConfig13](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig13)**

Configuration for a host with PostgreSQL 13 server deployed.

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`. ||
|| postgresqlConfig_13_1c | **[PostgresqlHostConfig13_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig13_1C)**

Configuration for a host with PostgreSQL 13 1C server deployed.

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`. ||
|| postgresqlConfig_14 | **[PostgresqlHostConfig14](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig14)**

Configuration for a host with PostgreSQL 14 server deployed.

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`. ||
|| postgresqlConfig_14_1c | **[PostgresqlHostConfig14_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig14_1C)**

Configuration for a host with PostgreSQL 14 1C server deployed.

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`. ||
|| postgresqlConfig_15 | **[PostgresqlHostConfig15](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig15)**

Configuration for a host with PostgreSQL 15 server deployed.

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`. ||
|| postgresqlConfig_15_1c | **[PostgresqlHostConfig15_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig15_1C)**

Configuration for a host with PostgreSQL 15 1C server deployed.

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`. ||
|| postgresqlConfig_16 | **[PostgresqlHostConfig16](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig16)**

Configuration for a host with PostgreSQL 16 server deployed.

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`. ||
|| postgresqlConfig_16_1c | **[PostgresqlHostConfig16_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig16_1C)**

Configuration for a host with PostgreSQL 16 1C server deployed.

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`. ||
|| postgresqlConfig_17 | **[PostgresqlHostConfig17](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig17)**

Configuration for a host with PostgreSQL 17 1C server deployed.

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`. ||
|| postgresqlConfig_17_1c | **[PostgresqlHostConfig17_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig17_1C)**

Configuration for a host with PostgreSQL 17 1C server deployed.

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`. ||
|| postgresqlConfig_18 | **[PostgresqlHostConfig18](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig18)**

Configuration for a host with PostgreSQL 18 1C server deployed.

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`. ||
|| postgresqlConfig_18_1c | **[PostgresqlHostConfig18_1C](#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig18_1C)**

Configuration for a host with PostgreSQL 18 1C server deployed.

Includes only one of the fields `postgresqlConfig_11`, `postgresqlConfig_12`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`, `postgresqlConfig_18`, `postgresqlConfig_18_1c`. ||
|#

## PostgresqlHostConfig11 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig11}

Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file
parameters which detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/11/runtime-config.html).

#|
||Field | Description ||
|| recoveryMinApplyDelay | **string** (int64)

Sets the minimum delay for applying changes during recovery. In milliseconds. ||
|| sharedBuffers | **string** (int64)

Sets the number of shared memory buffers used by the server. In bytes. ||
|| tempBuffers | **string** (int64)

Sets the maximum number of temporary buffers used by each session. In bytes. ||
|| workMem | **string** (int64)

Sets the maximum memory to be used for query workspaces. This much memory can be used by each
internal sort operation and hash table before switching to temporary disk files. In bytes. ||
|| tempFileLimit | **string** (int64)

Limits the total size of all temporary files used by each process. -1 means no limit. In bytes. ||
|| backendFlushAfter | **string** (int64)

Specifies how much data a backend can write before forcing the operating system to issue the writes. In bytes.

Acceptable values are 0 to 2097152, inclusive. ||
|| oldSnapshotThreshold | **string** (int64)

Time before a snapshot is too old to read pages changed after the snapshot was taken.
A value of -1 disables this feature. In milliseconds. ||
|| maxStandbyStreamingDelay | **string** (int64)

Sets the maximum delay before canceling queries when a hot standby server is processing streamed WAL data. In milliseconds. ||
|| constraintExclusion | **enum** (ConstraintExclusion)

Enables the planner to use constraints to optimize queries.

- `CONSTRAINT_EXCLUSION_ON`: Enable planner's use of constraints for all tables.
- `CONSTRAINT_EXCLUSION_OFF`: Disable planner's use of constraints for all tables
- `CONSTRAINT_EXCLUSION_PARTITION`: Only use constraints for child tables and UNION ALL clauses. ||
|| cursorTupleFraction | **number** (double)

Sets the planner's estimate of the fraction of a cursor's rows that will be retrieved. ||
|| fromCollapseLimit | **string** (int64)

Sets the FROM-list size beyond which subqueries are not collapsed.

Acceptable values are 1 to 2147483647, inclusive. ||
|| joinCollapseLimit | **string** (int64)

Sets the FROM-list size beyond which JOIN constructs are not flattened.

Acceptable values are 1 to 2147483647, inclusive. ||
|| forceParallelMode | **enum** (ForceParallelMode)

Forces use of parallel query facilities. If possible, run query using a parallel worker and with parallel restrictions.

- `FORCE_PARALLEL_MODE_ON`: Forces parallel mode for queries considered safe, even when no performance benefit is expected.
- `FORCE_PARALLEL_MODE_OFF`: Uses parallel mode only when the planner expects it to improve performance.
- `FORCE_PARALLEL_MODE_REGRESS`: Behaves like ON, but hides added Gather nodes in EXPLAIN output and
suppresses parallel-worker context lines to stabilize regression-test output. ||
|| clientMinMessages | **enum** (LogLevel)

Sets the message levels that are sent to the client.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinMessages | **enum** (LogLevel)

Sets the message levels that are logged.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinErrorStatement | **enum** (LogLevel)

Causes all statements generating error at or above this level to be logged.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinDurationStatement | **string** (int64)

Sets the minimum execution time above which all statements will be logged. In milliseconds. ||
|| logCheckpoints | **boolean**

Logs each checkpoint. ||
|| logConnections | **boolean**

Logs each successful connection. ||
|| logDisconnections | **boolean**

Logs end of a session, including duration. ||
|| logDuration | **boolean**

Logs the duration of each completed SQL statement.
 ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

Sets the verbosity of logged messages.

- `LOG_ERROR_VERBOSITY_TERSE`: DETAIL, HINT, QUERY, and CONTEXT fields are excluded from the error message.
- `LOG_ERROR_VERBOSITY_DEFAULT`: Default.
- `LOG_ERROR_VERBOSITY_VERBOSE`: Error message includes the SQLSTATE error code, source filename, function name, and the line number where the error occurred. ||
|| logLockWaits | **boolean**

Logs long lock waits. ||
|| logStatement | **enum** (LogStatement)

Sets the type of statements logged.

- `LOG_STATEMENT_NONE`: The filter is disabled, no SQL statements are logged.
- `LOG_STATEMENT_DDL`: System logs DDL statements, e.g., CREATE, ALTER, DROP etc.
- `LOG_STATEMENT_MOD`: System logs ddl-statements along with data modification commands, e.g., INSERT, UPDATE, etc.
- `LOG_STATEMENT_ALL`: System logs all SQL statements. ||
|| logTempFiles | **string** (int64)

Log the use of temporary files larger than this number of kilobytes. ||
|| searchPath | **string**

Sets the schema search order for names that are not schema-qualified. ||
|| rowSecurity | **boolean**

Enable row security. ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

Sets the transaction isolation level of each new transaction.

- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`: This level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.
- `TRANSACTION_ISOLATION_READ_COMMITTED`: On this level query sees only data committed before the query began.
- `TRANSACTION_ISOLATION_REPEATABLE_READ`: On this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).
- `TRANSACTION_ISOLATION_SERIALIZABLE`: This level provides the strictest transaction isolation.
All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction.
If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure. ||
|| statementTimeout | **string** (int64)

Sets the maximum allowed duration of any statement. In milliseconds. ||
|| lockTimeout | **string** (int64)

Sets the maximum allowed duration of any wait for a lock. In milliseconds. ||
|| idleInTransactionSessionTimeout | **string** (int64)

Sets the maximum allowed idle time between queries, when in a transaction. In milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| byteaOutput | **enum** (ByteaOutput)

Sets the output format for bytea.

- `BYTEA_OUTPUT_HEX`: Each byte is represented by two hexadecimal characters, e.g., 'SELECT '\xDEADBEEF';'.
- `BYTEA_OUTPUT_ESCAPED`: Standard PostgreSQL format with ASCII characters only. ||
|| xmlbinary | **enum** (XmlBinary)

Sets how binary values are to be encoded in XML.

- `XML_BINARY_BASE64`: Encodes binary values using Base64.
- `XML_BINARY_HEX`: Encodes binary values using hexadecimal notation. ||
|| xmloption | **enum** (XmlOption)

Sets whether XML data in implicit parsing and serialization operations is to be considered as documents or content fragments.

- `XML_OPTION_DOCUMENT`: Treats an XML value as a complete, well-formed document.
- `XML_OPTION_CONTENT`: Treats an XML value as a content fragment, which may contain multiple top-level elements or character nodes. ||
|| ginPendingListLimit | **string** (int64)

Sets the maximum size of the pending list for GIN index. In bytes. ||
|| deadlockTimeout | **string** (int64)

Sets the time to wait on a lock before checking for deadlock. In milliseconds.

Acceptable values are 1 to 2147483647, inclusive. ||
|| maxLocksPerTransaction | **string** (int64)

Sets the maximum number of locks per transaction. The shared lock table is sized on the assumption that
at most max_locks_per_transaction * max_connections distinct objects will need to be locked at any one time. ||
|| maxPredLocksPerTransaction | **string** (int64)

Sets the maximum number of predicate locks per transaction.The shared predicate lock table is sized on the assumption that
at most max_pred_locks_per_transaction * max_connections distinct objects will need to be locked at any one time. ||
|| arrayNulls | **boolean**

Enable input of NULL elements in arrays. When turned on, unquoted NULL in an array input
value means a null value; otherwise it is taken literally. ||
|| backslashQuote | **enum** (BackslashQuote)

Sets whether \"\\'\" is allowed in string literals.

- `BACKSLASH_QUOTE`: Legacy invalid value. Do not use.
- `BACKSLASH_QUOTE_ON`: Quotation mark can be represented as \'.
- `BACKSLASH_QUOTE_OFF`: Quotation mark can only be represented using the standard SQL syntax ''.
- `BACKSLASH_QUOTE_SAFE_ENCODING`: Representing a quotation mark as \' is only permitted for client encodings where \ is not used for multibyte characters. ||
|| defaultWithOids | **boolean**

WITH OIDS is no longer supported; this can only be false. ||
|| escapeStringWarning | **boolean**

Warn about backslash escapes in ordinary string literals. ||
|| loCompatPrivileges | **boolean**

Enables backward compatibility mode for privilege checks on large objects. Skips privilege checks
when reading or modifying large objects, for compatibility with PostgreSQL releases prior to 9.0. ||
|| operatorPrecedenceWarning | **boolean**

Emit a warning for constructs that changed meaning since PostgreSQL 9.4. ||
|| quoteAllIdentifiers | **boolean**

When generating SQL fragments, quote all identifiers. ||
|| standardConformingStrings | **boolean**

Causes '...' strings to treat backslashes literally. ||
|| synchronizeSeqscans | **boolean**

Enable synchronized sequential scans. ||
|| transformNullEquals | **boolean**

Treats \"expr=NULL\" as \"expr IS NULL\". When turned on, expressions of the form expr = NULL
(or NULL = expr) are treated as expr IS NULL, that is, they return true if expr evaluates to the
null value, and false otherwise. The correct behavior of expr = NULL is to always return null (unknown). ||
|| exitOnError | **boolean**

Terminate session on any error. ||
|| seqPageCost | **number** (double)

Sets the planner's estimate of the cost of a sequentially fetched disk page.

The minimum value is 0. ||
|| randomPageCost | **number** (double)

Sets the planner's estimate of the cost of a nonsequentially fetched disk page.

The minimum value is 0. ||
|| enableBitmapscan | **boolean**

Enables the planner's use of bitmap-scan plans. ||
|| enableHashagg | **boolean**

Enables the planner's use of hashed aggregation plans. ||
|| enableHashjoin | **boolean**

Enables the planner's use of hash join plans. ||
|| enableIndexscan | **boolean**

Enables the planner's use of index-scan plans. ||
|| enableIndexonlyscan | **boolean**

Enables the planner's use of index-only-scan plans. ||
|| enableMaterial | **boolean**

Enables the planner's use of materialization. ||
|| enableMergejoin | **boolean**

Enables the planner's use of merge join plans. ||
|| enableNestloop | **boolean**

Enables the planner's use of nested-loop join plans. ||
|| enableSeqscan | **boolean**

Enables the planner's use of sequential-scan plans. ||
|| enableSort | **boolean**

Enables the planner's use of explicit sort steps. ||
|| enableTidscan | **boolean**

Enables the planner's use of TID scan plans. ||
|| maxParallelWorkers | **string** (int64)

Sets the maximum number of parallel workers that can be active at one time.

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkersPerGather | **string** (int64)

Sets the maximum number of parallel processes per executor node.

Acceptable values are 0 to 1024, inclusive. ||
|| timezone | **string**

Sets the time zone for displaying and interpreting time stamps. ||
|| effectiveIoConcurrency | **string** (int64)

Number of simultaneous requests that can be handled efficiently by the disk subsystem.

Acceptable values are 0 to 1000, inclusive. ||
|| effectiveCacheSize | **string** (int64)

Sets the planner's assumption about the effective size of the disk cache available to a single query. In bytes.

Acceptable values are 1048576 to 549755813888, inclusive. ||
|#

## PostgresqlHostConfig12 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig12}

Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file
parameters which detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/11/runtime-config.html).

#|
||Field | Description ||
|| recoveryMinApplyDelay | **string** (int64)

Sets the minimum delay for applying changes during recovery. In milliseconds. ||
|| sharedBuffers | **string** (int64)

Sets the number of shared memory buffers used by the server. In bytes. ||
|| tempBuffers | **string** (int64)

Sets the maximum number of temporary buffers used by each session. In bytes. ||
|| workMem | **string** (int64)

Sets the maximum memory to be used for query workspaces. This much memory can be used by each
internal sort operation and hash table before switching to temporary disk files. In bytes. ||
|| tempFileLimit | **string** (int64)

Limits the total size of all temporary files used by each process. -1 means no limit. In bytes. ||
|| backendFlushAfter | **string** (int64)

Specifies how much data a backend can write before forcing the operating system to issue the writes. In bytes.

Acceptable values are 0 to 2097152, inclusive. ||
|| oldSnapshotThreshold | **string** (int64)

Time before a snapshot is too old to read pages changed after the snapshot was taken.
A value of -1 disables this feature. In milliseconds. ||
|| maxStandbyStreamingDelay | **string** (int64)

Sets the maximum delay before canceling queries when a hot standby server is processing streamed WAL data. In milliseconds. ||
|| constraintExclusion | **enum** (ConstraintExclusion)

Enables the planner to use constraints to optimize queries.

- `CONSTRAINT_EXCLUSION_ON`: Enable planner's use of constraints for all tables.
- `CONSTRAINT_EXCLUSION_OFF`: Disable planner's use of constraints for all tables
- `CONSTRAINT_EXCLUSION_PARTITION`: Only use constraints for child tables and UNION ALL clauses. ||
|| cursorTupleFraction | **number** (double)

Sets the planner's estimate of the fraction of a cursor's rows that will be retrieved. ||
|| fromCollapseLimit | **string** (int64)

Sets the FROM-list size beyond which subqueries are not collapsed.

Acceptable values are 1 to 2147483647, inclusive. ||
|| joinCollapseLimit | **string** (int64)

Sets the FROM-list size beyond which JOIN constructs are not flattened.

Acceptable values are 1 to 2147483647, inclusive. ||
|| forceParallelMode | **enum** (ForceParallelMode)

Forces use of parallel query facilities. If possible, run query using a parallel worker and with parallel restrictions.

- `FORCE_PARALLEL_MODE_ON`: Forces parallel mode for queries considered safe, even when no performance benefit is expected.
- `FORCE_PARALLEL_MODE_OFF`: Uses parallel mode only when the planner expects it to improve performance.
- `FORCE_PARALLEL_MODE_REGRESS`: Behaves like ON, but hides added Gather nodes in EXPLAIN output and
suppresses parallel-worker context lines to stabilize regression-test output. ||
|| clientMinMessages | **enum** (LogLevel)

Sets the message levels that are sent to the client.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinMessages | **enum** (LogLevel)

Sets the message levels that are logged.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinErrorStatement | **enum** (LogLevel)

Causes all statements generating error at or above this level to be logged.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinDurationStatement | **string** (int64)

Sets the minimum execution time above which all statements will be logged. In milliseconds. ||
|| logCheckpoints | **boolean**

Logs each checkpoint. ||
|| logConnections | **boolean**

Logs each successful connection. ||
|| logDisconnections | **boolean**

Logs end of a session, including duration. ||
|| logDuration | **boolean**

Logs the duration of each completed SQL statement.
 ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

Sets the verbosity of logged messages.

- `LOG_ERROR_VERBOSITY_TERSE`: DETAIL, HINT, QUERY, and CONTEXT fields are excluded from the error message.
- `LOG_ERROR_VERBOSITY_DEFAULT`: Default.
- `LOG_ERROR_VERBOSITY_VERBOSE`: Error message includes the SQLSTATE error code, source filename, function name, and the line number where the error occurred. ||
|| logLockWaits | **boolean**

Logs long lock waits. ||
|| logStatement | **enum** (LogStatement)

Sets the type of statements logged.

- `LOG_STATEMENT_NONE`: The filter is disabled, no SQL statements are logged.
- `LOG_STATEMENT_DDL`: System logs DDL statements, e.g., CREATE, ALTER, DROP etc.
- `LOG_STATEMENT_MOD`: System logs ddl-statements along with data modification commands, e.g., INSERT, UPDATE, etc.
- `LOG_STATEMENT_ALL`: System logs all SQL statements. ||
|| logTempFiles | **string** (int64)

Log the use of temporary files larger than this number of kilobytes. ||
|| searchPath | **string**

Sets the schema search order for names that are not schema-qualified. ||
|| rowSecurity | **boolean**

Enable row security. ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

Sets the transaction isolation level of each new transaction.

- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`: This level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.
- `TRANSACTION_ISOLATION_READ_COMMITTED`: On this level query sees only data committed before the query began.
- `TRANSACTION_ISOLATION_REPEATABLE_READ`: On this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).
- `TRANSACTION_ISOLATION_SERIALIZABLE`: This level provides the strictest transaction isolation.
All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction.
If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure. ||
|| statementTimeout | **string** (int64)

Sets the maximum allowed duration of any statement. In milliseconds. ||
|| lockTimeout | **string** (int64)

Sets the maximum allowed duration of any wait for a lock. In milliseconds. ||
|| idleInTransactionSessionTimeout | **string** (int64)

Sets the maximum allowed idle time between queries, when in a transaction. In milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| byteaOutput | **enum** (ByteaOutput)

Sets the output format for bytea.

- `BYTEA_OUTPUT_HEX`: Each byte is represented by two hexadecimal characters, e.g., 'SELECT '\xDEADBEEF';'.
- `BYTEA_OUTPUT_ESCAPED`: Standard PostgreSQL format with ASCII characters only. ||
|| xmlbinary | **enum** (XmlBinary)

Sets how binary values are to be encoded in XML.

- `XML_BINARY_BASE64`: Encodes binary values using Base64.
- `XML_BINARY_HEX`: Encodes binary values using hexadecimal notation. ||
|| xmloption | **enum** (XmlOption)

Sets whether XML data in implicit parsing and serialization operations is to be considered as documents or content fragments.

- `XML_OPTION_DOCUMENT`: Treats an XML value as a complete, well-formed document.
- `XML_OPTION_CONTENT`: Treats an XML value as a content fragment, which may contain multiple top-level elements or character nodes. ||
|| ginPendingListLimit | **string** (int64)

Sets the maximum size of the pending list for GIN index. In bytes. ||
|| deadlockTimeout | **string** (int64)

Sets the time to wait on a lock before checking for deadlock. In milliseconds.

Acceptable values are 1 to 2147483647, inclusive. ||
|| maxLocksPerTransaction | **string** (int64)

Sets the maximum number of locks per transaction. The shared lock table is sized on the assumption that
at most max_locks_per_transaction * max_connections distinct objects will need to be locked at any one time. ||
|| maxPredLocksPerTransaction | **string** (int64)

Sets the maximum number of predicate locks per transaction.The shared predicate lock table is sized on the assumption that
at most max_pred_locks_per_transaction * max_connections distinct objects will need to be locked at any one time. ||
|| arrayNulls | **boolean**

Enable input of NULL elements in arrays. When turned on, unquoted NULL in an array input
value means a null value; otherwise it is taken literally. ||
|| backslashQuote | **enum** (BackslashQuote)

Sets whether \"\\'\" is allowed in string literals.

- `BACKSLASH_QUOTE`: Legacy invalid value. Do not use.
- `BACKSLASH_QUOTE_ON`: Quotation mark can be represented as \'.
- `BACKSLASH_QUOTE_OFF`: Quotation mark can only be represented using the standard SQL syntax ''.
- `BACKSLASH_QUOTE_SAFE_ENCODING`: Representing a quotation mark as \' is only permitted for client encodings where \ is not used for multibyte characters. ||
|| defaultWithOids | **boolean**

WITH OIDS is no longer supported; this can only be false. ||
|| escapeStringWarning | **boolean**

Warn about backslash escapes in ordinary string literals. ||
|| loCompatPrivileges | **boolean**

Enables backward compatibility mode for privilege checks on large objects. Skips privilege checks
when reading or modifying large objects, for compatibility with PostgreSQL releases prior to 9.0. ||
|| operatorPrecedenceWarning | **boolean**

Emit a warning for constructs that changed meaning since PostgreSQL 9.4. ||
|| quoteAllIdentifiers | **boolean**

When generating SQL fragments, quote all identifiers. ||
|| standardConformingStrings | **boolean**

Causes '...' strings to treat backslashes literally. ||
|| synchronizeSeqscans | **boolean**

Enable synchronized sequential scans. ||
|| transformNullEquals | **boolean**

Treats \"expr=NULL\" as \"expr IS NULL\". When turned on, expressions of the form expr = NULL
(or NULL = expr) are treated as expr IS NULL, that is, they return true if expr evaluates to the
null value, and false otherwise. The correct behavior of expr = NULL is to always return null (unknown). ||
|| exitOnError | **boolean**

Terminate session on any error. ||
|| seqPageCost | **number** (double)

Sets the planner's estimate of the cost of a sequentially fetched disk page.

The minimum value is 0. ||
|| randomPageCost | **number** (double)

Sets the planner's estimate of the cost of a nonsequentially fetched disk page.

The minimum value is 0. ||
|| enableBitmapscan | **boolean**

Enables the planner's use of bitmap-scan plans. ||
|| enableHashagg | **boolean**

Enables the planner's use of hashed aggregation plans. ||
|| enableHashjoin | **boolean**

Enables the planner's use of hash join plans. ||
|| enableIndexscan | **boolean**

Enables the planner's use of index-scan plans. ||
|| enableIndexonlyscan | **boolean**

Enables the planner's use of index-only-scan plans. ||
|| enableMaterial | **boolean**

Enables the planner's use of materialization. ||
|| enableMergejoin | **boolean**

Enables the planner's use of merge join plans. ||
|| enableNestloop | **boolean**

Enables the planner's use of nested-loop join plans. ||
|| enableSeqscan | **boolean**

Enables the planner's use of sequential-scan plans. ||
|| enableSort | **boolean**

Enables the planner's use of explicit sort steps. ||
|| enableTidscan | **boolean**

Enables the planner's use of TID scan plans. ||
|| maxParallelWorkers | **string** (int64)

Sets the maximum number of parallel workers that can be active at one time.

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkersPerGather | **string** (int64)

Sets the maximum number of parallel processes per executor node.

Acceptable values are 0 to 1024, inclusive. ||
|| timezone | **string**

Sets the time zone for displaying and interpreting time stamps. ||
|| effectiveIoConcurrency | **string** (int64)

Number of simultaneous requests that can be handled efficiently by the disk subsystem.

Acceptable values are 0 to 1000, inclusive. ||
|| effectiveCacheSize | **string** (int64)

Sets the planner's assumption about the effective size of the disk cache available to a single query. In bytes.

Acceptable values are 1048576 to 549755813888, inclusive. ||
|#

## PostgresqlHostConfig13 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig13}

Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file
parameters which detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/11/runtime-config.html).

#|
||Field | Description ||
|| recoveryMinApplyDelay | **string** (int64)

Sets the minimum delay for applying changes during recovery. In milliseconds. ||
|| sharedBuffers | **string** (int64)

Sets the number of shared memory buffers used by the server. In bytes. ||
|| tempBuffers | **string** (int64)

Sets the maximum number of temporary buffers used by each session. In bytes. ||
|| workMem | **string** (int64)

Sets the maximum memory to be used for query workspaces. This much memory can be used by each
internal sort operation and hash table before switching to temporary disk files. In bytes. ||
|| tempFileLimit | **string** (int64)

Limits the total size of all temporary files used by each process. -1 means no limit. In bytes. ||
|| backendFlushAfter | **string** (int64)

Specifies how much data a backend can write before forcing the operating system to issue the writes. In bytes.

Acceptable values are 0 to 2097152, inclusive. ||
|| oldSnapshotThreshold | **string** (int64)

Time before a snapshot is too old to read pages changed after the snapshot was taken.
A value of -1 disables this feature. In milliseconds. ||
|| maxStandbyStreamingDelay | **string** (int64)

Sets the maximum delay before canceling queries when a hot standby server is processing streamed WAL data. In milliseconds. ||
|| constraintExclusion | **enum** (ConstraintExclusion)

Enables the planner to use constraints to optimize queries.

- `CONSTRAINT_EXCLUSION_ON`: Enable planner's use of constraints for all tables.
- `CONSTRAINT_EXCLUSION_OFF`: Disable planner's use of constraints for all tables
- `CONSTRAINT_EXCLUSION_PARTITION`: Only use constraints for child tables and UNION ALL clauses. ||
|| cursorTupleFraction | **number** (double)

Sets the planner's estimate of the fraction of a cursor's rows that will be retrieved. ||
|| fromCollapseLimit | **string** (int64)

Sets the FROM-list size beyond which subqueries are not collapsed.

Acceptable values are 1 to 2147483647, inclusive. ||
|| joinCollapseLimit | **string** (int64)

Sets the FROM-list size beyond which JOIN constructs are not flattened.

Acceptable values are 1 to 2147483647, inclusive. ||
|| forceParallelMode | **enum** (ForceParallelMode)

Forces use of parallel query facilities. If possible, run query using a parallel worker and with parallel restrictions.

- `FORCE_PARALLEL_MODE_ON`: Forces parallel mode for queries considered safe, even when no performance benefit is expected.
- `FORCE_PARALLEL_MODE_OFF`: Uses parallel mode only when the planner expects it to improve performance.
- `FORCE_PARALLEL_MODE_REGRESS`: Behaves like ON, but hides added Gather nodes in EXPLAIN output and
suppresses parallel-worker context lines to stabilize regression-test output. ||
|| clientMinMessages | **enum** (LogLevel)

Sets the message levels that are sent to the client.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinMessages | **enum** (LogLevel)

Sets the message levels that are logged.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinErrorStatement | **enum** (LogLevel)

Causes all statements generating error at or above this level to be logged.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinDurationStatement | **string** (int64)

Sets the minimum execution time above which all statements will be logged. In milliseconds. ||
|| logCheckpoints | **boolean**

Logs each checkpoint. ||
|| logConnections | **boolean**

Logs each successful connection. ||
|| logDisconnections | **boolean**

Logs end of a session, including duration. ||
|| logDuration | **boolean**

Logs the duration of each completed SQL statement.
 ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

Sets the verbosity of logged messages.

- `LOG_ERROR_VERBOSITY_TERSE`: DETAIL, HINT, QUERY, and CONTEXT fields are excluded from the error message.
- `LOG_ERROR_VERBOSITY_DEFAULT`: Default.
- `LOG_ERROR_VERBOSITY_VERBOSE`: Error message includes the SQLSTATE error code, source filename, function name, and the line number where the error occurred. ||
|| logLockWaits | **boolean**

Logs long lock waits. ||
|| logStatement | **enum** (LogStatement)

Sets the type of statements logged.

- `LOG_STATEMENT_NONE`: The filter is disabled, no SQL statements are logged.
- `LOG_STATEMENT_DDL`: System logs DDL statements, e.g., CREATE, ALTER, DROP etc.
- `LOG_STATEMENT_MOD`: System logs ddl-statements along with data modification commands, e.g., INSERT, UPDATE, etc.
- `LOG_STATEMENT_ALL`: System logs all SQL statements. ||
|| logTempFiles | **string** (int64)

Log the use of temporary files larger than this number of kilobytes. ||
|| searchPath | **string**

Sets the schema search order for names that are not schema-qualified. ||
|| rowSecurity | **boolean**

Enable row security. ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

Sets the transaction isolation level of each new transaction.

- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`: This level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.
- `TRANSACTION_ISOLATION_READ_COMMITTED`: On this level query sees only data committed before the query began.
- `TRANSACTION_ISOLATION_REPEATABLE_READ`: On this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).
- `TRANSACTION_ISOLATION_SERIALIZABLE`: This level provides the strictest transaction isolation.
All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction.
If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure. ||
|| statementTimeout | **string** (int64)

Sets the maximum allowed duration of any statement. In milliseconds. ||
|| lockTimeout | **string** (int64)

Sets the maximum allowed duration of any wait for a lock. In milliseconds. ||
|| idleInTransactionSessionTimeout | **string** (int64)

Sets the maximum allowed idle time between queries, when in a transaction. In milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| byteaOutput | **enum** (ByteaOutput)

Sets the output format for bytea.

- `BYTEA_OUTPUT_HEX`: Each byte is represented by two hexadecimal characters, e.g., 'SELECT '\xDEADBEEF';'.
- `BYTEA_OUTPUT_ESCAPED`: Standard PostgreSQL format with ASCII characters only. ||
|| xmlbinary | **enum** (XmlBinary)

Sets how binary values are to be encoded in XML.

- `XML_BINARY_BASE64`: Encodes binary values using Base64.
- `XML_BINARY_HEX`: Encodes binary values using hexadecimal notation. ||
|| xmloption | **enum** (XmlOption)

Sets whether XML data in implicit parsing and serialization operations is to be considered as documents or content fragments.

- `XML_OPTION_DOCUMENT`: Treats an XML value as a complete, well-formed document.
- `XML_OPTION_CONTENT`: Treats an XML value as a content fragment, which may contain multiple top-level elements or character nodes. ||
|| ginPendingListLimit | **string** (int64)

Sets the maximum size of the pending list for GIN index. In bytes. ||
|| deadlockTimeout | **string** (int64)

Sets the time to wait on a lock before checking for deadlock. In milliseconds.

Acceptable values are 1 to 2147483647, inclusive. ||
|| maxLocksPerTransaction | **string** (int64)

Sets the maximum number of locks per transaction. The shared lock table is sized on the assumption that
at most max_locks_per_transaction * max_connections distinct objects will need to be locked at any one time. ||
|| maxPredLocksPerTransaction | **string** (int64)

Sets the maximum number of predicate locks per transaction.The shared predicate lock table is sized on the assumption that
at most max_pred_locks_per_transaction * max_connections distinct objects will need to be locked at any one time. ||
|| arrayNulls | **boolean**

Enable input of NULL elements in arrays. When turned on, unquoted NULL in an array input
value means a null value; otherwise it is taken literally. ||
|| backslashQuote | **enum** (BackslashQuote)

Sets whether \"\\'\" is allowed in string literals.

- `BACKSLASH_QUOTE`: Legacy invalid value. Do not use.
- `BACKSLASH_QUOTE_ON`: Quotation mark can be represented as \'.
- `BACKSLASH_QUOTE_OFF`: Quotation mark can only be represented using the standard SQL syntax ''.
- `BACKSLASH_QUOTE_SAFE_ENCODING`: Representing a quotation mark as \' is only permitted for client encodings where \ is not used for multibyte characters. ||
|| defaultWithOids | **boolean**

WITH OIDS is no longer supported; this can only be false. ||
|| escapeStringWarning | **boolean**

Warn about backslash escapes in ordinary string literals. ||
|| loCompatPrivileges | **boolean**

Enables backward compatibility mode for privilege checks on large objects. Skips privilege checks
when reading or modifying large objects, for compatibility with PostgreSQL releases prior to 9.0. ||
|| operatorPrecedenceWarning | **boolean**

Emit a warning for constructs that changed meaning since PostgreSQL 9.4. ||
|| quoteAllIdentifiers | **boolean**

When generating SQL fragments, quote all identifiers. ||
|| standardConformingStrings | **boolean**

Causes '...' strings to treat backslashes literally. ||
|| synchronizeSeqscans | **boolean**

Enable synchronized sequential scans. ||
|| transformNullEquals | **boolean**

Treats \"expr=NULL\" as \"expr IS NULL\". When turned on, expressions of the form expr = NULL
(or NULL = expr) are treated as expr IS NULL, that is, they return true if expr evaluates to the
null value, and false otherwise. The correct behavior of expr = NULL is to always return null (unknown). ||
|| exitOnError | **boolean**

Terminate session on any error. ||
|| seqPageCost | **number** (double)

Sets the planner's estimate of the cost of a sequentially fetched disk page.

The minimum value is 0. ||
|| randomPageCost | **number** (double)

Sets the planner's estimate of the cost of a nonsequentially fetched disk page.

The minimum value is 0. ||
|| enableBitmapscan | **boolean**

Enables the planner's use of bitmap-scan plans. ||
|| enableHashagg | **boolean**

Enables the planner's use of hashed aggregation plans. ||
|| enableHashjoin | **boolean**

Enables the planner's use of hash join plans. ||
|| enableIndexscan | **boolean**

Enables the planner's use of index-scan plans. ||
|| enableIndexonlyscan | **boolean**

Enables the planner's use of index-only-scan plans. ||
|| enableMaterial | **boolean**

Enables the planner's use of materialization. ||
|| enableMergejoin | **boolean**

Enables the planner's use of merge join plans. ||
|| enableNestloop | **boolean**

Enables the planner's use of nested-loop join plans. ||
|| enableSeqscan | **boolean**

Enables the planner's use of sequential-scan plans. ||
|| enableSort | **boolean**

Enables the planner's use of explicit sort steps. ||
|| enableTidscan | **boolean**

Enables the planner's use of TID scan plans. ||
|| maxParallelWorkers | **string** (int64)

Sets the maximum number of parallel workers that can be active at one time.

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkersPerGather | **string** (int64)

Sets the maximum number of parallel processes per executor node.

Acceptable values are 0 to 1024, inclusive. ||
|| timezone | **string**

Sets the time zone for displaying and interpreting time stamps. ||
|| effectiveIoConcurrency | **string** (int64)

Number of simultaneous requests that can be handled efficiently by the disk subsystem.

Acceptable values are 0 to 1000, inclusive. ||
|| effectiveCacheSize | **string** (int64)

Sets the planner's assumption about the effective size of the disk cache available to a single query. In bytes.

Acceptable values are 1048576 to 549755813888, inclusive. ||
|#

## PostgresqlHostConfig13_1C {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig13_1C}

Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file
parameters which detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/11/runtime-config.html).

#|
||Field | Description ||
|| recoveryMinApplyDelay | **string** (int64)

Sets the minimum delay for applying changes during recovery. In milliseconds. ||
|| sharedBuffers | **string** (int64)

Sets the number of shared memory buffers used by the server. In bytes. ||
|| tempBuffers | **string** (int64)

Sets the maximum number of temporary buffers used by each session. In bytes. ||
|| workMem | **string** (int64)

Sets the maximum memory to be used for query workspaces. This much memory can be used by each
internal sort operation and hash table before switching to temporary disk files. In bytes. ||
|| tempFileLimit | **string** (int64)

Limits the total size of all temporary files used by each process. -1 means no limit. In bytes. ||
|| backendFlushAfter | **string** (int64)

Specifies how much data a backend can write before forcing the operating system to issue the writes. In bytes.

Acceptable values are 0 to 2097152, inclusive. ||
|| oldSnapshotThreshold | **string** (int64)

Time before a snapshot is too old to read pages changed after the snapshot was taken.
A value of -1 disables this feature. In milliseconds. ||
|| maxStandbyStreamingDelay | **string** (int64)

Sets the maximum delay before canceling queries when a hot standby server is processing streamed WAL data. In milliseconds. ||
|| constraintExclusion | **enum** (ConstraintExclusion)

Enables the planner to use constraints to optimize queries.

- `CONSTRAINT_EXCLUSION_ON`: Enable planner's use of constraints for all tables.
- `CONSTRAINT_EXCLUSION_OFF`: Disable planner's use of constraints for all tables
- `CONSTRAINT_EXCLUSION_PARTITION`: Only use constraints for child tables and UNION ALL clauses. ||
|| cursorTupleFraction | **number** (double)

Sets the planner's estimate of the fraction of a cursor's rows that will be retrieved. ||
|| fromCollapseLimit | **string** (int64)

Sets the FROM-list size beyond which subqueries are not collapsed.

Acceptable values are 1 to 2147483647, inclusive. ||
|| joinCollapseLimit | **string** (int64)

Sets the FROM-list size beyond which JOIN constructs are not flattened.

Acceptable values are 1 to 2147483647, inclusive. ||
|| forceParallelMode | **enum** (ForceParallelMode)

Forces use of parallel query facilities. If possible, run query using a parallel worker and with parallel restrictions.

- `FORCE_PARALLEL_MODE_ON`: Forces parallel mode for queries considered safe, even when no performance benefit is expected.
- `FORCE_PARALLEL_MODE_OFF`: Uses parallel mode only when the planner expects it to improve performance.
- `FORCE_PARALLEL_MODE_REGRESS`: Behaves like ON, but hides added Gather nodes in EXPLAIN output and
suppresses parallel-worker context lines to stabilize regression-test output. ||
|| clientMinMessages | **enum** (LogLevel)

Sets the message levels that are sent to the client.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinMessages | **enum** (LogLevel)

Sets the message levels that are logged.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinErrorStatement | **enum** (LogLevel)

Causes all statements generating error at or above this level to be logged.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinDurationStatement | **string** (int64)

Sets the minimum execution time above which all statements will be logged. In milliseconds. ||
|| logCheckpoints | **boolean**

Logs each checkpoint. ||
|| logConnections | **boolean**

Logs each successful connection. ||
|| logDisconnections | **boolean**

Logs end of a session, including duration. ||
|| logDuration | **boolean**

Logs the duration of each completed SQL statement.
 ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

Sets the verbosity of logged messages.

- `LOG_ERROR_VERBOSITY_TERSE`: DETAIL, HINT, QUERY, and CONTEXT fields are excluded from the error message.
- `LOG_ERROR_VERBOSITY_DEFAULT`: Default.
- `LOG_ERROR_VERBOSITY_VERBOSE`: Error message includes the SQLSTATE error code, source filename, function name, and the line number where the error occurred. ||
|| logLockWaits | **boolean**

Logs long lock waits. ||
|| logStatement | **enum** (LogStatement)

Sets the type of statements logged.

- `LOG_STATEMENT_NONE`: The filter is disabled, no SQL statements are logged.
- `LOG_STATEMENT_DDL`: System logs DDL statements, e.g., CREATE, ALTER, DROP etc.
- `LOG_STATEMENT_MOD`: System logs ddl-statements along with data modification commands, e.g., INSERT, UPDATE, etc.
- `LOG_STATEMENT_ALL`: System logs all SQL statements. ||
|| logTempFiles | **string** (int64)

Log the use of temporary files larger than this number of kilobytes. ||
|| searchPath | **string**

Sets the schema search order for names that are not schema-qualified. ||
|| rowSecurity | **boolean**

Enable row security. ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

Sets the transaction isolation level of each new transaction.

- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`: This level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.
- `TRANSACTION_ISOLATION_READ_COMMITTED`: On this level query sees only data committed before the query began.
- `TRANSACTION_ISOLATION_REPEATABLE_READ`: On this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).
- `TRANSACTION_ISOLATION_SERIALIZABLE`: This level provides the strictest transaction isolation.
All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction.
If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure. ||
|| statementTimeout | **string** (int64)

Sets the maximum allowed duration of any statement. In milliseconds. ||
|| lockTimeout | **string** (int64)

Sets the maximum allowed duration of any wait for a lock. In milliseconds. ||
|| idleInTransactionSessionTimeout | **string** (int64)

Sets the maximum allowed idle time between queries, when in a transaction. In milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| byteaOutput | **enum** (ByteaOutput)

Sets the output format for bytea.

- `BYTEA_OUTPUT_HEX`: Each byte is represented by two hexadecimal characters, e.g., 'SELECT '\xDEADBEEF';'.
- `BYTEA_OUTPUT_ESCAPED`: Standard PostgreSQL format with ASCII characters only. ||
|| xmlbinary | **enum** (XmlBinary)

Sets how binary values are to be encoded in XML.

- `XML_BINARY_BASE64`: Encodes binary values using Base64.
- `XML_BINARY_HEX`: Encodes binary values using hexadecimal notation. ||
|| xmloption | **enum** (XmlOption)

Sets whether XML data in implicit parsing and serialization operations is to be considered as documents or content fragments.

- `XML_OPTION_DOCUMENT`: Treats an XML value as a complete, well-formed document.
- `XML_OPTION_CONTENT`: Treats an XML value as a content fragment, which may contain multiple top-level elements or character nodes. ||
|| ginPendingListLimit | **string** (int64)

Sets the maximum size of the pending list for GIN index. In bytes. ||
|| deadlockTimeout | **string** (int64)

Sets the time to wait on a lock before checking for deadlock. In milliseconds.

Acceptable values are 1 to 2147483647, inclusive. ||
|| maxLocksPerTransaction | **string** (int64)

Sets the maximum number of locks per transaction. The shared lock table is sized on the assumption that
at most max_locks_per_transaction * max_connections distinct objects will need to be locked at any one time. ||
|| maxPredLocksPerTransaction | **string** (int64)

Sets the maximum number of predicate locks per transaction.The shared predicate lock table is sized on the assumption that
at most max_pred_locks_per_transaction * max_connections distinct objects will need to be locked at any one time. ||
|| arrayNulls | **boolean**

Enable input of NULL elements in arrays. When turned on, unquoted NULL in an array input
value means a null value; otherwise it is taken literally. ||
|| backslashQuote | **enum** (BackslashQuote)

Sets whether \"\\'\" is allowed in string literals.

- `BACKSLASH_QUOTE`: Legacy invalid value. Do not use.
- `BACKSLASH_QUOTE_ON`: Quotation mark can be represented as \'.
- `BACKSLASH_QUOTE_OFF`: Quotation mark can only be represented using the standard SQL syntax ''.
- `BACKSLASH_QUOTE_SAFE_ENCODING`: Representing a quotation mark as \' is only permitted for client encodings where \ is not used for multibyte characters. ||
|| defaultWithOids | **boolean**

WITH OIDS is no longer supported; this can only be false. ||
|| escapeStringWarning | **boolean**

Warn about backslash escapes in ordinary string literals. ||
|| loCompatPrivileges | **boolean**

Enables backward compatibility mode for privilege checks on large objects. Skips privilege checks
when reading or modifying large objects, for compatibility with PostgreSQL releases prior to 9.0. ||
|| operatorPrecedenceWarning | **boolean**

Emit a warning for constructs that changed meaning since PostgreSQL 9.4. ||
|| quoteAllIdentifiers | **boolean**

When generating SQL fragments, quote all identifiers. ||
|| standardConformingStrings | **boolean**

Causes '...' strings to treat backslashes literally. ||
|| synchronizeSeqscans | **boolean**

Enable synchronized sequential scans. ||
|| transformNullEquals | **boolean**

Treats \"expr=NULL\" as \"expr IS NULL\". When turned on, expressions of the form expr = NULL
(or NULL = expr) are treated as expr IS NULL, that is, they return true if expr evaluates to the
null value, and false otherwise. The correct behavior of expr = NULL is to always return null (unknown). ||
|| exitOnError | **boolean**

Terminate session on any error. ||
|| seqPageCost | **number** (double)

Sets the planner's estimate of the cost of a sequentially fetched disk page.

The minimum value is 0. ||
|| randomPageCost | **number** (double)

Sets the planner's estimate of the cost of a nonsequentially fetched disk page.

The minimum value is 0. ||
|| enableBitmapscan | **boolean**

Enables the planner's use of bitmap-scan plans. ||
|| enableHashagg | **boolean**

Enables the planner's use of hashed aggregation plans. ||
|| enableHashjoin | **boolean**

Enables the planner's use of hash join plans. ||
|| enableIndexscan | **boolean**

Enables the planner's use of index-scan plans. ||
|| enableIndexonlyscan | **boolean**

Enables the planner's use of index-only-scan plans. ||
|| enableMaterial | **boolean**

Enables the planner's use of materialization. ||
|| enableMergejoin | **boolean**

Enables the planner's use of merge join plans. ||
|| enableNestloop | **boolean**

Enables the planner's use of nested-loop join plans. ||
|| enableSeqscan | **boolean**

Enables the planner's use of sequential-scan plans. ||
|| enableSort | **boolean**

Enables the planner's use of explicit sort steps. ||
|| enableTidscan | **boolean**

Enables the planner's use of TID scan plans. ||
|| maxParallelWorkers | **string** (int64)

Sets the maximum number of parallel workers that can be active at one time.

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkersPerGather | **string** (int64)

Sets the maximum number of parallel processes per executor node.

Acceptable values are 0 to 1024, inclusive. ||
|| timezone | **string**

Sets the time zone for displaying and interpreting time stamps. ||
|| effectiveIoConcurrency | **string** (int64)

Number of simultaneous requests that can be handled efficiently by the disk subsystem.

Acceptable values are 0 to 1000, inclusive. ||
|| effectiveCacheSize | **string** (int64)

Sets the planner's assumption about the effective size of the disk cache available to a single query. In bytes.

Acceptable values are 1048576 to 549755813888, inclusive. ||
|#

## PostgresqlHostConfig14 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig14}

Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file
parameters which detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/11/runtime-config.html).

#|
||Field | Description ||
|| recoveryMinApplyDelay | **string** (int64)

Sets the minimum delay for applying changes during recovery. In milliseconds. ||
|| sharedBuffers | **string** (int64)

Sets the number of shared memory buffers used by the server. In bytes. ||
|| tempBuffers | **string** (int64)

Sets the maximum number of temporary buffers used by each session. In bytes. ||
|| workMem | **string** (int64)

Sets the maximum memory to be used for query workspaces. This much memory can be used by each
internal sort operation and hash table before switching to temporary disk files. In bytes. ||
|| tempFileLimit | **string** (int64)

Limits the total size of all temporary files used by each process. -1 means no limit. In bytes. ||
|| backendFlushAfter | **string** (int64)

Specifies how much data a backend can write before forcing the operating system to issue the writes. In bytes.

Acceptable values are 0 to 2097152, inclusive. ||
|| oldSnapshotThreshold | **string** (int64)

Time before a snapshot is too old to read pages changed after the snapshot was taken.
A value of -1 disables this feature. In milliseconds. ||
|| maxStandbyStreamingDelay | **string** (int64)

Sets the maximum delay before canceling queries when a hot standby server is processing streamed WAL data. In milliseconds. ||
|| constraintExclusion | **enum** (ConstraintExclusion)

Enables the planner to use constraints to optimize queries.

- `CONSTRAINT_EXCLUSION_ON`: Enable planner's use of constraints for all tables.
- `CONSTRAINT_EXCLUSION_OFF`: Disable planner's use of constraints for all tables
- `CONSTRAINT_EXCLUSION_PARTITION`: Only use constraints for child tables and UNION ALL clauses. ||
|| cursorTupleFraction | **number** (double)

Sets the planner's estimate of the fraction of a cursor's rows that will be retrieved. ||
|| fromCollapseLimit | **string** (int64)

Sets the FROM-list size beyond which subqueries are not collapsed.

Acceptable values are 1 to 2147483647, inclusive. ||
|| joinCollapseLimit | **string** (int64)

Sets the FROM-list size beyond which JOIN constructs are not flattened.

Acceptable values are 1 to 2147483647, inclusive. ||
|| forceParallelMode | **enum** (ForceParallelMode)

Forces use of parallel query facilities. If possible, run query using a parallel worker and with parallel restrictions.

- `FORCE_PARALLEL_MODE_ON`: Forces parallel mode for queries considered safe, even when no performance benefit is expected.
- `FORCE_PARALLEL_MODE_OFF`: Uses parallel mode only when the planner expects it to improve performance.
- `FORCE_PARALLEL_MODE_REGRESS`: Behaves like ON, but hides added Gather nodes in EXPLAIN output and
suppresses parallel-worker context lines to stabilize regression-test output. ||
|| clientMinMessages | **enum** (LogLevel)

Sets the message levels that are sent to the client.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinMessages | **enum** (LogLevel)

Sets the message levels that are logged.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinErrorStatement | **enum** (LogLevel)

Causes all statements generating error at or above this level to be logged.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinDurationStatement | **string** (int64)

Sets the minimum execution time above which all statements will be logged. In milliseconds. ||
|| logCheckpoints | **boolean**

Logs each checkpoint. ||
|| logConnections | **boolean**

Logs each successful connection. ||
|| logDisconnections | **boolean**

Logs end of a session, including duration. ||
|| logDuration | **boolean**

Logs the duration of each completed SQL statement.
 ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

Sets the verbosity of logged messages.

- `LOG_ERROR_VERBOSITY_TERSE`: DETAIL, HINT, QUERY, and CONTEXT fields are excluded from the error message.
- `LOG_ERROR_VERBOSITY_DEFAULT`: Default.
- `LOG_ERROR_VERBOSITY_VERBOSE`: Error message includes the SQLSTATE error code, source filename, function name, and the line number where the error occurred. ||
|| logLockWaits | **boolean**

Logs long lock waits. ||
|| logStatement | **enum** (LogStatement)

Sets the type of statements logged.

- `LOG_STATEMENT_NONE`: The filter is disabled, no SQL statements are logged.
- `LOG_STATEMENT_DDL`: System logs DDL statements, e.g., CREATE, ALTER, DROP etc.
- `LOG_STATEMENT_MOD`: System logs ddl-statements along with data modification commands, e.g., INSERT, UPDATE, etc.
- `LOG_STATEMENT_ALL`: System logs all SQL statements. ||
|| logTempFiles | **string** (int64)

Log the use of temporary files larger than this number of kilobytes. ||
|| searchPath | **string**

Sets the schema search order for names that are not schema-qualified. ||
|| rowSecurity | **boolean**

Enable row security. ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

Sets the transaction isolation level of each new transaction.

- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`: This level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.
- `TRANSACTION_ISOLATION_READ_COMMITTED`: On this level query sees only data committed before the query began.
- `TRANSACTION_ISOLATION_REPEATABLE_READ`: On this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).
- `TRANSACTION_ISOLATION_SERIALIZABLE`: This level provides the strictest transaction isolation.
All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction.
If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure. ||
|| statementTimeout | **string** (int64)

Sets the maximum allowed duration of any statement. In milliseconds. ||
|| lockTimeout | **string** (int64)

Sets the maximum allowed duration of any wait for a lock. In milliseconds. ||
|| idleInTransactionSessionTimeout | **string** (int64)

Sets the maximum allowed idle time between queries, when in a transaction. In milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| byteaOutput | **enum** (ByteaOutput)

Sets the output format for bytea.

- `BYTEA_OUTPUT_HEX`: Each byte is represented by two hexadecimal characters, e.g., 'SELECT '\xDEADBEEF';'.
- `BYTEA_OUTPUT_ESCAPED`: Standard PostgreSQL format with ASCII characters only. ||
|| xmlbinary | **enum** (XmlBinary)

Sets how binary values are to be encoded in XML.

- `XML_BINARY_BASE64`: Encodes binary values using Base64.
- `XML_BINARY_HEX`: Encodes binary values using hexadecimal notation. ||
|| xmloption | **enum** (XmlOption)

Sets whether XML data in implicit parsing and serialization operations is to be considered as documents or content fragments.

- `XML_OPTION_DOCUMENT`: Treats an XML value as a complete, well-formed document.
- `XML_OPTION_CONTENT`: Treats an XML value as a content fragment, which may contain multiple top-level elements or character nodes. ||
|| ginPendingListLimit | **string** (int64)

Sets the maximum size of the pending list for GIN index. In bytes. ||
|| deadlockTimeout | **string** (int64)

Sets the time to wait on a lock before checking for deadlock. In milliseconds.

Acceptable values are 1 to 2147483647, inclusive. ||
|| maxLocksPerTransaction | **string** (int64)

Sets the maximum number of locks per transaction. The shared lock table is sized on the assumption that
at most max_locks_per_transaction * max_connections distinct objects will need to be locked at any one time. ||
|| maxPredLocksPerTransaction | **string** (int64)

Sets the maximum number of predicate locks per transaction.The shared predicate lock table is sized on the assumption that
at most max_pred_locks_per_transaction * max_connections distinct objects will need to be locked at any one time. ||
|| arrayNulls | **boolean**

Enable input of NULL elements in arrays. When turned on, unquoted NULL in an array input
value means a null value; otherwise it is taken literally. ||
|| backslashQuote | **enum** (BackslashQuote)

Sets whether \"\\'\" is allowed in string literals.

- `BACKSLASH_QUOTE`: Legacy invalid value. Do not use.
- `BACKSLASH_QUOTE_ON`: Quotation mark can be represented as \'.
- `BACKSLASH_QUOTE_OFF`: Quotation mark can only be represented using the standard SQL syntax ''.
- `BACKSLASH_QUOTE_SAFE_ENCODING`: Representing a quotation mark as \' is only permitted for client encodings where \ is not used for multibyte characters. ||
|| defaultWithOids | **boolean**

WITH OIDS is no longer supported; this can only be false. ||
|| escapeStringWarning | **boolean**

Warn about backslash escapes in ordinary string literals. ||
|| loCompatPrivileges | **boolean**

Enables backward compatibility mode for privilege checks on large objects. Skips privilege checks
when reading or modifying large objects, for compatibility with PostgreSQL releases prior to 9.0. ||
|| quoteAllIdentifiers | **boolean**

When generating SQL fragments, quote all identifiers. ||
|| standardConformingStrings | **boolean**

Causes '...' strings to treat backslashes literally. ||
|| synchronizeSeqscans | **boolean**

Enable synchronized sequential scans. ||
|| transformNullEquals | **boolean**

Treats \"expr=NULL\" as \"expr IS NULL\". When turned on, expressions of the form expr = NULL
(or NULL = expr) are treated as expr IS NULL, that is, they return true if expr evaluates to the
null value, and false otherwise. The correct behavior of expr = NULL is to always return null (unknown). ||
|| exitOnError | **boolean**

Terminate session on any error. ||
|| seqPageCost | **number** (double)

Sets the planner's estimate of the cost of a sequentially fetched disk page.

The minimum value is 0. ||
|| randomPageCost | **number** (double)

Sets the planner's estimate of the cost of a nonsequentially fetched disk page.

The minimum value is 0. ||
|| enableBitmapscan | **boolean**

Enables the planner's use of bitmap-scan plans. ||
|| enableHashagg | **boolean**

Enables the planner's use of hashed aggregation plans. ||
|| enableHashjoin | **boolean**

Enables the planner's use of hash join plans. ||
|| enableIndexscan | **boolean**

Enables the planner's use of index-scan plans. ||
|| enableIndexonlyscan | **boolean**

Enables the planner's use of index-only-scan plans. ||
|| enableMaterial | **boolean**

Enables the planner's use of materialization. ||
|| enableMergejoin | **boolean**

Enables the planner's use of merge join plans. ||
|| enableNestloop | **boolean**

Enables the planner's use of nested-loop join plans. ||
|| enableSeqscan | **boolean**

Enables the planner's use of sequential-scan plans. ||
|| enableSort | **boolean**

Enables the planner's use of explicit sort steps. ||
|| enableTidscan | **boolean**

Enables the planner's use of TID scan plans. ||
|| maxParallelWorkers | **string** (int64)

Sets the maximum number of parallel workers that can be active at one time.

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkersPerGather | **string** (int64)

Sets the maximum number of parallel processes per executor node.

Acceptable values are 0 to 1024, inclusive. ||
|| timezone | **string**

Sets the time zone for displaying and interpreting time stamps. ||
|| effectiveIoConcurrency | **string** (int64)

Number of simultaneous requests that can be handled efficiently by the disk subsystem.

Acceptable values are 0 to 1000, inclusive. ||
|| effectiveCacheSize | **string** (int64)

Sets the planner's assumption about the effective size of the disk cache available to a single query. In bytes.

Acceptable values are 1048576 to 549755813888, inclusive. ||
|| idleSessionTimeout | **string** (int64)

Sets the maximum allowed idle time between queries, when not in a transaction. In milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|#

## PostgresqlHostConfig14_1C {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig14_1C}

Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file
parameters which detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/11/runtime-config.html).

#|
||Field | Description ||
|| recoveryMinApplyDelay | **string** (int64)

Sets the minimum delay for applying changes during recovery. In milliseconds. ||
|| sharedBuffers | **string** (int64)

Sets the number of shared memory buffers used by the server. In bytes. ||
|| tempBuffers | **string** (int64)

Sets the maximum number of temporary buffers used by each session. In bytes. ||
|| workMem | **string** (int64)

Sets the maximum memory to be used for query workspaces. This much memory can be used by each
internal sort operation and hash table before switching to temporary disk files. In bytes. ||
|| tempFileLimit | **string** (int64)

Limits the total size of all temporary files used by each process. -1 means no limit. In bytes. ||
|| backendFlushAfter | **string** (int64)

Specifies how much data a backend can write before forcing the operating system to issue the writes. In bytes.

Acceptable values are 0 to 2097152, inclusive. ||
|| oldSnapshotThreshold | **string** (int64)

Time before a snapshot is too old to read pages changed after the snapshot was taken.
A value of -1 disables this feature. In milliseconds. ||
|| maxStandbyStreamingDelay | **string** (int64)

Sets the maximum delay before canceling queries when a hot standby server is processing streamed WAL data. In milliseconds. ||
|| constraintExclusion | **enum** (ConstraintExclusion)

Enables the planner to use constraints to optimize queries.

- `CONSTRAINT_EXCLUSION_ON`: Enable planner's use of constraints for all tables.
- `CONSTRAINT_EXCLUSION_OFF`: Disable planner's use of constraints for all tables
- `CONSTRAINT_EXCLUSION_PARTITION`: Only use constraints for child tables and UNION ALL clauses. ||
|| cursorTupleFraction | **number** (double)

Sets the planner's estimate of the fraction of a cursor's rows that will be retrieved. ||
|| fromCollapseLimit | **string** (int64)

Sets the FROM-list size beyond which subqueries are not collapsed.

Acceptable values are 1 to 2147483647, inclusive. ||
|| joinCollapseLimit | **string** (int64)

Sets the FROM-list size beyond which JOIN constructs are not flattened.

Acceptable values are 1 to 2147483647, inclusive. ||
|| forceParallelMode | **enum** (ForceParallelMode)

Forces use of parallel query facilities. If possible, run query using a parallel worker and with parallel restrictions.

- `FORCE_PARALLEL_MODE_ON`: Forces parallel mode for queries considered safe, even when no performance benefit is expected.
- `FORCE_PARALLEL_MODE_OFF`: Uses parallel mode only when the planner expects it to improve performance.
- `FORCE_PARALLEL_MODE_REGRESS`: Behaves like ON, but hides added Gather nodes in EXPLAIN output and
suppresses parallel-worker context lines to stabilize regression-test output. ||
|| clientMinMessages | **enum** (LogLevel)

Sets the message levels that are sent to the client.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinMessages | **enum** (LogLevel)

Sets the message levels that are logged.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinErrorStatement | **enum** (LogLevel)

Causes all statements generating error at or above this level to be logged.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinDurationStatement | **string** (int64)

Sets the minimum execution time above which all statements will be logged. In milliseconds. ||
|| logCheckpoints | **boolean**

Logs each checkpoint. ||
|| logConnections | **boolean**

Logs each successful connection. ||
|| logDisconnections | **boolean**

Logs end of a session, including duration. ||
|| logDuration | **boolean**

Logs the duration of each completed SQL statement.
 ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

Sets the verbosity of logged messages.

- `LOG_ERROR_VERBOSITY_TERSE`: DETAIL, HINT, QUERY, and CONTEXT fields are excluded from the error message.
- `LOG_ERROR_VERBOSITY_DEFAULT`: Default.
- `LOG_ERROR_VERBOSITY_VERBOSE`: Error message includes the SQLSTATE error code, source filename, function name, and the line number where the error occurred. ||
|| logLockWaits | **boolean**

Logs long lock waits. ||
|| logStatement | **enum** (LogStatement)

Sets the type of statements logged.

- `LOG_STATEMENT_NONE`: The filter is disabled, no SQL statements are logged.
- `LOG_STATEMENT_DDL`: System logs DDL statements, e.g., CREATE, ALTER, DROP etc.
- `LOG_STATEMENT_MOD`: System logs ddl-statements along with data modification commands, e.g., INSERT, UPDATE, etc.
- `LOG_STATEMENT_ALL`: System logs all SQL statements. ||
|| logTempFiles | **string** (int64)

Log the use of temporary files larger than this number of kilobytes. ||
|| searchPath | **string**

Sets the schema search order for names that are not schema-qualified. ||
|| rowSecurity | **boolean**

Enable row security. ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

Sets the transaction isolation level of each new transaction.

- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`: This level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.
- `TRANSACTION_ISOLATION_READ_COMMITTED`: On this level query sees only data committed before the query began.
- `TRANSACTION_ISOLATION_REPEATABLE_READ`: On this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).
- `TRANSACTION_ISOLATION_SERIALIZABLE`: This level provides the strictest transaction isolation.
All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction.
If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure. ||
|| statementTimeout | **string** (int64)

Sets the maximum allowed duration of any statement. In milliseconds. ||
|| lockTimeout | **string** (int64)

Sets the maximum allowed duration of any wait for a lock. In milliseconds. ||
|| idleInTransactionSessionTimeout | **string** (int64)

Sets the maximum allowed idle time between queries, when in a transaction. In milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| byteaOutput | **enum** (ByteaOutput)

Sets the output format for bytea.

- `BYTEA_OUTPUT_HEX`: Each byte is represented by two hexadecimal characters, e.g., 'SELECT '\xDEADBEEF';'.
- `BYTEA_OUTPUT_ESCAPED`: Standard PostgreSQL format with ASCII characters only. ||
|| xmlbinary | **enum** (XmlBinary)

Sets how binary values are to be encoded in XML.

- `XML_BINARY_BASE64`: Encodes binary values using Base64.
- `XML_BINARY_HEX`: Encodes binary values using hexadecimal notation. ||
|| xmloption | **enum** (XmlOption)

Sets whether XML data in implicit parsing and serialization operations is to be considered as documents or content fragments.

- `XML_OPTION_DOCUMENT`: Treats an XML value as a complete, well-formed document.
- `XML_OPTION_CONTENT`: Treats an XML value as a content fragment, which may contain multiple top-level elements or character nodes. ||
|| ginPendingListLimit | **string** (int64)

Sets the maximum size of the pending list for GIN index. In bytes. ||
|| deadlockTimeout | **string** (int64)

Sets the time to wait on a lock before checking for deadlock. In milliseconds.

Acceptable values are 1 to 2147483647, inclusive. ||
|| maxLocksPerTransaction | **string** (int64)

Sets the maximum number of locks per transaction. The shared lock table is sized on the assumption that
at most max_locks_per_transaction * max_connections distinct objects will need to be locked at any one time. ||
|| maxPredLocksPerTransaction | **string** (int64)

Sets the maximum number of predicate locks per transaction.The shared predicate lock table is sized on the assumption that
at most max_pred_locks_per_transaction * max_connections distinct objects will need to be locked at any one time. ||
|| arrayNulls | **boolean**

Enable input of NULL elements in arrays. When turned on, unquoted NULL in an array input
value means a null value; otherwise it is taken literally. ||
|| backslashQuote | **enum** (BackslashQuote)

Sets whether \"\\'\" is allowed in string literals.

- `BACKSLASH_QUOTE`: Legacy invalid value. Do not use.
- `BACKSLASH_QUOTE_ON`: Quotation mark can be represented as \'.
- `BACKSLASH_QUOTE_OFF`: Quotation mark can only be represented using the standard SQL syntax ''.
- `BACKSLASH_QUOTE_SAFE_ENCODING`: Representing a quotation mark as \' is only permitted for client encodings where \ is not used for multibyte characters. ||
|| defaultWithOids | **boolean**

WITH OIDS is no longer supported; this can only be false. ||
|| escapeStringWarning | **boolean**

Warn about backslash escapes in ordinary string literals. ||
|| loCompatPrivileges | **boolean**

Enables backward compatibility mode for privilege checks on large objects. Skips privilege checks
when reading or modifying large objects, for compatibility with PostgreSQL releases prior to 9.0. ||
|| quoteAllIdentifiers | **boolean**

When generating SQL fragments, quote all identifiers. ||
|| standardConformingStrings | **boolean**

Causes '...' strings to treat backslashes literally. ||
|| synchronizeSeqscans | **boolean**

Enable synchronized sequential scans. ||
|| transformNullEquals | **boolean**

Treats \"expr=NULL\" as \"expr IS NULL\". When turned on, expressions of the form expr = NULL
(or NULL = expr) are treated as expr IS NULL, that is, they return true if expr evaluates to the
null value, and false otherwise. The correct behavior of expr = NULL is to always return null (unknown). ||
|| exitOnError | **boolean**

Terminate session on any error. ||
|| seqPageCost | **number** (double)

Sets the planner's estimate of the cost of a sequentially fetched disk page.

The minimum value is 0. ||
|| randomPageCost | **number** (double)

Sets the planner's estimate of the cost of a nonsequentially fetched disk page.

The minimum value is 0. ||
|| enableBitmapscan | **boolean**

Enables the planner's use of bitmap-scan plans. ||
|| enableHashagg | **boolean**

Enables the planner's use of hashed aggregation plans. ||
|| enableHashjoin | **boolean**

Enables the planner's use of hash join plans. ||
|| enableIndexscan | **boolean**

Enables the planner's use of index-scan plans. ||
|| enableIndexonlyscan | **boolean**

Enables the planner's use of index-only-scan plans. ||
|| enableMaterial | **boolean**

Enables the planner's use of materialization. ||
|| enableMergejoin | **boolean**

Enables the planner's use of merge join plans. ||
|| enableNestloop | **boolean**

Enables the planner's use of nested-loop join plans. ||
|| enableSeqscan | **boolean**

Enables the planner's use of sequential-scan plans. ||
|| enableSort | **boolean**

Enables the planner's use of explicit sort steps. ||
|| enableTidscan | **boolean**

Enables the planner's use of TID scan plans. ||
|| maxParallelWorkers | **string** (int64)

Sets the maximum number of parallel workers that can be active at one time.

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkersPerGather | **string** (int64)

Sets the maximum number of parallel processes per executor node.

Acceptable values are 0 to 1024, inclusive. ||
|| timezone | **string**

Sets the time zone for displaying and interpreting time stamps. ||
|| effectiveIoConcurrency | **string** (int64)

Number of simultaneous requests that can be handled efficiently by the disk subsystem.

Acceptable values are 0 to 1000, inclusive. ||
|| effectiveCacheSize | **string** (int64)

Sets the planner's assumption about the effective size of the disk cache available to a single query. In bytes.

Acceptable values are 1048576 to 549755813888, inclusive. ||
|| idleSessionTimeout | **string** (int64)

Sets the maximum allowed idle time between queries, when not in a transaction. In milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|#

## PostgresqlHostConfig15 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig15}

Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file
parameters which detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/11/runtime-config.html).

#|
||Field | Description ||
|| recoveryMinApplyDelay | **string** (int64)

Sets the minimum delay for applying changes during recovery. In milliseconds. ||
|| sharedBuffers | **string** (int64)

Sets the number of shared memory buffers used by the server. In bytes. ||
|| tempBuffers | **string** (int64)

Sets the maximum number of temporary buffers used by each session. In bytes. ||
|| workMem | **string** (int64)

Sets the maximum memory to be used for query workspaces. This much memory can be used by each
internal sort operation and hash table before switching to temporary disk files. In bytes. ||
|| tempFileLimit | **string** (int64)

Limits the total size of all temporary files used by each process. -1 means no limit. In bytes. ||
|| backendFlushAfter | **string** (int64)

Specifies how much data a backend can write before forcing the operating system to issue the writes. In bytes.

Acceptable values are 0 to 2097152, inclusive. ||
|| oldSnapshotThreshold | **string** (int64)

Time before a snapshot is too old to read pages changed after the snapshot was taken.
A value of -1 disables this feature. In milliseconds. ||
|| maxStandbyStreamingDelay | **string** (int64)

Sets the maximum delay before canceling queries when a hot standby server is processing streamed WAL data. In milliseconds. ||
|| constraintExclusion | **enum** (ConstraintExclusion)

Enables the planner to use constraints to optimize queries.

- `CONSTRAINT_EXCLUSION_ON`: Enable planner's use of constraints for all tables.
- `CONSTRAINT_EXCLUSION_OFF`: Disable planner's use of constraints for all tables
- `CONSTRAINT_EXCLUSION_PARTITION`: Only use constraints for child tables and UNION ALL clauses. ||
|| cursorTupleFraction | **number** (double)

Sets the planner's estimate of the fraction of a cursor's rows that will be retrieved. ||
|| fromCollapseLimit | **string** (int64)

Sets the FROM-list size beyond which subqueries are not collapsed.

Acceptable values are 1 to 2147483647, inclusive. ||
|| joinCollapseLimit | **string** (int64)

Sets the FROM-list size beyond which JOIN constructs are not flattened.

Acceptable values are 1 to 2147483647, inclusive. ||
|| forceParallelMode | **enum** (ForceParallelMode)

Forces use of parallel query facilities. If possible, run query using a parallel worker and with parallel restrictions.

- `FORCE_PARALLEL_MODE_ON`: Forces parallel mode for queries considered safe, even when no performance benefit is expected.
- `FORCE_PARALLEL_MODE_OFF`: Uses parallel mode only when the planner expects it to improve performance.
- `FORCE_PARALLEL_MODE_REGRESS`: Behaves like ON, but hides added Gather nodes in EXPLAIN output and
suppresses parallel-worker context lines to stabilize regression-test output. ||
|| clientMinMessages | **enum** (LogLevel)

Sets the message levels that are sent to the client.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinMessages | **enum** (LogLevel)

Sets the message levels that are logged.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinErrorStatement | **enum** (LogLevel)

Causes all statements generating error at or above this level to be logged.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinDurationStatement | **string** (int64)

Sets the minimum execution time above which all statements will be logged. In milliseconds. ||
|| logCheckpoints | **boolean**

Logs each checkpoint. ||
|| logConnections | **boolean**

Logs each successful connection. ||
|| logDisconnections | **boolean**

Logs end of a session, including duration. ||
|| logDuration | **boolean**

Logs the duration of each completed SQL statement.
 ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

Sets the verbosity of logged messages.

- `LOG_ERROR_VERBOSITY_TERSE`: DETAIL, HINT, QUERY, and CONTEXT fields are excluded from the error message.
- `LOG_ERROR_VERBOSITY_DEFAULT`: Default.
- `LOG_ERROR_VERBOSITY_VERBOSE`: Error message includes the SQLSTATE error code, source filename, function name, and the line number where the error occurred. ||
|| logLockWaits | **boolean**

Logs long lock waits. ||
|| logStatement | **enum** (LogStatement)

Sets the type of statements logged.

- `LOG_STATEMENT_NONE`: The filter is disabled, no SQL statements are logged.
- `LOG_STATEMENT_DDL`: System logs DDL statements, e.g., CREATE, ALTER, DROP etc.
- `LOG_STATEMENT_MOD`: System logs ddl-statements along with data modification commands, e.g., INSERT, UPDATE, etc.
- `LOG_STATEMENT_ALL`: System logs all SQL statements. ||
|| logTempFiles | **string** (int64)

Log the use of temporary files larger than this number of kilobytes. ||
|| searchPath | **string**

Sets the schema search order for names that are not schema-qualified. ||
|| rowSecurity | **boolean**

Enable row security. ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

Sets the transaction isolation level of each new transaction.

- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`: This level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.
- `TRANSACTION_ISOLATION_READ_COMMITTED`: On this level query sees only data committed before the query began.
- `TRANSACTION_ISOLATION_REPEATABLE_READ`: On this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).
- `TRANSACTION_ISOLATION_SERIALIZABLE`: This level provides the strictest transaction isolation.
All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction.
If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure. ||
|| statementTimeout | **string** (int64)

Sets the maximum allowed duration of any statement. In milliseconds. ||
|| lockTimeout | **string** (int64)

Sets the maximum allowed duration of any wait for a lock. In milliseconds. ||
|| idleInTransactionSessionTimeout | **string** (int64)

Sets the maximum allowed idle time between queries, when in a transaction. In milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| byteaOutput | **enum** (ByteaOutput)

Sets the output format for bytea.

- `BYTEA_OUTPUT_HEX`: Each byte is represented by two hexadecimal characters, e.g., 'SELECT '\xDEADBEEF';'.
- `BYTEA_OUTPUT_ESCAPED`: Standard PostgreSQL format with ASCII characters only. ||
|| xmlbinary | **enum** (XmlBinary)

Sets how binary values are to be encoded in XML.

- `XML_BINARY_BASE64`: Encodes binary values using Base64.
- `XML_BINARY_HEX`: Encodes binary values using hexadecimal notation. ||
|| xmloption | **enum** (XmlOption)

Sets whether XML data in implicit parsing and serialization operations is to be considered as documents or content fragments.

- `XML_OPTION_DOCUMENT`: Treats an XML value as a complete, well-formed document.
- `XML_OPTION_CONTENT`: Treats an XML value as a content fragment, which may contain multiple top-level elements or character nodes. ||
|| ginPendingListLimit | **string** (int64)

Sets the maximum size of the pending list for GIN index. In bytes. ||
|| deadlockTimeout | **string** (int64)

Sets the time to wait on a lock before checking for deadlock. In milliseconds.

Acceptable values are 1 to 2147483647, inclusive. ||
|| maxLocksPerTransaction | **string** (int64)

Sets the maximum number of locks per transaction. The shared lock table is sized on the assumption that
at most max_locks_per_transaction * max_connections distinct objects will need to be locked at any one time. ||
|| maxPredLocksPerTransaction | **string** (int64)

Sets the maximum number of predicate locks per transaction.The shared predicate lock table is sized on the assumption that
at most max_pred_locks_per_transaction * max_connections distinct objects will need to be locked at any one time. ||
|| arrayNulls | **boolean**

Enable input of NULL elements in arrays. When turned on, unquoted NULL in an array input
value means a null value; otherwise it is taken literally. ||
|| backslashQuote | **enum** (BackslashQuote)

Sets whether \"\\'\" is allowed in string literals.

- `BACKSLASH_QUOTE`: Legacy invalid value. Do not use.
- `BACKSLASH_QUOTE_ON`: Quotation mark can be represented as \'.
- `BACKSLASH_QUOTE_OFF`: Quotation mark can only be represented using the standard SQL syntax ''.
- `BACKSLASH_QUOTE_SAFE_ENCODING`: Representing a quotation mark as \' is only permitted for client encodings where \ is not used for multibyte characters. ||
|| defaultWithOids | **boolean**

WITH OIDS is no longer supported; this can only be false. ||
|| escapeStringWarning | **boolean**

Warn about backslash escapes in ordinary string literals. ||
|| loCompatPrivileges | **boolean**

Enables backward compatibility mode for privilege checks on large objects. Skips privilege checks
when reading or modifying large objects, for compatibility with PostgreSQL releases prior to 9.0. ||
|| quoteAllIdentifiers | **boolean**

When generating SQL fragments, quote all identifiers. ||
|| standardConformingStrings | **boolean**

Causes '...' strings to treat backslashes literally. ||
|| synchronizeSeqscans | **boolean**

Enable synchronized sequential scans. ||
|| transformNullEquals | **boolean**

Treats \"expr=NULL\" as \"expr IS NULL\". When turned on, expressions of the form expr = NULL
(or NULL = expr) are treated as expr IS NULL, that is, they return true if expr evaluates to the
null value, and false otherwise. The correct behavior of expr = NULL is to always return null (unknown). ||
|| exitOnError | **boolean**

Terminate session on any error. ||
|| seqPageCost | **number** (double)

Sets the planner's estimate of the cost of a sequentially fetched disk page.

The minimum value is 0. ||
|| randomPageCost | **number** (double)

Sets the planner's estimate of the cost of a nonsequentially fetched disk page.

The minimum value is 0. ||
|| enableBitmapscan | **boolean**

Enables the planner's use of bitmap-scan plans. ||
|| enableHashagg | **boolean**

Enables the planner's use of hashed aggregation plans. ||
|| enableHashjoin | **boolean**

Enables the planner's use of hash join plans. ||
|| enableIndexscan | **boolean**

Enables the planner's use of index-scan plans. ||
|| enableIndexonlyscan | **boolean**

Enables the planner's use of index-only-scan plans. ||
|| enableMaterial | **boolean**

Enables the planner's use of materialization. ||
|| enableMergejoin | **boolean**

Enables the planner's use of merge join plans. ||
|| enableNestloop | **boolean**

Enables the planner's use of nested-loop join plans. ||
|| enableSeqscan | **boolean**

Enables the planner's use of sequential-scan plans. ||
|| enableSort | **boolean**

Enables the planner's use of explicit sort steps. ||
|| enableTidscan | **boolean**

Enables the planner's use of TID scan plans. ||
|| maxParallelWorkers | **string** (int64)

Sets the maximum number of parallel workers that can be active at one time.

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkersPerGather | **string** (int64)

Sets the maximum number of parallel processes per executor node.

Acceptable values are 0 to 1024, inclusive. ||
|| timezone | **string**

Sets the time zone for displaying and interpreting time stamps. ||
|| effectiveIoConcurrency | **string** (int64)

Number of simultaneous requests that can be handled efficiently by the disk subsystem.

Acceptable values are 0 to 1000, inclusive. ||
|| effectiveCacheSize | **string** (int64)

Sets the planner's assumption about the effective size of the disk cache available to a single query. In bytes.

Acceptable values are 1048576 to 549755813888, inclusive. ||
|| idleSessionTimeout | **string** (int64)

Sets the maximum allowed idle time between queries, when not in a transaction. In milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|#

## PostgresqlHostConfig15_1C {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig15_1C}

Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file
parameters which detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/11/runtime-config.html).

#|
||Field | Description ||
|| recoveryMinApplyDelay | **string** (int64)

Sets the minimum delay for applying changes during recovery. In milliseconds. ||
|| sharedBuffers | **string** (int64)

Sets the number of shared memory buffers used by the server. In bytes. ||
|| tempBuffers | **string** (int64)

Sets the maximum number of temporary buffers used by each session. In bytes. ||
|| workMem | **string** (int64)

Sets the maximum memory to be used for query workspaces. This much memory can be used by each
internal sort operation and hash table before switching to temporary disk files. In bytes. ||
|| tempFileLimit | **string** (int64)

Limits the total size of all temporary files used by each process. -1 means no limit. In bytes. ||
|| backendFlushAfter | **string** (int64)

Specifies how much data a backend can write before forcing the operating system to issue the writes. In bytes.

Acceptable values are 0 to 2097152, inclusive. ||
|| oldSnapshotThreshold | **string** (int64)

Time before a snapshot is too old to read pages changed after the snapshot was taken.
A value of -1 disables this feature. In milliseconds. ||
|| maxStandbyStreamingDelay | **string** (int64)

Sets the maximum delay before canceling queries when a hot standby server is processing streamed WAL data. In milliseconds. ||
|| constraintExclusion | **enum** (ConstraintExclusion)

Enables the planner to use constraints to optimize queries.

- `CONSTRAINT_EXCLUSION_ON`: Enable planner's use of constraints for all tables.
- `CONSTRAINT_EXCLUSION_OFF`: Disable planner's use of constraints for all tables
- `CONSTRAINT_EXCLUSION_PARTITION`: Only use constraints for child tables and UNION ALL clauses. ||
|| cursorTupleFraction | **number** (double)

Sets the planner's estimate of the fraction of a cursor's rows that will be retrieved. ||
|| fromCollapseLimit | **string** (int64)

Sets the FROM-list size beyond which subqueries are not collapsed.

Acceptable values are 1 to 2147483647, inclusive. ||
|| joinCollapseLimit | **string** (int64)

Sets the FROM-list size beyond which JOIN constructs are not flattened.

Acceptable values are 1 to 2147483647, inclusive. ||
|| forceParallelMode | **enum** (ForceParallelMode)

Forces use of parallel query facilities. If possible, run query using a parallel worker and with parallel restrictions.

- `FORCE_PARALLEL_MODE_ON`: Forces parallel mode for queries considered safe, even when no performance benefit is expected.
- `FORCE_PARALLEL_MODE_OFF`: Uses parallel mode only when the planner expects it to improve performance.
- `FORCE_PARALLEL_MODE_REGRESS`: Behaves like ON, but hides added Gather nodes in EXPLAIN output and
suppresses parallel-worker context lines to stabilize regression-test output. ||
|| clientMinMessages | **enum** (LogLevel)

Sets the message levels that are sent to the client.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinMessages | **enum** (LogLevel)

Sets the message levels that are logged.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinErrorStatement | **enum** (LogLevel)

Causes all statements generating error at or above this level to be logged.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinDurationStatement | **string** (int64)

Sets the minimum execution time above which all statements will be logged. In milliseconds. ||
|| logCheckpoints | **boolean**

Logs each checkpoint. ||
|| logConnections | **boolean**

Logs each successful connection. ||
|| logDisconnections | **boolean**

Logs end of a session, including duration. ||
|| logDuration | **boolean**

Logs the duration of each completed SQL statement.
 ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

Sets the verbosity of logged messages.

- `LOG_ERROR_VERBOSITY_TERSE`: DETAIL, HINT, QUERY, and CONTEXT fields are excluded from the error message.
- `LOG_ERROR_VERBOSITY_DEFAULT`: Default.
- `LOG_ERROR_VERBOSITY_VERBOSE`: Error message includes the SQLSTATE error code, source filename, function name, and the line number where the error occurred. ||
|| logLockWaits | **boolean**

Logs long lock waits. ||
|| logStatement | **enum** (LogStatement)

Sets the type of statements logged.

- `LOG_STATEMENT_NONE`: The filter is disabled, no SQL statements are logged.
- `LOG_STATEMENT_DDL`: System logs DDL statements, e.g., CREATE, ALTER, DROP etc.
- `LOG_STATEMENT_MOD`: System logs ddl-statements along with data modification commands, e.g., INSERT, UPDATE, etc.
- `LOG_STATEMENT_ALL`: System logs all SQL statements. ||
|| logTempFiles | **string** (int64)

Log the use of temporary files larger than this number of kilobytes. ||
|| searchPath | **string**

Sets the schema search order for names that are not schema-qualified. ||
|| rowSecurity | **boolean**

Enable row security. ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

Sets the transaction isolation level of each new transaction.

- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`: This level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.
- `TRANSACTION_ISOLATION_READ_COMMITTED`: On this level query sees only data committed before the query began.
- `TRANSACTION_ISOLATION_REPEATABLE_READ`: On this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).
- `TRANSACTION_ISOLATION_SERIALIZABLE`: This level provides the strictest transaction isolation.
All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction.
If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure. ||
|| statementTimeout | **string** (int64)

Sets the maximum allowed duration of any statement. In milliseconds. ||
|| lockTimeout | **string** (int64)

Sets the maximum allowed duration of any wait for a lock. In milliseconds. ||
|| idleInTransactionSessionTimeout | **string** (int64)

Sets the maximum allowed idle time between queries, when in a transaction. In milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| byteaOutput | **enum** (ByteaOutput)

Sets the output format for bytea.

- `BYTEA_OUTPUT_HEX`: Each byte is represented by two hexadecimal characters, e.g., 'SELECT '\xDEADBEEF';'.
- `BYTEA_OUTPUT_ESCAPED`: Standard PostgreSQL format with ASCII characters only. ||
|| xmlbinary | **enum** (XmlBinary)

Sets how binary values are to be encoded in XML.

- `XML_BINARY_BASE64`: Encodes binary values using Base64.
- `XML_BINARY_HEX`: Encodes binary values using hexadecimal notation. ||
|| xmloption | **enum** (XmlOption)

Sets whether XML data in implicit parsing and serialization operations is to be considered as documents or content fragments.

- `XML_OPTION_DOCUMENT`: Treats an XML value as a complete, well-formed document.
- `XML_OPTION_CONTENT`: Treats an XML value as a content fragment, which may contain multiple top-level elements or character nodes. ||
|| ginPendingListLimit | **string** (int64)

Sets the maximum size of the pending list for GIN index. In bytes. ||
|| deadlockTimeout | **string** (int64)

Sets the time to wait on a lock before checking for deadlock. In milliseconds.

Acceptable values are 1 to 2147483647, inclusive. ||
|| maxLocksPerTransaction | **string** (int64)

Sets the maximum number of locks per transaction. The shared lock table is sized on the assumption that
at most max_locks_per_transaction * max_connections distinct objects will need to be locked at any one time. ||
|| maxPredLocksPerTransaction | **string** (int64)

Sets the maximum number of predicate locks per transaction.The shared predicate lock table is sized on the assumption that
at most max_pred_locks_per_transaction * max_connections distinct objects will need to be locked at any one time. ||
|| arrayNulls | **boolean**

Enable input of NULL elements in arrays. When turned on, unquoted NULL in an array input
value means a null value; otherwise it is taken literally. ||
|| backslashQuote | **enum** (BackslashQuote)

Sets whether \"\\'\" is allowed in string literals.

- `BACKSLASH_QUOTE`: Legacy invalid value. Do not use.
- `BACKSLASH_QUOTE_ON`: Quotation mark can be represented as \'.
- `BACKSLASH_QUOTE_OFF`: Quotation mark can only be represented using the standard SQL syntax ''.
- `BACKSLASH_QUOTE_SAFE_ENCODING`: Representing a quotation mark as \' is only permitted for client encodings where \ is not used for multibyte characters. ||
|| defaultWithOids | **boolean**

WITH OIDS is no longer supported; this can only be false. ||
|| escapeStringWarning | **boolean**

Warn about backslash escapes in ordinary string literals. ||
|| loCompatPrivileges | **boolean**

Enables backward compatibility mode for privilege checks on large objects. Skips privilege checks
when reading or modifying large objects, for compatibility with PostgreSQL releases prior to 9.0. ||
|| quoteAllIdentifiers | **boolean**

When generating SQL fragments, quote all identifiers. ||
|| standardConformingStrings | **boolean**

Causes '...' strings to treat backslashes literally. ||
|| synchronizeSeqscans | **boolean**

Enable synchronized sequential scans. ||
|| transformNullEquals | **boolean**

Treats \"expr=NULL\" as \"expr IS NULL\". When turned on, expressions of the form expr = NULL
(or NULL = expr) are treated as expr IS NULL, that is, they return true if expr evaluates to the
null value, and false otherwise. The correct behavior of expr = NULL is to always return null (unknown). ||
|| exitOnError | **boolean**

Terminate session on any error. ||
|| seqPageCost | **number** (double)

Sets the planner's estimate of the cost of a sequentially fetched disk page.

The minimum value is 0. ||
|| randomPageCost | **number** (double)

Sets the planner's estimate of the cost of a nonsequentially fetched disk page.

The minimum value is 0. ||
|| enableBitmapscan | **boolean**

Enables the planner's use of bitmap-scan plans. ||
|| enableHashagg | **boolean**

Enables the planner's use of hashed aggregation plans. ||
|| enableHashjoin | **boolean**

Enables the planner's use of hash join plans. ||
|| enableIndexscan | **boolean**

Enables the planner's use of index-scan plans. ||
|| enableIndexonlyscan | **boolean**

Enables the planner's use of index-only-scan plans. ||
|| enableMaterial | **boolean**

Enables the planner's use of materialization. ||
|| enableMergejoin | **boolean**

Enables the planner's use of merge join plans. ||
|| enableNestloop | **boolean**

Enables the planner's use of nested-loop join plans. ||
|| enableSeqscan | **boolean**

Enables the planner's use of sequential-scan plans. ||
|| enableSort | **boolean**

Enables the planner's use of explicit sort steps. ||
|| enableTidscan | **boolean**

Enables the planner's use of TID scan plans. ||
|| maxParallelWorkers | **string** (int64)

Sets the maximum number of parallel workers that can be active at one time.

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkersPerGather | **string** (int64)

Sets the maximum number of parallel processes per executor node.

Acceptable values are 0 to 1024, inclusive. ||
|| timezone | **string**

Sets the time zone for displaying and interpreting time stamps. ||
|| effectiveIoConcurrency | **string** (int64)

Number of simultaneous requests that can be handled efficiently by the disk subsystem.

Acceptable values are 0 to 1000, inclusive. ||
|| effectiveCacheSize | **string** (int64)

Sets the planner's assumption about the effective size of the disk cache available to a single query. In bytes.

Acceptable values are 1048576 to 549755813888, inclusive. ||
|| idleSessionTimeout | **string** (int64)

Sets the maximum allowed idle time between queries, when not in a transaction. In milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|#

## PostgresqlHostConfig16 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig16}

Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file
parameters which detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/11/runtime-config.html).

#|
||Field | Description ||
|| recoveryMinApplyDelay | **string** (int64)

Sets the minimum delay for applying changes during recovery. In milliseconds. ||
|| sharedBuffers | **string** (int64)

Sets the number of shared memory buffers used by the server. In bytes. ||
|| tempBuffers | **string** (int64)

Sets the maximum number of temporary buffers used by each session. In bytes. ||
|| workMem | **string** (int64)

Sets the maximum memory to be used for query workspaces. This much memory can be used by each
internal sort operation and hash table before switching to temporary disk files. In bytes. ||
|| tempFileLimit | **string** (int64)

Limits the total size of all temporary files used by each process. -1 means no limit. In bytes. ||
|| backendFlushAfter | **string** (int64)

Specifies how much data a backend can write before forcing the operating system to issue the writes. In bytes.

Acceptable values are 0 to 2097152, inclusive. ||
|| oldSnapshotThreshold | **string** (int64)

Time before a snapshot is too old to read pages changed after the snapshot was taken.
A value of -1 disables this feature. In milliseconds. ||
|| maxStandbyStreamingDelay | **string** (int64)

Sets the maximum delay before canceling queries when a hot standby server is processing streamed WAL data. In milliseconds. ||
|| constraintExclusion | **enum** (ConstraintExclusion)

Enables the planner to use constraints to optimize queries.

- `CONSTRAINT_EXCLUSION_ON`: Enable planner's use of constraints for all tables.
- `CONSTRAINT_EXCLUSION_OFF`: Disable planner's use of constraints for all tables
- `CONSTRAINT_EXCLUSION_PARTITION`: Only use constraints for child tables and UNION ALL clauses. ||
|| cursorTupleFraction | **number** (double)

Sets the planner's estimate of the fraction of a cursor's rows that will be retrieved. ||
|| fromCollapseLimit | **string** (int64)

Sets the FROM-list size beyond which subqueries are not collapsed.

Acceptable values are 1 to 2147483647, inclusive. ||
|| joinCollapseLimit | **string** (int64)

Sets the FROM-list size beyond which JOIN constructs are not flattened.

Acceptable values are 1 to 2147483647, inclusive. ||
|| debugParallelQuery | **enum** (DebugParallelQuery)

Forces the planner to use parallel query nodes.

- `DEBUG_PARALLEL_QUERY_ON`: Forces parallel mode for queries considered safe, even when no performance benefit is expected.
- `DEBUG_PARALLEL_QUERY_OFF`: Uses parallel mode only when the planner expects it to improve performance.
- `DEBUG_PARALLEL_QUERY_REGRESS`: Behaves like ON, but hides added Gather nodes in EXPLAIN output and
suppresses parallel-worker context lines to stabilize regression-test output. ||
|| clientMinMessages | **enum** (LogLevel)

Sets the message levels that are sent to the client.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_INFO`: Reports information implicitly requested by the user.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinMessages | **enum** (LogLevel)

Sets the message levels that are logged.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_INFO`: Reports information implicitly requested by the user.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinErrorStatement | **enum** (LogLevel)

Causes all statements generating error at or above this level to be logged.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_INFO`: Reports information implicitly requested by the user.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinDurationStatement | **string** (int64)

Sets the minimum execution time above which all statements will be logged. In milliseconds. ||
|| logCheckpoints | **boolean**

Logs each checkpoint. ||
|| logConnections | **boolean**

Logs each successful connection. ||
|| logDisconnections | **boolean**

Logs end of a session, including duration. ||
|| logDuration | **boolean**

Logs the duration of each completed SQL statement.
 ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

Sets the verbosity of logged messages.

- `LOG_ERROR_VERBOSITY_TERSE`: DETAIL, HINT, QUERY, and CONTEXT fields are excluded from the error message.
- `LOG_ERROR_VERBOSITY_DEFAULT`: Default.
- `LOG_ERROR_VERBOSITY_VERBOSE`: Error message includes the SQLSTATE error code, source filename, function name, and the line number where the error occurred. ||
|| logLockWaits | **boolean**

Logs long lock waits. ||
|| logStatement | **enum** (LogStatement)

Sets the type of statements logged.

- `LOG_STATEMENT_NONE`: The filter is disabled, no SQL statements are logged.
- `LOG_STATEMENT_DDL`: System logs DDL statements, e.g., CREATE, ALTER, DROP etc.
- `LOG_STATEMENT_MOD`: System logs ddl-statements along with data modification commands, e.g., INSERT, UPDATE, etc.
- `LOG_STATEMENT_ALL`: System logs all SQL statements. ||
|| logTempFiles | **string** (int64)

Log the use of temporary files larger than this number of kilobytes. ||
|| searchPath | **string**

Sets the schema search order for names that are not schema-qualified. ||
|| rowSecurity | **boolean**

Enable row security. ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

Sets the transaction isolation level of each new transaction.

- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`: This level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.
- `TRANSACTION_ISOLATION_READ_COMMITTED`: On this level query sees only data committed before the query began.
- `TRANSACTION_ISOLATION_REPEATABLE_READ`: On this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).
- `TRANSACTION_ISOLATION_SERIALIZABLE`: This level provides the strictest transaction isolation.
All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction.
If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure. ||
|| statementTimeout | **string** (int64)

Sets the maximum allowed duration of any statement. In milliseconds. ||
|| lockTimeout | **string** (int64)

Sets the maximum allowed duration of any wait for a lock. In milliseconds. ||
|| idleInTransactionSessionTimeout | **string** (int64)

Sets the maximum allowed idle time between queries, when in a transaction. In milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| byteaOutput | **enum** (ByteaOutput)

Sets the output format for bytea.

- `BYTEA_OUTPUT_HEX`: Each byte is represented by two hexadecimal characters, e.g., 'SELECT '\xDEADBEEF';'.
- `BYTEA_OUTPUT_ESCAPED`: Standard PostgreSQL format with ASCII characters only. ||
|| xmlbinary | **enum** (XmlBinary)

Sets how binary values are to be encoded in XML.

- `XML_BINARY_BASE64`: Encodes binary values using Base64.
- `XML_BINARY_HEX`: Encodes binary values using hexadecimal notation. ||
|| xmloption | **enum** (XmlOption)

Sets whether XML data in implicit parsing and serialization operations is to be considered as documents or content fragments.

- `XML_OPTION_DOCUMENT`: Treats an XML value as a complete, well-formed document.
- `XML_OPTION_CONTENT`: Treats an XML value as a content fragment, which may contain multiple top-level elements or character nodes. ||
|| ginPendingListLimit | **string** (int64)

Sets the maximum size of the pending list for GIN index. In bytes. ||
|| deadlockTimeout | **string** (int64)

Sets the time to wait on a lock before checking for deadlock. In milliseconds.

Acceptable values are 1 to 2147483647, inclusive. ||
|| maxLocksPerTransaction | **string** (int64)

Sets the maximum number of locks per transaction. The shared lock table is sized on the assumption that
at most max_locks_per_transaction * max_connections distinct objects will need to be locked at any one time. ||
|| maxPredLocksPerTransaction | **string** (int64)

Sets the maximum number of predicate locks per transaction.The shared predicate lock table is sized on the assumption that
at most max_pred_locks_per_transaction * max_connections distinct objects will need to be locked at any one time. ||
|| arrayNulls | **boolean**

Enable input of NULL elements in arrays. When turned on, unquoted NULL in an array input
value means a null value; otherwise it is taken literally. ||
|| backslashQuote | **enum** (BackslashQuote)

Sets whether \"\\'\" is allowed in string literals.

- `BACKSLASH_QUOTE`: Legacy invalid value. Do not use.
- `BACKSLASH_QUOTE_ON`: Quotation mark can be represented as \'.
- `BACKSLASH_QUOTE_OFF`: Quotation mark can only be represented using the standard SQL syntax ''.
- `BACKSLASH_QUOTE_SAFE_ENCODING`: Representing a quotation mark as \' is only permitted for client encodings where \ is not used for multibyte characters. ||
|| defaultWithOids | **boolean**

WITH OIDS is no longer supported; this can only be false. ||
|| escapeStringWarning | **boolean**

Warn about backslash escapes in ordinary string literals. ||
|| loCompatPrivileges | **boolean**

Enables backward compatibility mode for privilege checks on large objects. Skips privilege checks
when reading or modifying large objects, for compatibility with PostgreSQL releases prior to 9.0. ||
|| quoteAllIdentifiers | **boolean**

When generating SQL fragments, quote all identifiers. ||
|| standardConformingStrings | **boolean**

Causes '...' strings to treat backslashes literally. ||
|| synchronizeSeqscans | **boolean**

Enable synchronized sequential scans. ||
|| transformNullEquals | **boolean**

Treats \"expr=NULL\" as \"expr IS NULL\". When turned on, expressions of the form expr = NULL
(or NULL = expr) are treated as expr IS NULL, that is, they return true if expr evaluates to the
null value, and false otherwise. The correct behavior of expr = NULL is to always return null (unknown). ||
|| exitOnError | **boolean**

Terminate session on any error. ||
|| seqPageCost | **number** (double)

Sets the planner's estimate of the cost of a sequentially fetched disk page.

The minimum value is 0. ||
|| randomPageCost | **number** (double)

Sets the planner's estimate of the cost of a nonsequentially fetched disk page.

The minimum value is 0. ||
|| enableBitmapscan | **boolean**

Enables the planner's use of bitmap-scan plans. ||
|| enableHashagg | **boolean**

Enables the planner's use of hashed aggregation plans. ||
|| enableHashjoin | **boolean**

Enables the planner's use of hash join plans. ||
|| enableIndexscan | **boolean**

Enables the planner's use of index-scan plans. ||
|| enableIndexonlyscan | **boolean**

Enables the planner's use of index-only-scan plans. ||
|| enableMaterial | **boolean**

Enables the planner's use of materialization. ||
|| enableMergejoin | **boolean**

Enables the planner's use of merge join plans. ||
|| enableNestloop | **boolean**

Enables the planner's use of nested-loop join plans. ||
|| enableSeqscan | **boolean**

Enables the planner's use of sequential-scan plans. ||
|| enableSort | **boolean**

Enables the planner's use of explicit sort steps. ||
|| enableTidscan | **boolean**

Enables the planner's use of TID scan plans. ||
|| maxParallelWorkers | **string** (int64)

Sets the maximum number of parallel workers that can be active at one time.

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkersPerGather | **string** (int64)

Sets the maximum number of parallel processes per executor node.

Acceptable values are 0 to 1024, inclusive. ||
|| timezone | **string**

Sets the time zone for displaying and interpreting time stamps. ||
|| effectiveIoConcurrency | **string** (int64)

Number of simultaneous requests that can be handled efficiently by the disk subsystem.

Acceptable values are 0 to 1000, inclusive. ||
|| effectiveCacheSize | **string** (int64)

Sets the planner's assumption about the effective size of the disk cache available to a single query. In bytes.

Acceptable values are 1048576 to 549755813888, inclusive. ||
|| idleSessionTimeout | **string** (int64)

Sets the maximum allowed idle time between queries, when not in a transaction. In milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|#

## PostgresqlHostConfig16_1C {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig16_1C}

Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file
parameters which detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/11/runtime-config.html).

#|
||Field | Description ||
|| recoveryMinApplyDelay | **string** (int64)

Sets the minimum delay for applying changes during recovery. In milliseconds. ||
|| sharedBuffers | **string** (int64)

Sets the number of shared memory buffers used by the server. In bytes. ||
|| tempBuffers | **string** (int64)

Sets the maximum number of temporary buffers used by each session. In bytes. ||
|| workMem | **string** (int64)

Sets the maximum memory to be used for query workspaces. This much memory can be used by each
internal sort operation and hash table before switching to temporary disk files. In bytes. ||
|| tempFileLimit | **string** (int64)

Limits the total size of all temporary files used by each process. -1 means no limit. In bytes. ||
|| backendFlushAfter | **string** (int64)

Specifies how much data a backend can write before forcing the operating system to issue the writes. In bytes.

Acceptable values are 0 to 2097152, inclusive. ||
|| oldSnapshotThreshold | **string** (int64)

Time before a snapshot is too old to read pages changed after the snapshot was taken.
A value of -1 disables this feature. In milliseconds. ||
|| maxStandbyStreamingDelay | **string** (int64)

Sets the maximum delay before canceling queries when a hot standby server is processing streamed WAL data. In milliseconds. ||
|| constraintExclusion | **enum** (ConstraintExclusion)

Enables the planner to use constraints to optimize queries.

- `CONSTRAINT_EXCLUSION_ON`: Enable planner's use of constraints for all tables.
- `CONSTRAINT_EXCLUSION_OFF`: Disable planner's use of constraints for all tables
- `CONSTRAINT_EXCLUSION_PARTITION`: Only use constraints for child tables and UNION ALL clauses. ||
|| cursorTupleFraction | **number** (double)

Sets the planner's estimate of the fraction of a cursor's rows that will be retrieved. ||
|| fromCollapseLimit | **string** (int64)

Sets the FROM-list size beyond which subqueries are not collapsed.

Acceptable values are 1 to 2147483647, inclusive. ||
|| joinCollapseLimit | **string** (int64)

Sets the FROM-list size beyond which JOIN constructs are not flattened.

Acceptable values are 1 to 2147483647, inclusive. ||
|| debugParallelQuery | **enum** (DebugParallelQuery)

Forces the planner to use parallel query nodes.

- `DEBUG_PARALLEL_QUERY_ON`: Forces parallel mode for queries considered safe, even when no performance benefit is expected.
- `DEBUG_PARALLEL_QUERY_OFF`: Uses parallel mode only when the planner expects it to improve performance.
- `DEBUG_PARALLEL_QUERY_REGRESS`: Behaves like ON, but hides added Gather nodes in EXPLAIN output and
suppresses parallel-worker context lines to stabilize regression-test output. ||
|| clientMinMessages | **enum** (LogLevel)

Sets the message levels that are sent to the client.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_INFO`: Reports information implicitly requested by the user.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinMessages | **enum** (LogLevel)

Sets the message levels that are logged.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_INFO`: Reports information implicitly requested by the user.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinErrorStatement | **enum** (LogLevel)

Causes all statements generating error at or above this level to be logged.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_INFO`: Reports information implicitly requested by the user.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinDurationStatement | **string** (int64)

Sets the minimum execution time above which all statements will be logged. In milliseconds. ||
|| logCheckpoints | **boolean**

Logs each checkpoint. ||
|| logConnections | **boolean**

Logs each successful connection. ||
|| logDisconnections | **boolean**

Logs end of a session, including duration. ||
|| logDuration | **boolean**

Logs the duration of each completed SQL statement.
 ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

Sets the verbosity of logged messages.

- `LOG_ERROR_VERBOSITY_TERSE`: DETAIL, HINT, QUERY, and CONTEXT fields are excluded from the error message.
- `LOG_ERROR_VERBOSITY_DEFAULT`: Default.
- `LOG_ERROR_VERBOSITY_VERBOSE`: Error message includes the SQLSTATE error code, source filename, function name, and the line number where the error occurred. ||
|| logLockWaits | **boolean**

Logs long lock waits. ||
|| logStatement | **enum** (LogStatement)

Sets the type of statements logged.

- `LOG_STATEMENT_NONE`: The filter is disabled, no SQL statements are logged.
- `LOG_STATEMENT_DDL`: System logs DDL statements, e.g., CREATE, ALTER, DROP etc.
- `LOG_STATEMENT_MOD`: System logs ddl-statements along with data modification commands, e.g., INSERT, UPDATE, etc.
- `LOG_STATEMENT_ALL`: System logs all SQL statements. ||
|| logTempFiles | **string** (int64)

Log the use of temporary files larger than this number of kilobytes. ||
|| searchPath | **string**

Sets the schema search order for names that are not schema-qualified. ||
|| rowSecurity | **boolean**

Enable row security. ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

Sets the transaction isolation level of each new transaction.

- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`: This level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.
- `TRANSACTION_ISOLATION_READ_COMMITTED`: On this level query sees only data committed before the query began.
- `TRANSACTION_ISOLATION_REPEATABLE_READ`: On this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).
- `TRANSACTION_ISOLATION_SERIALIZABLE`: This level provides the strictest transaction isolation.
All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction.
If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure. ||
|| statementTimeout | **string** (int64)

Sets the maximum allowed duration of any statement. In milliseconds. ||
|| lockTimeout | **string** (int64)

Sets the maximum allowed duration of any wait for a lock. In milliseconds. ||
|| idleInTransactionSessionTimeout | **string** (int64)

Sets the maximum allowed idle time between queries, when in a transaction. In milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| byteaOutput | **enum** (ByteaOutput)

Sets the output format for bytea.

- `BYTEA_OUTPUT_HEX`: Each byte is represented by two hexadecimal characters, e.g., 'SELECT '\xDEADBEEF';'.
- `BYTEA_OUTPUT_ESCAPED`: Standard PostgreSQL format with ASCII characters only. ||
|| xmlbinary | **enum** (XmlBinary)

Sets how binary values are to be encoded in XML.

- `XML_BINARY_BASE64`: Encodes binary values using Base64.
- `XML_BINARY_HEX`: Encodes binary values using hexadecimal notation. ||
|| xmloption | **enum** (XmlOption)

Sets whether XML data in implicit parsing and serialization operations is to be considered as documents or content fragments.

- `XML_OPTION_DOCUMENT`: Treats an XML value as a complete, well-formed document.
- `XML_OPTION_CONTENT`: Treats an XML value as a content fragment, which may contain multiple top-level elements or character nodes. ||
|| ginPendingListLimit | **string** (int64)

Sets the maximum size of the pending list for GIN index. In bytes. ||
|| deadlockTimeout | **string** (int64)

Sets the time to wait on a lock before checking for deadlock. In milliseconds.

Acceptable values are 1 to 2147483647, inclusive. ||
|| maxLocksPerTransaction | **string** (int64)

Sets the maximum number of locks per transaction. The shared lock table is sized on the assumption that
at most max_locks_per_transaction * max_connections distinct objects will need to be locked at any one time. ||
|| maxPredLocksPerTransaction | **string** (int64)

Sets the maximum number of predicate locks per transaction.The shared predicate lock table is sized on the assumption that
at most max_pred_locks_per_transaction * max_connections distinct objects will need to be locked at any one time. ||
|| arrayNulls | **boolean**

Enable input of NULL elements in arrays. When turned on, unquoted NULL in an array input
value means a null value; otherwise it is taken literally. ||
|| backslashQuote | **enum** (BackslashQuote)

Sets whether \"\\'\" is allowed in string literals.

- `BACKSLASH_QUOTE`: Legacy invalid value. Do not use.
- `BACKSLASH_QUOTE_ON`: Quotation mark can be represented as \'.
- `BACKSLASH_QUOTE_OFF`: Quotation mark can only be represented using the standard SQL syntax ''.
- `BACKSLASH_QUOTE_SAFE_ENCODING`: Representing a quotation mark as \' is only permitted for client encodings where \ is not used for multibyte characters. ||
|| defaultWithOids | **boolean**

WITH OIDS is no longer supported; this can only be false. ||
|| escapeStringWarning | **boolean**

Warn about backslash escapes in ordinary string literals. ||
|| loCompatPrivileges | **boolean**

Enables backward compatibility mode for privilege checks on large objects. Skips privilege checks
when reading or modifying large objects, for compatibility with PostgreSQL releases prior to 9.0. ||
|| quoteAllIdentifiers | **boolean**

When generating SQL fragments, quote all identifiers. ||
|| standardConformingStrings | **boolean**

Causes '...' strings to treat backslashes literally. ||
|| synchronizeSeqscans | **boolean**

Enable synchronized sequential scans. ||
|| transformNullEquals | **boolean**

Treats \"expr=NULL\" as \"expr IS NULL\". When turned on, expressions of the form expr = NULL
(or NULL = expr) are treated as expr IS NULL, that is, they return true if expr evaluates to the
null value, and false otherwise. The correct behavior of expr = NULL is to always return null (unknown). ||
|| exitOnError | **boolean**

Terminate session on any error. ||
|| seqPageCost | **number** (double)

Sets the planner's estimate of the cost of a sequentially fetched disk page.

The minimum value is 0. ||
|| randomPageCost | **number** (double)

Sets the planner's estimate of the cost of a nonsequentially fetched disk page.

The minimum value is 0. ||
|| enableBitmapscan | **boolean**

Enables the planner's use of bitmap-scan plans. ||
|| enableHashagg | **boolean**

Enables the planner's use of hashed aggregation plans. ||
|| enableHashjoin | **boolean**

Enables the planner's use of hash join plans. ||
|| enableIndexscan | **boolean**

Enables the planner's use of index-scan plans. ||
|| enableIndexonlyscan | **boolean**

Enables the planner's use of index-only-scan plans. ||
|| enableMaterial | **boolean**

Enables the planner's use of materialization. ||
|| enableMergejoin | **boolean**

Enables the planner's use of merge join plans. ||
|| enableNestloop | **boolean**

Enables the planner's use of nested-loop join plans. ||
|| enableSeqscan | **boolean**

Enables the planner's use of sequential-scan plans. ||
|| enableSort | **boolean**

Enables the planner's use of explicit sort steps. ||
|| enableTidscan | **boolean**

Enables the planner's use of TID scan plans. ||
|| maxParallelWorkers | **string** (int64)

Sets the maximum number of parallel workers that can be active at one time.

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkersPerGather | **string** (int64)

Sets the maximum number of parallel processes per executor node.

Acceptable values are 0 to 1024, inclusive. ||
|| timezone | **string**

Sets the time zone for displaying and interpreting time stamps. ||
|| effectiveIoConcurrency | **string** (int64)

Number of simultaneous requests that can be handled efficiently by the disk subsystem.

Acceptable values are 0 to 1000, inclusive. ||
|| effectiveCacheSize | **string** (int64)

Sets the planner's assumption about the effective size of the disk cache available to a single query. In bytes.

Acceptable values are 1048576 to 549755813888, inclusive. ||
|| idleSessionTimeout | **string** (int64)

Sets the maximum allowed idle time between queries, when not in a transaction. In milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|#

## PostgresqlHostConfig17 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig17}

Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file
parameters which detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/17/runtime-config.html).

#|
||Field | Description ||
|| recoveryMinApplyDelay | **string** (int64)

Sets the minimum delay for applying changes during recovery. In milliseconds. ||
|| sharedBuffers | **string** (int64)

Sets the number of shared memory buffers used by the server. In bytes. ||
|| tempBuffers | **string** (int64)

Sets the maximum number of temporary buffers used by each session. In bytes. ||
|| workMem | **string** (int64)

Sets the maximum memory to be used for query workspaces. This much memory can be used by each
internal sort operation and hash table before switching to temporary disk files. In bytes. ||
|| tempFileLimit | **string** (int64)

Limits the total size of all temporary files used by each process. -1 means no limit. In bytes. ||
|| backendFlushAfter | **string** (int64)

Specifies how much data a backend can write before forcing the operating system to issue the writes. In bytes.

Acceptable values are 0 to 2097152, inclusive. ||
|| maxStandbyStreamingDelay | **string** (int64)

Sets the maximum delay before canceling queries when a hot standby server is processing streamed WAL data. In milliseconds. ||
|| constraintExclusion | **enum** (ConstraintExclusion)

Enables the planner to use constraints to optimize queries.

- `CONSTRAINT_EXCLUSION_ON`: Enable planner's use of constraints for all tables.
- `CONSTRAINT_EXCLUSION_OFF`: Disable planner's use of constraints for all tables
- `CONSTRAINT_EXCLUSION_PARTITION`: Only use constraints for child tables and UNION ALL clauses. ||
|| cursorTupleFraction | **number** (double)

Sets the planner's estimate of the fraction of a cursor's rows that will be retrieved. ||
|| fromCollapseLimit | **string** (int64)

Sets the FROM-list size beyond which subqueries are not collapsed.

Acceptable values are 1 to 2147483647, inclusive. ||
|| joinCollapseLimit | **string** (int64)

Sets the FROM-list size beyond which JOIN constructs are not flattened.

Acceptable values are 1 to 2147483647, inclusive. ||
|| debugParallelQuery | **enum** (DebugParallelQuery)

Forces the planner's use parallel query nodes.

- `DEBUG_PARALLEL_QUERY_ON`: Forces parallel mode for queries considered safe, even when no performance benefit is expected.
- `DEBUG_PARALLEL_QUERY_OFF`: Uses parallel mode only when the planner expects it to improve performance.
- `DEBUG_PARALLEL_QUERY_REGRESS`: Behaves like ON, but hides added Gather nodes in EXPLAIN output and
suppresses parallel-worker context lines to stabilize regression-test output. ||
|| clientMinMessages | **enum** (LogLevel)

Sets the message levels that are sent to the client.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_INFO`: Reports information implicitly requested by the user.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinMessages | **enum** (LogLevel)

Sets the message levels that are logged.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_INFO`: Reports information implicitly requested by the user.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinErrorStatement | **enum** (LogLevel)

Causes all statements generating error at or above this level to be logged.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_INFO`: Reports information implicitly requested by the user.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinDurationStatement | **string** (int64)

Sets the minimum execution time above which all statements will be logged. In milliseconds. ||
|| logCheckpoints | **boolean**

Logs each checkpoint. ||
|| logConnections | **boolean**

Logs each successful connection. ||
|| logDisconnections | **boolean**

Logs end of a session, including duration. ||
|| logDuration | **boolean**

Logs the duration of each completed SQL statement.
 ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

Sets the verbosity of logged messages.

- `LOG_ERROR_VERBOSITY_TERSE`: DETAIL, HINT, QUERY, and CONTEXT fields are excluded from the error message.
- `LOG_ERROR_VERBOSITY_DEFAULT`: Default.
- `LOG_ERROR_VERBOSITY_VERBOSE`: Error message includes the SQLSTATE error code, source filename, function name, and the line number where the error occurred. ||
|| logLockWaits | **boolean**

Logs long lock waits. ||
|| logStatement | **enum** (LogStatement)

Sets the type of statements logged.

- `LOG_STATEMENT_NONE`: The filter is disabled, no SQL statements are logged.
- `LOG_STATEMENT_DDL`: System logs DDL statements, e.g., CREATE, ALTER, DROP etc.
- `LOG_STATEMENT_MOD`: System logs ddl-statements along with data modification commands, e.g., INSERT, UPDATE, etc.
- `LOG_STATEMENT_ALL`: System logs all SQL statements. ||
|| logTempFiles | **string** (int64)

Log the use of temporary files larger than this number of kilobytes. ||
|| searchPath | **string**

Sets the schema search order for names that are not schema-qualified. ||
|| rowSecurity | **boolean**

Enable row security. ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

Sets the transaction isolation level of each new transaction.

- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`: This level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.
- `TRANSACTION_ISOLATION_READ_COMMITTED`: On this level query sees only data committed before the query began.
- `TRANSACTION_ISOLATION_REPEATABLE_READ`: On this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).
- `TRANSACTION_ISOLATION_SERIALIZABLE`: This level provides the strictest transaction isolation.
All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction.
If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure. ||
|| statementTimeout | **string** (int64)

Sets the maximum allowed duration of any statement. In milliseconds. ||
|| lockTimeout | **string** (int64)

Sets the maximum allowed duration of any wait for a lock. In milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| idleInTransactionSessionTimeout | **string** (int64)

Sets the maximum allowed idle time between queries, when in a transaction. In milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| byteaOutput | **enum** (ByteaOutput)

Sets the output format for bytea.

- `BYTEA_OUTPUT_HEX`: Each byte is represented by two hexadecimal characters, e.g., 'SELECT '\xDEADBEEF';'.
- `BYTEA_OUTPUT_ESCAPED`: Standard PostgreSQL format with ASCII characters only. ||
|| xmlbinary | **enum** (XmlBinary)

Sets how binary values are to be encoded in XML.

- `XML_BINARY_BASE64`: Encodes binary values using Base64.
- `XML_BINARY_HEX`: Encodes binary values using hexadecimal notation. ||
|| xmloption | **enum** (XmlOption)

Sets whether XML data in implicit parsing and serialization operations is to be considered as documents or content fragments.

- `XML_OPTION_DOCUMENT`: Treats an XML value as a complete, well-formed document.
- `XML_OPTION_CONTENT`: Treats an XML value as a content fragment, which may contain multiple top-level elements or character nodes. ||
|| ginPendingListLimit | **string** (int64)

Sets the maximum size of the pending list for GIN index. In bytes. ||
|| deadlockTimeout | **string** (int64)

Sets the time to wait on a lock before checking for deadlock. In milliseconds.

Acceptable values are 1 to 2147483647, inclusive. ||
|| maxLocksPerTransaction | **string** (int64)

Sets the maximum number of locks per transaction. The shared lock table is sized on the assumption that
at most max_locks_per_transaction * max_connections distinct objects will need to be locked at any one time. ||
|| maxPredLocksPerTransaction | **string** (int64)

Sets the maximum number of predicate locks per transaction.The shared predicate lock table is sized on the assumption that
at most max_pred_locks_per_transaction * max_connections distinct objects will need to be locked at any one time. ||
|| arrayNulls | **boolean**

Enable input of NULL elements in arrays. When turned on, unquoted NULL in an array input
value means a null value; otherwise it is taken literally. ||
|| backslashQuote | **enum** (BackslashQuote)

Sets whether \"\\'\" is allowed in string literals.

- `BACKSLASH_QUOTE`: Legacy invalid value. Do not use.
- `BACKSLASH_QUOTE_ON`: Quotation mark can be represented as \'.
- `BACKSLASH_QUOTE_OFF`: Quotation mark can only be represented using the standard SQL syntax ''.
- `BACKSLASH_QUOTE_SAFE_ENCODING`: Representing a quotation mark as \' is only permitted for client encodings where \ is not used for multibyte characters. ||
|| defaultWithOids | **boolean**

WITH OIDS is no longer supported; this can only be false. ||
|| escapeStringWarning | **boolean**

Warn about backslash escapes in ordinary string literals. ||
|| loCompatPrivileges | **boolean**

Enables backward compatibility mode for privilege checks on large objects. Skips privilege checks
when reading or modifying large objects, for compatibility with PostgreSQL releases prior to 9.0. ||
|| quoteAllIdentifiers | **boolean**

When generating SQL fragments, quote all identifiers. ||
|| standardConformingStrings | **boolean**

Causes '...' strings to treat backslashes literally. ||
|| synchronizeSeqscans | **boolean**

Enable synchronized sequential scans. ||
|| transformNullEquals | **boolean**

Treats \"expr=NULL\" as \"expr IS NULL\". When turned on, expressions of the form expr = NULL
(or NULL = expr) are treated as expr IS NULL, that is, they return true if expr evaluates to the
null value, and false otherwise. The correct behavior of expr = NULL is to always return null (unknown). ||
|| exitOnError | **boolean**

Terminate session on any error. ||
|| seqPageCost | **number** (double)

Sets the planner's estimate of the cost of a sequentially fetched disk page.

The minimum value is 0. ||
|| randomPageCost | **number** (double)

Sets the planner's estimate of the cost of a nonsequentially fetched disk page.

The minimum value is 0. ||
|| enableBitmapscan | **boolean**

Enables the planner's use of bitmap-scan plans. ||
|| enableHashagg | **boolean**

Enables the planner's use of hashed aggregation plans. ||
|| enableHashjoin | **boolean**

Enables the planner's use of hash join plans. ||
|| enableIndexscan | **boolean**

Enables the planner's use of index-scan plans. ||
|| enableIndexonlyscan | **boolean**

Enables the planner's use of index-only-scan plans. ||
|| enableMaterial | **boolean**

Enables the planner's use of materialization. ||
|| enableMergejoin | **boolean**

Enables the planner's use of merge join plans. ||
|| enableNestloop | **boolean**

Enables the planner's use of nested-loop join plans. ||
|| enableSeqscan | **boolean**

Enables the planner's use of sequential-scan plans. ||
|| enableSort | **boolean**

Enables the planner's use of explicit sort steps. ||
|| enableTidscan | **boolean**

Enables the planner's use of TID scan plans. ||
|| maxParallelWorkers | **string** (int64)

Sets the maximum number of parallel workers that can be active at one time.

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkersPerGather | **string** (int64)

Sets the maximum number of parallel processes per executor node.

Acceptable values are 0 to 1024, inclusive. ||
|| timezone | **string**

Sets the time zone for displaying and interpreting time stamps. ||
|| effectiveIoConcurrency | **string** (int64)

Number of simultaneous requests that can be handled efficiently by the disk subsystem.

Acceptable values are 0 to 1000, inclusive. ||
|| effectiveCacheSize | **string** (int64)

Sets the planner's assumption about the effective size of the disk cache available to a single query. In bytes.

Acceptable values are 1048576 to 549755813888, inclusive. ||
|| idleSessionTimeout | **string** (int64)

Sets the maximum allowed idle time between queries, when not in a transaction. In milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|#

## PostgresqlHostConfig17_1C {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig17_1C}

Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file
parameters which detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/17/runtime-config.html).

#|
||Field | Description ||
|| recoveryMinApplyDelay | **string** (int64)

Sets the minimum delay for applying changes during recovery. In milliseconds. ||
|| sharedBuffers | **string** (int64)

Sets the number of shared memory buffers used by the server. In bytes. ||
|| tempBuffers | **string** (int64)

Sets the maximum number of temporary buffers used by each session. In bytes. ||
|| workMem | **string** (int64)

Sets the maximum memory to be used for query workspaces. This much memory can be used by each
internal sort operation and hash table before switching to temporary disk files. In bytes. ||
|| tempFileLimit | **string** (int64)

Limits the total size of all temporary files used by each process. -1 means no limit. In bytes. ||
|| backendFlushAfter | **string** (int64)

Specifies how much data a backend can write before forcing the operating system to issue the writes. In bytes.

Acceptable values are 0 to 2097152, inclusive. ||
|| maxStandbyStreamingDelay | **string** (int64)

Sets the maximum delay before canceling queries when a hot standby server is processing streamed WAL data. In milliseconds. ||
|| constraintExclusion | **enum** (ConstraintExclusion)

Enables the planner to use constraints to optimize queries.

- `CONSTRAINT_EXCLUSION_ON`: Enable planner's use of constraints for all tables.
- `CONSTRAINT_EXCLUSION_OFF`: Disable planner's use of constraints for all tables
- `CONSTRAINT_EXCLUSION_PARTITION`: Only use constraints for child tables and UNION ALL clauses. ||
|| cursorTupleFraction | **number** (double)

Sets the planner's estimate of the fraction of a cursor's rows that will be retrieved. ||
|| fromCollapseLimit | **string** (int64)

Sets the FROM-list size beyond which subqueries are not collapsed.

Acceptable values are 1 to 2147483647, inclusive. ||
|| joinCollapseLimit | **string** (int64)

Sets the FROM-list size beyond which JOIN constructs are not flattened.

Acceptable values are 1 to 2147483647, inclusive. ||
|| debugParallelQuery | **enum** (DebugParallelQuery)

Forces the planner's use parallel query nodes.

- `DEBUG_PARALLEL_QUERY_ON`: Forces parallel mode for queries considered safe, even when no performance benefit is expected.
- `DEBUG_PARALLEL_QUERY_OFF`: Uses parallel mode only when the planner expects it to improve performance.
- `DEBUG_PARALLEL_QUERY_REGRESS`: Behaves like ON, but hides added Gather nodes in EXPLAIN output and
suppresses parallel-worker context lines to stabilize regression-test output. ||
|| clientMinMessages | **enum** (LogLevel)

Sets the message levels that are sent to the client.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_INFO`: Reports information implicitly requested by the user.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinMessages | **enum** (LogLevel)

Sets the message levels that are logged.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_INFO`: Reports information implicitly requested by the user.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinErrorStatement | **enum** (LogLevel)

Causes all statements generating error at or above this level to be logged.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_INFO`: Reports information implicitly requested by the user.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinDurationStatement | **string** (int64)

Sets the minimum execution time above which all statements will be logged. In milliseconds. ||
|| logCheckpoints | **boolean**

Logs each checkpoint. ||
|| logConnections | **boolean**

Logs each successful connection. ||
|| logDisconnections | **boolean**

Logs end of a session, including duration. ||
|| logDuration | **boolean**

Logs the duration of each completed SQL statement.
 ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

Sets the verbosity of logged messages.

- `LOG_ERROR_VERBOSITY_TERSE`: DETAIL, HINT, QUERY, and CONTEXT fields are excluded from the error message.
- `LOG_ERROR_VERBOSITY_DEFAULT`: Default.
- `LOG_ERROR_VERBOSITY_VERBOSE`: Error message includes the SQLSTATE error code, source filename, function name, and the line number where the error occurred. ||
|| logLockWaits | **boolean**

Logs long lock waits. ||
|| logStatement | **enum** (LogStatement)

Sets the type of statements logged.

- `LOG_STATEMENT_NONE`: The filter is disabled, no SQL statements are logged.
- `LOG_STATEMENT_DDL`: System logs DDL statements, e.g., CREATE, ALTER, DROP etc.
- `LOG_STATEMENT_MOD`: System logs ddl-statements along with data modification commands, e.g., INSERT, UPDATE, etc.
- `LOG_STATEMENT_ALL`: System logs all SQL statements. ||
|| logTempFiles | **string** (int64)

Log the use of temporary files larger than this number of kilobytes. ||
|| searchPath | **string**

Sets the schema search order for names that are not schema-qualified. ||
|| rowSecurity | **boolean**

Enable row security. ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

Sets the transaction isolation level of each new transaction.

- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`: This level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.
- `TRANSACTION_ISOLATION_READ_COMMITTED`: On this level query sees only data committed before the query began.
- `TRANSACTION_ISOLATION_REPEATABLE_READ`: On this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).
- `TRANSACTION_ISOLATION_SERIALIZABLE`: This level provides the strictest transaction isolation.
All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction.
If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure. ||
|| statementTimeout | **string** (int64)

Sets the maximum allowed duration of any statement. In milliseconds. ||
|| lockTimeout | **string** (int64)

Sets the maximum allowed duration of any wait for a lock. In milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| idleInTransactionSessionTimeout | **string** (int64)

Sets the maximum allowed idle time between queries, when in a transaction. In milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| byteaOutput | **enum** (ByteaOutput)

Sets the output format for bytea.

- `BYTEA_OUTPUT_HEX`: Each byte is represented by two hexadecimal characters, e.g., 'SELECT '\xDEADBEEF';'.
- `BYTEA_OUTPUT_ESCAPED`: Standard PostgreSQL format with ASCII characters only. ||
|| xmlbinary | **enum** (XmlBinary)

Sets how binary values are to be encoded in XML.

- `XML_BINARY_BASE64`: Encodes binary values using Base64.
- `XML_BINARY_HEX`: Encodes binary values using hexadecimal notation. ||
|| xmloption | **enum** (XmlOption)

Sets whether XML data in implicit parsing and serialization operations is to be considered as documents or content fragments.

- `XML_OPTION_DOCUMENT`: Treats an XML value as a complete, well-formed document.
- `XML_OPTION_CONTENT`: Treats an XML value as a content fragment, which may contain multiple top-level elements or character nodes. ||
|| ginPendingListLimit | **string** (int64)

Sets the maximum size of the pending list for GIN index. In bytes. ||
|| deadlockTimeout | **string** (int64)

Sets the time to wait on a lock before checking for deadlock. In milliseconds.

Acceptable values are 1 to 2147483647, inclusive. ||
|| maxLocksPerTransaction | **string** (int64)

Sets the maximum number of locks per transaction. The shared lock table is sized on the assumption that
at most max_locks_per_transaction * max_connections distinct objects will need to be locked at any one time. ||
|| maxPredLocksPerTransaction | **string** (int64)

Sets the maximum number of predicate locks per transaction.The shared predicate lock table is sized on the assumption that
at most max_pred_locks_per_transaction * max_connections distinct objects will need to be locked at any one time. ||
|| arrayNulls | **boolean**

Enable input of NULL elements in arrays. When turned on, unquoted NULL in an array input
value means a null value; otherwise it is taken literally. ||
|| backslashQuote | **enum** (BackslashQuote)

Sets whether \"\\'\" is allowed in string literals.

- `BACKSLASH_QUOTE`: Legacy invalid value. Do not use.
- `BACKSLASH_QUOTE_ON`: Quotation mark can be represented as \'.
- `BACKSLASH_QUOTE_OFF`: Quotation mark can only be represented using the standard SQL syntax ''.
- `BACKSLASH_QUOTE_SAFE_ENCODING`: Representing a quotation mark as \' is only permitted for client encodings where \ is not used for multibyte characters. ||
|| defaultWithOids | **boolean**

WITH OIDS is no longer supported; this can only be false. ||
|| escapeStringWarning | **boolean**

Warn about backslash escapes in ordinary string literals. ||
|| loCompatPrivileges | **boolean**

Enables backward compatibility mode for privilege checks on large objects. Skips privilege checks
when reading or modifying large objects, for compatibility with PostgreSQL releases prior to 9.0. ||
|| quoteAllIdentifiers | **boolean**

When generating SQL fragments, quote all identifiers. ||
|| standardConformingStrings | **boolean**

Causes '...' strings to treat backslashes literally. ||
|| synchronizeSeqscans | **boolean**

Enable synchronized sequential scans. ||
|| transformNullEquals | **boolean**

Treats \"expr=NULL\" as \"expr IS NULL\". When turned on, expressions of the form expr = NULL
(or NULL = expr) are treated as expr IS NULL, that is, they return true if expr evaluates to the
null value, and false otherwise. The correct behavior of expr = NULL is to always return null (unknown). ||
|| exitOnError | **boolean**

Terminate session on any error. ||
|| seqPageCost | **number** (double)

Sets the planner's estimate of the cost of a sequentially fetched disk page.

The minimum value is 0. ||
|| randomPageCost | **number** (double)

Sets the planner's estimate of the cost of a nonsequentially fetched disk page.

The minimum value is 0. ||
|| enableBitmapscan | **boolean**

Enables the planner's use of bitmap-scan plans. ||
|| enableHashagg | **boolean**

Enables the planner's use of hashed aggregation plans. ||
|| enableHashjoin | **boolean**

Enables the planner's use of hash join plans. ||
|| enableIndexscan | **boolean**

Enables the planner's use of index-scan plans. ||
|| enableIndexonlyscan | **boolean**

Enables the planner's use of index-only-scan plans. ||
|| enableMaterial | **boolean**

Enables the planner's use of materialization. ||
|| enableMergejoin | **boolean**

Enables the planner's use of merge join plans. ||
|| enableNestloop | **boolean**

Enables the planner's use of nested-loop join plans. ||
|| enableSeqscan | **boolean**

Enables the planner's use of sequential-scan plans. ||
|| enableSort | **boolean**

Enables the planner's use of explicit sort steps. ||
|| enableTidscan | **boolean**

Enables the planner's use of TID scan plans. ||
|| maxParallelWorkers | **string** (int64)

Sets the maximum number of parallel workers that can be active at one time.

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkersPerGather | **string** (int64)

Sets the maximum number of parallel processes per executor node.

Acceptable values are 0 to 1024, inclusive. ||
|| timezone | **string**

Sets the time zone for displaying and interpreting time stamps. ||
|| effectiveIoConcurrency | **string** (int64)

Number of simultaneous requests that can be handled efficiently by the disk subsystem.

Acceptable values are 0 to 1000, inclusive. ||
|| effectiveCacheSize | **string** (int64)

Sets the planner's assumption about the effective size of the disk cache available to a single query. In bytes.

Acceptable values are 1048576 to 549755813888, inclusive. ||
|| idleSessionTimeout | **string** (int64)

Sets the maximum allowed idle time between queries, when not in a transaction. In milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|#

## PostgresqlHostConfig18 {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig18}

Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file
parameters which detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/18/runtime-config.html).

#|
||Field | Description ||
|| recoveryMinApplyDelay | **string** (int64)

Sets the minimum delay for applying changes during recovery. In milliseconds. ||
|| sharedBuffers | **string** (int64)

Sets the number of shared memory buffers used by the server. In bytes. ||
|| tempBuffers | **string** (int64)

Sets the maximum number of temporary buffers used by each session. In bytes. ||
|| workMem | **string** (int64)

Sets the maximum memory to be used for query workspaces. This much memory can be used by each
internal sort operation and hash table before switching to temporary disk files. In bytes. ||
|| tempFileLimit | **string** (int64)

Limits the total size of all temporary files used by each process. -1 means no limit. In bytes. ||
|| backendFlushAfter | **string** (int64)

Specifies how much data a backend can write before forcing the operating system to issue the writes. In bytes.

Acceptable values are 0 to 2097152, inclusive. ||
|| maxStandbyStreamingDelay | **string** (int64)

Sets the maximum delay before canceling queries when a hot standby server is processing streamed WAL data. In milliseconds. ||
|| constraintExclusion | **enum** (ConstraintExclusion)

Enables the planner to use constraints to optimize queries.

- `CONSTRAINT_EXCLUSION_ON`: Enable planner's use of constraints for all tables.
- `CONSTRAINT_EXCLUSION_OFF`: Disable planner's use of constraints for all tables
- `CONSTRAINT_EXCLUSION_PARTITION`: Only use constraints for child tables and UNION ALL clauses. ||
|| cursorTupleFraction | **number** (double)

Sets the planner's estimate of the fraction of a cursor's rows that will be retrieved. ||
|| fromCollapseLimit | **string** (int64)

Sets the FROM-list size beyond which subqueries are not collapsed.

Acceptable values are 1 to 2147483647, inclusive. ||
|| joinCollapseLimit | **string** (int64)

Sets the FROM-list size beyond which JOIN constructs are not flattened.

Acceptable values are 1 to 2147483647, inclusive. ||
|| debugParallelQuery | **enum** (DebugParallelQuery)

Forces the planner's use parallel query nodes.

- `DEBUG_PARALLEL_QUERY_ON`: Forces parallel mode for queries considered safe, even when no performance benefit is expected.
- `DEBUG_PARALLEL_QUERY_OFF`: Uses parallel mode only when the planner expects it to improve performance.
- `DEBUG_PARALLEL_QUERY_REGRESS`: Behaves like ON, but hides added Gather nodes in EXPLAIN output and
suppresses parallel-worker context lines to stabilize regression-test output. ||
|| clientMinMessages | **enum** (LogLevel)

Sets the message levels that are sent to the client.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_INFO`: Reports information implicitly requested by the user.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinMessages | **enum** (LogLevel)

Sets the message levels that are logged.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_INFO`: Reports information implicitly requested by the user.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinErrorStatement | **enum** (LogLevel)

Causes all statements generating error at or above this level to be logged.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_INFO`: Reports information implicitly requested by the user.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinDurationStatement | **string** (int64)

Sets the minimum execution time above which all statements will be logged. In milliseconds. ||
|| logCheckpoints | **boolean**

Logs each checkpoint. ||
|| logConnections | **boolean**

Logs each successful connection. ||
|| logDisconnections | **boolean**

Logs end of a session, including duration. ||
|| logDuration | **boolean**

Logs the duration of each completed SQL statement.
 ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

Sets the verbosity of logged messages.

- `LOG_ERROR_VERBOSITY_TERSE`: DETAIL, HINT, QUERY, and CONTEXT fields are excluded from the error message.
- `LOG_ERROR_VERBOSITY_DEFAULT`: Default.
- `LOG_ERROR_VERBOSITY_VERBOSE`: Error message includes the SQLSTATE error code, source filename, function name, and the line number where the error occurred. ||
|| logLockWaits | **boolean**

Logs long lock waits. ||
|| logStatement | **enum** (LogStatement)

Sets the type of statements logged.

- `LOG_STATEMENT_NONE`: The filter is disabled, no SQL statements are logged.
- `LOG_STATEMENT_DDL`: System logs DDL statements, e.g., CREATE, ALTER, DROP etc.
- `LOG_STATEMENT_MOD`: System logs ddl-statements along with data modification commands, e.g., INSERT, UPDATE, etc.
- `LOG_STATEMENT_ALL`: System logs all SQL statements. ||
|| logTempFiles | **string** (int64)

Log the use of temporary files larger than this number of kilobytes. ||
|| searchPath | **string**

Sets the schema search order for names that are not schema-qualified. ||
|| rowSecurity | **boolean**

Enable row security. ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

Sets the transaction isolation level of each new transaction.

- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`: This level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.
- `TRANSACTION_ISOLATION_READ_COMMITTED`: On this level query sees only data committed before the query began.
- `TRANSACTION_ISOLATION_REPEATABLE_READ`: On this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).
- `TRANSACTION_ISOLATION_SERIALIZABLE`: This level provides the strictest transaction isolation.
All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction.
If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure. ||
|| statementTimeout | **string** (int64)

Sets the maximum allowed duration of any statement. In milliseconds. ||
|| lockTimeout | **string** (int64)

Sets the maximum allowed duration of any wait for a lock. In milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| idleInTransactionSessionTimeout | **string** (int64)

Sets the maximum allowed idle time between queries, when in a transaction. In milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| byteaOutput | **enum** (ByteaOutput)

Sets the output format for bytea.

- `BYTEA_OUTPUT_HEX`: Each byte is represented by two hexadecimal characters, e.g., 'SELECT '\xDEADBEEF';'.
- `BYTEA_OUTPUT_ESCAPED`: Standard PostgreSQL format with ASCII characters only. ||
|| xmlbinary | **enum** (XmlBinary)

Sets how binary values are to be encoded in XML.

- `XML_BINARY_BASE64`: Encodes binary values using Base64.
- `XML_BINARY_HEX`: Encodes binary values using hexadecimal notation. ||
|| xmloption | **enum** (XmlOption)

Sets whether XML data in implicit parsing and serialization operations is to be considered as documents or content fragments.

- `XML_OPTION_DOCUMENT`: Treats an XML value as a complete, well-formed document.
- `XML_OPTION_CONTENT`: Treats an XML value as a content fragment, which may contain multiple top-level elements or character nodes. ||
|| ginPendingListLimit | **string** (int64)

Sets the maximum size of the pending list for GIN index. In bytes. ||
|| deadlockTimeout | **string** (int64)

Sets the time to wait on a lock before checking for deadlock. In milliseconds.

Acceptable values are 1 to 2147483647, inclusive. ||
|| maxLocksPerTransaction | **string** (int64)

Sets the maximum number of locks per transaction. The shared lock table is sized on the assumption that
at most max_locks_per_transaction * max_connections distinct objects will need to be locked at any one time. ||
|| maxPredLocksPerTransaction | **string** (int64)

Sets the maximum number of predicate locks per transaction.The shared predicate lock table is sized on the assumption that
at most max_pred_locks_per_transaction * max_connections distinct objects will need to be locked at any one time. ||
|| arrayNulls | **boolean**

Enable input of NULL elements in arrays. When turned on, unquoted NULL in an array input
value means a null value; otherwise it is taken literally. ||
|| backslashQuote | **enum** (BackslashQuote)

Sets whether \"\\'\" is allowed in string literals.

- `BACKSLASH_QUOTE`: Legacy invalid value. Do not use.
- `BACKSLASH_QUOTE_ON`: Quotation mark can be represented as \'.
- `BACKSLASH_QUOTE_OFF`: Quotation mark can only be represented using the standard SQL syntax ''.
- `BACKSLASH_QUOTE_SAFE_ENCODING`: Representing a quotation mark as \' is only permitted for client encodings where \ is not used for multibyte characters. ||
|| defaultWithOids | **boolean**

WITH OIDS is no longer supported; this can only be false. ||
|| escapeStringWarning | **boolean**

Warn about backslash escapes in ordinary string literals. ||
|| loCompatPrivileges | **boolean**

Enables backward compatibility mode for privilege checks on large objects. Skips privilege checks
when reading or modifying large objects, for compatibility with PostgreSQL releases prior to 9.0. ||
|| quoteAllIdentifiers | **boolean**

When generating SQL fragments, quote all identifiers. ||
|| standardConformingStrings | **boolean**

Causes '...' strings to treat backslashes literally. ||
|| synchronizeSeqscans | **boolean**

Enable synchronized sequential scans. ||
|| transformNullEquals | **boolean**

Treats \"expr=NULL\" as \"expr IS NULL\". When turned on, expressions of the form expr = NULL
(or NULL = expr) are treated as expr IS NULL, that is, they return true if expr evaluates to the
null value, and false otherwise. The correct behavior of expr = NULL is to always return null (unknown). ||
|| exitOnError | **boolean**

Terminate session on any error. ||
|| seqPageCost | **number** (double)

Sets the planner's estimate of the cost of a sequentially fetched disk page.

The minimum value is 0. ||
|| randomPageCost | **number** (double)

Sets the planner's estimate of the cost of a nonsequentially fetched disk page.

The minimum value is 0. ||
|| enableBitmapscan | **boolean**

Enables the planner's use of bitmap-scan plans. ||
|| enableHashagg | **boolean**

Enables the planner's use of hashed aggregation plans. ||
|| enableHashjoin | **boolean**

Enables the planner's use of hash join plans. ||
|| enableIndexscan | **boolean**

Enables the planner's use of index-scan plans. ||
|| enableIndexonlyscan | **boolean**

Enables the planner's use of index-only-scan plans. ||
|| enableMaterial | **boolean**

Enables the planner's use of materialization. ||
|| enableMergejoin | **boolean**

Enables the planner's use of merge join plans. ||
|| enableNestloop | **boolean**

Enables the planner's use of nested-loop join plans. ||
|| enableSeqscan | **boolean**

Enables the planner's use of sequential-scan plans. ||
|| enableSort | **boolean**

Enables the planner's use of explicit sort steps. ||
|| enableTidscan | **boolean**

Enables the planner's use of TID scan plans. ||
|| maxParallelWorkers | **string** (int64)

Sets the maximum number of parallel workers that can be active at one time.

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkersPerGather | **string** (int64)

Sets the maximum number of parallel processes per executor node.

Acceptable values are 0 to 1024, inclusive. ||
|| timezone | **string**

Sets the time zone for displaying and interpreting time stamps. ||
|| effectiveIoConcurrency | **string** (int64)

Number of simultaneous requests that can be handled efficiently by the disk subsystem.

Acceptable values are 0 to 1000, inclusive. ||
|| effectiveCacheSize | **string** (int64)

Sets the planner's assumption about the effective size of the disk cache available to a single query. In bytes.

Acceptable values are 1048576 to 549755813888, inclusive. ||
|| idleSessionTimeout | **string** (int64)

Sets the maximum allowed idle time between queries, when not in a transaction. In milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|#

## PostgresqlHostConfig18_1C {#yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig18_1C}

Options and structure of `PostgresqlConfig` reflects PostgreSQL configuration file
parameters which detailed description is available in
[PostgreSQL documentation](https://www.postgresql.org/docs/18/runtime-config.html).

#|
||Field | Description ||
|| recoveryMinApplyDelay | **string** (int64)

Sets the minimum delay for applying changes during recovery. In milliseconds. ||
|| sharedBuffers | **string** (int64)

Sets the number of shared memory buffers used by the server. In bytes. ||
|| tempBuffers | **string** (int64)

Sets the maximum number of temporary buffers used by each session. In bytes. ||
|| workMem | **string** (int64)

Sets the maximum memory to be used for query workspaces. This much memory can be used by each
internal sort operation and hash table before switching to temporary disk files. In bytes. ||
|| tempFileLimit | **string** (int64)

Limits the total size of all temporary files used by each process. -1 means no limit. In bytes. ||
|| backendFlushAfter | **string** (int64)

Specifies how much data a backend can write before forcing the operating system to issue the writes. In bytes.

Acceptable values are 0 to 2097152, inclusive. ||
|| maxStandbyStreamingDelay | **string** (int64)

Sets the maximum delay before canceling queries when a hot standby server is processing streamed WAL data. In milliseconds. ||
|| constraintExclusion | **enum** (ConstraintExclusion)

Enables the planner to use constraints to optimize queries.

- `CONSTRAINT_EXCLUSION_ON`: Enable planner's use of constraints for all tables.
- `CONSTRAINT_EXCLUSION_OFF`: Disable planner's use of constraints for all tables
- `CONSTRAINT_EXCLUSION_PARTITION`: Only use constraints for child tables and UNION ALL clauses. ||
|| cursorTupleFraction | **number** (double)

Sets the planner's estimate of the fraction of a cursor's rows that will be retrieved. ||
|| fromCollapseLimit | **string** (int64)

Sets the FROM-list size beyond which subqueries are not collapsed.

Acceptable values are 1 to 2147483647, inclusive. ||
|| joinCollapseLimit | **string** (int64)

Sets the FROM-list size beyond which JOIN constructs are not flattened.

Acceptable values are 1 to 2147483647, inclusive. ||
|| debugParallelQuery | **enum** (DebugParallelQuery)

Forces the planner's use parallel query nodes.

- `DEBUG_PARALLEL_QUERY_ON`: Forces parallel mode for queries considered safe, even when no performance benefit is expected.
- `DEBUG_PARALLEL_QUERY_OFF`: Uses parallel mode only when the planner expects it to improve performance.
- `DEBUG_PARALLEL_QUERY_REGRESS`: Behaves like ON, but hides added Gather nodes in EXPLAIN output and
suppresses parallel-worker context lines to stabilize regression-test output. ||
|| clientMinMessages | **enum** (LogLevel)

Sets the message levels that are sent to the client.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_INFO`: Reports information implicitly requested by the user.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinMessages | **enum** (LogLevel)

Sets the message levels that are logged.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_INFO`: Reports information implicitly requested by the user.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinErrorStatement | **enum** (LogLevel)

Causes all statements generating error at or above this level to be logged.

- `LOG_LEVEL_DEBUG5`: Provides the most detailed diagnostic information for developers.
- `LOG_LEVEL_DEBUG4`: Provides more detailed diagnostic information than DEBUG3.
- `LOG_LEVEL_DEBUG3`: Provides more detailed diagnostic information than DEBUG2.
- `LOG_LEVEL_DEBUG2`: Provides more detailed diagnostic information than DEBUG1.
- `LOG_LEVEL_DEBUG1`: Provides diagnostic information for developers.
- `LOG_LEVEL_INFO`: Reports information implicitly requested by the user.
- `LOG_LEVEL_LOG`: Reports information of interest to database administrators.
- `LOG_LEVEL_NOTICE`: Reports information that may be helpful to users.
- `LOG_LEVEL_WARNING`: Reports a warning about a likely problem.
- `LOG_LEVEL_ERROR`: Reports an error that aborts the current command.
- `LOG_LEVEL_FATAL`: Reports an error that aborts the current session.
- `LOG_LEVEL_PANIC`: Reports an error that aborts all database sessions. ||
|| logMinDurationStatement | **string** (int64)

Sets the minimum execution time above which all statements will be logged. In milliseconds. ||
|| logCheckpoints | **boolean**

Logs each checkpoint. ||
|| logConnections | **boolean**

Logs each successful connection. ||
|| logDisconnections | **boolean**

Logs end of a session, including duration. ||
|| logDuration | **boolean**

Logs the duration of each completed SQL statement.
 ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

Sets the verbosity of logged messages.

- `LOG_ERROR_VERBOSITY_TERSE`: DETAIL, HINT, QUERY, and CONTEXT fields are excluded from the error message.
- `LOG_ERROR_VERBOSITY_DEFAULT`: Default.
- `LOG_ERROR_VERBOSITY_VERBOSE`: Error message includes the SQLSTATE error code, source filename, function name, and the line number where the error occurred. ||
|| logLockWaits | **boolean**

Logs long lock waits. ||
|| logStatement | **enum** (LogStatement)

Sets the type of statements logged.

- `LOG_STATEMENT_NONE`: The filter is disabled, no SQL statements are logged.
- `LOG_STATEMENT_DDL`: System logs DDL statements, e.g., CREATE, ALTER, DROP etc.
- `LOG_STATEMENT_MOD`: System logs ddl-statements along with data modification commands, e.g., INSERT, UPDATE, etc.
- `LOG_STATEMENT_ALL`: System logs all SQL statements. ||
|| logTempFiles | **string** (int64)

Log the use of temporary files larger than this number of kilobytes. ||
|| searchPath | **string**

Sets the schema search order for names that are not schema-qualified. ||
|| rowSecurity | **boolean**

Enable row security. ||
|| defaultTransactionIsolation | **enum** (TransactionIsolation)

Sets the transaction isolation level of each new transaction.

- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`: This level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.
- `TRANSACTION_ISOLATION_READ_COMMITTED`: On this level query sees only data committed before the query began.
- `TRANSACTION_ISOLATION_REPEATABLE_READ`: On this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).
- `TRANSACTION_ISOLATION_SERIALIZABLE`: This level provides the strictest transaction isolation.
All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction.
If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure. ||
|| statementTimeout | **string** (int64)

Sets the maximum allowed duration of any statement. In milliseconds. ||
|| lockTimeout | **string** (int64)

Sets the maximum allowed duration of any wait for a lock. In milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| idleInTransactionSessionTimeout | **string** (int64)

Sets the maximum allowed idle time between queries, when in a transaction. In milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
|| byteaOutput | **enum** (ByteaOutput)

Sets the output format for bytea.

- `BYTEA_OUTPUT_HEX`: Each byte is represented by two hexadecimal characters, e.g., 'SELECT '\xDEADBEEF';'.
- `BYTEA_OUTPUT_ESCAPED`: Standard PostgreSQL format with ASCII characters only. ||
|| xmlbinary | **enum** (XmlBinary)

Sets how binary values are to be encoded in XML.

- `XML_BINARY_BASE64`: Encodes binary values using Base64.
- `XML_BINARY_HEX`: Encodes binary values using hexadecimal notation. ||
|| xmloption | **enum** (XmlOption)

Sets whether XML data in implicit parsing and serialization operations is to be considered as documents or content fragments.

- `XML_OPTION_DOCUMENT`: Treats an XML value as a complete, well-formed document.
- `XML_OPTION_CONTENT`: Treats an XML value as a content fragment, which may contain multiple top-level elements or character nodes. ||
|| ginPendingListLimit | **string** (int64)

Sets the maximum size of the pending list for GIN index. In bytes. ||
|| deadlockTimeout | **string** (int64)

Sets the time to wait on a lock before checking for deadlock. In milliseconds.

Acceptable values are 1 to 2147483647, inclusive. ||
|| maxLocksPerTransaction | **string** (int64)

Sets the maximum number of locks per transaction. The shared lock table is sized on the assumption that
at most max_locks_per_transaction * max_connections distinct objects will need to be locked at any one time. ||
|| maxPredLocksPerTransaction | **string** (int64)

Sets the maximum number of predicate locks per transaction.The shared predicate lock table is sized on the assumption that
at most max_pred_locks_per_transaction * max_connections distinct objects will need to be locked at any one time. ||
|| arrayNulls | **boolean**

Enable input of NULL elements in arrays. When turned on, unquoted NULL in an array input
value means a null value; otherwise it is taken literally. ||
|| backslashQuote | **enum** (BackslashQuote)

Sets whether \"\\'\" is allowed in string literals.

- `BACKSLASH_QUOTE`: Legacy invalid value. Do not use.
- `BACKSLASH_QUOTE_ON`: Quotation mark can be represented as \'.
- `BACKSLASH_QUOTE_OFF`: Quotation mark can only be represented using the standard SQL syntax ''.
- `BACKSLASH_QUOTE_SAFE_ENCODING`: Representing a quotation mark as \' is only permitted for client encodings where \ is not used for multibyte characters. ||
|| defaultWithOids | **boolean**

WITH OIDS is no longer supported; this can only be false. ||
|| escapeStringWarning | **boolean**

Warn about backslash escapes in ordinary string literals. ||
|| loCompatPrivileges | **boolean**

Enables backward compatibility mode for privilege checks on large objects. Skips privilege checks
when reading or modifying large objects, for compatibility with PostgreSQL releases prior to 9.0. ||
|| quoteAllIdentifiers | **boolean**

When generating SQL fragments, quote all identifiers. ||
|| standardConformingStrings | **boolean**

Causes '...' strings to treat backslashes literally. ||
|| synchronizeSeqscans | **boolean**

Enable synchronized sequential scans. ||
|| transformNullEquals | **boolean**

Treats \"expr=NULL\" as \"expr IS NULL\". When turned on, expressions of the form expr = NULL
(or NULL = expr) are treated as expr IS NULL, that is, they return true if expr evaluates to the
null value, and false otherwise. The correct behavior of expr = NULL is to always return null (unknown). ||
|| exitOnError | **boolean**

Terminate session on any error. ||
|| seqPageCost | **number** (double)

Sets the planner's estimate of the cost of a sequentially fetched disk page.

The minimum value is 0. ||
|| randomPageCost | **number** (double)

Sets the planner's estimate of the cost of a nonsequentially fetched disk page.

The minimum value is 0. ||
|| enableBitmapscan | **boolean**

Enables the planner's use of bitmap-scan plans. ||
|| enableHashagg | **boolean**

Enables the planner's use of hashed aggregation plans. ||
|| enableHashjoin | **boolean**

Enables the planner's use of hash join plans. ||
|| enableIndexscan | **boolean**

Enables the planner's use of index-scan plans. ||
|| enableIndexonlyscan | **boolean**

Enables the planner's use of index-only-scan plans. ||
|| enableMaterial | **boolean**

Enables the planner's use of materialization. ||
|| enableMergejoin | **boolean**

Enables the planner's use of merge join plans. ||
|| enableNestloop | **boolean**

Enables the planner's use of nested-loop join plans. ||
|| enableSeqscan | **boolean**

Enables the planner's use of sequential-scan plans. ||
|| enableSort | **boolean**

Enables the planner's use of explicit sort steps. ||
|| enableTidscan | **boolean**

Enables the planner's use of TID scan plans. ||
|| maxParallelWorkers | **string** (int64)

Sets the maximum number of parallel workers that can be active at one time.

Acceptable values are 0 to 1024, inclusive. ||
|| maxParallelWorkersPerGather | **string** (int64)

Sets the maximum number of parallel processes per executor node.

Acceptable values are 0 to 1024, inclusive. ||
|| timezone | **string**

Sets the time zone for displaying and interpreting time stamps. ||
|| effectiveIoConcurrency | **string** (int64)

Number of simultaneous requests that can be handled efficiently by the disk subsystem.

Acceptable values are 0 to 1000, inclusive. ||
|| effectiveCacheSize | **string** (int64)

Sets the planner's assumption about the effective size of the disk cache available to a single query. In bytes.

Acceptable values are 1048576 to 549755813888, inclusive. ||
|| idleSessionTimeout | **string** (int64)

Sets the maximum allowed idle time between queries, when not in a transaction. In milliseconds.

Acceptable values are 0 to 2147483647, inclusive. ||
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
|| metadata | **[AddClusterHostsMetadata](#yandex.cloud.mdb.postgresql.v1.AddClusterHostsMetadata)**

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

## AddClusterHostsMetadata {#yandex.cloud.mdb.postgresql.v1.AddClusterHostsMetadata}

#|
||Field | Description ||
|| clusterId | **string**

ID of the PostgreSQL cluster to which the hosts are being added. ||
|| hostNames[] | **string**

Names of hosts that are being added to the cluster. ||
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