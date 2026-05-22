### Restrictive permissions for Kubelet configuration file are set {#host-security.kubelet-config-permissions-600}

#|
|| **kind** | **severity** | **ID** ||
|| HostSecurity | Medium | host-security.kubelet-config-permissions-600 ||
|#

#### Description

Ensure that if the kubelet refers to a configuration file with the `--config` argument, that file has permissions of `600` or more restrictive.
The kubelet reads various parameters, including security settings, from a config file specified by the `--config` argument. 
If this file is specified, you should restrict its file permissions to maintain the integrity of the file. 
The file should be writable by only the administrators on the system.

#### Recommendations

**To perform the audit manually:**

Run the below command (based on the file location on your system) on the each worker node. 
For example:
```
stat -c %a /var/lib/kubelet/config.yaml
```
Verify that the permissions are set as `600` or more restrictive.

**Remediation:**

Run the following command (using the config file location identified in the Audit step):
```
chmod 600 /var/lib/kubelet/config.yaml
```
