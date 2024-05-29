# Creating document tables in a database

{% note warning %}

You can only create document tables when using a {{ ydb-full-name }} DB in [serverless mode](../concepts/serverless-and-dedicated.md#serverless).

{% endnote %}

{{ ydb-full-name }} document tables contain data as a set of items and are compatible with [Amazon DynamoDB](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/HowItWorks.CoreComponents.html#HowItWorks.CoreComponents.TablesItemsAttributes) tables. Therefore, you can use the AWS provider for {{ TF }} and the `aws_dynamodb_table` resource to create {{ ydb-full-name }} document tables.

To create a document table using the AWS provider, you will need the following:
* Service account with the `ydb.editor` [role](../security/index.md#ydb-editor) or higher.
* [Static access key](../../iam/concepts/authorization/access-key.md).

To get started, you need to configure the AWS provider in the project file:

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "aws" {
  region = "{{ region-id }}"
  endpoints {
    dynamodb = "{{ ydb.document-api-endpoint }}/{{ region-id }}/<cloud_id>/<ydb_database_id>"
  }
  profile = "<profile_name>"
  skip_credentials_validation = true
  skip_metadata_api_check = true
  skip_region_validation = true
  skip_requesting_account_id = true
}
```

The `aws` provider arguments:
* `region`: Resource deployment region. It is always set to `{{ region-id }}`.
* `endpoints.dynamodb`: Document API endpoint of the database. You can find the endpoint address in the management console: {{ ydb-full-name }} → **Overview** → **Connection** → **Document API endpoint**.
* `profile`: Name of the section containing `aws_access_key_id` (static access key ID) and `aws_secret_access_key` (secret key contents) in the `~/.aws/credentials` file.
* `skip_credentials_validation`: Skipping validation of credentials through the STS (Amazon Web Services Security Token Service) API. Token validation will be bypassed.
* `skip_metadata_api_check`: Skipping {{ TF }} authentication through the AWS Metadata API.
* `skip_region_validation`: Skipping validation of the specified region name.
* `skip_requesting_account_id`: Skipping the account ID request.

The specified `skip_` parameters are required as they ensure the compatibility of the AWS provider's API requests to {{ yandex-cloud }}.

Then, you can specify the `aws_dynamodb_table` resource to create a document table:

```hcl
resource "aws_dynamodb_table" "test" {
  name         = "<table_name>"
  billing_mode = "PAY_PER_REQUEST"

  hash_key  = "<attribute_name_1>"
  range_key = "<attribute_name_2>"

  attribute {
    name = "<attribute_name_1>"
    type = "<attribute_type>"
  }

  attribute {
    name = "<attribute_name_2>"
    type = "<attribute_type>"
  }
}
```

The `aws_dynamodb_table` resource arguments:
* `name`: Table name. Tables can be stored in a hierarchical namespace within {{ ydb-short-name }}. For example, to place a table into the `my-test-doctable` directory relative to the database root, specify the following path: `my-test-doctable/table-name`. If there is no such directory, it will be created automatically.
* `billing_mode`: Billing model for read and write operations. The only supported model is `PAY_PER_REQUEST`.
* `hash_key`: Attribute to use as the hash key. It is defined in the `attribute` section.
* `range_key`: Attribute to use as the range (sorting) key. It is defined in the `attribute` section.
* `attribute`: Section with nested attribute definitions. It consists of the `name` (attribute name) and `type` (attribute data type) fields: `S` for a string, `N` for a number.

The first time you run the script, you need to run the `terraform init` command to initialize the AWS provider. Then, you can run `terraform plan` and `terraform apply`. As a result of running these commands, a document table named as specified in the `name` parameter will be created.