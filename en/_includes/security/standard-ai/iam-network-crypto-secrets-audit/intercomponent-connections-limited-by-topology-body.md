{#ai-net2-id}

Requirement ID: `AI-NET2`

{#ai-net2-requirement}

**Requirement**

The system owner must define permitted inbound, outbound, and intercomponent connections between the application, model API, RAG store, agent, tool, and logs. For the purpose of communication, the following are recorded: purpose, owner, source, recipient, and application authentication method. Where the service supports {{ vpc-short-name }} and security groups, the rules must allow only the necessary directions, protocols, ports, and sources.

{#ai-net2-implementation}

**Implementation**

[{{ vpc-short-name }} security groups](../../../../vpc/concepts/security-groups.md) track connection status. They do not perform document-level authorization, nor inspect the semantics of model requests.

For serverless and managed services, the published network connection method must be verified separately. The [{{ serverless-containers-name }}](../../../../serverless-containers/index.yaml) and [{{ sf-name }}](../../../../functions/index.yaml) network connection controls outbound access to a custom {{ vpc-short-name }} but does not constitute a private ingress to the instance. The managed {{ ai-studio-name }} API is not assigned any custom subnets or private endpoints that are not documented. [{{ iam-full-name }}](../../../../iam/index.yaml) does not replace the internal {{ k8s }} or {{ OS }} RBAC at the data level.

{#ai-net2-check}

**Check**

1. Map the rules to the stream diagram and execute an allowed and a denied connection for each boundary.
1. Pay special attention to broad access rules, shared service accounts, and paths bypassing the gateway.
1. Check the actual connection, route, and application denial, not just the security group configuration; when fixed, a broad rule is not replaced by a `0.0.0.0/0` rule.

{#ai-net2-artifacts}

**Artifact**

* Flow diagram.
* Security group rules.
* Allowed and denied connection.
* Connection results from allowed and denied sources.
