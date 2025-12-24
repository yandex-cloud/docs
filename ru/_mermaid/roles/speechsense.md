```mermaid
flowchart BT
    speech-sense.spaces.creator["speech-sense. spaces.creator"] --> speech-sense.editor
    speech-sense.auditor --> speech-sense.viewer
    speech-sense.viewer --> speech-sense.editor
    speech-sense.editor --> speech-sense.admin
    speech-sense.data.editor --> speech-sense.admin
    speech-sense.data.viewer --> speech-sense.data.editor
```