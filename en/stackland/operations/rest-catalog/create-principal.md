# Creating a catalog user

A [{{ rest-catalog-name }} catalog](../../concepts/components/rest-catalog.md) user is an account with OAuth2 access. Create a user in a project with an existing catalog.

{% list tabs group=instructions %}

- CLI {#cli}

  1. Create the `RestCatalogPrincipal` resource file, e.g., using the `touch restcatalogprincipal.yaml` command.
  1. Open the file and paste the configuration below into it. Along with the user, create an OAuth2 credentials secret:

      {% include notitle [YAML-file-restcatalogprincipal](../../_includes/yamls/operations/rest-catalog/restcatalogprincipal.md) %}

      Follow these requirements:

      * `spec.catalog` must refer to an existing catalog named `RestCatalog` in the same project.
      * The names in `spec.principalRoles` must be on the `spec.declaredPrincipalRoles` list of user groups of that catalog.

  1. Apply the manifest: `kubectl apply -f restcatalogprincipal.yaml -n <project_name>`. Optionally, you can specify the project name in the `metadata.namespace` resource property and skip it in the command.


- Management console {#console}

  1. If you have not opened a project yet, select one.
  1. In the left-hand menu, select **Iceberg REST Catalog**.
  1. In the **Catalogs** tab, select the catalog.
  1. Go to the **Users** tab.
  1. Click **Create user**.
  1. Fill out the fields as follows:

      * **Name**: Catalog user name. Once created, the name never changes.
      * **Client ID**: Matches the user name and cannot be changed.
      * **Client secret**: Specify the OAuth2 secret.
      * **List of roles**: Select one or more catalog user groups.

  1. Click **Create**.

{% endlist %}
