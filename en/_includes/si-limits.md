### {{ sw-name }} {#workflows}

#### Quotas {#sw-quotas}


Type of limit | Value
--- | ---
Maximum number of [workflows](../serverless-integrations/concepts/workflows/workflow.md) per cloud | 30
Maximum number of active [workflow](../serverless-integrations/concepts/workflows/execution.md) executions per cloud | 100
Maximum execution duration | 48 hours

#### Limits {#sw-limits}

Type of limit | Value
--- | ---
Maximum step execution time | 10 minutes
Maximum step execution time, including retry attempts | 24 hours
Maximum number of step retry attempts | 100
Maximum input and output data size per workflow step | 2 MB

In addition to those listed above, there are limits on the number of steps and the total volume of input and output data for all steps within a workflow. If these limits are exceeded, the workflow execution will fail with an error.

### {{ er-name }} {#eventrouter}

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
