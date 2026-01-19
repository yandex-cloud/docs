```mermaid
flowchart BT
    dspm.admin --> security-deck.admin
    dspm.editor --> dspm.admin
    dspm.editor --> security-deck.editor
    dspm.viewer --> dspm.editor
    dspm.viewer --> security-deck.viewer
    dspm.auditor --> dspm.viewer
    dspm.auditor --> security-deck.auditor
    dspm.worker --> security-deck.worker

    security-deck.auditor --> security-deck.viewer
    security-deck.viewer --> security-deck.editor
    security-deck.editor --> security-deck.admin

    security-deck.auditor ~~~ security-deck.admin
```