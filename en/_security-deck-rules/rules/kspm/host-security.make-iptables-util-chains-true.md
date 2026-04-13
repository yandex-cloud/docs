### Kubelet is allowed to manage iptables {#host-security.make-iptables-util-chains-true}

#|
|| **kind** | **severity** | **ID** ||
|| HostSecurity | Medium | host-security.make-iptables-util-chains-true ||
|#

#### Description

Allow Kubelet to manage iptables.
Kubelets can automatically manage the required changes to iptables based on how you choose your networking options for the pods. 
It is recommended to let kubelets manage the changes to iptables.
This ensures that the iptables configuration remains in sync with pods networking configuration. 
Manually configuring iptables with dynamic pod network configuration changes might hamper the communication between pods/containers and to the outside world. 
You might have iptables rules too restrictive or too open.

#### Recommendations

**To perform the audit manually:**

Run the following command on each node:
```
ps -ef | grep kubelet
```
Verify that if the `--make-iptables-util-chains` argument exists, then it is set to true.
If the `--make-iptables-util-chains` argument does not exist, and there is a Kubelet config file specified by `--config`, verify that the file does not `set makeIPTablesUtilChains` to *false*.

**Remediation:**

If using a Kubelet config file, edit the file to set `makeIPTablesUtilChains: true`.
If using command line arguments, edit the kubelet service file `/etc/kubernetes/kubelet.conf` on each worker node and remove the `--make-iptables-util-chains` argument from the `KUBELET_SYSTEM_PODS_ARGS` variable.
Based on your system, restart the kubelet service. 
For example:
```
systemctl daemon-reload
systemctl restart kubelet.service
```
