# Deleting a listener

{% list tabs %}

- Management console

   To delete a [listener](../concepts/listener.md) for your network load balancer:

   1. Open the **Load Balancer** section in the folder to delete the listener from.
   1. Select the network load balancer for deleting the listener.
   1. Under **Listeners**, click ![image](../../_assets/vertical-ellipsis.svg) in the line of the listener to delete.
   1. In the menu that opens, click **Remove listener**.

- CLI

   If you don't have the {{ yandex-cloud }} command line interface, [install it](../../cli/quickstart.md#install).

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To delete a listener for your network load balancer:

   1. Look through the list of load balancers:

      ```
      yc load-balancer network-load-balancer list
      ```

      Result:

      {% if product == "yandex-cloud" %}

      ```
      +----------------------+--------------------+-------------+----------+----------------+------------------------+----------+
      |          ID          |        NAME        |  REGION ID  |   TYPE   | LISTENER COUNT | ATTACHED TARGET GROUPS |  STATUS  |
      +----------------------+--------------------+-------------+----------+----------------+------------------------+----------+
      ...
      | c58r8boim8qfkcqtuioj | test-load-balancer | {{ region-id }} | EXTERNAL |              1 |                        | INACTIVE |
      ...
      +----------------------+--------------------+-------------+----------+----------------+------------------------+----------+
      ```

      {% endif %}

      {% if product == "cloud-il" %}

      ```
      +----------------------+--------------------+-----------+----------+----------------+------------------------+----------+
      |          ID          |        NAME        | REGION ID |   TYPE   | LISTENER COUNT | ATTACHED TARGET GROUPS |  STATUS  |
      +----------------------+--------------------+-----------+----------+----------------+------------------------+----------+
      ...
      | c58r8boim8qfkcqtuioj | test-load-balancer | {{ region-id }}       | EXTERNAL |              1 |                        | INACTIVE |
      ...
      +----------------------+--------------------+-----------+----------+----------------+------------------------+----------+
      ```

      {% endif %}

   1. Choose the `ID` of the load balancer with the listener you want to delete.
   1. Get information about the selected load balancer:

      ```
      yc load-balancer network-load-balancer get c58r8boim8qfkcqtuioj
      ```

      Result:

      ```
      id: c58r8boim8qfkcqtuioj
      folder_id: aoerb349v3h4bupphtaf
      created_at: "2019-04-01T09:29:25Z"
      name: test-load-balancer
      region_id: {{ region-id }}
      status: INACTIVE
      type: EXTERNAL
      listeners:
      - name: test-listener
        address: 130.193.32.39
        port: "80"
        protocol: TCP
      ```

   1. To delete the selected listener, specify the load balancer ID and the name of this listener:

      ```
      yc load-balancer network-load-balancer remove-listener c58r8boim8qfkcqtuioj --listener-name test-listener
      ```

      Result:

      ```
      .......done
      id: c58r8boim8qfkcqtuioj
      folder_id: aoerb349v3h4bupphtaf
      created_at: "2019-04-01T09:29:25Z"
      name: test-load-balancer
      region_id: {{ region-id }}
      status: INACTIVE
      type: EXTERNAL
      ```

- API

   To delete a listener, use the [removeListener](../api-ref/NetworkLoadBalancer/removeListener.md) API method.

{% endlist %}