If you create a VM from an AMI-based image, `cloud-init` will verify that the VM is running within the Amazon EC2 environment. VMs launched in {{ compute-full-name }} will fail the verification and may run incorrectly.

To avoid this, disable metadata verification on your VMs: in the `/etc/cloud/cloud.cfg.d` directory, create a configuration file, e.g., `99-ec2-datasource.cfg`, and add the following code to it:

```yaml
#cloud-config
datasource:
  Ec2:
    strict_id: false
```