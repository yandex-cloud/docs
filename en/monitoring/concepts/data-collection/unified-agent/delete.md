---
title: How to delete {{ unified-agent-full-name }}
description: In this tutorial, you will learn how to delete {{ unified-agent-full-name }}.
---

# Deleting {{ unified-agent-full-name }}

The way you delete {{ unified-agent-short-name }} depends on the way it was installed.

{% list tabs group=unified_agent %}

- Docker image {#docker}

  1. View the {{ unified-agent-short-name }} container ID:
   
      ```bash
      sudo docker ps
      ```

   1. Stop the container:
   
      ```bash
      sudo docker stop <container_ID>
      ```

   1. Delete the container:
   
      ```bash
      sudo docker rm <container_ID>
      ```
  
- deb package {#deb}

  1. Stop {{ unified-agent-short-name }}:
   
      ```bash
      sudo service unified-agent stop
      ```

  1. View the deb package name:

      ```bash
      sudo dpkg -S /etc/yandex/unified_agent
      ```
  
  1. Delete the deb package:

      ```bash
      sudo apt remove yandex-unified-agent
      ```

- Binary file {#binary}

  1. View the {{ unified-agent-short-name }} process number and the location of the `unified_agent` file and `*.yml` configuration file:
   
      ```bash
      ps aux | grep unified_agent
      ```

      Result:

      ```bash
      root 1068 0.0 2.1 2314804 43540 ? Ssl 08:33 0:03 /bin/unified_agent --config /etc/yc/unified_agent/config.yml
      yc-sa-a+ 4124 0.0 0.1 6612 2272 pts/2 S+ 12:34 0:00 grep --color=auto unified_agent
      ```
      In this example, the process number is `1068`.

  1. Stop the {{ unified-agent-short-name }} process:

     ```bash
      sudo kill <process_number>
      ```
   
  1. Delete the binary file:
    
      ```bash
      sudo rm -f /usr/bin/unified_agent
      ```

  1. Delete the configuration file:

      ```bash
      sudo rm -f /etc/yc/unified_agent/config.yml
      ```

- When creating a VM {#vm}

  If {{ unified-agent-short-name }} was installed this way, the `unified_agent` binary file and the `config.yml` default configuration file are copied to the VM. Therefore, {{ unified-agent-short-name }} is deleted the same way as the binary file. 
 
  Information about the installed {{ unified-agent-short-name }} is stored in the VM metadata. When deleting {{ unified-agent-short-name }}, metadata is not updating automatically; however, you can do it manually.

  {% note info %}

  Information in metadata does not affect {{ unified-agent-short-name }}'s operation, so updating is optional.

  {% endnote %}

  To delete information about {{ unified-agent-short-name }} from metadata:

  1. [Get an IAM token for your VM's service account](../../../../iam/operations/iam-token/create-for-sa.md#via-cli).
   
  1. Make sure you have installed [cURL](https://curl.haxx.se).
   
  1. Send an API request to update metadata:

      ```bash
      curl \
        --request PATCH \
        --header "Authorization: Bearer <IAM_token>" \
        --data '{"updateMask": "metadata", "metadata": {"install-unified-agent": "0" },}' \
        https://compute.api.cloud.yandex.net/compute/v1/instances/<VM_ID>
      ```

  1. View metadata:
   
     1. In the [management console]({{ link-console-main }}), go to **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.

     1. In the left-hand panel, select ![image](../../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}**.
   
     1. Select the VM and navigate to the **{{ ui-key.yacloud.common.overview }}** tab.
  
     1. Make sure the **{{ ui-key.yacloud.compute.instance.overview.field_ua-enabled }}** parameter is now set to `no` under **{{ ui-key.yacloud.compute.instance.overview.section_monitoring }}**.
   

{% endlist %}
