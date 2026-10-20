{#ai-infra-isol2-id}

Requirement ID: `AI-INFRA-ISOL2`

{#ai-infra-isol2-applicability}

**Scope**

The requirement applies if the same environment, in sequence or in parallel, serves independent tasks, sessions, users, or tenants, whether the generated code can be executed or not.

{#ai-infra-isol2-requirement}

**Requirement**

Temporary files, cache, session memory, and alternative operational state must be created for a specific task or access scope and cleaned up on completion. A long-lived state is allowed only in a named external storage with application-level authorization, life period, and cleanup rules. Reusing a process or instance by the managed service must not result in reusing data of another task.

State inventory covers memory, temporary files, cache, session storage, and volumes of the selected environment. For each one of them, a scope, lifespan, and cleanup procedure are specified. A dialog application may save an explicitly limited state of an authenticated subject’s session. An unrelated state is not inherited.

{{ serverless-containers-name }} and {{ sf-name }} provide managed instance lifecycle; however, the application must not see the completion of a specific request as a guaranteed destruction of the instance. For {{ k8s }} and {{ compute-name }}, the boundary of the process, pods, VMs, or a specific working directory is defined by the architecture. An end of a serverless revision or pod restart is not by itself an evidence of application state cleanup; the task status and {{ ml-platform-name }} notebook status are two different things.

{#ai-infra-isol2-check}

**Check**

1. During the first test session, create a synthetic marker in temporary state, complete the task, and start an independent session.
1. If the state is preserved intentionally, show its owner, authorization, and cleanup time.

The marker must not be accessible through the app, file path, cache, or diagnostic interface. The marker is also checked using the key cache; the previous implementation is returned only after a successful retest with the marker.

{#ai-infra-isol2-artifacts}

**Artifact**

* Synthetic marker.
* Unavailability after task completion.
* State map with lifespans.
* Cleanup event.
