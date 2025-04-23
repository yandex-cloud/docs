1. [Create](../../compute/operations/vm-create/create-linux-vm.md) the `test-vm1` VM from the [Ubuntu 24.04](/marketplace/products/yc/ubuntu-2404-lts-oslogin) public image in the `{{ region-id }}-a` availability zone.
   
1. [Connect to your VM over SSH](../../compute/operations/vm-connect/ssh.md).
   
    If you have the [{{ yandex-cloud }} CLI](../../cli/quickstart.md) installed, you can connect to your VM via [{{ oslogin }}](../../compute/operations/vm-connect/os-login):

    ```bash
    yc compute ssh --name test-vm1
    ```
    

1. Start a test web server listening on port `8080`:

    ```bash
    mkdir test-server; echo 'HELLO' > test-server/hello.txt; python3 -m http.server -d test-server 8080
    ```

1. Make sure your web server returns a list of subdirectories in the `test-server` directory. Open the terminal on your computer and run this command:

    ```bash
    curl --verbose <VM_public_IP_address>:8080
    ```