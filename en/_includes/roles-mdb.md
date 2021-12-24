The diagram shows which roles are available in the service and how they inherit each other's permissions. For example, the `{{ roles-editor }}` role includes all the permissions of `{{ roles-viewer }}`. A description of each role is given under the diagram.

![image](../_assets/mdb/service-roles-hierarchy.svg)

Active roles in the service:

### Service roles {#service-roles}

| Role | Permissions |
| ----- | ----- |
| `{{ roles-mdb-admin }}` | Lets you create and modify managed database clusters. |

### Roles of other {{ yandex-cloud }} services {#other-roles}

| Role | Permissions |
| ----- | ----- |
| `{{ roles-cloud-owner }}` | Grants you full access to a cloud and the resources in it. You can only assign this role for a cloud. |
| `{{ roles-cloud-member }}` | Everyone needs this role to access cloud resources, except [cloud owners](../resource-manager/concepts/resources-hierarchy.md#owner) and owners of [service accounts](../iam/concepts/users/service-accounts.md). |
| `{{ roles-vpc-public-admin }}` | Lets you manage external connectivity. Important: if a network and a subnet are in different folders, you can check for the presence of this role in the folder where the *network* is hosted. For more information, see [{{ vpc-name }} roles](../iam/concepts/access-control/roles.md#vpc-public-admin). |

### Primitive roles {#primitive-roles}

{% include [roles-primitive](roles-primitive.md) %}

