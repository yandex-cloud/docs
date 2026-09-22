### Yandex DataSphere service accounts must not be assigned critical roles {#datasphere-sa-privileges}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | medium | ai.datasphere-sa-privileges ||
|#

#### Description

**How the rule works:** The system verifies that the service accounts linked to Yandex DataSphere [communities](https://yandex.cloud/en/docs/datasphere/concepts/community) or projects do not have any roles higher than `editor`.

In DataSphere, user ML code, [jobs](https://yandex.cloud/en/docs/datasphere/concepts/jobs/), and operations with DataSphere Notebook can be run under a project or community service account or [service agent](https://yandex.cloud/en/docs/iam/concepts/service-control#service-agent); this requires strict adherence to least privilege principle. Roles that allow managing [Yandex Identity and Access Management](https://yandex.cloud/en/docs/iam/security/#service-roles), [service accounts](https://yandex.cloud/en/docs/iam/security/#iam-serviceAccounts-admin), secrets, encryption keys, object storages, virtual machines, networks, or AI resources pose a particularly high security risk.

#### Instructions and solutions

1. Get the list of DataSphere projects and communities:

   ```bash
   yc datasphere community list --format json yc datasphere project list --community-id <id> --format json 
   ```

   If your version does not support CLI commands, use REST API or UI export:
   * [Community list](https://datasphere.api.cloud.yandex.net/datasphere/v2/communities)
   * [Project list](https://datasphere.api.cloud.yandex.net/datasphere/v2/projects?communityId=<id>)
1. For each project or community, identify the associated service account or agent. If the field in question is unavailable in CLI or API, check the details in the [Datasphere UI](https://datasphere.yandex.cloud/communities). 
1. Check the access permissions these service accounts have by using [CIEM](https://yandex.cloud/en/docs/security-deck/operations/ciem/view-permissions). 
1. The current DataSphere roles that must be cross-referenced with the Yandex Identity and Access Management [role reference](https://yandex.cloud/en/docs/iam/roles-reference#datasphere-roles) before running the scanner are: `datasphere.community-projects.viewer, datasphere.community-projects.developer, datasphere.community-projects.editor, datasphere.community-projects.admin, datasphere.communities.viewer, datasphere.communities.developer, datasphere.communities.editor, datasphere.communities.admin`. 
1. If a specific role is missing from the tenant or reference, the scanner must not abort the task; log it as `role not found / not applicable`. 
1. The prohibited roles for the runtime environment or service accounts in DataSphere without exception are: `admin, editor, resource-manager.clouds.owner, resource-manager.admin, iam.serviceAccounts.admin, iam.serviceAccounts.tokenCreator, lockbox.admin, lockbox.editor, kms.admin, kms.editor, storage.admin, compute.admin, vpc.admin, datasphere.communities.admin, datasphere.communities.editor, datasphere.community-projects.admin, datasphere.community-projects.editor, ai.admin, ai.editor, ai.models.admin, ai.models.editor`, as well as any excessive `*.admin / *.editor` permissions. 
1. Allow only the minimum required roles for the resources currently in use, such as: 
   * `storage.viewer` or `upload` roles only to a specific bucket. 
   * `lockbox.payloadViewer` only to a specific secret. 
   * `ai.models.user` or specific `ai.*.user` roles if the project in question if the project actively calls models. 
   * Minimum roles for logging and monitoring, only when required.

The solution is to delete broad roles, create a dedicated service account for the project or community, assign the minimum required roles to a minimum list of resources, and run the scan again.
