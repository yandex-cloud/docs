# Resolving errors of access to a bucket with an assigned security policy



## Issue description {#issue-description}

* When trying to access a bucket with a policy assigned from the management console interface, you see the `Access Denied` error.
* You cannot display the list of objects in a bucket with an assigned security policy.

## Diagnostics and error reproduction

Make sure that security policies have been applied to the bucket.

## Solution {#issue-resolution}

Edit the policy so that the Resource field contains the name of the bucket without `/*`.
This enables actions with the bucket. If you have specified the bucket with `/*`, this would allow actions with objects inside the bucket.

## If the issue persists {#if-issue-still-persists}

If the above actions did not help solve the problem, create a [request for technical support]({{ link-console-support }}).
In the request, specify the following information:

1. Bucket name in Object Storage.
2. Problem description.