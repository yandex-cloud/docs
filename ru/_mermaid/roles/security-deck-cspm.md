```mermaid
flowchart BT
    cspm.admin --> security-deck.admin
    cspm.editor --> security-deck.editor
    cspm.editor --> cspm.admin
    cspm.viewer --> security-deck.viewer
    cspm.viewer --> cspm.editor
    cspm.auditor --> security-deck.auditor
    cspm.auditor --> cspm.viewer
    cspm.worker --> security-deck.worker

    security-deck.auditor --> security-deck.viewer
    security-deck.viewer --> security-deck.editor
    security-deck.editor --> security-deck.admin

    security-deck.auditor ~~~ security-deck.admin
```