# Providers

In {{ TF }}, a provider is a component that enables interaction with various cloud and infrastructure services. Technically, providers are links between {{ TF }} and target platforms such as AWS, Google Cloud, Azure, Docker, and others.

Providers' main functions:

* Supplying {{ TF }} with resources and data it needs to describe and manage the infrastructure.
* Implementing the logic required to create, update, read, and delete resources on relevant platforms.
* Processing authentication and authorization for {{ TF }} to securely communicate with the APIs of cloud services.
* Converting configurations written in [HCL](https://github.com/hashicorp/hcl/blob/main/hclsyntax/spec.md) into API calls the target services can understand.

In {{ TF }}, each provider has its own collection of resources representing various infrastructure components (virtual machines, networks, databases, etc.). To use a provider in a project, you should first declare it in the configuration file stating the necessary credentials and connection parameters. Here is an example of connecting a {{ yandex-cloud }} {{ TF }} provider:

   
   ```hcl
   terraform {
     required_providers {
       yandex = {
         source = "yandex-cloud/yandex"
       }
     }
     required_version = ">= 0.13"
   }

   provider "yandex" {
     zone = "<default_availability_zone>"
   }
   ```



## See also {#see-also}

* [{#T}](../quickstart.md)
* [{#T}](../tutorials/index.md)