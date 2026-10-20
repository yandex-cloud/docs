{#ai-model2-id}

Requirement ID: `AI-MODEL2`

{#ai-model2-requirement}

**Requirement**

Before using an external model package for the first time, the organization must assess the properties of its format, supporting code, custom loader and dependencies, eliminate unnecessary code execution, verify the checksum, and run the first launch in an isolated environment without production secrets or write access to production stores. Choosing a format depends on the risk. The extension name alone does not prove security.

The admission rules must list the allowed formats and exact versions of loaders for the framework in use. Executable deserialization of an untrusted artifact must not be used if a compatible secure format exists.

{#ai-model2-implementation}

**Implementation**

The {{ container-registry-name }} scanner analyzes Docker image vulnerabilities rather than model behavior, weight contents, or data poisoning. For information on scanner scope, refer to [this guide](../../../../container-registry/concepts/vulnerability-scanner.md).

{#ai-model2-check}

**Check**

Repeat running the fixed package in an isolated environment while observing file, network, and process activities. If you observe unexpected code execution, external state changes, or checksum mismatch, using the package is prohibited. The initial check concludes upon an expected smoke test result, after which the check’s one-time environment is wiped out.

{#ai-model2-artifacts}

**Artifact**

* Isolated execution result.
* Activity monitoring.
* Format and loader versions.
* Isolated environment configuration.
* Admission decision.
