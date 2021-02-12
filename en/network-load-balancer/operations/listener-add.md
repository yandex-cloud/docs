# Adding a listener to a network load balancer

{% list tabs %}

- Management console

  To add a [listener](../concepts/listener.md) to a network load balancer:
  1. Open the **Load Balancer** section in the folder where you want to add a new listener to the load balancer.
  1. Click ![image](../../_assets/vertical-ellipsis.svg) in the line of the load balancer to add a listener for.
  1. In the menu that opens, click **Add listener**.
  1. Enter a port for the listener.
  1. Click **Add**.

- CLI

  If you don't have the {{ yandex-cloud }} command-line interface, [install it](../../cli/quickstart.md#install).

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To add a listener to a network load balancer:

  1. Get the list of load balancers:

     ```
     $ yc load-balancer network-load-balancer list
     +----------------------+--------------------+-------------+----------+----------------+------------------------+----------+
     |          ID          |        NAME        |  REGION ID  |   TYPE   | LISTENER COUNT | ATTACHED TARGET GROUPS |  STATUS  |
     +----------------------+--------------------+-------------+----------+----------------+------------------------+----------+
     | c58r8boim8qfkcqtuioj | test-load-balancer | ru-central1 | EXTERNAL |              0 |                        | INACTIVE |
     +----------------------+--------------------+-------------+----------+----------------+------------------------+----------+
     ```

  1. Add the listener by entering the name, port, and IP address version:

     ```
     $ yc load-balancer network-load-balancer add-listener c580id04kvumgn7ssfh1 \
          --listener name=test-listener,port=80,external-ip-version=ipv4
     .....done
     id: c58r8boim8qfkcqtuioj
     folder_id: aoerb349v3h4bupphtaf
     created_at: "2019-04-01T09:29:25Z"
     name: test-load-balancer
     region_id: ru-central1
     status: INACTIVE
     type: EXTERNAL
     listeners:
     - name: test-listener
       address: <listener IP address>
       port: "80"
       protocol: TCP
     ```

- API

  You can add a listener using the [addListener](../api-ref/NetworkLoadBalancer/addListener.md) API method.

{% endlist %}

## Examples

### Adding a listener to an internal network load balancer {#without-listener}

{% list tabs %}

- CLI

  Run the command, indicating the listener name, port, and subnet ID:

  ```
  $ yc load-balancer network-load-balancer add-listener b7rc2h753djb3a5dej1i \
  --listener name=test-listener,port=80,internal-subnet-id=e9b81t3kjmi0auoi0vpj
  ```

{% endlist %}

