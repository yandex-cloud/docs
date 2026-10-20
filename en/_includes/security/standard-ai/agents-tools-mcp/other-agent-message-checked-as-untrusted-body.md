{#ai-app-inject2-id}

Requirement ID: `AI-APP-INJECT2`

{#ai-app-inject2-requirement}

**Requirement**

An inter-agent message must include a verifiable sender, schema ID and version, task ID, expiration timestamp, trust level label, and protection against replay. The recipient must reject an unknown schema version and must not accept new authorizations or a trusted system instruction from the message.

Cycles and redelivery are limited by `AI-AGENT2` rules. The sender communicates using permitted message types; the message cannot convey a valid system instruction, identity, confirmation, or extended purpose.

If the message contains a RAG link or a retrieved fragment, the user's access permissions to the document must be verified before transmission to the model via `AI-RAG-ACL2`. Trust in the sending agent does not automatically transfer permissions for the data.

{#ai-app-inject2-check}

**Check**

Send messages with an invalid schema, expired timestamp, duplicate ID, and spoofed sender: each of them must be rejected. An untrusted instruction to expand privileges may persist as data, but it must not alter the trusted objective or actual permissions. A rejection must not produce an effect within the tool or the target system; upon failure, the other agent's channel is isolated, and the sender's credentials are revoked.

{#ai-app-inject2-artifacts}

**Artifact**

* Tests involving incorrect schemas, expired validity, duplicates, sender spoofing.
* Sender identity and binding.
* Schema and policy versions.
