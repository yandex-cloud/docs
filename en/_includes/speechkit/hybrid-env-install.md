1. {% include [cli-install](../cli-install.md) %}
1. [Create a registry](../../container-registry/operations/registry/registry-create.md) in {{ container-registry-full-name }}.

   {% include [default-catalogue](../default-catalogue.md) %}

   ```bash
   yc container registry create --name speechkit-hybrid
   ```

   Result:

   ```text
   id: <registry_ID>
   folder_id: <folder_ID>
   name: speechkit-hybrid
   status: ACTIVE
   created_at: "<creation_date_and_time>"
   ```

1. [Create a service account](../../iam/operations/sa/create.md) with the `{{ roles-editor }}` role for the selected folder.
1. [Create an API key](../../iam/operations/authentication/manage-api-keys.md#create-api-key) for the service account.
1. Notify the {{ speechkit-name }} team of the created registry ID. All required containers will appear in your registry, and you will get the `docker-compose.yaml` file with the deployment settings.
