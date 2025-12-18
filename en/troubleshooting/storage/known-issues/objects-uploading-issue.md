# Fixing issues with uploading new objects to a bucket


## Issue description {#issue-description}

You fail to upload new files to a bucket, or your bucket has no associated bucket policies or ACLs, although the {{ iam-short-name }} account you use to upload files has enough roles to run this operation.

## Solution {#issue-resolution}

You have probably exceeded the **Storage size** quota in your cloud.

You can check the current quotas and request to increase them on [this page]({{ link-console-quotas }}).

## If the issue persists {#if-issue-still-persists}

If the above actions did not help, [create a support ticket]({{ link-console-support }}).
When creating a ticket, provide the following information:

1. {{ objstorage-name }} bucket name.
1. Date and time when the objects were uploaded.
1. How you uploaded objects to the bucket: using WinSCP, CyberDuck, AWS CLI, s3cmd, or any other tool.
1. ID of the service account for which you [issued a static access key](../../../iam/operations/authentication/manage-access-keys.md#create-access-key).
