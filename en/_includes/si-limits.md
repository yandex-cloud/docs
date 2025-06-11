### {{ sw-name }} {#workflows}

#### Quotas {#sw-quotas}


Type of limitation | Value
--- | ---
Maximum number of [workflows](../serverless-integrations/concepts/workflows/workflow.md) per cloud | 30
Maximum number of active [workflow executions](../serverless-integrations/concepts/workflows/execution.md) per cloud | 100

#### Limits {#sw-limits}

Type of limitation | Value
--- | ---
Maximum number of workflow steps considering all [Parallel](../serverless-integrations/concepts/workflows/yawl/management/parallel.md) and [Foreach](../serverless-integrations/concepts/workflows/yawl/management/foreach.md) execution branches | 1000
Maximum step execution time | 15 minutes
Maximum step execution time, including retry attempts | 24 hours
Maximum execution duration | 48 hours
Maximum number of step retry attempts | 100
Maximum input and output data size per workflow step | 2 MB

### {{ er-name }} {#eventrouter}

#### Quotas {#er-quotas}

Type of limitation | Value
--- | ---
Maximum number of buses per cloud | 10
Maximum number of connectors across all buses per cloud | 20
Maximum number of rules across all buses per cloud | 50

#### Limits {#er-limits}

Type of limitation | Value
--- | ---
Maximum number of targets per rule | 5
Maximum size of a message transmitted to the bus | 256 KB
