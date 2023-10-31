`k8s.tunnelClusters.agent` — специальная роль для создания кластера Kubernetes с туннельным режимом. Дает право на создание групп узлов, дисков, внутренних балансировщиков. Позволяет использовать заранее созданные ключи Yandex Key Management Service для шифрования и расшифровки секретов. Включает роли:

* `compute.admin`
* `iam.serviceAccounts.user`
* `k8s.viewer`
* `kms.keys.encrypterDecrypter`
* `load-balancer.privateAdmin`