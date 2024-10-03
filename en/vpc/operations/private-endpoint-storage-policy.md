---
title: How to assign an access policy in {{ objstorage-short-name }} for a {{ vpc-full-name }} service connection
description: Follow this guide to assign an access policy in {{ objstorage-short-name }} for a service connection.
---

# Assigning an access policy in {{ objstorage-short-name }} for a service connection

{% include [vpc-pe-preview](../../_includes/vpc/pe-preview.md) %}


[Bucket policies](../../storage/concepts/policy.md) set permissions for operations with [buckets](../../storage/concepts/bucket.md), [objects](../../storage/concepts/object.md), and object groups.

The minimum role required to apply or modify an access policy is `storage.configurer`. For more information, see the [role description](../../storage/security/index.md#storage-configurer).

To assign an access policy in {{ objstorage-short-name }} for a service connection:

{% list tabs group=instructions %}

- AWS CLI {#aws-cli}

  {% note info %}

  To manage a policy using the AWS CLI, a service account must have the `storage.admin` [role](../../storage/security/index.md#storage-admin) assigned.

  {% endnote %}

  If you do not have the AWS CLI yet, [install and configure it](../../storage/tools/aws-cli.md).

  1. Describe your access policy configuration as a [data schema](../../storage/s3/api-ref/policy/scheme.md) in JSON format:

     ```json
     {
       "Version": "2012-10-17",
       "Statement": {
         "Effect": "Allow",
         "Principal": "*",
         "Action": "*",
         "Resource": [
           "arn:aws:s3:::<bucket-name>/*",
           "arn:aws:s3:::<bucket-name>>"
         ],
         "Condition": {
           "StringEquals": {
             "yc:private-endpoint-id": "<pe-id>"
           }
         }
       }
     }
     ```

     Where:
     * `<bucket-name>`: Object Storage bucket name to apply an access policy to, e.g., `my-s3-bucket`.
     * `<pe-id>`: ID of the previously created service connection (Private Endpoint), e.g., .`enpd7***************`.

  1. Once complete, save the configuration to a file named `policy.json`.

  1. Run this command:

     ```bash
     aws s3api put-bucket-policy \
       --endpoint https://{{ s3-storage-host }} \
       --bucket <bucket-name> \
       --policy file://policy.json
     ```

  After successfully applying the access policy, connection to the bucket will be possible only from the VPC in which the appropriate service connection (Private Endpoint) was created.

  For more information about working with {{ objstorage-short-name }} using `AWS CLI`, see the [access policy management](../../storage/operations/buckets/policy.md#aws-cli_1) document.

{% endlist %}

