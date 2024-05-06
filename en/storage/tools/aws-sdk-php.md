# AWS SDK for PHP


The [AWS SDK for PHP](https://aws.amazon.com/sdk-for-php/) is a set of tools for developers working with AWS services.

## Getting started {#before-you-begin}

{% include [aws-tools-prepare](../../_includes/aws-tools/aws-tools-prepare.md) %}

{% include [access-bucket-sa](../../_includes/storage/access-bucket-sa.md) %}

## Installing {#installation}

{% include [install-php-sdk](../../_includes/aws-tools/install-php-sdk.md)%}

## Setup {#setup}

1. In your home directory, create a file named `.aws/credentials` with the static key:

   ```
   [default]
     aws_access_key_id = <key_ID>
     aws_secret_access_key = <secret_key>
   ```

1. If you are using a LAMP image from {{ marketplace-name }}, add to the Apache `httpd.conf` configuration file (for Debian and Ubuntu — `apache2.conf`), the `HOME` environment variable with the home directory:

   ```
   SetEnv HOME <home_directory>
   ```

   For more information about the location and name of the Apache configuration file for different operating systems, see the [Apache HTTP Server Wiki](https://cwiki.apache.org/confluence/display/HTTPD/DistrosDefaultLayout).

Instead of the `.aws/credentials` file, you can use the `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` environment variables.

Use the {{ objstorage-name }} address to access `{{ s3-storage-host }}`.

## Code samples {#code-examples}

List of bucket names:

```php
// We assume that the AWS SDK is installed via Composer
require '/path/to/vendor/autoload.php';
use Aws\S3\S3Client;

$s3 = new S3Client([
    'version' => 'latest',
    'endpoint' => 'https://{{ s3-storage-host }}',
    'region' => '{{ region-id }}',
]);
$buckets = $s3->listBuckets();
foreach ($buckets['Buckets'] as $bucket) {
    echo $bucket['Name'] . "\n";
}
```

See also the [code samples](https://docs.aws.amazon.com/sdk-for-php/v3/developer-guide/s3-examples.html) and [PHP API Reference Guide](https://docs.aws.amazon.com/aws-sdk-php/v3/api/index.html) in the AWS documentation.