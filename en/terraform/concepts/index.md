# Overview

{% include [terraform-intro](../../_includes/terraform-intro.md) %}

## Key advantages {#main-advantages}

* Automation: {{ TF }} enables you to quickly and easily create, update, and delete cloud [resources](resources.md) for streamlined infrastructure management.
* Code reuse: {{ TF }} supports [modules](modules.md) reusable across different projects. This reduces development and testing time.
* Security: {{ TF }} provides version control and audit of infrastructure changes through [state](states.md) snapshots. This helps to prevent unauthorized changes and ensures data security.

## How {{ TF }} works {#how-it-works}

{{ TF }} follows a declarative approach to infrastructure management ([Infrastructure as Code](https://en.wikipedia.org/wiki/Infrastructure_as_code), IaC). You describe the desired end state of your infrastructure, and {{ TF }} automatically creates, modifies, or deletes resources to achieve that state.

To use {{ TF }}, install it on your computer, configure the provider, and create configuration files (`*.tf`) describing your infrastructure in [HashiCorp Configuration Language (HCL)](https://github.com/hashicorp/hcl/blob/main/hclsyntax/spec.md). Then you can use {{ TF }} commands to create, modify, or delete resources.

## Usage example {#example}

Let's assume you want to create a VM in {{ yandex-cloud }}. The following code describes the configuration of a `terraform1` VM with 2 cores and 2 GB of RAM, a boot disk named `boot-disk-1`, network interface connected to `subnet-1`, public IP address, and SSH key from a file located at the specified path:

```
resource "yandex_compute_instance" "vm-1" {
  name = "terraform1"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    disk_id = yandex_compute_disk.boot-disk-1.id
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
  }
}
```

This is just a simple example of how you can use {{ TF }}. With this tool, you can create complex infrastructures with multiple resources and dependencies, provide metadata, manage resources using service accounts, and more.

## See also {#see-also}

* [{#T}](providers.md)
* [{#T}](resources.md)
* [{#T}](states.md)
* [{#T}](data-sources.md)