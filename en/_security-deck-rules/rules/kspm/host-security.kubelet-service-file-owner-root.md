### Kubelet service file ownership is set to root:root {#host-security.kubelet-service-file-owner-root}

#|
|| **kind** | **severity** | **ID** ||
|| HostSecurity | Medium | host-security.kubelet-service-file-owner-root ||
|#

#### Description

The kubelet service file controls various parameters that set the behavior of the kubelet service in the worker node. 
You should set its file ownership to maintain the integrity of the file. 
The file should be owned by `root:root`.

#### Recommendations

**To perform the audit manually:**

Run the below command (based on the file location on your system) on the each worker node. 
For example:
```
stat -c %U:%G /etc/systemd/system/kubelet.service.d/kubeadm.conf
```
Verify that the ownership is set to `root:root`.

**Remediation:**

Run the below command (based on the file location on your system) on the each worker node. 
For example:
```
chown root:root /etc/systemd/system/kubelet.service.d/kubeadm.conf
```
