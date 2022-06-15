# Creating a service account

Create a [service account](../../concepts/users/service-accounts.md) to manage resources under a different account.

## Create a service account {#create-sa}

{% list tabs %}

- Management console

   {% include [create-sa-via-console](../../../_includes/iam/create-sa-via-console.md) %}

- CLI

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. See the description of the command for creating a service account:

      ```bash
      yc iam service-account create --help
      ```

   1. Create a service account named `my-robot`:

      ```bash
      yc iam service-account create --name my-robot
      ```

      Name format requirements:

      {% include [name-format](../../../_includes/name-format.md) %}

- API

   To create a service account, use the [create](../../api-ref/ServiceAccount/create.md) method for the [ServiceAccount](../../api-ref/ServiceAccount/index.md) resource.

{% endlist %}

## Examples {#examples}

### Add a description when creating {#add-description}

Create a service account with the following name and description:

{% list tabs %}

- CLI

   ```bash
   yc iam service-account create --name my-robot \
     --description "this is my favorite service account"
   ```

- API

   ```bash
   curl -X POST \
       -H 'Content-Type: application/json' \
       -H "Authorization: Bearer <IAM-TOKEN>" \
       -d '{
           "folderId": "b1gvmob95yysaplct532",
           "name": "my-robot",
           "description": "this is my favorite service account"
       }' \
       https://iam.{{ api-host }}/iam/v1/serviceAccounts
   ```

{% endlist %}

#### What's next {#what-is-next}

* [{#T}](assign-role-for-sa.md)
* [{#T}](create-access-key.md)
* [{#T}](set-access-bindings.md)
