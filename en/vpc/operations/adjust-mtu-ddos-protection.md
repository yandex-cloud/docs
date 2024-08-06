# Setting the MTU when DDoS protection is active

We recommend always setting the MTU to `1450` bytes when [{{ ddos-protection-full-name }}](./enable-ddos-protection.md) protection is active.

{% note alert %}

If you enable {{ ddos-protection-name }} and leave the MTU at the default value, you may lose network traffic.

{% endnote %}

To learn more about MTU and MSS parameters in {{ yandex-cloud }}, see [{#T}](../concepts/mtu-mss.md).

## Setting the MTU {#set-mtu}

### For a VM with Ubuntu Linux 20.04 or 22.04 {#ubuntu}

1. [Connect](../../compute/operations/vm-connect/ssh.md) to the VM over SSH:

   ```
   ssh <username>@<VM's_IP>
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
       version: 1v
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
         hostNetwork: true
         containers:
         - name: mtu-fix
           image: {{ registry }}/crpjfmfou6gflobbfvfv/ipfixik:0.1.0
           command:
             - bash
             - -c
             - |
               ip link set dev eth0 mtu 1450
               sleep infinity
           imagePullPolicy: Always
           securityContext:
             privileged: true
           resources:
             limits:
               memory: 200Mi
             requests:
               cpu: 100m
               memory: 200Mi
           volumeMounts:
           - mountPath: /sys/
             name: sys
           - mountPath: /proc/
             name: proc
         volumes:
         - name: sys
           hostPath:
             path: /sys/
             type: Directory
         - name: proc
           hostPath:
             path: /proc/
             type: Directory
   ```

   Save it to a file with any name, e.g., `ds-mtu-fix.yml`.

1. Apply the manifest you created to the {{ managed-k8s-name }} cluster:

   ```bash
   kubectl -f ds-mtu-fix.yml
   ```

1. [Connect](../../managed-kubernetes/operations/node-connect-ssh.md) to any production node within the cluster over SSH and check the MTU and MSS values.

   ```
   ssh <username>@<production_node_IP>
   ip link show eth0 | grep mtu
   ss -i | grep mss
   ```

### For a VM with Windows Server {#windows-server}

1. [Connect](../../compute/operations/vm-connect/rdp.md) to the VM with Windows Server over RDP and launch Windows PowerShell.

1. Specify the name of the interface for which you want to change the MTU:

   ```
   netsh interface ipv4 show subinterfaces
   ```

1. Set the MTU of the network interface to `1450`. In our example, it is `Ethernet 2`:

   ```
   netsh interface ipv4 set subinterface "Ethernet 2" mtu=1450 store=persistent
   ```

1. Make sure the MTU value has changed.

   ```
   netsh interface ipv4 show subinterfaces
   ```
