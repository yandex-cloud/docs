# boto3 and boto

[boto3](https://github.com/boto/boto3) and [boto](https://github.com/boto/boto) are software development kits (SDKs) for the Python 2.x and 3.x programming languages. The SDKs are designed for working with AWS services.


## Getting started {#before-you-begin}

{% include [aws-tools-prepare](../../_includes/aws-tools/aws-tools-prepare.md) %}

{% include [access-bucket-sa](../../_includes/storage/access-bucket-sa.md) %}

## Installation {#installation}

{% include [install-boto](../../_includes/aws-tools/install-boto.md)%}

## Setup {#setup}

{% list tabs group=instructions %}

- Locally {#locally}

   {% include [storage-sdk-setup](../_includes_service/storage-sdk-setup-storage-url.md) %}

- {{ sf-full-name }} {#functions}

   [Add environment variables](../../functions/operations/function/version-manage#version-env) to a function in {{ sf-name }}:

   * `AWS_ACCESS_KEY_ID`: Service account's static key ID.
   * `AWS_SECRET_ACCESS_KEY`: Secret key.
   * `AWS_DEFAULT_REGION`: Region ID.

   Use the {{ objstorage-name }} address to access `{{ s3-storage-host }}`.

{% endlist %}


## Example {#boto-example}


{% list tabs group=instructions %}

- Locally {#locally}

   boto3:

   {% include [boto3-example](../../_includes/storage/boto3-example.md) %}

   {% cut "boto" %}

   {% include [boto-example](../../_includes/storage/boto-example.md) %}

   {% endcut %}

- {{ sf-full-name }} {#functions}

   See the example in the [video conversion guide](../../functions/tutorials/video-converting-queue.md).

{% endlist %}

