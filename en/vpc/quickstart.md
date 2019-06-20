# Getting started with {{ vpc-short-name }}

If you already have a folder in Yandex.Cloud, open the page of that folder in the management console. If you don't have any folders yet, create a new folder before creating a cloud network:

{% include [create-folder](../_includes/create-folder.md) %}

Create a [cloud network](concepts/network.md):

1. Open the section **Virtual Private Cloud**.

1. Click **Create network.**

1. Enter the network name, for example, `test-network`.

   The name may contain lowercase Latin letters, numbers, and hyphens. The first character must be a letter. The last character can't be a hyphen. The length of the name must be from 3 to 63 characters.

1. Click **Create network**.

Create a [subnet](concepts/network.md#subnet) where cloud resources will be assigned internal IP addresses:

1. Click on the name of the cloud network created.

1. Click **Add subnet**.

1. Enter the subnet name, for example, `test-subnet-1`.

   The name may contain lowercase Latin letters, numbers, and hyphens. The first character must be a letter. The last character can't be a hyphen. The length of the name must be from 3 to 63 characters.

1. Select an availability zone from the drop-down list. The first zone on the list will do for the first subnet.

1. Enter the subnet CIDR: its IP address and mask, for example, `10.10.0.0/24`. For more information about subnet IP address ranges, see the section [Cloud networks and subnets](concepts/network.md).

1. Click **Create subnet**.

