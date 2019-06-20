# Create a service account

Create a [service account](../../concepts/users/service-accounts.md) to manage resources under a different account.

## How to create a service account

{% list tabs %}

- Management console
  
  1. Select a folder.
  
  2. Select the **Service accounts** tab.
  
  3. Click **Create service account**.
  
  4. Enter the name of the service account.
  
  5. You can immediately assign the service account a [role](../../concepts/access-control/roles.md) for the folder where it is created.
  To do this, click **Add role** and select a role.
  
      To assign a role for another resource, use the CLI or API following the instructions [#T](assign-role-for-sa.md).
  
  6. Click **Add**.
  
- CLI
  
  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
  
  1. See the description of the create service account command:
  
      ```
      $ yc iam service-account create --help
      ```
  
  2. Create a service account named `my-robot`:
  
      ```
      $ yc iam service-account create --name my-robot
      ```
  
      {% include [name-format](../../../_includes/name-format.md) %}
  
- API
  
  To create a service account, use the [create](../../api-ref/ServiceAccount/create.md) method for the [ServiceAccount](../../api-ref/ServiceAccount/index.md) resource.
  
{% endlist %}

## Examples

### Create with a description

Create a service account with the following name and description:

{% list tabs %}

- CLI
  
  ```bash
  $ yc iam service-account create --name my-robot \
      --description "this is my favorite service account"
  ```
  
- API
  
  ```bash
  curl -X POST \
      -H 'Content-Type: application/json' \
      -H "Authorization: Bearer <IAM-TOKEN>" \
      -d '{
          "folderId": "b1gd129pp9ha0vnao5g7",
          "name": "my-robot",
          "description": "this is my favorite service account"
      }' \
      https://iam.api.cloud.yandex.net/iam/v1/serviceAccounts
  ```
  
{% endlist %}

#### What's next

- [#T](assign-role-for-sa.md)
- [#T](create-access-key.md)
- [#T](set-access-bindings.md)

