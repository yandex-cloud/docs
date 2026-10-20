{#ai-rel1-id}

Requirement ID: `AI-REL1`

{#ai-rel1-requirement}

**Requirement**

The release decision must bind the exact versions of data or index, model package, system instructions, app configuration, image, check results, current exceptions, and the approvers. Building and publishing must be handled by a trusted process. The release result must match the approved package; manual component swapping after the check is prohibited.

The deployment must use the release manifest, not the default tag or name. For serverless runtimes, use the exact revision or version, for {{ k8s }}, image digest and configuration, and for {{ ai-studio-name }}, IDs of the model instance, guardrail, and index.

{#ai-rel1-implementation}

**Implementation**

For a containerized release, an [image scanning](../../../../container-registry/operations/scanning-docker-image.md) result may be part of the release decision, but the organization must set the acceptance threshold and deadline for fixing vulnerabilities. Image scanning does not replace the model package and data checks.

{#ai-rel1-check}

**Check**

Use a production revision to restore all listed versions and the release decision. The requirement is met if the model package is unambiguous, reproducible, and it matches the approved one. The `latest` tag or an unapproved discrepancy between the actual revision and manifest means failure.

{#ai-rel1-artifacts}

**Artifact**

* Release decision.
* Production revision mapping.
* Release manifest hash.
* Deployment event.
