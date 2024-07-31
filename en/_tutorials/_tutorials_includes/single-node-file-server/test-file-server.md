1. Install ACL on the `fileserver-tutorial` VM:

   {% list tabs group=operating_system %}

   - Ubuntu {#ubuntu}

      ```bash
      sudo apt install acl
      ```

   {% endlist %}

1. On the `fileserver-tutorial` VM instance, create a directory named `remote` and the `test.txt` file:

   {% list tabs group=operating_system %}

   - Ubuntu {#ubuntu}

      ```bash
      sudo mkdir /<folder_name>/remote
      sudo setfacl -m u:<name_of_your_user>:rwx /<folder_name>/remote
      echo "Hello world!" > /<folder_name>/remote/test.txt
      ```

   {% endlist %}

1. Connect the network disk to your computer via NFS and check if the test file is available:

   {% list tabs group=operating_system %}

   - Linux/macOS {#linux-macos}

      If needed, install the network disk utility:

      ```bash
      sudo apt-get install nfs-common
      ```

      Create a mount point:

      ```bash
      sudo mkdir /remote-test-dir
      ```

      Attach a network disk:

      ```bash
      sudo mount -t nfs <VM_public_IP_address>:/<folder_name> /remote-test-dir
      ```

      As as result, the test directory and the file should become available at the mount point.

   - Windows {#windows}

      1. Run the **cmd.exe** utility. To do this, use the **Windows** + **R** keyboard shortcut and run the `cmd` command.
      1. From the command line, run:

         ```bash
         net use x: \\<VM_public_IP_address>\folder_name
         ```

      This will create a disk **X** with the test directory and file.

   {% endlist %}