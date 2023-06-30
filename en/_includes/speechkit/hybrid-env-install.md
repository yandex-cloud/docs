1. {% include [cli-install](../cli-install.md) %}
1. [Create a registry](../../container-registry/operations/registry/registry-create.md) in {{ container-registry-full-name }}.

   {% include [default-catalogue](../default-catalogue.md) %}

   ```bash
   yc container registry create --name speechkit-hybrid
   ```

   Result:

   ```text
   id: <registry ID>
   folder_id: <folder ID>
   name: speechkit-hybrid
   status: ACTIVE
   created_at: "<creation date and time>"
   ```

1. [Create a service account](../../iam/operations/sa/create.md) with the `{{ roles-editor }}` role for the selected folder.
1. [Create an API key](../../iam/operations/api-key/create.md) for the service account.
1. Notify the {{ speechkit-name }} team of the created registry ID. All the required containers will appear in your registry, and you will be provided with the `docker-compose.yaml` file that contains the deployment settings.
