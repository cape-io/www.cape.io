---
title : List Types
description:
---

### Added Only
This returns items that have been specifically added to a list.

    http://list.cape.io/{{username}}/{{list}}/added-{{size}}.json

### Removed Only
This returns items that have been specifically removed from a list.

    http://list.cape.io/{{username}}/{{list}}/removed-{{size}}.json

### Pending
This returns items that have not been added or removed from a list.

    http://list.cape.io/{{username}}/{{list}}/pending-{{size}}.json

### Stream
This returns items that have not been removed from a list.

    http://list.cape.io/{{username}}/{{list}}/stream-{{size}}.json
