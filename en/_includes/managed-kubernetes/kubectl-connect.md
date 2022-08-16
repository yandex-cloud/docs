## Connect to the {{ k8s }} cluster {#cluster-connect}

To work with a {{ k8s }} cluster using kubectl:
* [Configure cluster security groups](../../managed-kubernetes/operations/connect/security-groups.md#rules-master).

  {% note warning %}

  Security group settings may prevent connection to the cluster.

  {% endnote %}

* Add the {{ k8s }} cluster credentials to the kubectl configuration file:
  1. Run the command:

     ```bash
     {{ yc-k8s }} cluster get-credentials --external --name k8s-demo
     ```

  1. Check the kubectl configuration:

     ```yaml
     kubectl config view
     apiVersion: v1
     clusters:
       - cluster:
         certificate-authority-data: DATA+OMITTED
     ...
     ```

  * By default, credentials are added to the `$HOME/.kube/config` directory.
  * If you need to change the configuration location, use the `--kubeconfig <file path>` flag.