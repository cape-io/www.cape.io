The content lifecycle

CAPE.io is a web service that lets curators use content created anywhere and publish it everywhere. Everything that has a feed, API or webhook becomes a content source feeding your data-pool. Content streams in from Facebook, Twitter, Instagram, Flickr, Youtube, Zapier, Dropbox, Git based content repo and other Websites. CAPE.io is an aggregator and search engine for navigating those sources easily. It then allows you to create custom new feeds and/or content sources for use on your website or potentially any app. Think the wordpress.com for Jekyll with more power than Drupal without being limited to a single data source. For example, a user links social media websites with CAPE and sees a website automatically generated based on the information and content available from those sources. A "newspaper" will manually or automatically compile a collection of content from various sources and pass it through templates making it ready print, web, mobile, and syndicates.

Feeds and moderation. 

Four steps of content life cycle
Authoring
Storage, Organization, Compilation
Delivery
Consumption

Step 2 should be all about search. Building saved searches that get used on different areas of the site. A search is really just a list of filters.

Two types of lists. Smart and Static.

Steps to CAPE.io
Define sources
Send source content to search index
Create filters. This creates a "Feed".
Each feed has two status filters. Added, Removed.
Each feed has a single "Live" list that is based on a combination of "is" or "is not" for Added and Removed. For example: added, not_added+not_removed,not_removed.
When new results are found on the live list the compiler is called.
Web pages are also a list. A list of lists. Assign lists to a token.
Iterate through tokens to build HTML page.
Web sections can be created from a list and generate pages and pass arguments to individual pages.

1. Content creation. Pen and paper, typewriter, word processor, twitter, Facebook, youtube.
2. Content management. Filing cabinet, computer folders, wordpress, drupal.
3. Content delivery. Post office, magazines, newspaper, PHP Apache, CDN.

CAPE handles various content creation repositories. Each piece of content is a content object.

## CAPE.io is for Content Curation
Assemble content from anywhere.

1. Define your content sources.
2. Create a set of filters.
3. Preview the results.
4. Save the final query.
5. Optionally save and remove results from the list.
6. Optionally set a specific order to the results or define a sort.
7. Optionally create or select mustache templates to pass results to.
8. Optionally define where the results should be pushed/saved to.

## Content Sources
* Instagram
  * Each search filter needs to be added to the real-time list and auto-added.
* Flickr
* Facebook - https://developers.facebook.com/apps/301954979862828/realtime/
* Google Cal feeds
* Google spreadsheets
* Twitter
* Dropbox markdown files
* Github repo of markdown files