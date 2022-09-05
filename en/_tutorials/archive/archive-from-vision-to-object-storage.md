# Digitizing archives in {{ vision-full-name }}

[{{ vision-full-name }}](../../vision/) is a computer vision service for image analysis.

With this guide, you will:
* Set up a {{ yandex-cloud }} environment for {{ vision-full-name }}.
* Recognize text in images using {{ vision-full-name }}.
* Upload the results to [{{ objstorage-full-name }}](../../storage/).

1. [Prepare your cloud](#before-you-begin).
1. [Create and set up a virtual machine](#create-vm).
1. [Set up the AWS CLI](#aws-cli).
1. [Set up access to Object Storage](#object-storage-access).
1. [Create an archive with images](#create-archive).
1. [Create a script for digitizing and uploading images](#create-script).
1. [Check the digitized content](#check).
1. [Delete the created cloud resources](#cleanup).


## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}




### Required paid resources

Infrastructure costs for recognition and data storage include:

* a fee for a continuously running vm (see [pricing {{ compute-full-name }}](../../compute/pricing.md)).
* A fee for using a dynamic or a static public IP (see [pricing {{ vpc-full-name }}](../../vpc/pricing.md)).
* A fee for using object storage (see [pricing for {{ objstorage-full-name }}](../../storage/pricing.md)).
* A fee for using {{ vision-full-name }} (see [pricing for {{ vision-full-name }}](../../vision/pricing.md)).



## Create and set up a virtual machine {#create-vm}

### Create a virtual machine:

1. On the [management console]({{ link-console-main }}) folder page, click **Create resource** and select **Virtual machine**.
1. In the **Name** field, enter a name for the VM.

   {% include [name-format](../../_includes/name-format.md) %}

1. Select an [availability zone](../../overview/concepts/geo-scope.md) to put your virtual machine in.
1. Under **Image/boot disk selection**, go to the **{{ marketplace-name }}** tab and select a [CentOS 7](/marketplace/products/yc/centos-7) image.

1. Under **Disks**, select:
   * SSD
   * 19 GB

1. Under **Computing resources**:
   - Select the VM's [platform](../../compute/concepts/vm-platforms.md).
   - Specify the number of vCPUs and amount of RAM:
      * **Platform**: Intel Cascade Lake.
      * **Guaranteed vCPU share**: 20%.
      * **vCPU**: 2.
      * **RAM**: 2 GB.

1. In the **Network settings** section, select the network and subnet to connect the VM to. If you don't have a network or subnet yet, you can create them on the VM creation page.

1. In the **Public address** field, leave the **Automatically** value to assign a random external IP address from the {{ yandex-cloud }} pool. To ensure that the external IP address doesn't change after the VM is stopped, [make it static](../../vpc/operations/set-static-ip).

1. Specify data required for accessing the VM:
   - Enter the username in the **Login** field.
   - In the **SSH key** field, paste the contents of the public key file.

      You need to create a key pair for the SSH connection yourself. See the [section about how to connect to VMs via SSH](../../compute/operations/vm-connect/ssh.md).

   {% note alert %}

   The IP address and host name (FQDN) for connecting to the VM will be assigned when it's created. If you selected the **No address** option in the **Public address** field, you won't be able to access the VM from the internet.

   {% endnote %}

1. Click **Create VM**.

Creating the VM may take several minutes.


### Configure YC CLI

1. Log in to the VM over SSH.
1. Install the YC CLI according to the [instructions](../../cli/quickstart.md):
   1. Install the CLI.
   1. Initialize the CLI.
1. Make sure that the YC CLI runs correctly:
   ```bash
   yc config list
   ```
   The settings you made during setup are output as a result.

### Set up a service account

1. Create a service account and assign it a name (like `vision`):
   ```bash
   yc iam service-account create --name vision --description "this is vision service account"
   ```
1. Get the ID of the folder by following the [instructions](../../resource-manager/operations/folder/get-id.md).
1. Find the ID of your service account based on the folder ID:
   ```bash
   yc iam service-account --folder-id <FOLDER-ID> get vision
   ```

   You get one of the following strings as a result:
   ```
   id: <SERVICE-ACCOUNT-ID>
   ```
1. Configure the `editor` role for your service account by entering the relevant value:
   ```bash
   yc resource-manager folder add-access-binding default --role editor --subject serviceAccount:<SERVICE-ACCOUNT-ID>
   ```
1. Create a static access key for your service account:
   ```bash
   yc iam access-key create --service-account-name vision --description "this key is for vision"
   ```
   Save the following values (they'll be used to set up the AWS CLI):
   * `key_id`
   * `secret`

1. Get an IAM token for the service account in the CLI by following the [instructions](../../iam/operations/iam-token/create-for-sa.md):

   ```bash
   yc iam key create --service-account-name vision --output key.json
   yc config profile create vision-profile
   yc config set service-account-key key.json
   yc iam create-token
   ```

   Save the IAM token value returned by the command `yc iam create-token`. You need this value to upload images to {{ vision-full-name }}.

## Set up the AWS CLI {#aws-cli}

1. Install the `yum` repository:
   ```bash
   sudo yum install epel-release -y
   ```
1. Install pip:
   ```bash
   sudo yum install python-pip -y
   ```
1. Install the AWS CLI:
   ```bash
   sudo pip install awscli --upgrade
   ```
1. Set up the AWS CLI:
   ```bash
   aws configure
   ```

   When the parameter values are requested:
   * `AWS Access Key ID`: Specify the `key_id` value from the previous section, "Create a static access key for your service account".
   * `AWS Secret Access Key`: Specify the `secret` value from the same section.
   * `Default region name`: Enter `{{ region-id }}`.
   * `Default output format`: Enter `json`.
1. Check that the `~/.aws/credentials` file contains the correct values:
   ```bash
   cat ~/.aws/credentials
   ```
1. Check that the `~/.aws/config` file contains the correct values:
   ```bash
   cat ~/.aws/config
   ```

## Set up access to Object Storage {#object-storage-access}
1. Create an Object Storage bucket by following the [instructions](../../storage/operations/buckets/create.md):
   * Leave the default value for the maximum size.
   * Bucket access: **Limited**.
   * Storage class: **Cold**.
1. Go to the {{ yandex-cloud }} console and make sure that the bucket is in the list:

   ```
   {{ link-console-main }}/folders/<FOLDER-ID>/storage
   ```

## Create an archive with images {#create-archive}
1. Upload images with text to your bucket by following the [instructions](../../storage/operations/objects/upload.md).
1. Make sure that the images were uploaded:
   ```bash
   aws --endpoint-url=https://{{ s3-storage-host }} s3 ls s3://<BUCKET-NAME>/
   ```
   Where `<BUCKET-NAME>` is the name of your bucket.
1. Download images to your virtual machine, such as to the `my_pictures` directory:
   ```bash
   aws --endpoint-url=https://{{ s3-storage-host }} s3 cp s3://<BUCKET-NAME>/ my_pictures --recursive
   ```
1. Create an archive of the images and name it (for example, `my_pictures`):
   ```bash
   tar -cf my_pictures.tar my_pictures/*
   ```
1. Delete the image folder:
   ```bash
   rm -rfd my_pictures
   ```

## Create a script for digitizing and uploading images {#create-script}

### Preparation
1. Install the `jq` package. The script will use it to process the results from {{ vision-name }}:
   ```bash
   yum install jq -y
   ```
1. Create the environment variables necessary for the script to run:
   ```bash
   export BUCKETNAME="<BUCKET-NAME>"
   export FOLDERID="<FOLDER-ID>"
   export IAMTOKEN="<IAM-TOKEN>"
   ```

   Where:

   * `BUCKETNAME`: The name of your bucket.
   * `FOLDERID`: The name of your folder.
   * `IAMTOKEN`: The IAM token you obtained in [this section](#iam-token).

### Writing a script
This script performs the following steps:
1. Creates the necessary directories.
1. Unpacks the archive with images.
1. Processes images in a loop:
   1. Encodes images to be sent in a POST request to {{ vision-name }}.
   1. Forms the request body for the image.
   1. Sends the image to {{ vision-full-name }} with subsequent processing.
   1. Saves the result to `output.json`.
   1. Parses the text from `output.json` and saves it to a text file.
1. Archives all the text files obtained after image processing.
1. Moves the digitized archive to {{ objstorage-name }}.
1. Deletes the unnecessary files.

To make it easier to read, each step is commented in the script body.

1. Create a file with any name (such as `vision.sh`). Open this file in a text editor (like `vi`):
   ```bash
   vi vision.sh
   ```
1. Paste the script there:
   ```bash
   #!/bin/bash

   # Create the necessary directories.
    echo "Creating directories..."

   # Create a directory for the recognized text.
   mkdir my_pictures_text

   # Unpack the archive with images to the new directory.
   echo "Extract pictures in my_pictures directory..."
   tar -xf my_pictures.tar

   # Digitize the images from the archive.
   FILES=my_pictures/*
   for f in $FILES
   # For each file in the directory, perform the following actions in a loop:
   do
       # Encode the image to base64 to upload it to the {{ vision-full-name }} server.
       CODEIMG=$(base64 -i $f | cat)

       # Create the body.json file to be uploaded in a POST request to the {{ vision-full-name }} server.
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
       # Send the image to the {{ vision-full-name }} server for processing and write the result to the output.json file.
       echo "Processing file $f in Vision..."
       curl -X POST --silent \
       -H "Content-Type: application/json" \
       -H "Authorization: Bearer ${IAMTOKEN}" \
       -d '@body.json' \
       https://vision.{{ api-host }}/vision/v1/batchAnalyze > output.json

       # Get the name of the image to use it later.
       IMAGE_BASE_NAME=$(basename -- "$f")
       IMAGE_NAME="${IMAGE_BASE_NAME%.*}"

       # Get the text data from the JSON file with the processing results and write the data to a text file with the same name as the image file, but with the .txt extension.
       cat output.json | jq -r '.results[].results[].textDetection.pages[].blocks[].lines[].words[].text' | awk -v ORS=" " '{print}' > my_pictures_text/$IMAGE_NAME".txt"
   done

   # Archive the contents of the text file directory.
   echo "Packing text files to archive..."
   tar -cf my_pictures_text.tar my_pictures_text

   # Move the text file archive to your bucket.
   echo "Sending archive to Object Storage Bucket..."
   aws --endpoint-url=https://{{ s3-storage-host }} s3 cp my_pictures_text.tar s3://$BUCKETNAME/ > /dev/null

   # Delete any unnecessary files.
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

## Check the digitized content {#check}
1. Go to {{ vision-name }} in the {{ yandex-cloud }} console.
1. Make sure that your bucket contains the `my_pictures_text.tar` archive.
1. Download and unpack the archive.
1. Make sure that the text in the `<image name>.txt` file matches the text in the image.


## Delete the created cloud resources {#cleanup}
If you no longer need the cloud resources you created to digitize the archive:

* [Delete the VM](../../compute/operations/vm-control/vm-delete.md).
* [Delete the static IP address](../../vpc/operations/address-delete.md) if you created it.
* [Delete the Object Storage bucket](../../storage/operations/buckets/delete.md).
