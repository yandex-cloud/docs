---
title: boto3 and boto
description: In this article, you will learn about boto3 and boto, how to install and configure them, and will see some examples of operations.
---

# boto3 and boto


[boto3](https://github.com/boto/boto3) and [boto](https://github.com/boto/boto) are software development kits (SDKs) for the Python 2.x and 3.x programming languages. The SDKs are designed for working with AWS services.


## Getting started {#before-you-begin}

{% include [aws-tools-prepare](../../_includes/aws-tools/aws-tools-prepare.md) %}

{% include [access-bucket-sa](../../_includes/storage/access-bucket-sa.md) %}

## Installation {#installation}

{% include [install-boto](../../_includes/aws-tools/install-boto.md)%}

## Configuration {#setup}

{% list tabs group=instructions %}

- Locally {#locally}

  {% include [storage-sdk-setup](../_includes_service/storage-sdk-setup-storage-url.md) %}

- {{ sf-full-name }} {#functions}
  
  [Add environment variables](../../functions/operations/function/version-manage#version-env) to a function in {{ sf-name }}:

  * `AWS_ACCESS_KEY_ID`: Static key ID of the service account.
  * `AWS_SECRET_ACCESS_KEY`: Secret key.
  * `AWS_DEFAULT_REGION`: Region ID.

  Use the `{{ s3-storage-host }}` address to access {{ objstorage-name }}.

{% endlist %}


## Example {#boto-example}


{% list tabs group=instructions %}

- Locally {#locally}
  
  boto3: 

  {% include [boto3-example](../../_includes/storage/boto3-example.md) %}

  Boto3 retrieves authentication credentials from the `~/.aws` directory by default, but you can manually set the `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` variables.

  ```python
  ...
  session = boto3.session.Session()
  s3 = session.client(
      service_name='s3',
      endpoint_url='https://{{ s3-storage-host }}',
      aws_access_key_id='<static_key_ID>',
      aws_secret_access_key='<secret_key>'
  )
  ```

  {% note info %}

  This method is not considered secure as it poses a risk of key leaks.

  {% endnote %}

  {% cut "boto" %}

  {% include [boto-example](../../_includes/storage/boto-example.md) %}

  {% endcut %}

- {{ sf-full-name }} {#functions}

  For an example, see this [video conversion guide](../tutorials/video-converting-queue.md).

{% endlist %}

