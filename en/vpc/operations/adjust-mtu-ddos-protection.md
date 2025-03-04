# Setting up the MTU when enabling DDoS protection

We recommend always setting the MTU to `1450` bytes when [{{ ddos-protection-full-name }}](./enable-ddos-protection.md) protection is active.

{% note alert %}

If you enable {{ ddos-protection-name }} and leave the default MTU, you may lose network traffic.

{% endnote %}

To learn more about the MTU and MSS in {{ yandex-cloud }}, see [{#T}](../concepts/mtu-mss.md).

## Setting up the MTU {#set-mtu}

### For an Ubuntu 20.04 or 22.04 VM {#ubuntu}

1. [Connect](../../compute/operations/vm-connect/ssh.md) to the VM over SSH:

   ```
   ssh <username>@<VM_IP_address>
   ```

1. Set the MTU to `1450` using the `netplan` command. Run this command:

   ```
   sudo netplan set ethernets.eth0.mtu=1450 && sudo netplan apply
   ```

1. Check the new MTU and MSS values:

   ```
   ip link show eth0 | grep mtu
   ss -i | grep mss
   ```

### For worker nodes of a {{ managed-k8s-name }} cluster {#managed-kubernetes}

1. Create a DaemonSet YAML manifest with the following contents:

   ```yml
   ---
   apiVersion: "apps/v1"
   kind: DaemonSet
   metadata:
     name: mtu-fix
     namespace: kube-system
     labels:
       k8s-app: mtu-fix
       version: 2v
   spec:
     selector:
       matchLabels:
         k8s-app: mtu-fix
     template:
       metadata:
         labels:
           k8s-app: mtu-fix
       spec:
         hostPID: true
         hostIPC: true
         hostNetwork: true
         containers:
         - name: mtu-fix
           image: {{ registry }}/yc/mk8s-openssl:stable
           command:
             - bash
             - -c
             - |
               chroot /host /bin/bash -c "ip link set dev eth0 mtu 1450 &&  sleep infinity"
           imagePullPolicy: IfNotPresent
           securityContext:
             privileged: true
           resources:
             limits:
               memory: 100Mi
             requests:
               cpu: 100m
               memory: 100Mi
           volumeMounts:
             - mountPath: /host
               name: host-namespace
         volumes:
           - name: host-namespace
             hostPath:
               path: /
   ```
    
   Save it to a file with any name, e.g., `ds-mtu-fix.yml`.

1. Apply the manifest you created to the {{ managed-k8s-name }} cluster:

   ```bash
   kubectl -f ds-mtu-fix.yml
   ```

1. [Connect](../../managed-kubernetes/operations/node-connect-ssh.md) to any worker node within the cluster over SSH and check the MTU and MSS values.

   ```
   ssh <username>@<worker_node_IP_address>
   ip link show eth0 | grep mtu
   ss -i | grep mss
   ```

### For a Windows Server VM {#windows-server}

1. [Connect](../../compute/operations/vm-connect/rdp.md) to the Windows Server VM over RDP and launch Windows PowerShell.

1. Specify the name of the interface for which you want to change the MTU:

   ```
   netsh interface ipv4 show subinterfaces
   ```

1. Set the MTU to `1450` for the network interface in question. In our example, it is `Ethernet 2`:

   ```
   netsh interface ipv4 set subinterface "Ethernet 2" mtu=1450 store=persistent
   ```

1. Make sure the MTU value has changed:

   ```
   netsh interface ipv4 show subinterfaces
   ```
