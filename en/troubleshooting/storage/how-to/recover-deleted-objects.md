# How to restore data deleted from a bucket


## Case description {#case-description}

You need to restore data mistakenly deleted from an {{ objstorage-name }} bucket.

## Solution {#case-resolution}

Check the bucket properties to see if versioning is enabled. If not, you will not be able to restore data.

## If nothing helped {#if-nothing-worked}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. Bucket name.
1. Approximate date and time when the objects were deleted.
1. Object names or links.

{% note warning %}

Our support cannot guarantee the data deleted from {{ objstorage-name }} buckets by users will be restored. While our support team is processing your ticket, you may want to avoid writing any new data to the affected bucket.

{% endnote %}