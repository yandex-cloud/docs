### Kubelet client certificate rotation is enabled {#host-security.rotate-certs-not-false}

#|
|| **kind** | **severity** | **ID** ||
|| HostSecurity | Medium | host-security.rotate-certs-not-false ||
|#

#### Description

Enable kubelet client certificate rotation.
The `--rotate-certificates` setting causes the kubelet to rotate its client certificates by creating new CSRs as its existing credentials expire. 
This automated periodic rotation ensures that there is no downtime due to expired certificates and thus addressing availability in the CIA security triad. 
**Note:** This recommendation only applies if you let kubelets get their certificates from the API server. 
In case your kubelet certificates come from an outside authority/tool (e.g. Vault) then you need to take care of rotation yourself. 
**Note:** This feature also requires the `RotateKubeletClientCertificate` feature gate to be enabled (which is the default since Kubernetes v1.7)

#### Recommendations

**To perform the audit manually:**

Run the following command on each node:
```
ps -ef | grep kubelet
```
Verify that the `RotateKubeletServerCertificate` argument is not present, or is set to true.
If the `RotateKubeletServerCertificate` argument is not present, verify that if there is a Kubelet config file specified by `--config`, that file does not contain `RotateKubeletServerCertificate: false`.

**Remediation:**

If using a Kubelet config file, edit the file to add the line `rotateCertificates: true` or remove it altogether to use the default value.
If using command line arguments, edit the kubelet service file `/etc/kubernetes/kubelet.conf` on each worker node and remove `--rotate-certificates=false` argument from the `KUBELET_CERTIFICATE_ARGS` variable or set `--rotate-certificates=true`.
Based on your system, restart the kubelet service. 
For example:
```
systemctl daemon-reload
systemctl restart kubelet.service
```
