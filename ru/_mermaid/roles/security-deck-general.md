```mermaid
flowchart BT
    security-deck.worker ~~~ security-deck.auditor
    security-deck.auditor --> security-deck.viewer
    security-deck.viewer --> security-deck.editor
    security-deck.editor --> security-deck.admin
```