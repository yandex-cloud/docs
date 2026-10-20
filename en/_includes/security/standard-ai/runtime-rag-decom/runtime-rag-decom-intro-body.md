The runtime environment determines which processes share nodes and a network, where the state is stored, how the application retrieves secrets, and which logs are automatically generated. {{ managed-k8s-name }}, {{ serverless-containers-name }}, {{ sf-name }}, {{ compute-name }}, {{ ml-platform-name }}, and managed APIs have different models. The requirement is considered met only for the environment that is actually in use.

The owner specifies the applicable branch:

* For a managed [{{ ai-studio-name }} API]({{ link-docs-ai }}ai-studio/concepts/api), no control over the OS or node is claimed; the calling application as well as its identity, inputs/outputs, data, and external state are verified.
* For [{{ ml-platform-name }}](../../../../datasphere/index.yaml), the boundaries are defined by the community, project, task or node, its service identities, network, and external resources.
* For [{{ managed-k8s-name }}](../../../../managed-kubernetes/index.yaml), the following are checked separately: {{ iam-name }}, {{ k8s }} RBAC, namespaces, pods, nodes, and the network.
* For [{{ serverless-containers-name }}](../../../../serverless-containers/index.yaml) and [{{ sf-name }}](../../../../functions/index.yaml), the following are factored in: revision or version, respectively, active service account, instance reuse, and external state.
* For [{{ compute-name }}](../../../../compute/index.yaml), the organization is responsible for the VM, OS, process, model loader, and telemetry agent.
* For the external model API, a local runtime profile is used, along with a dedicated outbound traffic boundary, external credentials, and a recipient.

Specific roles, configuration objects, and verification methods are listed [here](../../../../security/standard-ai/profiles.md).
