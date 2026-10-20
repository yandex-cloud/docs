{#ai-content2-id}

Requirement ID: `AI-CONTENT2`

{#ai-content2-requirement}

**Requirement**

The application must treat the model's output as untrusted data. Before displaying it as active content, forming a request, writing to storage, or executing a command, the application must validate the format, schema, permissible values, target object, and the calling subject's privileges.

If the model generates SQL, shell command, URL, file name, template, API call, or tool arguments, the application must use a separate deterministic validator and a list of allowed operations. Successful generation of text by the model is not an authorization for an action.

The response gets parsed into a typed object: unknown and missing fields are rejected, and values are escaped according to the target context rules (HTML, SQL, shell, or file name).

For a system that outputs only inert text, execution-related branches may not apply but a safe render is still mandatory. Output validation is implemented by the application: the native output schema validation mechanism in {{ yandex-cloud }} is not certified.

{#ai-content2-check}

**Check**

Submit a synthetic response with an extra or privileged field, prohibited object, control sequence, HTML or script markup, invalid JSON, fragment of an SQL or shell command, and an unknown action. The requirement is met if the application rejects each such response prior to execution and logs the reason without recording sensitive data. None of the tests should result in a call for the target system, which should be confirmed by the absence of the corresponding event in the log or trace.

{#ai-content2-artifacts}

**Artifact**

* Model test responses.
* Rejection records.
* Validator code.
* Schema hash and policy version.
* Confirmation that there is no call for the target system.
