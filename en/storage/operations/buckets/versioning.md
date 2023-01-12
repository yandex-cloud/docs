---
title: "Managing bucket versioning in {{ objstorage-full-name }}"
description: "Bucket versioning is the capability to store the history of an object using versions. Enabling versioning is irreversible. You can't disable versioning later, but you can stop creating new versions. After you pause versioning, new objects are saved as null versions."
---

# Managing bucket versioning

[Bucket versioning](../../concepts/versioning.md) is the capability to store the history of an object using versions.

{% note info %}

Enabling versioning is irreversible: you can't disable versioning, but you can pause the creation of new versions. After you pause versioning, new objects are saved as `null` versions.

{% endnote %}

Enable bucket versioning:

{% list tabs %}

- AWS CLI

   If you don't have the AWS CLI yet, [install and configure it](../../tools/aws-cli.md).

   Run the following command:

   ```bash
   aws --endpoint https://{{ s3-storage-host }} \
     s3api put-bucket-versioning \
     --bucket <bucket_name> \
     --versioning-configuration 'Status=Enabled'
   ```

- {{ TF }}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

   Retrieve [static access keys](../../../iam/operations/sa/create-access-key.md): a static key and a key ID used to authenticate in {{ objstorage-short-name }}.

   In the configuration file, describe the parameters of resources that you want to create:

   ```hcl
   resource "yandex_storage_bucket" "b" {
     bucket = "<bucket name>"
     access_key = "<key ID>"
     secret_key = "<secret key>"
     acl    = "private"

     versioning {
       enabled = true
     }
   }
   ```

  Where:

  * `bucket`: Bucket name. Required parameter.
  * `access_key`: The ID of the static access key.
  * `secret_key`: The value of the secret access key.
  * `acl`: The ACL policy applied. Defaults to `private`. Optional.
  * `versioning`: Bucket versioning management:
    * `enabled`: Enables bucket versioning. Optional.

{% endlist %}