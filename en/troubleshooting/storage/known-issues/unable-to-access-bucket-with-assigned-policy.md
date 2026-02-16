# Resolving errors of access to a bucket with an assigned security policy



## Issue description {#issue-description}

* When trying to access a bucket with a policy assigned from the [management console]({{ link-console-main }}) interface, you see the `Access Denied` error.
* Unable to list objects in a bucket with an assigned security policy.

## Diagnostics and issue reproduction {#issue-diagnostics-and-reproduction}

Make sure that security policies have been applied to the bucket.

## Solution {#issue-resolution}

We recommend editing the policy so that the **Resource** field contains the name of the bucket without `/*`. This enables actions with the bucket. If you have specified the bucket with `/*`, this would allow actions with objects inside the bucket.

## If the issue persists {#if-issue-still-persists}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. Bucket name in {{ objstorage-name }}.
1. Issue description.