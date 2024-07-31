1. [Use SSH to connect](../../../compute/operations/vm-connect/ssh.md#vm-connect) to the VM.
1. [Authenticate](../../../compute/operations/vm-connect/auth-inside-vm.md#auth-inside-vm) under the service account tied to the machine:

   ```bash
   curl -H Metadata-Flavor:Google 169.254.169.254/computeMetadata/v1/instance/service-accounts/default/token | \
   cut -f1 -d',' | \
   cut -f2 -d':' | \
   tr -d '"' | \
   docker login --username iam --password-stdin {{ registry }}
   ```

   Result:

   ```text
   Login succeeded
   ```

1. Download the Docker image to the VM:

   ```bash
   docker pull {{ registry }}/${REGISTRY_ID}/ubuntu:hello
   ```

   Result:

   ```text
   hello: Pulling from crpc9qeoft23********/ubuntu
   6a5697faee43: Pulling fs layer
   ba13d3bc422b: Pulling fs layer
   ...
   Digest: sha256:42068479274f1d4c7ea095482430dcba24dcfe8c23ebdf6d32305928********
   Status: Downloaded newer image for {{ registry }}/crpc9qeoft23********/ubuntu:hello
   {{ registry }}/crpc9qeoft23********/ubuntu:hello
   ```
