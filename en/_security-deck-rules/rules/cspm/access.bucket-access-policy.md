### Yandex Object Storage uses bucket policies {#bucket-access-policy}

#|
|| **kind** | **severity** | **ID** ||
|| manual | high | access.bucket-access-policy ||
|#

#### Description

{% note warning "**Manual verification**" %}

This rule automatically finds buckets with no bucket policy applied.

This rule requires a manual check. Upon completion, please change the rule's status.

{% endnote %}

[Bucket policies](https://yandex.cloud/en/docs/storage/concepts/policy) set permissions for actions with buckets, objects, and object groups. A policy applies when a user makes a request to a resource. As a result, the request is either executed or rejected.

Bucket policy [examples](https://yandex.cloud/en/docs/storage/concepts/policy#config-examples):

* Policy that only enables object download from a specified range of IP addresses.
* Policy that prohibits downloading objects from the specified IP address.
* Policy that provides different users with full access only to certain folders, with each user being able to access their own.
* Policy that gives each user and service account full access to a folder named the same as the user ID or service account ID.

We recommend making sure that your Object Storage bucket uses at least one policy.

#### Guides and solutions to use

**Guides and solutions to use:**

1. In the [management console](https://console.yandex.cloud), select the cloud or folder where resides the bucket which you want to check bucket policies for.
2. Go to Object Storage and select the bucket in question.
3. In the left-hand menu, select **Security** and go to the **Access policy** tab.
4. If at least one policy is enabled, the rule is considered satisfied. Otherwise, it is recommended to [configure](https://yandex.cloud/en/docs/storage/operations/buckets/policy) an access policy for the bucket.
