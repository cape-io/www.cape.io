# Drupal Hosting

## Data
title: Sundays Energy, Inc.

## Config
theme: cape
base_path: 
production_url: 

## Collection

name: catalog
source_location: https://github.com/sundaysenergy/www.sundaysenergy.com or file://Users/kc/Sites/www.sundaysenergy.com

## View

source_uri: catalog
name: hosting
collection: catalog
query: page.path == hosting* AND page.categories == drupal 
data:
  title: Drupal Hosting
  description: blah blah blah

## Render

view: hosting
list_type: stream
permalink: /catalog/hosting/drupal-hosting
per_page: 0
layout_default: pricing

# What we do. (Grouped)

## Global Data
title: Foundation

## Global Config
theme: rwdf

## Entity Collection
name: github_content_repo
source_location: http://github.com/ookb/rwdfruhoh.ookb.co

## View of Collection
name: whatwedo_categories
collection: github_content_repo
collection_uri: whatwedo
group_by: page.categories
sort_by: title ascending

## Render
name: whatwedo_categories
views: whatwedo_categories
groups_per: 1
entities_per: 20
theme_default:
layout_default: 
render_uri: /whatwedo/`{{categories}}`

# Theme
  - whatwedo_categories
  - menu

