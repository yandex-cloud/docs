1. [Create](../../compute/operations/vm-create/create-linux-vm.md) a virtual machine named `test-vm1` from the [Ubuntu 24.04](/marketplace/products/yc/ubuntu-2404-lts-oslogin) public image in the `{{ region-id }}-a` availability zone.
   
1. [Connect to the VM over SSH](../../compute/operations/vm-connect/ssh.md).
   
    If you have the [{{ yandex-cloud }} command line interface](../../cli/quickstart.md) installed, you can connect to the VM via [{{ oslogin }}](../../compute/operations/vm-connect/os-login):

    ```bash
    yc compute ssh --name test-vm1
    ```
    

1. Start a test web server that will respond to requests at port `8080`:

    ```bash
    mkdir test-server; echo 'HELLO' > test-server/hello.txt; python3 -m http.server -d test-server 8080
    ```

1. Make sure the web server returns a list of folders in the `test-server` folder. Open the terminal on your computer and run this command:

    ```bash
    curl --verbose <VM_public_IP_address>:8080
    ```