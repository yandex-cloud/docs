# Deleting a container

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), go to the folder where the container is located.
  1. Open **{{ serverless-containers-name }}**.
  1. In the line with the container, click ![image](../../_assets/horizontal-ellipsis.svg).
  1. In the menu that opens, click **Delete**.
  1. In the window that opens, click **Delete**.

- CLI

  To delete a container, run the command:

  ```
  yc serverless container delete --name <container_name>
  ```

  Result:

  ```
  done (2s)
  ```

{% endlist %}

