---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Create a target group

{% list tabs %}

- Management console
  
  To create a new [target group](../concepts/target-resources.md):
  
  1. Open the **Load Balancer** section in the folder where you want to create a target group.
  
  1. Open the **Target group** tab.
  
  1. Click **Create target group**.
  
  1. Enter the name of the target group.
  
      {% include [name-format](../../_includes/name-format.md) %}
  
  1. Select the VMs to add to the target group.
  
  1. Click **Create target group**.
  
- CLI
  
  If you don't have the Yandex.Cloud command line interface yet, [install it](https://cloud.yandex.com/docs/cli/quickstart#install).
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  1. See the description of the CLI's create target group command:
  
     ```
     $ yc load-balancer target-group create --help
     ```
  
  1. Get a list of VMs:
  
     ```
     $ yc compute instance list
     +----------------------+------------+---------------+---------+
     |          ID          |    NAME    |    ZONE ID    | STATUS  |
     +----------------------+------------+---------------+---------+
     ...
     | fhmajnpl7cvhl6v1s12i | test-vm-1  | ru-central1-a | RUNNING |
     | fhmajv6f27n0a4a1sbml | test-vm-2  | ru-central1-a | RUNNING |
     ...
     +----------------------+------------+---------------+---------+
     ```
  
  1. Choose the `ID` of the VM to add to a target group and get information about it:
  
     ```
     $ yc compute instance get fhmajnpl7cvhl6v1s12i
       ...
       subnet_id: e9bhjah6j3k7e6v8t5fa
       primary_v4_address:
         address: 192.168.0.3
       ...
     ```
  
  1. Create a target group and add the appropriate VM to it as a target by specifying the `subnet-id` and `address` of the VM in the `--target` flag:
  
     ```
     $ yc load-balancer target-group create \
     --region-id ru-central1 \
     --name test-tg-1 \
     --target subnet-id=e9bhjah6j3k7e6v8t5fa,address=192.168.0.3
     ```
  
- API
  
  You can create a new target group using the [create](../api-ref/TargetGroup/create.md) API method.
  
  Once the target group has been created, add targets that the load will be distributed across. You can use the [addTargets](../ api-ref/TargetGroup/addTargets) method to add targets to a group.
  
{% endlist %}

