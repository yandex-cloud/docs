# Migrating from an ALB ingress controller to Gwin

Follow this tutorial to migrate your {{ k8s }} apps from an {{ alb-name }} ingress controller to the new Gwin controller for {{ managed-k8s-name }}.

To migrate your app from an {{ alb-name }} ingress controller to the Gwin controller:

1. [Install Gwin](#gwin-install).
1. [Run the converter script](#run-script-converter).
1. [Create new resources in the cluster](#create-resources).
1. [Make sure your load balancing is correct](#check-load-balancing).
1. [Redirect traffic to the new load balancer](#dns-switch).
1. [Delete the resources you no longer need](#clear-out).

## Installing Gwin {#gwin-install}

Deploy the Gwin controller in your cluster following [this guide](../../../application-load-balancer/tools/gwin/quickstart.md). The controller will not respond to the ALB ingress controller's resources because its specification uses a different `ingressClassName`.

## Running the converter script {#run-script-converter}

The `alb-ingress-converter` tool automatically converts existing ALB ingress controller resources to the Gwin controller's format.

The converter transforms your {{ k8s }} resources as follows:

* **IngressClass**: Changes the ALB ingress class to `gwin-default`.
* **Annotations**: Converts `ingress.alb.yc.io/*` annotations to `gwin.yandex.cloud/*` format.
* **Backend Groups**: Converts `HttpBackendGroup`/`GrpcBackendGroup` resources into `IngressBackendGroup`.
* **Storage Buckets**: Converts references to {{ objstorage-name }} buckets into `YCStorageBucket` resources.
* **Services**: Creates `IngressBackendGroup` resources for backend groups when needed.
* **Path Types**: Updates path types to support regular expressions (`ImplementationSpecific`).

To run the converter script, do the following:

1. Download the converter binary and make it executable. The file you need is stored in a public {{ objstorage-name }} bucket. Builds are available for the following operating systems:

   * [Linux AMD64](https://{{ s3-storage-host }}/gwin/utils/alb-ingress-converter/alb-ingress-converter-v1.0.0.linux-amd64.tar.gz)
   * [Linux ARM64](https://{{ s3-storage-host }}/gwin/utils/alb-ingress-converter/alb-ingress-converter-v1.0.0.linux-arm64.tar.gz)
   * [macOS AMD64](https://{{ s3-storage-host }}/gwin/utils/alb-ingress-converter/alb-ingress-converter-v1.0.0.darwin-amd64.tar.gz)
   * [macOS ARM64](https://{{ s3-storage-host }}/gwin/utils/alb-ingress-converter/alb-ingress-converter-v1.0.0.darwin-arm64.tar.gz)
   * [Windows AMD64](https://{{ s3-storage-host }}/gwin/utils/alb-ingress-converter/alb-ingress-converter-v1.0.0.windows-amd64.tar.gz)
   * [Windows ARM64](https://{{ s3-storage-host }}/gwin/utils/alb-ingress-converter/alb-ingress-converter-v1.0.0.windows-arm64.tar.gz)

   Sample command to download the file for Linux:

   ```bash
   wget https://{{ s3-storage-host }}/gwin/utils/alb-ingress-converter/alb-ingress-converter-v1.0.0.linux-amd64.tar.gz &&
   tar -xzf alb-ingress-converter-v1.0.0.linux-amd64.tar.gz &&
   chmod +x alb-ingress-converter
   ```

1. Optionally, export all ALB ingress resources from your cluster using the following command:

   ```bash
   kubectl get ingress,ingressclasses,ingressgroupsettings,httpbackendgroups,grpcbackendgroups,services \
       -A -o yaml > current-resources.yaml
   ```

   Alternatively, you can run the converter to fetch resources directly from the cluster. In this case, the converter will use the default `kubectl` configuration or the one specified via the `-kubeconfig` parameter.

1. Run the converter in one of the following ways:

   * Basic usage of the converter:

       ```bash
       # Converting from files
       ./alb-ingress-converter -input-files current-resources.yaml

       # Directly converting from the cluster
       ./alb-ingress-converter
       ```

   * Advanced usage options:

       ```bash
       # Specifying an output directory
       ./alb-ingress-converter -input-files input.yaml -output-dir ./migration-output

       # Adding prefixes/suffixes to resource names to avoid naming conflicts
       ./alb-ingress-converter -input-files input.yaml -add-name-suffix "-migrated"

       # Saving diff files to review changes
       ./alb-ingress-converter -input-files input.yaml -save-diff

       # Validation-only mode (without generating output)
       ./alb-ingress-converter -input-files input.yaml -validate-only

       # Processing multiple files or directories
       ./alb-ingress-converter -input-files file1.yaml,file2.yaml
       ./alb-ingress-converter -input-dirs ./manifests -recursive
       ```

       The converter supports the following command-line flags:

       | Flag | Description |
       | --- | --- |
       | `-kubeconfig` | Path to the `kubectl` configuration file |
       | `-input-files` | Comma-separated list of YAML files containing the input resource configuration |
       | `-input-dirs` | Comma-separated list of directories containing the input resource configuration |
       | `-recursive` | Recursively scan input directories.<br>The default value is `false`. |
       | `-output-dir` | Output directory for converted resources.<br>The default value is `./alb-ingress-converter-output`. |
       | `-output-format` | Output format, `files` or `stdout`.<br>The default value is `files`. |
       | `-save-diff` | Save diff files showing the changes made.<br>The default value is `false`. |
       | `-validate-only` | Validate input files only.<br>The default value is `false`. |
       | `-add-name-prefix` | Add a prefix to the names of generated resources.<br>The default value is `""`. |
       | `-add-name-suffix` | Add a suffix to the names of generated resources.<br>The default value is `""`. |
       | `-ingress-controller-name` | Controller name used for filtering resources.<br>The default value is `ingress.alb.yc.io/yc-alb-ingress-controller`. |

1. Review the converter's output. The output directory is structured as follows:

    ```text
    output/
    ├── alb-ingress/ # Original ALB ingress resources
    │   ├── ...
    ├── gwin/ # Converted Gwin resources
    │   ├── ...
    └── diff/  # Diff files (if the `-save-diff` flag was used)
        └── ...
    ```

## Creating new resources in the cluster {#create-resources}

Review the converted resources and apply them to your cluster:

1. Inspect the generated YAML files in the `gwin` folder.
1. Apply them using the command: `kubectl apply -f <YAML_file>`. This will create a new load balancer.
1. Make sure all resources were created successfully by checking their status with the `kubectl get` command.

The new load balancer will be created without removing the existing one.

## Checking that your load balancing is correct {#check-load-balancing}

Test the new load balancer to ensure it functions correctly:

1. Get the IP address of your new load balancer:
    * Retrieve the `Ingress` resource status using the `kubectl get Ingress` command.
    * In the [management console]({{ link-console-main }}), do the following:
      * Go to the {{ managed-k8s-name }} cluster page.
      * In the left-hand panel, select ![image](../../../_assets/console-icons/timestamps.svg) **{{ ui-key.yacloud.k8s.cluster.switch_network }}**.
      * Navigate to the **{{ ui-key.yacloud.k8s.network.label_ingress }}** tab.
1. Make sure routing behaves as expected by testing the availability of your app's HTTP/HTTPS endpoints.
1. Make sure backend health checks report all backends as healthy.
1. Check the [logs](../../../application-load-balancer/operations/application-load-balancer-get-logs.md) for errors and review the [load balancer metrics](../../../application-load-balancer/metrics.md) for any signs of performance issues.

## Redirecting traffic to the new load balancer {#dns-switch}

1. Update your domain DNS records to point to the new load balancer's IP address, thereby redirecting traffic.
1. Monitor app metrics during the traffic switchover.
1. Make sure the app's features remain fully accessible after the traffic redirection.

## Deleting the resources you no longer need {#clear-out}

1. Delete your old ALB Ingress resources, i.e., original ingress controllers, backend groups, etc.
1. Uninstall the ALB Ingress Controller app.
1. Remove any unused load balancers or TLS certificates.

## Troubleshooting {#troubleshooting}

### Converter errors {#converter-errors}

`No resources found` error:

* Make sure `IngressClass` resources are included in the input data.
* Check that the ingress controller name filter matches your actual configuration.

## Resource transformation examples {#examples}

### Ingress resource basic configuration {#base-config-example}

Before converting (ALB ingress class):

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  annotations:
    ingress.alb.yc.io/group-name: "my-group"
    ingress.alb.yc.io/security-groups: "sg-1,sg-2"
spec:
  ingressClassName: yc-alb-ingress
  rules:
  - host: example.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: grpc-service
            port:
              number: 80
```

After converting (Gwin class):

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  annotations:
    gwin.yandex.cloud/groupName: "my-group"
    gwin.yandex.cloud/securityGroups: "sg-1,sg-2"
spec:
  ingressClassName: gwin-default
  rules:
  - host: example.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          resource:
            apiGroup: gwin.yandex.cloud
            kind: IngressBackendGroup
            name: grpc-service-80
```

### Converting a backend group {#backend-groups-example}

Before converting (ALB ingress version):

```yaml
apiVersion: alb.yc.io/v1alpha1
kind: HttpBackendGroup
metadata:
  name: weighted-backends
spec:
  backends:
  - name: v1
    service:
      name: app-v1
      port:
        number: 8080
    weight: 70
```

After converting (Gwin version):

```yaml
apiVersion: gwin.yandex.cloud/v1
kind: IngressBackendGroup
metadata:
  name: weighted-backends
spec:
  type: HTTP
  backends:
  - name: v1
    backendRef:
      name: app-v1
      port: 8080
    weight: 70
```
