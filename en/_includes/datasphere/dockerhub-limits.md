{% note tip %}

The [Docker Hub](https://hub.docker.com/) image library has limits on anonymous usage. If you encounter slow or failed base image pulls when building a Docker image, try changing your project IP address. To do this:

* [Create a subnet](../../vpc/operations/subnet-create.md).
* [Create an egress NAT gateway](../../vpc/operations/create-nat-gateway.md).
* [Create a service account](../../iam/operations/sa/create.md) with the `{{ roles-vpc-user }}` role.
* In the [project settings](../../datasphere/operations/projects/update.md), add the subnet and the service account you created.

You can also use basic images from other libraries.

{% endnote %}