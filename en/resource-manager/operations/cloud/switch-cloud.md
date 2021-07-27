---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Switch clouds

{% list tabs %}

- Management console

  1. Click on the name of the current folder in the upper-right corner.

      ![image](../../../_assets/resource-manager/switch-cloud.png)

  1. Choose the cloud or folder you want to switch to.

- CLI

  There are two ways to choose the cloud that is used in the CLI by default:
  * Select a cloud when [creating a profile](../../../cli/operations/profile/profile-create.md).
  * Change the `cloud-id` parameter in the profile configuration.

  To change the `cloud-id` parameter for the current profile:

  1. See the description of the command to change configuration parameters:

      ```
      $ yc config set --help
      ```

  2. Find out the ID of the cloud you want to use. To do this, get a list of available clouds:

      ```
      $ yc resource-manager cloud list
      +----------------------+----------------------+-------------------------------+
      |          ID          |         NAME         |          DESCRIPTION          |
      +----------------------+----------------------+-------------------------------+
      | b1gg8sgd16g7qch5onqs | cloud-b1gg8sgd1g23qc | ...                           |
      | b1gjqgj3hhvjen5iqakp | cloud-b1gjqgj3hhvjen | ...                           |
      +----------------------+----------------------+-------------------------------+
      ```

      {% note info %}

      If the list contains only one cloud, it means you don't have access to any other clouds. To access the desired cloud, ask the cloud [owner](../../concepts/resources-hierarchy.md#owner) to [add](../../../iam/operations/users/create.md) you to it.

      {% endnote %}

  3. Specify the ID of the cloud to be used by default:

      ```
      $ yc config set cloud-id b1gjqgj3hhvjen5iqakp
      ```

{% endlist %}

