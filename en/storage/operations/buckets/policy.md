## Managing bucket policies

[Bucket policies](../../concepts/policy.md) set permissions for actions with buckets, objects, and groups of objects.

To change a bucket policy:

{% list tabs %}

- Terraform

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Get [static access keys](../../../iam/operations/sa/create-access-key.md): a private key and key ID used for authentication in {{ objstorage-short-name }}.

  1. In the configuration file, describe the parameters of resources that you want to create:
     * `access_key`: The ID of the static access key.
     * `secret_key`: The value of the private access key.
     * `bucket`: Bucket name. Required parameter.
     * `policy`: Policy name. Required parameter.

     ```hcl
     resource "yandex_storage_bucket" "b" {
       bucket = "my-policy-bucket"
       policy = <<POLICY
      {
       "Version": "2012-10-17",
       "Statement": [
         {
           "Effect": "Allow",
           "Principal": "*",
           "Action": "s3:*",
           "Resource": [
             "arn:aws:s3:::my-policy-bucket/*",
             "arn:aws:s3:::my-policy-bucket"
           ]
         },
         {
           "Effect": "Deny",
           "Principal": "*",
           "Action": "s3:PutObject",
           "Resource": [
             "arn:aws:s3:::my-policy-bucket/*",
             "arn:aws:s3:::my-policy-bucket"
           ]
         }
       ]
     }
     POLICY
     }
     ```

     For more information about the resources you can create using Terraform, see the [provider documentation](https://www.terraform.io/docs/providers/yandex/index.html).

  1. Make sure that the configuration files are correct.

     1. In the command line, go to the directory where you created the configuration file.

     1. Run the check using the command:

        ```bash
        terraform plan
        ```

     If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If there are errors in the configuration, Terraform points them out.

  1. Deploy the cloud resources.

     1. If the configuration doesn't contain any errors, run the command:

        ```bash
        terraform apply
        ```

     1. Confirm that you want to create the resources.

     Afterwards, all the necessary resources are created in the specified folder. You can check resource availability and their settings in tne [management console]({{ link-console-main }}).

{% endlist %}

