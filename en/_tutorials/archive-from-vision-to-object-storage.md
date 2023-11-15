# Recognizing text in image archives in {{ vision-name }}

Use the [{{ vision-full-name }}](../vision/) service to recognize text in images. You can also store both the source images and recognition results in [{{ objstorage-full-name }}](../storage/).

To set up an infrastructure for text recognition using {{ vision-name }} and export the results automatically to {{ objstorage-name }}:
1. [Prepare your cloud](#before-you-begin).
1. [Create a bucket](#create-bucket).
1. [Create a VM](#create-vm).
1. [Configure the VM](#configure-vm).
1. [Create an archive with images](#create-archive).
1. [Prepare a script for recognition and uploading of images](#prepare-script).
1. [Double-check the recognition results](#check-result).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

{% include [before-you-begin](_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The infrastructure costs for image recognition and data storage include:
* Fee for VM computing resources and disks (see [{{ compute-full-name }} pricing](../compute/pricing.md)).
* Fee for data storage in a bucket and operations with data (see [{{ objstorage-name }} pricing](../storage/pricing.md)).
* Fee for using a dynamic or a static public IP (see [{{ vpc-name }} pricing](../vpc/pricing.md)).
* A fee for using {{ vision-name }} (see [pricing for {{ vision-name }}](../vision/pricing.md)).


## Create a bucket {#create-bucket}

To create an {{ objstorage-name }} [bucket](../storage/concepts/bucket.md) to store the source images and recognition results:

{% list tabs %}

- Management console

   1. Go to the {{ yandex-cloud }} [management console]({{ link-console-main }}) and select the folder where you will perform the operations.
   1. On the folder page, click **Create resource** and select **Bucket**.
   1. In the **Name** field, enter the bucket name following the [naming requirements](../storage/concepts/bucket.md#naming).
   1. In the **Bucket access** field, select **Restricted**.
   1. In the **Storage class** field, select **Cold**.
   1. Click **Create bucket**.

{% endlist %}

## Create a VM {#create-vm}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), click **Create resource** and select **Virtual machine**.
   1. In the **Name** field, enter the VM name. The naming requirements are as follows:

      {% include [name-format](../_includes/name-format.md) %}

   1. Select an [availability zone](../overview/concepts/geo-scope.md) to place the VM in.
   1. Under **Image/boot disk selection**, go to the **{{ marketplace-name }}** tab and select a public [CentOS 7](/marketplace/products/yc/centos-7) image.
   1. Under **Disks and file storages**, select the parameters:
      * **Type**: SSD.
      * **Size**: 19 GB.
   1. Under **Computing resources**, select:
      * **Platform**: Intel Cascade Lake.
      * **Guaranteed vCPU share**: 20%
      * **vCPU**: 2.
      * **RAM**: 2 GB.
   1. Under **Network settings**, select the network and subnet to connect the VM to. If there are no networks available, create one:
      1. Select ![image](../_assets/plus-sign.svg) **Create network**.
      1. In the window that opens, enter the network name and specify the folder to host the network.
      1. (optional) To automatically create subnets, select the **Create subnets** option.
      1. Click **Create**.

         Each network must have at least one [subnet](../vpc/concepts/network.md#subnet). If there is no subnet available, create one by selecting ![image](../_assets/plus-sign.svg)**Add subnet**.
   1. In the **Public address** field, keep **Auto** to assign your VM a random external IP address from the {{ yandex-cloud }} pool, or select a static address from the list if you [reserved](../vpc/operations/get-static-ip.md) one in advance.
   1. Enter the VM access information:
      * Enter the username in the **Login** field.
      * In the **SSH key** field, paste the contents of the public key file.

         You will need to create a key pair for the SSH connection yourself, see [{#T}](../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
   1. Click **Create VM**.
   1. Wait for the VM status to change to `Running` and save its public IP address: you'll need it for SSH connection.

{% endlist %}

## Configure the VM {#configure-vm}

### Set up the {{ yandex-cloud }} CLI {#configure-yc-cli}

1. [Connect](../compute/operations/vm-connect/ssh.md#vm-connect) to the VM via SSH.
1. [Install](../cli/quickstart.md#install) the {{ yandex-cloud }} CLI and [create](../cli/quickstart.md#initialize) a profile.
1. Make sure that the {{ yandex-cloud }} CLI runs correctly:

   {% list tabs %}

   - CLI

      Run the following command on the VM:

      ```bash
      yc config list
      ```

      Result:

      ```text
      token: AQ...gs
      cloud-id: b1gdtdqb1900********
      folder-id: b1gveg9vude9********
      ```

      Save the `folder-id` parameter: you'll need it to set up a service account.

   {% endlist %}

### Set up a service account {#configure-sa}

{% list tabs %}

- CLI

   1. Create a [service account](../iam/concepts/users/service-accounts.md):

      ```bash
      yc iam service-account create \
        --name <service_account_name> \
        --description "<service_account_description>"
      ```

      Where:
      * `--name` is the service account name, such as `vision-sa`.
      * `--description` is a description of the service account, for example, `this is the vision service account`.

      Result:

      ```text
      id: aje6aoc8hccu********
      folder_id: b1gv87ssvu49********
      created_at: "2022-10-12T14:04:43.198559512Z"
      name: vision-sa
      description: this is vision service account
      ```

      Save the `id` parameter: this is the service account ID you'll need in the setup process.
   1. Assign the `editor` [role](../iam/concepts/access-control/roles.md#editor) to the service account.

      ```bash
      yc resource-manager folder add-access-binding <folder_id> \
        --role editor \
        --subject serviceAccount:<service_account_ID>
      ```

      Where:
      * `--role`: Role being assigned.
      * `--subject serviceAccount`: Service account ID.

   1. Create a [static access key](../iam/concepts/authorization/access-key.md) for the service account.

      ```bash
      yc iam access-key create \
        --service-account-id <service_account_ID> \
        --description "<key_description>"
      ```

      Where:
      * `--service-account-id`: Service account ID.
      * `--description`: A description for the key, for example, `this key is for vision`.

      Result:

      ```yaml
      access_key:
        id: ajen8d7fur27********
        service_account_id: aje6aoc8hccu********
        created_at: "2022-10-12T15:08:08.045280520Z"
        description: this key is for vision
        key_id: YC...li
      secret: YC...J5
      ```

      Save the following parameters (you'll need them to set up the AWS CLI utility):
      * `key_id`: The ID of the static access key.
      * `secret`: Secret key.
   1. Create an [authorized key](../iam/concepts/authorization/key.md) for a service account:

      ```bash
      yc iam key create \
        --service-account-id <service_account_ID> \
        --output key.json
      ```

      Where:
      * `--service-account-id`: Service account ID.
      * `--output`: The name of JSON file with an authorized key.

      Result:

      ```yaml
      id: aje3qc9pagb9********
      service_account_id: aje6aoc8hccu********
      created_at: "2022-10-13T12:53:04.810240976Z"
      key_algorithm: RSA_2048
      ```

   1. Create a {{ yandex-cloud }} CLI profile to run on behalf of the service account, such as `vision-profile`:

      ```bash
      yc config profile create vision-profile
      ```

      Result:

      ```text
      Profile 'vision-profile' created and activated
      ```

   1. Specify the authorized key of the service account in the profile configuration:

      ```bash
      yc config set service-account-key key.json
      ```

   1. Get an [IAM token](../iam/concepts/authorization/iam-token.md) for the service account:

      ```bash
      yc iam create-token
      ```

      Save the IAM token, you'll need it to send images to {{ vision-name }}.

{% endlist %}

### Set up the AWS CLI {#configure-aws-cli}

1. Update the packages installed in the VM operating system. To do this, run the command:

   ```bash
   sudo yum update -y
   ```

1. Install the AWS CLI:

   ```bash
   sudo yum install awscli -y
   ```

1. Set up the AWS CLI:

   ```bash
   aws configure
   ```

   Specify the parameter values:
   * `AWS Access Key ID`: The ID of the `key_id` static access key that you generated when [setting up the service account](#configure-sa).
   * `AWS Secret Access Key`: The `secret` key that you generated when [setting up the service account](#configure-sa).
   * `Default region name` — `{{ region-id }}`.
   * `Default output format` — `json`.
1. Make sure that the `~/.aws/credentials` file contains relevant values for `key_id` and `secret`:

   ```bash
   cat ~/.aws/credentials
   ```

1. Make sure that the `~/.aws/config` file contains relevant values for `Default region name` and `Default output format`:

   ```bash
   cat ~/.aws/config
   ```

## Create an archive with images {#create-archive}

1. [Upload](../storage/operations/objects/upload.md) your images that include recognizable text to the bucket.

   {% note tip %}

   Use the [sample image](https://{{ s3-storage-host }}/vision/penguins_sample.jpg) of the penguin crossing road sign.

   {% endnote %}

1. To make sure that the images were uploaded, use the request with the bucket name:

   ```bash
   aws --endpoint-url=https://{{ s3-storage-host }} s3 ls s3://<bucket_name>/
   ```

1. Save the images from the bucket to the VM, for example, to the `my_pictures` folder:

   ```bash
   aws --endpoint-url=https://{{ s3-storage-host }} s3 cp s3://<bucket_name>/ my_pictures --recursive
   ```

1. Compress the images into an archive, for example, `my_pictures.tar`:

   ```bash
   tar -cf my_pictures.tar my_pictures/*
   ```

1. Delete the image directory:

   ```bash
   rm -rfd my_pictures
   ```

## Prepare a script for digitizing and uploading images {#prepare-script}

### Configure the environment {#prepare-environment}

1. Install the `jq` package. The script will use it to process the results from {{ vision-name }}:

   ```bash
   sudo yum install jq -y
   ```

1. Install the text editor `nano`:

   ```bash
   sudo yum install nano -y
   ```

1. Set the environment variables necessary for the script to run:

   ```bash
   export BUCKETNAME="<bucket_name>"
   export FOLDERID="<folder_id>"
   export IAMTOKEN="<IAM_token>"
   ```

   Where:
   * `BUCKETNAME`: The bucket name.
   * `FOLDERID`: The folder ID.
   * `IAMTOKEN`: The IAM token that you issued when [setting up the service account](#configure-sa).

### Create a script {#create-script}

The script includes the following steps:
1. Create the relevant directories.
1. Unpack the archive with images.
1. Process all the images one-by-one:
   1. Base64-encode the image.
   1. Create a request body for the given image.
   1. Send the image in a POST request to {{ vision-name }} for recognition.
   1. Save the result to the `output.json` file.
   1. Extract the recognized text from `output.json` and save it to a text file.
1. Add the resulting text files to an archive.
1. Upload the archive with the text files to {{ objstorage-name }}.
1. Delete the auxiliary files.

For your convenience, the text of the script includes comments to each step.

To implement the script:
1. Create a file, for example, `vision.sh` and open it in the `nano` text editor:

   ```bash
   sudo nano vision.sh
   ```

1. Copy the script text to `vision.sh`:

   ```bash
   #!/bin/bash

   # Create the required directories.
   echo "Creating directories..."

   # Create a directory for the recognized text.
   mkdir my_pictures_text

   # Unpack the archive with images to the new directory.
   echo "Extract pictures in my_pictures directory..."
   tar -xf my_pictures.tar

   # Recognize the images from the archive
   FILES=my_pictures/*
   for f in $FILES
   # For each file in the directory, perform the following actions in a loop:
   do
      # Encode the image to base64 to upload it to {{ vision-name }}.
      CODEIMG=$(base64 -i $f | cat)

      # Create a body.json file to upload to {{ vision-name }} in a POST request.
      cat <<EOF > body.json
   {
     "folderId": "$FOLDERID",
     "analyze_specs": [{
       "content": "$CODEIMG",
       "features": [{
         "type": "TEXT_DETECTION",
         "text_detection_config": {
         "language_codes": ["en","ru"]
         }
       }]
     }]
   }
   EOF
     # Send the image to {{ vision-name }} for recognition and write the result to the output.json file.
     echo "Processing file $f in {{ vision-name }}..."
     curl -X POST --silent \
     -H "Content-Type: application/json" \
     -H "Authorization: Bearer ${IAMTOKEN}" \
     -d '@body.json' \
     https://vision.{{ api-host }}/vision/v1/batchAnalyze > output.json

     # Get the name of the image file to use it later.
     IMAGE_BASE_NAME=$(basename -- "$f")
     IMAGE_NAME="${IMAGE_BASE_NAME%.*}"

     # Get the text data from the output.json file and write it to a .txt file with the same name as the image file.
     cat output.json | jq -r '.results[].results[].textDetection.pages[].blocks[].lines[].words[].text' | awk -v ORS=" " '{print}' > my_pictures_text/$IMAGE_NAME".txt"
   done

   # Archive the contents of the text file directory.
   echo "Packing text files to archive..."
   tar -cf my_pictures_text.tar my_pictures_text

   # Move the text file archive to your bucket.
   echo "Sending archive to Object Storage Bucket..."
   aws --endpoint-url=https://{{ s3-storage-host }} s3 cp my_pictures_text.tar s3://$BUCKETNAME/ > /dev/null

   # Delete the auxiliary files.
   echo "Cleaning up..."
   rm -f body.json
   rm -f output.json
   rm -rfd my_pictures
   rm -rfd my_pictures_text
   rm -r my_pictures_text.tar
   ```

1. Set the permissions to run the script:

   ```bash
   sudo chmod 755 vision.sh
   ```

1. Run the script:

   ```bash
   ./vision.sh
   ```

## Double-check the recognition results {#check-result}

{% list tabs %}

- Management console

   1. In the {{ yandex-cloud }} [management console]({{ link-console-main }}), select the folder where the bucket with the recognition results is located.
   1. Select **{{ objstorage-name }}**.
   1. Open the bucket with the recognition results.
   1. Make sure that the bucket contains the `my_pictures_text.tar` archive.
   1. Download and unpack the archive.
   1. Make sure that the text in the `<image name>.txt` file matches the text in the image.

{% endlist %}

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:
1. [Delete](../storage/operations/objects/delete-all.md) all the objects from the bucket.
1. [Delete](../storage/operations/buckets/delete.md) the respective bucket.
1. [Delete](../compute/operations/vm-control/vm-delete.md) the VM.
1. [Delete](../vpc/operations/address-delete.md) the static public IP if you reserved one.