```mermaid
%%{init: {"flowchart": {'defaultRenderer': 'elk'}} }%%
flowchart BT
    threat-detector.admin --> security-deck.admin
    threat-detector.editor --> security-deck.editor
    threat-detector.viewer --> security-deck.viewer
    threat-detector.auditor --> security-deck.auditor
    threat-detector.worker --> security-deck.worker

    security-deck.auditor --> security-deck.viewer
    security-deck.viewer --> security-deck.editor
    security-deck.editor --> security-deck.admin

    threat-detector.editor --> threat-detector.admin
    threat-detector.viewer --> threat-detector.editor
    threat-detector.auditor --> threat-detector.viewer

    security-deck.auditor ~~~ security-deck.admin
```