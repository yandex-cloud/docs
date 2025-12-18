# How to find out the external IP address of a {{ managed-k8s-name }} node


## Case description {#case-description}

You need to find out the external IP address of the node running the pod.

## Solution {#case-resolution}

You can get the node's IP address by sending the following request to the metadata service:

```
curl -H Metadata-Flavor:Google 169.254.169.254/computeMetadata/v1/instance/?recursive=true
```

For more information about this method of getting metadata, see [this guide](../../../compute/operations/vm-info/get-info.md) in the {{ compute-name }} section.

If your {{ managed-k8s-name }} node has internet access, you can also send a request to a third-party resource that returns the external IP address, such as the following:

```
curl http://ifconfig.co
```

## If nothing helped {#if-nothing-worked}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. {{ managed-k8s-name }} cluster ID.
1. Description of what you actually need to do.