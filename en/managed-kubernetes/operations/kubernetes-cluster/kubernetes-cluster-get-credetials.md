# Adding credentials to the kubectl configuration file

When you add credentials, please note:

{% include [note-about-conf](../../../_includes/managed-kubernetes/note-about-conf.md) %}

{% list tabs %}

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    To add {{ k8s }} cluster credentials to the kubectl configuration file:

    1. View a description of the CLI command:

        ```
        yc managed-kubernetes cluster get-credentials --help
        ```

    1. Add the credentials to the kubectl configuration file:

        ```
        yc managed-kubernetes cluster get-credentials test-k8s-cluster --external
        ```

    1. Check the kubectl configuration after adding the credentials:

        ```
        kubectl config view
        apiVersion: v1
        clusters:
        - cluster:
            certificate-authority-data: DATA+OMITTED
            server: https://84.201.150.175/
          name: yc-managed-k8s-cata9ertn6tcr09bh8ht
        contexts:
        ...
        ```

{% endlist %}

