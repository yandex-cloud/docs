# Host header in CDN server requests to origins

To make sure that CDN servers send correct requests to [origins](origins.md), configure the `Host` HTTP header value for these requests:

* **Primary domain name**: The first [domain name for content distribution](resource.md#hostnames) specified in the CDN resource settings.
* **Custom value**: An arbitrary domain name.
* **Forward**: The same value as that of the `Host` header in the client request to the CDN.

The `Host` header value is selected when creating a resource. You can change it afterwards along with other basic resource settings. For more information, see the instructions:

* [{#T}](../operations/resources/create-resource.md)
* [{#T}](../operations/resources/configure-basics.md)

## How to set up the header properly {#best-practices}

Choosing the right setting for the `Host` header depends on the origins you use in your resource:

{% list tabs %}

- A single origin

  If the origin is a bucket, select the **Custom value** option and specify the `<bucket name>.{{ s3-storage-host }}` (or `<bucket name>.{{ s3-web-host }}` if the bucket is configured for [static website hosting](../../storage/concepts/hosting.md)).

  In other cases, the setting depends on what requests the origin accepts.

  > For example, in [blue-green and canary deployment scenarios](../tutorials/blue-green-canary-deployment.md), the L7 load balancer is configured to accept requests with two values of the `Host` header. For the CDN resource, the **Forward** option is selected.

  To check that the origin accepts requests with the selected `Host` header value correctly, run the following command:

  ```bash
  curl -Ik -H "Host: <header value>" <server or L7 load balancer address>
  ```

- Origin group

  If there is one bucket in the group:

  1. Select the **Custom value** option and specify the `<bucket name>.{{ s3-storage-host }}` (or `<bucket name>.{{ s3-web-host }}` if the bucket is configured for [static website hosting](../../storage/concepts/hosting.md)).
  1. Configure other origins (servers and L7 load balancers) so that they accept requests with the specified header value.

  If there are multiple buckets in the group, we recommend using the L7 load balancer with buckets that act as backends instead (see the configuration example for [blue-green and canary deployment](../tutorials/blue-green-canary-deployment.md)).

  In other cases, the setting depends on what requests the origins accept. To check that the origin accepts requests with the selected `Host` header value correctly, run the following command:

  ```bash
  curl -Ik -H "Host: <header value>" <server or L7 load balancer address>
  ```

{% endlist %}
