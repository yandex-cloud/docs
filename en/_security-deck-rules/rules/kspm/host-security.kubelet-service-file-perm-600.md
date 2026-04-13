### Restrictive permissions for Kubelet service file are set {#host-security.kubelet-service-file-perm-600}

#|
|| **kind** | **severity** | **ID** ||
|| HostSecurity | Medium | host-security.kubelet-service-file-perm-600 ||
|#

#### Description

The kubelet service file controls various parameters that set the behavior of the kubelet service in the worker node. 
You should restrict its file permissions to maintain the integrity of the file. 
The file should be writable by only the administrators on the system.

#### Recommendations

**To perform the audit manually:**

Run the below command (based on the file location on your system) on the each worker node. 
For example:
```
stat -c %a /etc/systemd/system/kubelet.service.d/kubeadm.conf
```
Verify that the permissions are set as `600` or more restrictive.

**Remediation:**

Run the below command (based on the file location on your system) on the each worker node. 
For example:
```
chmod 600 /etc/systemd/system/kubelet.service.d/kubeadm.conf
```
