```mermaid
%%{init: {"flowchart": {'defaultRenderer': 'elk'}} }%%
flowchart BT
    access-transparency.billingProvider["access-transparency.<br>billingProvider"] --> access-transparency.editor
    
    access-transparency.subscriptionManager["access-transparency.<br>subscriptionManager"] --> access-transparency.editor
    access-transparency.viewer --> access-transparency.subscriptionManager["access-transparency.<br>subscriptionManager"]

    access-transparency.viewer["access-transparency.<br>viewer"] --> security-deck.viewer

    access-transparency.admin["access-transparency.<br>admin"] --> security-deck.admin
    access-transparency.editor --> security-deck.editor
    access-transparency.editor --> access-transparency.admin

    security-deck.auditor ~~~ security-deck.admin

    security-deck.auditor --> security-deck.viewer
    security-deck.viewer --> security-deck.editor
    security-deck.editor --> security-deck.admin

```
