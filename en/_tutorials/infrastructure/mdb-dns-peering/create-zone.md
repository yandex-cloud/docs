To be able to resolve a cluster FQDN to IP addresses from other cloud networks, you need to create a DNS zone that will include the necessary cloud networks.

Create an internal zone called `vpc-peering-zone` to give you the ability to resolve cluster FQDNs from the `vm-net` and the `cluster-net` cloud networks:

1. Using the command line, navigate to the folder that contains the up-to-date {{ TF }} configuration files with an infrastructure plan for the example.
1. Create a configuration file named `dns.tf` describing the zone:

   {% cut "dns.tf" %}

   ```hcl
   resource "yandex_dns_zone" "vpc-peering-zone" {
     name             = "vpc-peering-zone"
     zone             = "{{ dns-zone }}."
     public           = false
     private_networks = [yandex_vpc_network.vm-net.id, yandex_vpc_network.cluster-net.id]
   }
   ```

   {% endcut %}

1. Check the {{ TF }} configuration files for errors:

   {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

1. Apply your changes:

   {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}
