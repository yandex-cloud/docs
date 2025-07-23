# Managing {{ k8s }} resources in a {{ managed-k8s-full-name }} cluster via the {{ TF }} provider

You can create {{ k8s }} resources using {{ TF }} manifests. To do this, activate the `kubernetes` {{ TF }} provider. It supports {{ TF }} resources that are mapped to YAML configuration files for various {{ k8s }} resources.

It is convenient to create {{ k8s }} resources with {{ TF }} if you are already using {{ TF }} to support the infrastructure for a [{{ managed-k8s-full-name }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster). This way, you will be able to describe all resources in the same markup language.

In addition, {{ TF }} tracks dependencies between resources and prevents creation, changes, or deletion of a resource if its dependencies are not ready. Let’s assume you are creating a resource named `PersistentVolumeClaim`. It needs space in the `PersistentVolume` resource storage, but there is not enough free space there. {{ TF }} will detect the lack of free space and prevent creation of the `PersistentVolumeClaim` resource.

The example below illustrates how to create standard {{ k8s }} resources using {{ TF }}.

To create {{ k8s }} resources with {{ TF }}:

1. [Set up your infrastructure](#prepare-kubernetes-infrastructure).
1. [Activate the `kubernetes` provider](#apply-kubernetes-provider).
1. [Create {{ k8s }} resources](#create-standard-resources).
1. [Make sure the cluster application is available from the internet](#verify-setup).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

The support cost includes:

* Fee for using the master and outgoing traffic in a {{ managed-k8s-name }} cluster (see [{{ managed-k8s-name }} pricing](../../managed-kubernetes/pricing.md)).
* Fee for using computing resources, OS, and storage in cluster nodes (VMs) (see [{{ compute-name }} pricing](../../compute/pricing.md)).
* Fee for an NLB (see [{{ network-load-balancer-name }} pricing](../../network-load-balancer/pricing.md)).
* Fee for using public IP addresses for the VM and NLB (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).


## Prepare the infrastructure for {{ managed-k8s-name }} {#prepare-kubernetes-infrastructure}

1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}

   At this step, the file should not contain `kubernetes` provider settings. You will add them at the [next steps](#apply-kubernetes-provider).

1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}
1. Download the [k8s-cluster.tf](https://github.com/yandex-cloud-examples/yc-mk8s-cluster-infrastructure/blob/main/k8s-cluster.tf) configuration file to the same working directory.

   This file describes:

   * Network.
   * Subnet.
   * Two security groups: one for the cluster and one for the node group.
   * Cloud service account with the `k8s.clusters.agent`, `k8s.tunnelClusters.agent`, `vpc.publicAdmin`, `load-balancer.admin`, and `container-registry.images.puller` roles.
   * {{ managed-k8s-name }} cluster
   * {{ k8s }} node group.

1. Specify the values of variables in the `k8s-cluster.tf` file.
1. Make sure the {{ TF }} configuration files are correct using this command:

   ```bash
   terraform validate
   ```

   If there are any errors in the configuration files, {{ TF }} will point them out.

1. Create an infrastructure:

   {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

## Activate the Kubernetes provider {#apply-kubernetes-provider}

1. In the working directory, open the file with `yandex` provider settings. It must have the following structure:

    ```hcl
    terraform {
      required_providers {
        yandex = {
          source = "yandex-cloud/yandex"
        }
      }
      required_version = ">= 0.13"
    }

    provider "yandex" {
      token     = "<IAM_token>"
      cloud_id  = "<cloud_ID>"
      folder_id = "<folder_ID>"
      zone      = "<default_availability_zone>"
    }
    ```

1. In the file, specify the parameters required for the `kubernetes` provider to operate:

    1. Under `required_providers`, add:

        ```hcl
        kubernetes = {
          source = "hashicorp/kubernetes"
        }
        ```

    1. Under `required_providers`, change `required_version` to `">= 0.14.8"`.

    1. Add a new section at the end of the file:

        ```hcl
        data "yandex_client_config" "client" {}

        provider "kubernetes" {
          host                   = yandex_kubernetes_cluster.k8s-cluster.master[0].external_v4_endpoint
          cluster_ca_certificate = yandex_kubernetes_cluster.k8s-cluster.master[0].cluster_ca_certificate
          token                  = data.yandex_client_config.client.iam_token
        }
        ```

1. Make sure the resulting file looks like this:

    ```hcl
    terraform {
      required_providers {
        yandex = {
          source = "yandex-cloud/yandex"
        }
        kubernetes = {
          source = "hashicorp/kubernetes"
        }
      }
      required_version = ">= 0.14.8"
    }

    provider "yandex" {
      token     = "<IAM_token>"
      cloud_id  = "<cloud_ID>"
      folder_id = "<folder_ID>"
      zone      = "<default_availability_zone>"
    }

    data "yandex_client_config" "client" {}

    provider "kubernetes" {
      host                   = yandex_kubernetes_cluster.k8s-cluster.master[0].external_v4_endpoint
      cluster_ca_certificate = yandex_kubernetes_cluster.k8s-cluster.master[0].cluster_ca_certificate
      token                  = data.yandex_client_config.client.iam_token
    }
    ```

1. Initialize the `kubernetes` provider:

    ```bash
    terraform init
    ```

## Create {{ k8s }} resources {#create-standard-resources}

Create a test application and service of the `LoadBalancer` type:

1. In the working directory, create a file named `deployment.tf` describing the `Deployment` resource:

    ```hcl
    resource "kubernetes_deployment" "demo-app-deployment" {
      metadata {
        name = "hello"
        labels = {
          app = "hello"
          version = "v1"
        }
      }
      spec {
        replicas = 2
        selector {
          match_labels = {
            app = "hello"
          }
        }
        template {
          metadata {
            labels = {
              app = "hello"
              version = "v1"
            }
          }
          spec {
            container {
              name  = "hello-app"
              image = "{{ registry }}/crpjd37scfv653nl11i9/hello:1.1"
            }
          }
        }
      }
    }
    ```

1. In the working directory, create a file named `service.tf` describing the `Service` resource:

    ```hcl
    resource "kubernetes_service" "demo-lb-service" {
      metadata {
        name = "hello"
      }
      spec {
        selector = {
          app = kubernetes_deployment.demo-app-deployment.spec.0.template.0.metadata[0].labels.app
        }
        type = "LoadBalancer"
        port {
          port = 80
          target_port = 8080
        }
      }
    }
    ```

1. Create {{ k8s }} resources:

   {% include [terraform-apply-short](../../_includes/mdb/terraform/apply-short.md) %}

   After you run the `terraform apply` command, you may get this error:

   ```text
   Error: Waiting for rollout to finish: 2 replicas wanted; 0 replicas Ready
   │ 
   │   with kubernetes_deployment.demo-app-deployment,
   │   on deployment.tf line 1, in resource "kubernetes_deployment" "demo-app-deployment":
   │   1: resource "kubernetes_deployment" "demo-app-deployment" {
   │ 
   ```

   It means the `Deployment` resources are not ready yet. Check their readiness using the `kubectl get deployment` command, which will return this result:

   ```text
   NAME         READY   UP-TO-DATE   AVAILABLE   AGE
   hello        0/2     2            0           12m
   ```

   When the `READY` column indicates `2/2`, run the `terraform apply` command again.

You can also create other standard {{ k8s }} resources using {{ TF }} manifests. Use the YAML configuration of the resource you need as the basis ([here is an example for a pod](https://kubernetes.io/docs/concepts/workloads/pods/#using-pods)). Take the structure and parameters from the configuration and apply the {{ TF }} markup. For example, replace the `containerPort` parameter from the YAML file with the `container_port` parameter in {{ TF }}. For a full list of {{ TF }} resources for {{ k8s }}, see the [relevant provider documentation](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs).

For information about creating [custom resources](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/) using {{ TF }}, see [{{ TF }} tutorials](https://developer.hashicorp.com/terraform/tutorials/kubernetes/kubernetes-provider?variants=kubernetes%3Akind#managing-custom-resources).

## Make sure the cluster application is available from the internet {#verify-setup}

1. View information about the created load balancer:

     ```bash
     kubectl describe service hello
     ```

     Result:

     ```bash
      Name:                     hello
      Namespace:                default
      Labels:                   <none>
      Annotations:              <none>
      Selector:                 app=hello
      Type:                     LoadBalancer
      IP Family Policy:         SingleStack
      IP Families:              IPv4
      IP:                       10.96.228.81
      IPs:                      10.96.228.81
      LoadBalancer Ingress:     84.201.148.8
      Port:                     <unset>  80/TCP
      TargetPort:               8080/TCP
      NodePort:                 <unset>  32532/TCP
      Endpoints:                10.112.128.7:8080,10.112.128.8:8080
      Session Affinity:         None
      External Traffic Policy:  Cluster
      Internal Traffic Policy:  Cluster
      Events:
        Type    Reason                Age    From                Message
        ----    ------                ----   ----                -------
        Normal  EnsuringLoadBalancer  5m32s  service-controller  Ensuring load balancer
        Normal  EnsuredLoadBalancer   5m25s  service-controller  Ensured load balancer
     ```

1. Copy the IP address from the `LoadBalancer Ingress` field.  

1. Open the application's URL in your browser:

    ```http
    http://<copied_IP_address>
    ```

    Result:

    ```text
    Hello, world!
    Running in 'hello-5c46b*****-nc**'
    ```

    {% include [check-sg-if-url-unavailable-lvl3](../../_includes/managed-kubernetes/security-groups/check-sg-if-url-unavailable-lvl3.md) %}

## Delete the resources you created {#clear-out}

1. In the terminal window, navigate to the directory containing the infrastructure plan.

1. Run this command:

   ```bash
   terraform destroy
   ```

   {{ TF }} will delete all resources you created in the current configuration.

## Example of preparing a persistent volume using {{ TF }} {#example}

Prepare a [persistent volume](../../managed-kubernetes/concepts/volume.md#persistent-volume) for the {{ managed-k8s-name }} cluster. To do this, use a configuration file:

{% cut "pv-pvc.tf" %}

```hcl
resource "yandex_compute_disk" "pv_disk" {
  name = "pv-disk"
  zone = "ru-central1-a"
  size = 10
  type = "network-ssd"
}

resource "kubernetes_storage_class" "pv_sc" {
  metadata {
    name = "pv-sc"
  }
  storage_provisioner = "disk-csi-driver.mks.ycloud.io"

  parameters = {
    "csi.storage.k8s.io/fstype" = "ext4"
  }

  reclaim_policy      = "Retain"
  volume_binding_mode = "WaitForFirstConsumer"
}

resource "kubernetes_persistent_volume" "my_pv" {
  metadata {
    name = "my-pv"
  }
  spec {
    capacity = {
      storage = "10Gi"
    }
    access_modes       = ["ReadWriteOnce"]
    storage_class_name = "pv-sc"
    persistent_volume_source {
      csi {
        driver        = "disk-csi-driver.mks.ycloud.io"
        volume_handle = yandex_compute_disk.pv_disk.id
      }
    }
  }
}

resource "kubernetes_persistent_volume_claim" "my_pvc" {
  metadata {
    name = "my-pvc"
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "5Gi"
      }
    }
    storage_class_name = "pv-sc"
    volume_name        = "my-pv"
  }
}
```

{% endcut %}

The `pv-pvc.tf` file describes:

* {{ compute-name }} [disk](../../compute/concepts/disk.md) used as a storage for `PersistentVolume`:
  
    * Name: `pv-disk`.
    * Availability zone: `ru-central1-a`.
    * Disk size: 10 GB.
    * Disk type: `network-ssd`.

* Custom [StorageClass](../../managed-kubernetes/operations/volumes/manage-storage-class.md):

    * Name: `pv-sc`.
    * Storage provider: `disk-csi-driver.mks.ycloud.io`.
    * File system type: `ext4`.
    * Reuse policy: `Retain`. The `PersistentVolume` object will not be deleted after the deletion of its associated `PersistentVolumeClaim` object.
    * Volume binding mode: `WaitForFirstConsumer`. `PersistentVolume` and `PersistentVolumeClaim` will only be bound when the pod requests the volume.

    [Learn more about storage class parameters](https://kubernetes.io/docs/concepts/storage/storage-classes/).

* `PersistentVolume` object:

    * Name: `my-pv`.
    * Size: 10 GB.
    * Access mode: `ReadWriteOnce`. Only pods located on the same node can read and write data to this `PersistentVolume` object. Pods on other nodes will not be able to access this object.
    * Storage class: `pv-sc`. If not specified, the default storage class will be used.
    * Data source: `pv-disk`.

    [Learn more about PersistentVolume parameters](https://kubernetes.io/docs/reference/kubernetes-api/config-and-storage-resources/persistent-volume-v1/).

* `PersistentVolumeClaim` object:

    * Name: `my-pvc`.
    * Access mode: `ReadWriteOnce`. Only pods located on the same node can read and write data to this `PersistentVolume` object. Pods on other nodes will not be able to access this object.
    * Requested storage size is 5GB.
    * Storage class: `pv-sc`. If not specified, the default storage class will be used.
    * Volume name: `PersistentVolume` object to bind with `PersistentVolumeClaim`.

  [Learn more about PersistentVolumeClaim parameters](https://kubernetes.io/docs/reference/kubernetes-api/config-and-storage-resources/persistent-volume-claim-v1/).  

#### See also {#see-also}

* [{{ TF }} tutorials for creating {{ k8s }} resources](https://developer.hashicorp.com/terraform/tutorials/kubernetes/kubernetes-provider)
* [Provider documentation](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs)
