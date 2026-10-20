{#ai-supply4-id}

Requirement ID: `AI-SUPPLY4`

{#ai-supply4-requirement}

**Requirement**

The organization must maintain a registry of software dependencies and images, obtain vulnerability information, determine the remediation timeframe with respect to the risk, and must not release a component that violates the approved criterion. An exception must name the specific version and the compensating measure. Scanning covers the dependencies of the application and the model loader; the finds are linked to the release manifest. If there is no container, an `N/A` result is acceptable for the image branch, but the dependency branch remains applicable.

{#ai-supply4-implementation}

**Implementation**

[{{ container-registry-name }}](../../../../container-registry/index.yaml) can scan Docker images manually, on upload, or on a schedule; the scope and results are described in the [scanner docs](../../../../container-registry/concepts/vulnerability-scanner.md) and the [scanning guide](../../../../container-registry/operations/scanning-docker-image.md). The scanner does not analyze model weights, model behavior, the RAG corpus, or the external service.

{#ai-supply4-check}

**Check**

1. Compare the production image digest and dependency versions against latest scan results.
1. Check test find processing and the impossibility to release a version that violates the approved criterion.

You can roll back to a previously accepted digest only after its vulnerabilities are checked.

{#ai-supply4-artifacts}

**Artifact**

* Image digest.
* Latest scan results.
* Release test.
* Dependency report.
* Redeployment event.
