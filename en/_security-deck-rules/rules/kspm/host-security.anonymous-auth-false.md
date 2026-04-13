### Requests from anonymous users to Kubelet server are disabled {#host-security.anonymous-auth-false}

#|
|| **kind** | **severity** | **ID** ||
|| HostSecurity | Medium | host-security.anonymous-auth-false ||
|#

#### Description

Disable anonymous requests to the Kubelet server.
When enabled, requests that are not rejected by other configured authentication methods are treated as anonymous requests. 
These requests are then served by the Kubelet server. 
You should rely on authentication to authorize access and disallow anonymous requests.

#### Recommendations

**To perform the audit manually:**

If using a Kubelet configuration file, check that there is an entry for `authentication: anonymous: enabled` set to *false*.
Run the following command on each node:
```
ps -ef | grep kubelet
```
Verify that the `--anonymous-auth` argument is set to *false*.
This executable argument may be omitted, provided there is a corresponding entry set to *false* in the Kubelet config file.

**Remediation:**

If using a Kubelet config file, edit the file to set `authentication: anonymous: enabled` to *false*.
If using executable arguments, edit the kubelet service file `/etc/kubernetes/kubelet.conf` on each worker node and set the below parameter in `KUBELET_SYSTEM_PODS_ARGS` variable:
`--anonymous-auth=false`
Based on your system, restart the kubelet service. For example:
```
systemctl daemon-reload
systemctl restart kubelet.service
```
