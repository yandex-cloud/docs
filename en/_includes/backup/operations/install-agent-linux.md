1. [Connect](../../../compute/operations/vm-connect/ssh.md) to the VM over SSH.
1. Install the {{ backup-name }} agent on the VM by running this command in the Linux terminal:

    {% list tabs group=operating_system %}

    - Ubuntu {#ubuntu}

      ```bash
      sudo apt update && \
      sudo apt install -y jq && \
      curl https://{{ s3-storage-host }}/backup-distributions/agent_installer.sh | sudo bash
      ```

      Result:

      ```text
      ...
      Agent registered with id D9CA44FC-716A-4B3B-A702-C6**********
      ```

    - CentOS {#centos}

      ```bash
      sudo yum install epel-release -y && \
      sudo yum update -y && \
      sudo yum install jq -y && \
      curl https://{{ s3-storage-host }}/backup-distributions/agent_installer.sh | sudo bash
      ```

      Result:

      ```text
      ...
      Agent registered with id D9CA44FC-716A-4B3B-A702-C6**********
      ```

    {% endlist %}