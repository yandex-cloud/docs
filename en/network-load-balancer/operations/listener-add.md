# Adding a listener to a network load balancer

{% list tabs %}

- Management console

   To add a [listener](../concepts/listener.md) to a network load balancer:

   1. In the [management console]({{ link-console-main }}), select the folder where you need to add a listener to a load balancer.
   1. In the list of services, select **{{ network-load-balancer-name }}**.
   1. In the line of the load balancer to add a listener to, click ![image](../../_assets/horizontal-ellipsis.svg) and select **Add listener**.
   1. In the window that opens:

      * Specify a port in the range of 1 to 32767 that the listener will receive incoming traffic on.
      * Specify a target port in the range of 1 to 32767 that the load balancer will send traffic to.
      * Click **Add**.

- CLI

   If you don't have the {{ yandex-cloud }} command line interface, [install it](../../cli/quickstart.md#install).

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To add a listener to a network load balancer:

   1. Get the list of load balancers:

      ```
      yc load-balancer network-load-balancer list
      +----------------------+--------------------+-------------+----------+----------------+------------------------+----------+
      |          ID          |        NAME        |  REGION ID  |   TYPE   | LISTENER COUNT | ATTACHED TARGET GROUPS |  STATUS  |
      +----------------------+--------------------+-------------+----------+----------------+------------------------+----------+
      | c58r8boim8qfkcqtuioj | test-load-balancer | ru-central1 | EXTERNAL |              0 |                        | INACTIVE |
      +----------------------+--------------------+-------------+----------+----------------+------------------------+----------+

      ```

   1. Add the listener by entering the name, port, and IP address version:

      ```
      yc load-balancer network-load-balancer add-listener c580id04kvumgn7ssfh1 \
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

### Adding a listener to an internal network load balancer {#internal-listener}

{% list tabs %}

- CLI

   Run the command, indicating the listener name, port, subnet ID, and internal address from the range of subnet addresses:

   ```
   yc load-balancer network-load-balancer add-listener b7rc2h753djb3a5dej1i \
     --listener name=test-listener,port=80,internal-subnet-id=e9b81t3kjmi0auoi0vpj,internal-address=10.10.0.14
   ```

{% endlist %}

