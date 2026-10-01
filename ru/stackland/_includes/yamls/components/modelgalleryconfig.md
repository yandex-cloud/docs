```yaml
apiVersion: stackland.yandex.cloud/v1alpha1
kind: ModelGalleryConfig
metadata:
  name: main
spec:
  enabled: true
  settings:
    storageClass: stackland-other

    embeddings:
      enabled: true
      nodeSelector:
        nvidia.com/gpu.product: NVIDIA-A100-SXM4-80GB
      affinity: {}
      resources:
        requests:
          cpu: "8"
          memory: 12Gi
          nvidia.com/gpu: "1"
        limits:
          cpu: "32"
          memory: 48Gi
          nvidia.com/gpu: "1"
      weightsInit:
        resources:
          requests:
            cpu: 500m
            memory: 512Mi
          limits:
            cpu: "2"
            memory: 2Gi

    ethics:
      enabled: true
      nodeSelector: &h100Selector
        nvidia.com/gpu.product: NVIDIA-H100-80GB-HBM3
      affinity: {}
      resources:
        requests:
          cpu: "4"
          memory: 4Gi
          nvidia.com/gpu: "1"
        limits:
          cpu: "16"
          memory: 32Gi
          nvidia.com/gpu: "1"
      weightsInit: &weightsInit
        resources:
          requests:
            cpu: 500m
            memory: 512Mi
          limits:
            cpu: "2"
            memory: 2Gi
    models:
      - name: lite
        modelType: yandexgpt-lite
        enabled: true
        nodeSelector: *h100Selector
        affinity: {}
        modelBackend:
          resources:
            requests:
              cpu: "2"
              memory: 4Gi
              nvidia.com/gpu: "1"
            limits:
              cpu: "8"
              memory: 16Gi
              nvidia.com/gpu: "1"
        grpcBackend: &grpcBackend
          resources:
            requests:
              cpu: "1"
              memory: 2Gi
            limits:
              cpu: "4"
              memory: 8Gi
        weightsInit: *weightsInit

      - name: pro-5-1
        modelType: yandexgpt-pro
        enabled: false
        nodeSelector: *h100Selector
        affinity: {}
        modelBackend:
          resources:
            requests:
              nvidia.com/gpu: "2"
            limits:
              nvidia.com/gpu: "2"
        grpcBackend: *grpcBackend
        weightsInit: *weightsInit

      - name: alice
        modelType: yandexgpt-lite
        enabled: false
        nodeSelector: *h100Selector
        affinity: {}
        modelBackend:
          resources:
            requests:
              cpu: "2"
              nvidia.com/gpu: "1"
            limits:
              cpu: "8"
              nvidia.com/gpu: "1"
        grpcBackend: *grpcBackend
        weightsInit: *weightsInit

      - name: alice-flash
        modelType: yandexgpt-lite
        enabled: false
        nodeSelector: *h100Selector
        affinity: {}
        modelBackend:
          resources:
            requests:
              cpu: "2"
              nvidia.com/gpu: "2"
            limits:
              cpu: "8"
              nvidia.com/gpu: "2"
        grpcBackend: *grpcBackend
        weightsInit: *weightsInit
```
