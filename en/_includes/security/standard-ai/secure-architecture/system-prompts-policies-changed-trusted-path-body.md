{#ai-core5-id}

Requirement ID: `AI-CORE5`

{#ai-core5-requirement}

**Requirement**

System instructions, prompt templates, tool policies, routing rules, security configurations, and other trusted settings must be stored separately from user content, have an owner, object ID, and version, and must be modified only through an approved change process. If such a configuration exists, the `N/A` result is not allowed.

For the object, the reading and writing entities, revision history, and active version are recorded. A deployment record links the artifact hash of the instructions to a model or application version.

The application must not replace them with data from RAG, a tool response, or message from another agent. The runtime environment accepts a trusted set only from an approved release path.

Secrets should not be included in the system prompt. If the configuration is stored in {{ objstorage-full-name }} or another cloud resource, the access control, encryption, and versioning mechanisms documented for that resource apply; [{{ objstorage-name }} versioning](../../../../storage/operations/buckets/versioning.md) may be used as part of the revision history but does not replace the approval procedure. No native registry for prompts and policies is claimed for {{ yandex-cloud }}; cloud-based tools ensure secure storage and deployment, while trusted instruction management handles the application release process.

{#ai-core5-manual-check}

**Manual check**

1. Compare the active version of the configuration with the approved version and the subjects authorized to read and modify it.
1. Then, try to change the goal or policy via custom input and the RAG document.

This change must not be included in the trusted configuration. If the change has made its way into the active configuration, stop the release or agent operation, revert to the last approved set, rotate any exposed secrets, and rerun the original negative test.

{#ai-core5-artifacts}

**Artifact**

* Active configuration version.
* Release notes.
* Spoofing test result.
* Instruction artifact hash.
* Deployment event.
* Current version log.
