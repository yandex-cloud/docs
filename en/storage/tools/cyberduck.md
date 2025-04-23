# CyberDuck

[CyberDuck](https://cyberduck.io/) is a GUI client that allows you to work with cloud storages, including those compatible with the Amazon S3 API. CyberDuck is available for macOS and Windows and as a [console client](https://duck.sh/) for Linux.

## Getting started {#before-you-begin}

{% include [aws-tools-prepare-with-bucket](../../_includes/aws-tools/aws-tools-prepare-with-bucket.md) %}

{% include [access-bucket-sa](../../_includes/storage/access-bucket-sa.md) %}

## Installation {#installation}

[Download](https://cyberduck.io/download/) the CyberDuck distribution for your OS and run it.

## Connection {#connection}

{% list tabs group=operating_system %}

- Windows {#windows}

  1. Run CyberDuck.
  1. Click **Open Connection**.
  1. Select the **Amazon S3** connection type.
  1. Specify the connection parameters:
      * **Server**: `{{ s3-storage-host }}`.

        To connect to a particular bucket, open the **More options** tab and specify the bucket name in the **Path** field.
      * **Port**: `443`.
      * **Access key ID**: Static key ID [you got previously](#before-you-begin).
      * **Secret Access Key**: Static key contents [you got previously](#before-you-begin).
  1. Click **Connect**.

- macOS {#macos}

  1. Run CyberDuck.
  1. Click **Open Connection**.
  1. Select the **Amazon S3** connection type.
  1. Specify the connection parameters:
      * **Server**: `{{ s3-storage-host }}`.

        To connect to a particular bucket, specify `<bucket_name>.{{ s3-storage-host }}` in the **Server** field. This method only works with buckets with no dot in their names. For buckets with a dot in their names, follow the [alternative guide](#alternative-connection) below.
      * **Port**: `443`.
      * **Access key ID**: Static key ID [you got previously](#before-you-begin).
      * **Secret Access Key**: Static key contents [you got previously](#before-you-begin).
  1. Click **Connect**.

  To connect to a bucket with a dot in its name, e.g., `example.com`: {#alternative-connection}
  1. Download the [Deprecated path style requests](https://profiles.cyberduck.io/S3%20(Deprecated%20path%20style%20requests).cyberduckprofile) configuration file (for more information, see the [Cyberduck documentation](https://docs.cyberduck.io/protocols/s3/#connecting-using-deprecated-path-style-requests)).
      
      Some browsers automatically open the configuration file in a new tab. To download the configuration file, right-click the download link, select **Download Linked File As...**, and click **Save**.
  1. Open the configuration file.
  1. Specify the connection parameters the same as in the standard method.
  1. Expand the **More options** section and specify the name of your bucket in the **Path** field.
  1. Close the parameter window.
  1. Double-click the new connection to open it.

{% endlist %}


Once the connection is established, the bucket you created earlier will open.

{% note info %}

CyberDuck treats {{ objstorage-name }} as a hierarchical file system. This means that the keys of objects uploaded via CyberDuck will look like file paths, e.g., `prefix/subprefix/picture.jpg`.

{% endnote %}

Learn more about using CyberDuck with S3-compatible storages in the [CyberDuck documentation](https://docs.cyberduck.io/protocols/s3/).
