## Connect to the {{ k8s }} cluster {#cluster-connect}

To work with your {{ k8s }} cluster using kubectl, add the {{ k8s }} cluster credentials to the kubectl configuration file.

1. Run the command:

    ```
    yc managed-kubernetes cluster get-credentials --external --name k8s-demo
    ```

1. Check the kubectl configuration:

    ```
    kubectl config view
    apiVersion: v1
    clusters:
    - cluster:
        certificate-authority-data: DATA+OMITTED
    ...
    ```
   * By default, credentials are added to the `$HOME/.kube/config` directory.
   * If you need to change the configuration location, use the `--kubeconfig <file path>` flag.

