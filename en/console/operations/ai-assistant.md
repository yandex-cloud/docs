---
title: Using an AI assistant to manage {{ yandex-cloud }} resources
description: This guide describes how to use an AI assistant to manage {{ yandex-cloud }} resources in the management console interface.
---

# Managing {{ yandex-cloud }} resources with an AI assistant

{% include [preview-pp](../../_includes/preview-pp.md) %}

You can use an [AI assistant](../../ai-studio/concepts/assistant/index.md) integrated into the management console to create and delete {{ yandex-cloud }} resources as well as manage their settings. With the AI assistant, you can run operations on cloud resources by sending text messages to a chat with a generative model.

## Creating and deleting resources {#create-and-delete}

In the example below, you will use an AI assistant to create a [cloud network](../../vpc/concepts/network.md#network), a [subnet](../../vpc/concepts/network.md#subnet), and a [security group](../../vpc/concepts/security-groups.md) in it. Then you will delete the resources you created.

To use an AI assistant for resource management:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you are going to run operations on {{ yandex-cloud }} resources, then select ![sparkles-fill](../../_assets/console-icons/sparkles-fill.svg) **{{ ui-key.yacloud.ai-assistant.label_ai-assistant-open }}** in the left-hand panel.
  1. In the AI assistant window, use the message input field to describe what you want to do with {{ yandex-cloud }} resources:

      {% note info %}

      By default the AI assistant performs operations on resources in the folder you selected in the management console before opening the AI assistant window.

      {% endnote %}

      1. Create a cloud network:

          ```text
          Create a new cloud network named my-new-network.
          ```

          The AI assistant will create a cloud network with this name and notify you accordingly:

          ```text
          Alright! You have successfully created a new cloud network named my-new-network. It is ready for use: you can now add subnets and other cloud resources.
          ```

      1. Create a subnet specifying the new network name and the availability zone for the subnet:

          ```text
          In my-new-network, create a subnet in the {{ region-id }}-a availability zone with this address range: 192.168.1.0/24.
          ```

          Result:

          ```text
          Successfully created a new subnet with the provided parameters:

          Name: subnet-{{ region-id }}-a
          Network: my-new-network
          Availability zone: {{ region-id }}-a
          IP address range: 192.168.1.0/24
          The subnet is ready for use.
          ```

          As you can see in the result, the AI assistant has given its own name to the new subnet since you have not specified the name in the request. Therefore, the assistant itself can set some standard values for most parameters of the resources you create.

      1. Create a security group that allows inbound traffic on TCP ports `80` and `443` as well as any outbound traffic:

          ```text
          In my-new-network, create a security group that allows any outgoing traffic as well as incoming traffic on TCP ports 80 and 443.
          ```

          Result:

          ```text
          Successfully created a security group with the following settings:

          Name: web-security-group
          Network: my-new-network
          Rules:

          ✅ Incoming traffic (Ingress):
          TCP port 80 (HTTP) from any IP address (0.0.0.0/0)
          TCP port 443 (HTTPS) from any IP address (0.0.0.0/0)
          ✅ Outgoing traffic (Egress):
          All outgoing traffic is allowed (from any IP address and over any protocol)
          Security group is active and ready to connect to your VMs.
          ```

          When using the AI assistant, you do not have to create resources one by one: you can specify several resources in a single request.

          {% cut "For example:" %}

          ```text
          Create a new cloud network named my-new-network. In this network, create a subnet in the {{ region-id }}-a availability zone and a security group allowing all outgoing traffic as well as incoming traffic on TCP ports 80 and 443.
          ```

          The AI assistant will then define the parameters of the new resoures and the order in which to create them and ask you to confirm the action plan:

          ```text
          Thank you for your request! So, you would like to create three resources: a network, a subnet, and a security group. This is a complex project, so let me outline the plan first.

          Suggested plan:

          1. Create a network named my-new-network.
          2. In this network, create a subnet in the {{ region-id }}-a availability zone. I will assign it the standard CIDR block, 10.0.0.0/24.
          3. Create a security group in the new network that allows:
              ● Any outgoing traffic.
              ● Incoming traffic on TCP ports 80 (HTTP) and 443 (HTTPS) from any address.

          All resources will be created in the folder with ID b1gt6g8ht345********.

          Is everything correct? May I proceed with this plan?
          ```

          You can accept the proposed plan or modify some parameters, e.g.:

          ```text
          Reduce the number of available subnet addresses to sixteen.
          ```

          The AI assistant will then provide an updated plan:

          ```text
          Excellent point! I will revise the plan.

          Here is the new plan:

          1. Create a network named my-new-network.
          2. In this network, create a subnet in the {{ region-id }}-a availability zone. Now I will use the 10.0.0.0/28 CIDR block which contains exactly 16 IP addresses.
          3. Create a security group in the new network that allows:
              ● Any outgoing traffic.
              ● Incoming traffic on TCP ports 80 (HTTP) and 443 (HTTPS) from any address.
          I am ready to proceed. Do you confirm?
          ```

          You may ask the assistant to make other changes or approve the plan. After your approval, the assistant will create the resources.

          {% endcut %}

      1. Delete all resoures you created by specifying their names or IDs:

          ```text
          Delete subnet-{{ region-id }}-a and web-security-group, then delete my-new-network.
          ```

          The AI assistant will delete all the specified resources.

{% endlist %}

## Managing chats with the AI assistant {#manage-chats}

To manage multiple segments of a cloud infrastructure at the same time, you can create separate chats with the AI assistant. To manage your chats with the AI assistant:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select ![sparkles-fill](../../_assets/console-icons/sparkles-fill.svg) **{{ ui-key.yacloud.ai-assistant.label_ai-assistant-open }}** in the left-hand panel.
  1. To start a new chat:
     * Select a suggested prompt or enter your own query in the input field.
     * In an active chat, click ![plus](../../_assets/console-icons/plus.svg) in the top-right corner.
  1. To view your chat history, click ![clock-arrow-rotate-left](../../_assets/console-icons/clock-arrow-rotate-left.svg) in the top-right corner of the AI assistant window.
     1. To open a chat, click the line with its name in the chat history.
     1. To delete a chat, click ![trash-bin](../../_assets/console-icons/trash-bin.svg) in the line with its name in the chat history and confirm the deletion.

{% endlist %}
