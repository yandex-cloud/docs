### Kubelet authentication via certificates is enabled {#host-security.client-ca-file-set}

#|
|| **kind** | **severity** | **ID** ||
|| HostSecurity | Medium | host-security.client-ca-file-set ||
|#

#### Description

Enable Kubelet authentication using certificates.
The connections from the apiserver to the kubelet are used for fetching logs for pods, attaching (through kubectl) to running pods, and using the kubelet's port-forwarding functionality. 
These connections terminate at the kubelet's HTTPS endpoint. 
By default, the apiserver does not verify the kubelet's serving certificate, which makes the connection subject to man-in-the-middle attacks, and unsafe to run over untrusted and/or public networks. 
Enabling Kubelet certificate authentication ensures that the apiserver could authenticate the Kubelet before submitting any requests.

#### Recommendations

**To perform the audit manually:**

Run the following command on each node:
```
ps -ef | grep kubelet
```
Verify that the `--client-ca-file` argument exists and is set to the location of the client certificate authority file.
If the `--client-ca-file` argument is not present, check that there is a Kubelet config file specified by `--config`, and that the file sets `authentication: x509: clientCAFile` to the location of the client certificate authority file.

**Remediation:**

If using a Kubelet config file, edit the file to set `authentication: x509: clientCAFile` to the location of the client CA file.
If using command line arguments, edit the kubelet service file `/etc/kubernetes/kubelet.conf` on each worker node and set the below parameter in `KUBELET_AUTHZ_ARGS` variable:
`--client-ca-file=<path/to/client-ca-file>`
Based on your system, restart the kubelet service. 
For example:
```
systemctl daemon-reload
systemctl restart kubelet.service
```
