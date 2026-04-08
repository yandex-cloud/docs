```yaml
apiVersion: v1
kind: ResourceQuota
metadata:
  name: example-quota
spec:
  hard:
    requests.cpu: '2' # Requested CPUs: 2
    limits.cpu: '4'    # CPU limit: 4
    requests.memory: '1' # Requested RAM: 1 GB
    limits.memory: '10'   # RAM limit: 10 GB
    requests.nvidia.com/gpu: 1 # Requested GPUs: 1
```
