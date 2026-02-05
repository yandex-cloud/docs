```mermaid
flowchart BT
    kspm.admin --> security-deck.admin
    kspm.editor --> kspm.admin
    kspm.editor --> security-deck.editor
    kspm.viewer --> kspm.editor
    kspm.viewer --> security-deck.viewer
    kspm.auditor --> kspm.viewer
    kspm.auditor --> security-deck.auditor
    kspm.worker --> security-deck.worker

    security-deck.auditor --> security-deck.viewer
    security-deck.viewer --> security-deck.editor
    security-deck.editor --> security-deck.admin

    security-deck.auditor ~~~ security-deck.admin
```