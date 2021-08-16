# Delete a network load balancer

{% list tabs %}

- Management console

  To delete a [network load balancer](../concepts/index.md):
  1. Open the **Load Balancer** section in the folder to delete the load balancer from.
  1. Click ![image](../../_assets/vertical-ellipsis.svg) in the row of the load balancer to delete.
  1. In the menu that opens, click **Delete**.
  1. In the window that opens, click **Delete**.

- CLI

  If you don't have the {{ yandex-cloud }} command-line interface, [install it](../../cli/quickstart.md#install).

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI's delete network load balancer command:

     ```
     $ yc load-balancer network-load-balancer delete --help
     ```

  1. Get a list of all load balancers:

     ```
     $ yc load-balancer network-load-balancer list
     +----------------------+--------------------+-------+
     |          ID          | NAME               |  ...  |
     +----------------------+------+-------------+-------+
     ...
     | b7r97ah2jn5rmo6k1dsk | test-load-balancer |  ...  |
     ...
     +----------------------+------+-------------+-------+
     ```

  1. Select the identifier (`ID`) or name (`NAME`) of the load balancer you need.

  1. Delete the load balancer:

     ```
     $ yc load-balancer network-load-balancer delete b7r97ah2jn5rmo6k1dsk
     ```

- API

  You can delete network load balancers using the [delete](../api-ref/NetworkLoadBalancer/delete.md) API method.

- Terraform

  {% include [terraform-definition](../../_includes/solutions/terraform-definition.md) %}

  Read more about Terraform in the [documentation](../../solutions/infrastructure-management/terraform-quickstart.md#install-terraform).

  Network load balancers created using Terraform can be deleted:

   1. In the command line, go to the directory with the Terraform configuration file.

   2. Delete resources using the command:

      ```
      $ terraform destroy
      ```

      {% note alert %}

      Terraform deletes all the resources that you created in the current configuration, such as clusters, networks, subnets, and VMs.

      {% endnote %}

    3. Confirm the deletion of resources.

{% endlist %}

## Examples {examples}

### Deleting a network load balancer from a particular folder {from-folder}

{% list tabs %}

- CLI

  To delete a network load balancer from another folder, use the `--folder-id` or `--folder-name` flags.

  ```
  $ yc load-balancer network-load-balancer delete test-load-balancer --folder-id b1gnbfd11bq5g5vnjgr4
  ```

  ```
  $ yc load-balancer network-load-balancer delete test-load-balancer --folder-name test-folder
  ```

{% endlist %}

