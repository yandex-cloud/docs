```yaml
apiVersion: stackland.yandex.cloud/v1alpha1
kind: PolicyManagerConfig
metadata:
  name: main # This is a required field you must set to `main`
spec:
  enabled: true
  settings:
    defaultPolicySet:
      engines:
        kyverno: # tool name
          presets:
            - baseline      # based on Pod Security Standard Baseline (default)
            # - restricted  # based on Pod Security Standard Restricted (optional)
    trivy:
      enabled: true # image scanning is enabled by default
      settings:
        scanner:
          reportTTL: 24h
          scanJobTimeout: 5m
          concurrentScanJobs: 5
          excludeNamespaces:
            - tenant-sandbox
        # Do not specify `database` to use the bundled database.
        # For independent updates, specify both `registry` and `repository`:
        # database:
        #   registry: registry.example.com
        #   repository: security/trivy-db
        # To update Java DB outside of a release, set both Java parameters:
        #   javaRegistry: registry.example.com
        #   javaRepository: security/trivy-java-db
```
