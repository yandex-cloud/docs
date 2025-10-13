[{{ k8s }} Security Posture Management (KSPM)](../../security-deck/concepts/kspm.md) ensures the security of containerized applications and images they use.

The KSPM module automatically identifies all {{ k8s }} clusters and containers in the specified [workspace](../../security-deck/concepts/workspace.md), and deploys security components in them as defined in the configuration. New clusters automatically get security coverage, without requiring manual search or installation of any components.

The module continuously assesses workloads for misconfigurations and provides runtime security monitoring through sensors that detect attacks targeting nodes and containers.