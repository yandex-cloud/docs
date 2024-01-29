{% note alert %}

To make sure your cluster and any of its node groups are not recreated (unless it is your intention to do so), analyze the output of the `terraform plan` and `terraform apply` commands before applying the configuration.

You can migrate a master host to a different availability zone without recreating the cluster only if the configuration file contains the `master_location` section.

{% endnote %}