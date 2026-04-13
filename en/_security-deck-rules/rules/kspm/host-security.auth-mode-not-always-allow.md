### Only explicitly authorized requests to Kubelet server are allowed {#host-security.auth-mode-not-always-allow}

#|
|| **kind** | **severity** | **ID** ||
|| HostSecurity | Medium | host-security.auth-mode-not-always-allow ||
|#

#### Description

Do not allow all requests. Enable explicit authorization.
Kubelets, by default, allow all authenticated requests (even anonymous ones) without needing explicit authorization checks from the apiserver. 
You should restrict this behavior and only allow explicitly authorized requests.

#### Recommendations

**To perform the audit manually:**

Run the following command on each node:
```
ps -ef | grep kubelet
```
If the `--authorization-mode` argument is present, check that it is not set to *AlwaysAllow*. 
If it is not present, check that there is a Kubelet config file specified by `--config`, and that file sets `authorization: mode` to something other than *AlwaysAllow*.
It is also possible to review the running configuration of a Kubelet via the `/configz` endpoint on the Kubelet API port (typically `10250/TCP`). 
Accessing these with appropriate credentials will provide details of the Kubelet's configuration.

**Remediation:**

If using a Kubelet config file, edit the file to set `authorization: mode` to *Webhook*.
If using executable arguments, edit the kubelet service file `/etc/kubernetes/kubelet.conf` on each worker node and set the below parameter in `KUBELET_AUTHZ_ARGS` variable:
`--authorization-mode=Webhook`
Based on your system, restart the kubelet service. 
For example:
```
systemctl daemon-reload
systemctl restart kubelet.service
```
