---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Removing a listener

{% list tabs %}

- Management console
  
  To remove a [listener](../concepts/listener.md) for your network load balancer:
  
  1. Open the **Load Balancer** section in the folder where you want to remove the listener.
  1. Select the network load balancer for deleting the listener.
  1. In the **Listeners** section, click ![image](../../_assets/vertical-ellipsis.svg) in the line of the listener to remove.
  1. In the menu that opens, click **Remove listener**.
  
- CLI
  
  If you don't have the Yandex.Cloud command line interface yet, [install it](https://cloud.yandex.com/docs/cli/quickstart#install).
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  To remove a listener for your network load balancer:
  
  1. Look through the list of load balancers:
  
     ```
     $ yc load-balancer network-load-balancer list
     +----------------------+--------------------+-------------+----------+----------------+------------------------+----------+
     |          ID          |        NAME        |  REGION ID  |   TYPE   | LISTENER COUNT | ATTACHED TARGET GROUPS |  STATUS  |
     +----------------------+--------------------+-------------+----------+----------------+------------------------+----------+
     ...
     | c58r8boim8qfkcqtuioj | test-load-balancer | ru-central1 | EXTERNAL |              1 |                        | INACTIVE |
     ...
     +----------------------+--------------------+-------------+----------+----------------+------------------------+----------+
     ```
  
  1. Choose the `ID` of the load balancer with the listener you want to remove.
  
  1. Get information about the selected load balancer:
  
     ```
     $ yc load-balancer network-load-balancer get c58r8boim8qfkcqtuioj
     id: c58r8boim8qfkcqtuioj
     folder_id: aoerb349v3h4bupphtaf
     created_at: "2019-04-01T09:29:25Z"
     name: test-load-balancer
     region_id: ru-central1
     status: INACTIVE
     type: EXTERNAL
     listeners:
     - name: test-listener
       address: 130.193.32.39
       port: "80"
       protocol: TCP
     ```
  
  1. To remove the selected listener, specify the load balancer ID and the name of this listener:
  
     ```
     $ yc load-balancer network-load-balancer remove-listener c58r8boim8qfkcqtuioj --listener-name test-listener
     .......done
     id: c58r8boim8qfkcqtuioj
     folder_id: aoerb349v3h4bupphtaf
     created_at: "2019-04-01T09:29:25Z"
     name: test-load-balancer
     region_id: ru-central1
     status: INACTIVE
     type: EXTERNAL
     ```
  
- API
  
  To delete a listener, use the [removeListener](../api-ref/NetworkLoadBalancer/removeListener.md) API method.
  
{% endlist %}

