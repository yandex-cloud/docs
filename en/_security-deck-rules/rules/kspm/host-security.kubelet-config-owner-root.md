### The owner of Kubelet configuration file is set to root:root {#host-security.kubelet-config-owner-root}

#|
|| **kind** | **severity** | **ID** ||
|| HostSecurity | Medium | host-security.kubelet-config-owner-root ||
|#

#### Description

Ensure that if the kubelet refers to a configuration file with the `--config` argument, that file is owned by `root:root`.
The kubelet reads various parameters, including security settings, from a config file specified by the `--config` argument. 
If this file is specified, you should restrict its file permissions to maintain the integrity of the file. 
The file should be owned by `root:root`.

#### Recommendations

**To perform the audit manually:**

Run the below command (based on the file location on your system) on the each worker node. 
For example:
```
stat -c %U:%G /var/lib/kubelet/config.yaml
```
Verify that the ownership is set to `root:root`.

**Remediation:**

Run the following command (using the config file location identied in the Audit step):
```
chown root:root /etc/kubernetes/kubelet.conf
```
