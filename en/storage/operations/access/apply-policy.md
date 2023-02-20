# Applying an access policy

You can apply a policy using the SDK or the console client (such as the [AWS CLI](../../tools/aws-cli.md)).

{% note info %}

To apply a policy using the AWS CLI, the service account must have the `storage.admin` role assigned to it.

{% endnote %}

## Applying a policy {#apply-policy}

To apply an access policy to a bucket:

{% list tabs %}

- AWS CLI

  1. Describe your access policy configuration as a [data schema](../../s3/api-ref/policy/scheme.md) in JSON format. For example:

     ```json
     {
       "Version": "2012-10-17",
       "Statement": {
         "Effect": "Allow",
         "Principal": "*",
         "Action": "s3:GetObject",
         "Resource": "arn:aws:s3:::<bucket-name>/*",
         "Condition": {
           "Bool": {
             "aws:SecureTransport": "true"
           }
         }
       }
     }
     ```

     Save the configuration to a file named `policy.json`.

  1. Run the command:

     ```bash
     aws --endpoint https://{{ s3-storage-host }} s3api put-bucket-policy \
       --bucket <bucket-name> \
       --policy file://policy.json
     ```

- API

  Use the [PutBucketPolicy](../../s3/api-ref/policy/put.md) method.

{% endlist %}

## Viewing a policy {#get-policy}

To view the access policy applied to a bucket:

{% list tabs %}

- AWS CLI

  Run the command:

  ```bash
  aws --endpoint https://{{ s3-storage-host }} s3api get-bucket-policy \
    --bucket <bucket-name> \
    --output text | jq .
  ```

  Result:

  ```json
  {
    "Version": "2012-10-17",
    "Statement": {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::<bucket-name>/*",
      "Condition": {
        "Bool": {
          "aws:SecureTransport": "true"
        }
      }
    }
  }
  ```

- API

  Use the [GetBucketPolicy](../../s3/api-ref/policy/get.md) method.

{% endlist %}

## Deleting a policy {#delete-policy}

To delete an access policy:

{% list tabs %}

- AWS CLI

  Run the command:

  ```bash
  aws --endpoint https://{{ s3-storage-host }} s3api delete-bucket-policy \
    --bucket <bucket-name>
  ```

- API

  Use the [DeleteBucketPolicy](../../s3/api-ref/policy/delete.md) method.

{% endlist %}