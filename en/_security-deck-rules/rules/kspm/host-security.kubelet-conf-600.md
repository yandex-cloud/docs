### Restrictive permissions for kubeconfig configuration file are set {#host-security.kubelet-conf-600}

#|
|| **kind** | **severity** | **ID** ||
|| HostSecurity | Medium | host-security.kubelet-conf-600 ||
|#

#### Description

The `kubelet.conf` file is the kubeconfig file for the node. It controls various parameters that set the behavior and identity of the worker node. 
You should restrict its file permissions to maintain the integrity of the file. 
The file should be writable by only the administrators on the system.

#### Recommendations

**To perform the audit manually:**

Run the below command (based on the file location on your system) on the each worker node. 
For example:
```
stat -c %a /etc/kubernetes/kubelet.conf
```
Verify that the permissions are `600` or more restrictive.

**Remediation:**

Run the below command (based on the file location on your system) on the each worker node.
For example:
```
chmod 600 /etc/kubernetes/kubelet.conf
```
