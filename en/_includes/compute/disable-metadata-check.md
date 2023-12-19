If you are creating a VM from an image based on an Amazon Machine Image, `cloud-init` will check that the VM can be run in Amazon EC2. VMs in {{ compute-full-name }} will fail the check and may run incorrectly.

To avoid this, disable metadata verification on your VMs. To do this, in the `/etc/cloud/cloud.cfg.d` directory, create a configuration file, e.g., `99-ec2-datasource.cfg`, and add the following code to it:

```yaml
#cloud-config
datasource:
  Ec2:
    strict_id: false
```
