{#ai-agent1-id}

Requirement ID: `AI-AGENT1`

{#ai-agent1-requirement}

**Requirement**

Prior to production use, the owner must list the tools, data, recipients, and actions available to the agent, as well as the maximum consequences of each action. The classification must reflect the actual capabilities: reading, modifying, publishing, financial action, code execution, access management, or impact on an external object.

The registry is built based on the actual configuration of the agent, orchestrator, and MCP Gateway, not project descriptions, and takes into account the direct bypass to the target system and third-party provider tools. A capability not described in the registry gets rejected before reaching the target system; the registry version is linked to the release.

The model's response does not limit the actual privileges. These are determined by the available endpoint, backend identity, and permissions for the target.

{#ai-agent1-manual-check}

**Manual check**

1. Map the capability registry to the configurations of the agent, MCP Gateway, backend, and target permissions.
1. For each registered capability, perform one safe allow test; an action with a stronger effect than described gets rejected before calling the target system.

An unaccounted tool or a broader actual action blocks the release.

{#ai-agent1-artifacts}

**Artifact**

* Capability registry.
* Mapping to configuration.
* Registry version.
* Test events.
