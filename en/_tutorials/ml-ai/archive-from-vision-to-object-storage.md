# Recognizing text in image archives using {{ vision-full-name }}

With [{{ vision-name }}]({{ link-docs-ai }}vision/concepts/ocr) and [{{ objstorage-full-name }}](../../storage/), you can perform text recognition on images and maintain an archive of source images and recognition results.

To set up an {{ vision-name }} infrastructure for image recognition and automatic export of the results to {{ objstorage-name }}:

1. [Get your cloud ready](#before-you-begin).
1. [Create a bucket](#create-bucket).
1. [Create a VM](#create-vm).
1. [Configure the VM](#configure-vm).
1. [Create an image archive](#create-archive).
1. [Prepare a script for recognizing and uploading images](#prepare-script).
1. [Verify the recognition accuracy](#check-result).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The cost of supporting the infrastructure for image recognition and data storage includes:
* Fee for [VM](../../compute/concepts/vm.md) computing resources and [disks](../../compute/concepts/disk.md) (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for [bucket](../../storage/operations/index.md) data storage and data [operations](../../storage/concepts/bucket.md) (see [{{ objstorage-name }} pricing](../../storage/pricing.md)).
* Fee for a static or dynamic [public IP address](../../vpc/concepts/address.md#public-addresses) (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).
* Fee for using {{ vision-name }} (see [{{ vision-name }} pricing]({{ link-docs-ai }}vision/pricing)).

## Create a bucket {#create-bucket}

To create an {{ objstorage-name }} bucket for storing source images and recognition results:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you will operate.
  1. [Navigate](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Click **{{ ui-key.yacloud.storage.buckets.button_create }}**.
  1. Specify the bucket name that meets [these naming conventions](../../storage/concepts/bucket.md#naming).
  1. In the **{{ ui-key.yacloud.storage.bucket.settings.field_access-read }}** field, select **{{ ui-key.yacloud.storage.bucket.settings.access_value_private }}**.
  1. In the **{{ ui-key.yacloud.storage.bucket.settings.field_class }}** field, select **{{ ui-key.yacloud.storage.value_cold }}**.
  1. Click **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.

{% endlist %}

## Create a VM {#create-vm}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) dashboard, click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}**, and select `{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}`.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, enter `CentOS 7` in the **{{ ui-key.yacloud.compute.instances.create.placeholder_search_marketplace-product }}** field and select a public [CentOS 7](/marketplace/products/yc/centos-7) image.
  1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select an [availability zone](../../overview/concepts/geo-scope.md) where your VM will reside. If you are not sure which availability zone you need, leave the default selection.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_storages }}**, select the [disk](../../compute/concepts/disk.md#disks_types) type (`{{ ui-key.yacloud.compute.value_disk-type-network-ssd_4Mmub }}`) and specify its size (`19 {{ ui-key.yacloud.common.units.label_gigabyte }}`).
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, switch to the `{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}` tab and specify the [platform](../../compute/concepts/vm-platforms.md), number of vCPUs, and amount of RAM:

      * **{{ ui-key.yacloud.component.compute.resources.field_platform }}**: `Intel Cascade Lake`
      * **{{ ui-key.yacloud.component.compute.resources.field_cores }}**: `2`
      * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}**: `20%`
      * **{{ ui-key.yacloud.component.compute.resources.field_memory }}**: `2 {{ ui-key.yacloud.common.units.label_gigabyte }}`

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      * In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, select the network and subnet to which you want to connect your VM. If the [network](../../vpc/concepts/network.md#network) or [subnet](../../vpc/concepts/network.md#subnet) you need does not exist yet, [create it](../../vpc/operations/subnet-create.md).
      * In the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field, select a static IP address from the list, or leave `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}` to assign your VM a random external IP address from the {{ yandex-cloud }} pool.

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, select **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** and specify the VM access credentials:

      * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, enter the username. Do not use `root` or other reserved usernames. For operations requiring root privileges, use the `sudo` command.
      * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name. The naming requirements are as follows:

      {% include [name-format](../../_includes/name-format.md) %}

  1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.
  1. Wait for the VM status to change to `Running` and save its public IP address; you will need it for SSH connection.

{% endlist %}

## Configure the VM {#configure-vm}

### Configure the {{ yandex-cloud }} CLI {#configure-yc-cli}

1. [Connect](../../compute/operations/vm-connect/ssh.md#vm-connect) to the VM over SSH.
1. [Install](../../cli/quickstart.md#install) the {{ yandex-cloud }} CLI on your VM and [create](../../cli/quickstart.md#initialize) a profile.
1. Make sure the {{ yandex-cloud }} CLI is working properly:

   {% list tabs group=instructions %}

   - CLI {#cli}

     Run the following command on your VM:

     ```bash
     yc config list
     ```

     Result:

     ```text
     token: AQ...gs
     cloud-id: b1gdtdqb1900********
     folder-id: b1gveg9vude9********
     ```

     Save the folder ID from the `folder-id` field in the response; you will need it for configuring a [service account](../../iam/concepts/users/service-accounts.md).

   {% endlist %}

### Configure a service account {#configure-sa}

{% list tabs group=instructions %}

- CLI {#cli}

  1. Create a service account:

     ```bash
     yc iam service-account create \
       --name <service_account_name> \
       --description "<service_account_description>"
     ```

     Where:
     * `--name`: Service account name, e.g., `vision-sa`.
     * `--description`: Service account description, e.g., `this is vision service account`.

     Result:

     ```text
     id: aje6aoc8hccu********
     folder_id: b1gv87ssvu49********
     created_at: "2022-10-12T14:04:43.198559512Z"
     name: vision-sa
     description: this is vision service account
     ```

     Save the service account ID from the `id` field in the response; you will need it for further configuration.

  1. Assign the `editor` [role](../../iam/concepts/access-control/roles.md) to the service account:

      ```bash
      yc resource-manager folder add-access-binding <folder_ID> \
        --role editor \
        --subject serviceAccount:<service_account_ID>
      ```

      Where:
      * `--role`: Role to assign.
      * `--subject serviceAccount`: Service account ID.
  1. Create a [static access key](../../iam/concepts/authorization/access-key.md) for your service account:

     ```bash
     yc iam access-key create \
       --service-account-id <service_account_ID> \
       --description "<key_description>"
     ```

     Where:
     * `--service-account-id`: Service account ID.
     * `--description`: Key description, e.g., `this key is for vision`.

     Result:

     ```text
     access_key:
       id: ajen8d7fur27********
       service_account_id: aje6aoc8hccu********
       created_at: "2022-10-12T15:08:08.045280520Z"
       description: this key is for vision
       key_id: YC...li
     secret: YC...J5
     ```

     Save the following values, as you will need them to configure the AWS CLI:
     * `key_id`: Static access key ID
     * `secret`: Secret key
  1. Create an [authorized key](../../iam/concepts/authorization/key.md) for the service account:

     ```bash
     yc iam key create \
       --service-account-id <service_account_ID> \
       --output key.json
     ```

     Where:
     * `--service-account-id`.
     * `--output`: Name of the JSON file containing your authorized key.

     Result:

     ```text
     id: aje3qc9pagb9********
     service_account_id: aje6aoc8hccu********
     created_at: "2022-10-13T12:53:04.810240976Z"
     key_algorithm: RSA_2048
     ```

  1. Create a {{ yandex-cloud }} CLI profile to run as the service account, e.g., `vision-profile`:

     ```bash
     yc config profile create vision-profile
     ```

     Result:

     ```text
     Profile 'vision-profile' created and activated
     ```

  1. In the profile configuration, specify the service account’s authorized key:

     ```bash
     yc config set service-account-key key.json
     ```

  1. Obtain an [{{ iam-short-name }} token](../../iam/concepts/authorization/iam-token.md) for the service account:

     ```bash
     yc iam create-token
     ```

     Save the {{ iam-short-name }} token. You will need it to send images to {{ vision-name }}.

{% endlist %}

### Configure the AWS CLI {#configure-aws-cli}

1. Update the packages installed on your VM’s operating system by running the following command:

   ```bash
   sudo yum update -y
   ```

1. Install the AWS CLI:

   ```bash
   sudo yum install awscli -y
   ```

1. Configure the AWS CLI:

   ```bash
   aws configure
   ```

   Specify these settings:
   * `AWS Access Key ID`: Static access key ID (`key_id`) that you received when [configuring the service account](#configure-sa).
   * `AWS Secret Access Key`: Secret key (`secret`) that you received when [configuring the service account](#configure-sa).
   * `Default region name`: `{{ region-id }}`.
   * `Default output format`: `json`.
1. Verify that the `~/.aws/credentials` file contains the correct `key_id` and `secret` values:

   ```bash
   cat ~/.aws/credentials
   ```

1. Verify that the `~/.aws/config` file contains the correct `Default region name` and `Default output format` values:

   ```bash
   cat ~/.aws/config
   ```

## Create an image archive {#create-archive}

1. [Upload](../../storage/operations/objects/upload.md) the images with text you want to recognize to the bucket.

   {% include [example-image](../../_includes/vision/example-image.md) %}

1. Make sure the images were uploaded by sending the following request with your bucket name specified:

   ```bash
   aws --endpoint-url=https://{{ s3-storage-host }} s3 ls s3://<bucket_name>/
   ```

1. Save the images from the bucket to the `my_pictures` directory on your VM:

   ```bash
   aws --endpoint-url=https://{{ s3-storage-host }} s3 cp s3://<bucket_name>/ my_pictures --recursive
   ```

1. Add the images to the `my_pictures.tar` archive:

   ```bash
   tar -cf my_pictures.tar my_pictures/*
   ```

1. Delete the image directory:

   ```bash
   rm -rfd my_pictures
   ```

## Prepare a script for image recognition and uploading {#prepare-script}

### Set up your environment {#prepare-environment}

1. Install the `epel` repository for additional packages:

   ```bash
   sudo yum install epel-release -y
   ```

1. Install the `jq` package for processing results from {{ vision-name }}:

   ```bash
   sudo yum install jq -y
   ```

1. Install the `nano` text editor:

   ```bash
   sudo yum install nano -y
   ```

1. Set the environment variables used by the script:

   ```bash
   export BUCKETNAME="<bucket_name>"
   export FOLDERID="<folder_ID>"
   export IAMTOKEN="<IAM_token>"
   ```

   Where:
   * `BUCKETNAME`: Bucket name.
   * `FOLDERID`: Folder ID.
   * `IAMTOKEN`: {{ iam-short-name }} token that you received when [configuring the service account](#configure-sa).

### Create a script {#create-script}

{% list tabs group=programming_language %}

- Bash {#bash}

   The script runs through the following steps:
   1. Creating required directories.
   1. Extracting the image archive.
   1. Processing all images in sequence:
      1. Encoding the image in Base64.
      1. Creating a request body containing the image.
      1. Sending the image to {{ vision-name }} for recognition via a POST request.
      1. Saving the response to the `output.json` file.
      1. Extracting the recognized text from `output.json` and saving it to a text file.
   1. Adding the resulting text files to an archive.
   1. Uploading the archive to {{ objstorage-name }}.
   1. Deleting temporary files.

   To make things clearer, the script has comments for each step.

   To prepare this script:
   1. Create a file named `vision.sh` and open it in `nano`:

      ```bash
      sudo nano vision.sh
      ```

   1. Paste the following Bash script into `vision.sh`:

      ```bash
      #!/bin/bash

      # Create the required directories.
      echo "Creating directories..."

      # Create a directory to store the recognized text.
      mkdir my_pictures_text

      # Extract the image archive into the new directory.
      echo "Extract pictures in my_pictures directory..."
      tar -xf my_pictures.tar

      # Run text recognition on the images from the archive.
      FILES=my_pictures/*
      for f in $FILES
      # Loop through each file in the directory and perform the following steps:
      do
         # Encode the image in Base64 for submission to {{ vision-name }}.
         CODEIMG=$(base64 -i $f | cat)

         # Create a `body.json` file that you will send to {{ vision-name }} via a POST request.
         cat <<EOF > body.json
      {
      "mimeType": "JPEG",
      "languageCodes": ["*"],
      "model": "page",
      "content": "$CODEIMG"
      }
      EOF
      # Send the image to Vision OCR for recognition and write the response to the `output.json` file.
      echo "Processing file $f in Vision..."
      curl --request POST \
        --header "Content-Type: application/json" \
        --header "Authorization: Bearer ${IAMTOKEN}" \
        --header "x-data-logging-enabled: true" \
        --header "x-folder-id: ${FOLDERID}" \
        --data '@body.json' \
        https://ocr.{{ api-host }}/ocr/v1/recognizeText \
        --output output.json

      # Get the image file name to use later in the request.
      IMAGE_BASE_NAME=$(basename -- "$f")
      IMAGE_NAME="${IMAGE_BASE_NAME%.*}"

      # Retrieve the text data from `output.json` and write it to a .txt file named after the original image file.
      cat output.json | jq -r '.result[].blocks[].lines[].text' | awk -v ORS=" " '{print}' > my_pictures_text/$IMAGE_NAME".txt"
      done

      # Archive the contents of the text file directory.
      echo "Packing text files to archive..."
      tar -cf my_pictures_text.tar my_pictures_text

      # Upload the text file archive to your bucket.
      echo "Sending archive to Object Storage Bucket..."
      aws --endpoint-url=https://{{ s3-storage-host }} s3 cp my_pictures_text.tar s3://$BUCKETNAME/ > /dev/null

      # Delete temporary files.
      echo "Cleaning up..."
      rm -f body.json
      rm -f output.json
      rm -rfd my_pictures
      rm -rfd my_pictures_text
      rm -r my_pictures_text.tar
      ```

   1. Set execute permissions for the script:

      ```bash
      sudo chmod 755 vision.sh
      ```

   1. Run the script:

      ```bash
      ./vision.sh
      ```

{% endlist %}

## Verify the recognition accuracy {#check-result}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the {{ yandex-cloud }} [management console]({{ link-console-main }}), select the folder containing the bucket with your recognition results.
  1. [Navigate](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Open the bucket with the recognition results.
  1. Verify that the bucket contains `my_pictures_text.tar`.
  1. Download and unpack the archive.
  1. Verify that the text in the `<image_name>.txt` files matches the text on the corresponding images.

{% endlist %}

## How to delete the resources you created {#clear-out}

To stop incurring costs for the resources you created:

1. [Delete](../../storage/operations/objects/delete-all.md) all objects from the bucket.
1. [Delete](../../storage/operations/buckets/delete.md) the bucket.
1. [Delete](../../compute/operations/vm-control/vm-delete.md) the VM.
1. [Delete](../../vpc/operations/address-delete.md) the static public IP address if you reserved one.
