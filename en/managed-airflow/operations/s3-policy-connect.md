---
title: Connecting {{ maf-full-name }} to an {{ objstorage-full-name }} bucket with a bucket policy
description: In {{ maf-full-name }}, you can work with an {{ objstorage-full-name }} bucket with bucket policies configured.
---

# Connecting to a {{ objstorage-full-name }} bucket with a bucket policy

In {{ maf-full-name }}, you can work with an {{ objstorage-full-name }} bucket with [bucket policies](../../storage/security/policy.md) configured. You access the bucket from a separate DNS zone through an internal load balancer used to distribute traffic among NAT instances. The described connection is shown below. An {{ AF }} cluster will be used in place of the `test-s3-vm` VM.

![Storage VPC Access](../../_assets/managed-airflow/storage-vpc-access-maf.svg)

## Getting started {#before-you-begin}

1. Create a network infrastructure to access the {{ objstorage-name }} bucket as shown on the picture above. For information on how to create such an infrastructure, see [this tutorial](../../storage/tutorials/storage-vpc-access.md).
1. [Test the new infrastructure](../../vpc/tutorials/storage-vpc-access.md#check). 
1. To connect to the bucket you created via {{ AF }}, edit the bucket access policy. To do this, in the `Action` [parameter](https://github.com/yandex-cloud-examples/yc-s3-private-endpoint/blob/bb65c064061c4b8ccdef96bb7b4b180acab55f72/bucket.tf#L23), specify operations allowed for {{ AF }}: `"s3:GetObject, s3:ListBucket"`. After that, apply the changes using the `terraform apply` command.

## Prepare the {{ AF }} cluster {#prepare-airflow}

1. [Create a service account](../../iam/operations/sa/create.md) named `my-account` with the `vpc.user` and `managed-airflow.integrationProvider` roles.
1. [Grant the `READ` permission](../../storage/operations/buckets/edit-acl.md) for the bucket you created earlier to the `my-account` service account.
1. [Create an {{ AF }} cluster](cluster-create.md) and specify the `my-account` service account in it.

## Test the connection {#check-connection}

To test the connection to the {{ objstorage-name }} bucket, [upload the DAG file](upload-dags.md) to the bucket The DAG should be displayed in the {{ AF }} web interface.
