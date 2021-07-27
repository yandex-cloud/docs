---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Working with component network interfaces

{{ dataproc-name }} lets you create clusters with just Yandex.Cloud internal addresses. However, you can't access component network or web interfaces externally. To connect externally to components like HDFS NameNode and YARN ResourceManager, you have to route traffic via an intermediate VM with a public IP address.

## Port forwarding {#routing}

To access the network interface of a component from the web, [create](../../compute/operations/vm-create/create-linux-vm.md) an intermediate virtual machine in {{compute-full-name}}. This VM must have a public IP address in the same network as your {{ dataproc-name }} cluster.

To connect to the desired {{ dataproc-name }} host port, run the following command:

```
ssh -A -J <VM public IP address> -L <port number>:<FQDN of Data Proc host>:<port number> root@<FQDN of Data Proc host>
```

You can find the FQDN of the {{ dataproc-name }} host on the {{ dataproc-name }} cluster page, in the **Hosts** tab, under the **Hostname** column.

The port numbers used for {{ dataproc-name }} components are given below.

## Components and ports {#port-numbers}

| Service | Port |
| ----- | ----- |
| HDFS Name Node | 9870 |
| YARN Resource Manager | 8088 |
| YARN Application History | 8188 |
| MapReduce Application History | 19888 |
| Hive Server2 | 10002 |
| HBase Master | 16010 |
| HBase REST | 8085 |
| Zeppelin | 8890 |
| Oozie | 11000 |

