# Configuring permissions for access to a secret created by {{ connection-manager-full-name }} for a {{ mpg-full-name }} user

You can get a [{{ mpg-name }}](../../managed-postgresql/index.yaml) user's password from the [{{ lockbox-name }} secret](../../lockbox/concepts/secret.md). You can do it via the [{{ yandex-cloud }} CLI](../../cli/index.yaml). Do it by permitting the [service account](../../iam/concepts/users/service-accounts.md) you are using to log in to the {{ yandex-cloud }} CLI to access the user's secret. You can get the secret-related information you need to configure the permissions from the [{{ connection-manager-name }}](../../metadata-hub/concepts/connection-manager.md) connection.

To configure permissions for access to a user's secret:

1. [Create the required infrastructure and configure permissions for access to the user's secret](#set-up-roles).
1. [Get the user password from the secret](#get-password).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

* {{ mpg-name }} cluster, which includes the use of computing resources allocated to hosts, storage and backup size (see [{{ mpg-name }} pricing](../../managed-postgresql/pricing.md)).
* Public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).

{{ connection-manager-name }} and the secrets created with it are free of charge.

## Configure permissions for access to a {{ mpg-name }} user's secret {#set-up-roles}

{% list tabs group=instructions %}

- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}

        {% note warning %}
        
        Requires Yandex provider version `0.160.0` or higher. If the provider version is not explicitly specified in the configuration, {{ TF }} will automatically download the latest compatible version.

        {% endnote %}

    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. Download the [conn-man-secret-access.tf](https://github.com/yandex-cloud-examples/yc-connection-manager-secret-access/blob/main/conn-man-secret-access.tf) configuration file to the same working directory.

        This file describes:

        * {{ mpg-name }} cluster.
        * Setting up service account permissions to access the {{ mpg-name }} user's secret.
        * Getting connection ID and secret ID.     

    1. Specify the following in the configuration file:
        
        * `network_id`: [Network](../../vpc/concepts/network.md#network) ID for the cluster.
        * `subnet_id`: [Subnet](../../vpc/concepts/network.md#subnet) ID in the `ru-central1-a` [availability zone](../../overview/concepts/geo-scope.md) for the cluster.
        * `pg_cluster_version`: {{ PG }} version.
        * `pg_cluster_name`: Cluster name.
        * `pg_cluster_db`: Cluster database name.
        * `pg_cluster_username`: Cluster username.
        * `pg_cluster_password`: User password.
        * `lockbox_sa_id`: ID of the service account for which access to the secret will be configured.

    1. Validate your {{ TF }} configuration files using this command:

        ```bash
        terraform validate
        ```

        {{ TF }} will display any configuration errors detected in your files.

    1. Create the required infrastructure:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}
    
    1. After you apply the configuration, {{ TF }} will output the connection and secret IDs.

        Here is an example of the command output:
        
        > ```bash
        > Outputs:
        >
        > connection_id = "a59v09bb8907********"
        > connection_info = "e6q2rjghh9bc********"
        > ```

        Save the `connection_info` secret ID for later to [get the user password](#get-password).

{% endlist %}

## Get the user password from the {{ lockbox-name }} secret {#get-password}

1. [Authenticate to the {{ yandex-cloud }} CLI as a service account using an authorized key](../../cli/operations/authentication/service-account.md#auth-as-sa).

1. Get the user password from the secret and save it to the `PASSWORD` variable: 

    {% list tabs group=instructions %}

    - CLI {#cli}

      ```bash
      PASSWORD=$(yc lockbox payload get <secret_ID> \
        --format json \
        | jq -r '.entries[] | select(.key=="postgresql_password") | .text_value')
      ```

    {% endlist %}

1. To view the saved password, run this command:

    ```bash
    echo "$PASSWORD"
    ```

## Delete the resources you created {#clear-out}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:

{% list tabs group=instructions %}

- {{ TF }} {#tf}

    {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}