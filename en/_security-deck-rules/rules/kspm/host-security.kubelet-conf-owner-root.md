### The owner of kubeconfig configuration file is set to root:root {#host-security.kubelet-conf-owner-root}

#|
|| **kind** | **severity** | **ID** ||
|| HostSecurity | Medium | host-security.kubelet-conf-owner-root ||
|#

#### Description

The `kubelet.conf` file is the kubeconfig file for the node. It controls various parameters that set the behavior and identity of the worker node. 
You should set its file ownership to maintain the integrity of the file. 
The file should be owned by `root:root`.

#### Recommendations

**To perform the audit manually:**

Run the below command (based on the file location on your system) on the each worker node. 
For example:
```
stat -c %U:%G /etc/kubernetes/kubelet.conf
```
Verify that the ownership is set to `root:root`.

**Remediation:**

Run the below command (based on the file location on your system) on the each worker node. 
For example:
```
chown root:root /etc/kubernetes/kubelet.conf
```
