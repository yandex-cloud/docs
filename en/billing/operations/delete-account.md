# Delete a billing account

If don't plan to use {{ yandex-cloud }} services, delete all resources to avoid charges.

{% note warning %}

Disks, snapshots, images, and reserved static public IP addresses are billed regardless of whether the {% if lang == "ru" and audience != "internal" %}[VM](../../glossary/vm.md){% else %}VM{% endif %} is running or not. Learn more about billing for [disks, snapshots, and images](../../compute/pricing.md#disk) and [public IP addresses](../../vpc/pricing.md#prices-public-ip).

{% endnote %}

To delete a cloud with all its resources or a billing account, contact [technical support]({{ link-console-support }}). In your request, please specify your [cloud ID](../../resource-manager/operations/cloud/get-id.md) or billing account ID.
