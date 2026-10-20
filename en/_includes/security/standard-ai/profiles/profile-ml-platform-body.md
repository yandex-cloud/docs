{#profile-ml-platform-applicability}

**Scope and status**

This profile is applied to notebooks, tasks, nodes, and published {{ ml-platform-name }} resources. The managed environment does not replace data provenance tracking, model acceptance, and release decision.

{#profile-ml-platform-flow}

**Flow and trust boundaries**

`user or CI → community and project → notebook/task/node → storages and external services → model artifact → release`. Project membership, task workload identity, and access to an external resource are different boundaries.

{#profile-ml-platform-authentication}

**Workload identity and authentication**

The project user, the associated project service account, and the community service agent are kept separate. To run tasks under a service account, the latter has to be added to the project; its permissions for external resources are assigned separately.

In the documented branch of a task with a service agent, its token is saved to a file, the path to which the task gets via `SA_TOKEN_FILENAME`. The official guide does not define this file's permissions or process isolation: the task owner separately configures access to the path using the selected image's tools and does not transfer the token into task parameters, logs, or evidence.

{#profile-ml-platform-roles}

**Roles and scope**

The project uses `datasphere.community-projects.viewer`, `datasphere.community-projects.developer`, `datasphere.community-projects.editor`, and `datasphere.community-projects.admin` depending on which operation is required. For the community, `datasphere.communities.viewer`, `datasphere.communities.developer`, `datasphere.communities.editor`, and `datasphere.communities.admin` are used separately.

For a task under a service account, the `datasphere.community-projects.developer` role for the project is checked; a broad role for the cloud does not replace access to the project.

If the service agent of the task is reading {{ lockbox-short-name }}, it gets the `lockbox.payloadViewer` role for the particular secret. If the secret uses a custom {{ kms-short-name }} key, it gets the `kms.keys.encrypterDecrypter` role for that key as per the [{{ lockbox-short-name }} access model](../../../../lockbox/security/index.md).

{{ ml-platform-name }} relevant operations and inheritance are cross-checked against the [service access model](../../../../datasphere/security/index.md).

{#profile-ml-platform-network}

**Network**

The default or custom subnet, {{ vpc-short-name }}, security groups, and outbound path are recorded. A project in a service subnet has documented internet access; a custom subnet without configured NAT does not get it.

For a custom subnet, the project's service account needs the `vpc.user` role; if internet access is maintained via a NAT gateway, the `vpc.gateways.user` role is additionally required as per the [project settings](../../../../datasphere/operations/projects/update.md). Roles are assigned for an actually selected network or gateway, but not entire cloud.

For notebooks and tasks, no direct access to the subnet is declared. If a node or alias is published, the endpoint and public/private status get recorded; [{{ ml-platform-name }} docs](../../../../datasphere/operations/deploy/alias-api.md) state that the public alias is accessible to all authenticated {{ yandex-cloud }} users, while the private one requires the described project permissions. If no node or alias exists, this inbound branch is marked as `N/A`.

{#profile-ml-platform-secrets}

**Secrets and credentials**

For a [project secret](../../../../datasphere/concepts/secrets.md), its ID, owner, and scope are specified, but not the value.

For a task that accesses {{ lockbox-short-name }}, the following are recorded: service agent, specific secret, bindings of the `lockbox.payloadViewer` role and applicable {{ kms-short-name }} permission, as well as the `SA_TOKEN_FILENAME` variable name according to the [official guide](../../../../datasphere/operations/projects/jobs-with-ssa.md). The selected image and task specification must separately limit the path users; the token value and secret content do not form part of the evidence.

{#profile-ml-platform-configuration}

**Configuration objects**

Community and project IDs, participants and roles, project service account and community service agent, cloud networks, subnets, security groups, NAT gateways, `SA_TOKEN_FILENAME` (without the token value) and the selected restriction of path access, limits, task ID and specification, task data period, secrets, datasets, files, artifacts, node, and alias.

{#profile-ml-platform-telemetry}

**Telemetry and blind spots**

[{{ at-name }} in {{ ml-platform-name }}](../../../../datasphere/at-ref.md) covers published management-plane operations. Node and alias metrics show operational status, but not cell execution, data content, prompt logs, or the full provenance chain; these are covered by process logs and the provenance card.

{#profile-ml-platform-checks}

**Positive and negative checks**

1. Start as an authorized or unauthorized user or service account. Check the task's access to an allowed and forbidden resource.
1. For the service agent branch, check a successful API call with a token from `SA_TOKEN_FILENAME`, denial after the role is revoked, and that no token value is present in parameters and logs.
1. Verify the outbound path of the custom subnet, secret visibility, task data period, and management event without displaying the token or secret value.
1. Trace the dataset and model package through to release.

{#profile-ml-platform-inputs}

**What you need for profile implementation**

* Architecture: projects, workload types, network, sources, and recipients.
* Policy: roles, limits, TTL, shared access, and internet access.
* Legal approach: training data and usage permissions. If undocumented telemetry of data operations is required, it must not be claimed until there is an official source; until then, it remains an application-level blind spot.
