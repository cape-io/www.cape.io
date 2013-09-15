---
title : Glossary, List Types, Collections
description:

---

collection (content repo)
: Content Repository. A way of defining a collection of entities. It can be content, documents, media. This defines a database index.

view (query)
: A specific set of filters used to filter down the collection. The list returns ID's the represent entity documents. This defines a query against a database.

list (flags on query)
: A specific set of add/remove flags saved against ids in the view.

render (process mustache)
: Instructions on what list to use and what to do with it. Optionally makes pages.

theme
: Defines mustache theme files that lists are passed through.


## List Types

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

## View

* collection
* query
* layout_default
* theme_default
* group_by

## Render

* name
* list (The list of content to pass to the compiler.)
* theme_default
* layout_default
* permalink - (is page if has permalink. Create as many pages as necessary based on the mustache)
* summary_lines
* latest
* items_per (Qty of items per page.)
* groups_per
* paginator (This info should be available all the time.)
* priority

## Compile
Load up the config file. For each `render` create permalinks.

sort_by: priority
theme: cape
base_path: 
production_url: 
data_url:

## Theme

Theme layout files can depend on other theme files and other rendered list.