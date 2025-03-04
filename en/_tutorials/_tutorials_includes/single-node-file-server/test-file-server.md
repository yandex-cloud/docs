1. Install ACL on the `fileserver-tutorial` VM:

   {% list tabs group=operating_system %}

   - Ubuntu {#ubuntu}

     ```bash
     sudo apt install acl
     ```

   {% endlist %}

1. Create a directory named `remote` and a file named `test.txt` on the `fileserver-tutorial` VM:

   {% list tabs group=operating_system %}

   - Ubuntu {#ubuntu}

     ```bash
     sudo mkdir /my_folder/remote
     sudo setfacl -m u:<your_username>:rwx /my_folder/remote
     echo "Hello world!" > /my_folder/remote/test.txt
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
     sudo mount -t nfs <VM_public_IP_address>:/my_folder /remote-test-dir
     ```

     As as result, the test directory and the file should become available at the mount point.

   - Windows {#windows}

     {% note info %}

     You may need to configure Windows security policies for access to the file server.

     {% endnote %}

     1. Run the **cmd.exe** utility. To do this, use the **Windows** + **R** keyboard shortcut and run the `cmd` command.
     1. From the command line, run:

        ```bash
        net use x: \\<VM_public_IP_address>\data
        ```

     This will create a disk **X** with the test directory and file.

   {% endlist %}