### {{ sw-name }}

#### Limits {#sw-limits}

Type of limit | Value
--- | ---
Maximum number of active [workflow](../serverless-integrations/concepts/workflows/workflow.md) runs per cloud | 100
Maximum number of workflow steps considering all [Parallel](../serverless-integrations/concepts/workflows/yawl.md#Parallel) and [Foreach](../serverless-integrations/concepts/workflows/yawl.md#Foreach) execution branches | 1000
Maximum step execution time | 15 minutes
Maximum step execution time, including retry attempts | 24 hours
Maximum run execution time | 48 hours
Maximum number of step retry attempts | 100
Maximum input and output data size per workflow step | 2 MB

### {{ er-name }}

#### Quotas {#er-quotas}

Type of limit | Value
--- | ---
Maximum number of buses per cloud | 10
Maximum number of connectors across all buses per cloud | 20
Maximum number of rules across all buses per cloud | 50

#### Limits {#er-limits}

Type of limit | Value
--- | ---
Maximum number of targets per rule | 5
Maximum size of a message transmitted to the bus | 256 KB
