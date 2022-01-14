# Deleting secrets

To delete a secret:

{% list tabs %}

- Management console

    1. In the [management console]({{ link-console-main }}), select the folder that the secret belongs to.
    1. Select **{{ lockbox-name }}**.
    1. In the menu on the left, select **Secrets**.
    1. Select the secret and click ![image](../../_assets/dots.svg).
    1. In the menu that opens, select **Delete**.
    1. Confirm the deletion.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. View a description of the CLI delete secret command:
       ```
       yc lockbox secret delete --help
       ```

    1. Request a list of secrets:
       ```
       yc lockbox secret list --cloud-id <cloud ID> --folder-name <folder name>
       ```

       Result:
       ```
       +----------------------+--------------------+------------+---------------------+----------------------+--------+
       |          ID          |       NAME         | KMS KEY ID |     CREATED AT      |  CURRENT VERSION ID  | STATUS |
       +----------------------+--------------------+------------+---------------------+----------------------+--------+
       | e6q942hj2r5ni36j09ul | <name of secret 1> |            | 2021-11-09 13:07:12 | e2r9pdm39tn2hg2koasn | ACTIVE |
       | e4qkyo469mu2det6pvku | <name of secret 2> |            | 2021-12-09 06:50:37 | e6fpq386othpq93s4t8m | ACTIVE |
       +----------------------+--------------------+------------+---------------------+----------------------+--------+
       ```

    1. To delete a secret, run the command:
       ```
       yc lockbox secret delete --id e4qkyo469mu2det6pvku 
       ```

       Result:
       ```
       id: e4qkyo469mu2det6pvku
       folder_id: b1ulgko2th573evfdh3a
       created_at: "2021-11-08T17:13:48.393Z"
       name: <secret name>
       description: <secret description>
       current_version:
         id: e6fpq386othpq93s4t8m
         secret_id: e4qkyo469mu2det6pvku
         created_at: "2021-11-08T17:13:48.393Z"
         status: ACTIVE
         payload_entry_keys:
         - <key>
       ```

    1. Make sure the secret is not in the list:
       ```
       yc lockbox secret list --cloud-id <cloud ID> --folder-name <folder name>
       ```

	   Result:
       ```
	   +----------------------+--------------------+------------+---------------------+----------------------+--------+
       |          ID          |      NAME          | KMS KEY ID |     CREATED AT      |  CURRENT VERSION ID  | STATUS |
       +----------------------+--------------------+------------+---------------------+----------------------+--------+
       | e6q942hj2r5ni36j09ul | <name of secret 1> |            | 2021-11-09 13:07:12 | e2r9pdm39tn2hg2koasn | ACTIVE |
       +----------------------+--------------------+------------+---------------------+----------------------+--------+
       ```

{% endlist %}
