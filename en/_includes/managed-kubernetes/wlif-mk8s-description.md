{{ managed-k8s-name }} supports integration with {{ iam-name }} _workload identity federations_.

{% include [move-groups-api](../iam/wlif-instructions-intro.md) %}

When this option is enabled, {{ managed-k8s-name }} automatically creates an OIDC provider for the specific cluster and provides the following parameters for integration with workload identity federations:
* `{{ ui-key.yacloud.k8s.IAMService.ClusterIAMSection.iam-issuer_iKJcv }}`.
* `{{ ui-key.yacloud.k8s.IAMService.ClusterIAMSection.iam-jwks-uri_x2AJJ }}`.