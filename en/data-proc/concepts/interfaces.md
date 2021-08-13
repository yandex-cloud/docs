---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Working with component network interfaces

{{ dataproc-name }} enables you to create clusters with just {{ yandex-cloud }} internal addresses. However, you can't access component network or web interfaces externally. To connect externally to components like HDFS NameNode and YARN ResourceManager, you have to route traffic via an intermediate VM with a public IP address.

## Port forwarding {#routing}

To access the network interface of a component from the web, [create](../../compute/operations/vm-create/create-linux-vm.md) an intermediate virtual machine in {{compute-full-name}}.

Requirements for an intermediate VM:

* An assigned public IP address.
* Hosted in the same network as the required {{ dataproc-name }} cluster.
* [Security group settings](network.md#security-groups) that allow traffic exchange with the cluster via the corresponding components' ports.

For step-by-step instructions on how to configure security groups for port forwarding, see [{#T}](../operations/connect.md).

To connect to the desired {{ dataproc-name }} host port, run the following command:

```bash
ssh -A -J <VM public IP address> -L <port number>:<FQDN of Data Proc host>:<port number> root@<FQDN of Data Proc host>
```

You can find the FQDN of the {{ dataproc-name }} host on the {{ dataproc-name }} cluster page, in the **Hosts** tab, under the **Hostname** column.

The port numbers used for {{ dataproc-name }} components are given below.

## Components and ports {#port-numbers}

{% include [ports-table](../../_includes/data-proc/ports-table.md) %}

