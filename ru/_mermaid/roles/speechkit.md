```mermaid
flowchart BT
    ai.editor --> ai.admin
    ai.speechkit-tts.user --> ai.editor
    ai.viewer --> ai.editor
    ai.auditor --> ai.viewer
    ai.speechkit-stt.user --> ai.editor
```