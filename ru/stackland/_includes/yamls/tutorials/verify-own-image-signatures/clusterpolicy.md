```yaml
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: verify-my-images
spec:
  admission: true
  background: true
  webhookConfiguration:
    failurePolicy: Ignore
  rules:
  - name: verify-signature
    match:
      any:
      - resources:
          kinds:
          # Pod only: Kyverno generates rules for Deployment, StatefulSet, DaemonSet, Job, and CronJob.
          # Adding these kinds here disables autogeneration.
          - Pod
          # namespaceSelector:
          #   matchLabels:
          #     stackland.yandex.cloud/project-name: <project-name>
    exclude:
      any:
      - resources:
          namespaceSelector:
            matchLabels:
              # Platform namespaces are verified on the node, not by this policy.
              stackland.yandex.cloud/project-name: stackland
    verifyImages:
    - imageReferences:
      # Match only customer-owned paths. Never use * here.
      - <адрес реестра>/<путь к вашим образам>/*
      failureAction: Audit
      type: Cosign
      mutateDigest: false
      verifyDigest: true
      required: true
      useCache: true
      imageRegistryCredentials:
        secrets:
        # The Secret must exist in the stackland-policy-manager namespace.
        - my-registry-creds
      attestors:
      - count: 1
        entries:
        - keys:
            publicKeys: |-
              -----BEGIN PUBLIC KEY-----
              <содержимое файла cosign.pub>
              -----END PUBLIC KEY-----
            signatureAlgorithm: sha256
            rekor:
              ignoreTlog: true
            ctlog:
              ignoreSCT: true
```
