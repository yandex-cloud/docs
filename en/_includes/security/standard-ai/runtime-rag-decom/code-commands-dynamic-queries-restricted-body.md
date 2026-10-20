{#ai-infra-isol3-id}

Requirement ID: `AI-INFRA-ISOL3`

{#ai-infra-isol3-requirement}

**Requirement**

If a model or agent can generate code, command, SQL or another executable query, execution must take place in a separate environment with minimum identity, an explicit list of available processes and storages, limited CPUs, memory, and time, controlled file system and network. For permitted outputs, the exact recipients and operations are specified. Unknown output is forbidden.

The state is linked to a specific task or tenant; a timeout or boundary violation forcibly terminates the process, and temporary data gets purged. Production secrets and administrative permissions are not transferred solely for ease of execution.

In absence of such execution paths, the `N/A` result is permitted only together with inventory of execution points. For SQL, parameterized queries and query policies are used.

{#ai-infra-isol3-implementation}

**Implementation**

For {{ k8s }}, limitations are implemented by pod and container security settings, RBAC, network policy, and resource limits to the extent of the [{{ k8s }} security guide](../../../../security/domains/kubernetes.md).

For {{ serverless-containers-name }} and {{ sf-name }}, you should consider the limits and properties of the specific revision or version from the [{#T}](../../../../security/standard-ai/profiles.md#profile-serverless) profile. Runtime isolation does not replace the model output check by `AI-CONTENT2`.

In {{ k8s }}, the load is not started from root, with prohibition on elevation of privileges and host namespaces, and a limit on volumes and outgoing traffic. {{ yandex-cloud }} does not provide a universal isolation switch for executable AI code.

{#ai-infra-isol3-manual-check}

**Manual check**

1. Run a permitted operation with a permitted temporary object.
1. Then run a synthetic command attempting to create a child process outside the list, read a file belonging to another user, write to persistent storage, access a forbidden address or metadata service, exceed the resource limit, and survive a timeout.

None of the attempts must go beyond the approved environment boundaries. After the check, confirm the process completion and test data cleanup.

{#ai-infra-isol3-artifacts}

**Artifact**

* Permitted operation.
* Boundary tests.
* Process completion.
* List of permitted operations.
* Confirmation of absence of side effects.
