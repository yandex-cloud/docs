1. View the description of the CLI command for creating a VM:

   ```
   yc compute instance create --help
   ```

1. Select one of the public images on Windows.

   {% include [standard-images](../../_includes/standard-images.md) %}

1. Create a YAML file (for example, `metadata.yaml`) and specify the following:

   ```yaml
   #ps1
   net user administrator '<password>'
   ```

1. Create a VM in the default folder:

   ```
   yc compute instance create \
     --name second-instance \
     --metadata-from-file user-data=metadata.yaml \
     --zone {{ region-id }}-a \
     --public-ip \
     --create-boot-disk image-folder-id=standard-images,image-family=windows-2016-gvlk
   ```

   This command creates a VM instance with the following characteristics:

   - Named `second-instance`.
   - With the Windows Server 2016 OS.
   - In the `{{ region-id }}-a` availability zone.
   - With the `Administrator` user.
   - With a public IP address.

   To create a VM without a public IP, remove the `--public-ip` flag.

   Specify:

   - The VM name in the `--name` flag.

      The name must be unique within the folder. It may contain lowercase Latin letters, numbers, and hyphens. The first character must be a letter. The last character can't be a hyphen. The maximum length of the name is 63 characters.

      {% include [name-fqdn](../../_includes/compute/name-fqdn.md) %}

   - The administrator password in the `metadata.yaml` file. A password is required for accessing the VM via RDP.

      {% include [password-requirements](../../_includes/compute/password-requirements.md) %}


