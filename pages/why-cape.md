---
layout: page
title: Static benefits
header: Pages

---

## The problems with content management systems 

### Complexity and Cost

Using Drupal or Wordpress requires software to be running on a server to dynamically build each page request. So every time a user wants to visit a page, the server has to build it first. The software that does this builds each page dynamically, and requires constant updates and has a lot of "moving parts". The cost to keep all of those parts moving all the time is high. Therefore, the cost to host a website like this will be much more expensive than a static site.

### Constraints on Content Creation

With a typical CMS, content can only be created via that website. The method for adding content was designed to be like a “desktop” type device that was connected to the internet. This approach was fine when everyone did everything on a desktop computer. But now content creators have all kinds of devices they like to use for content creation. A good example is the iPad. It’s clumsy editing content via a website, and it's a much nicer experience using a native app that is a content editor.

### Emphasis on 
WYSIWYM

## Why switch to Create Anywhere Publish Everywhere (CAPE)?

### Performance

Content rarely changes. It is a complete waste of resources to load a database and software to handle the processing it into the final html markup. It's difficult to get higher performance than serving static files. Dynamic content can be handled with various third party javascript libraries. Ever get a notice from your host that your website is using too many resources? CPU or Memory issues will be gone forever when your site is statically cached.

### Data Protection

Own your content. If you use a blogging service like Tumblr you should have a backup of all your posts. Do you? CAPE accepts various sources of information and stores them in plain text files. They are easy to edit anywhere and can be published everywhere.

### Security

Serving static HTML is inherently safe. No server side scripts to get attacked, or abused. Anytime your site is being dynamically generated that software must be updated regularly or you are at risk for security vulnerabilities.

### Focus on the content

Interfaces change, content remains. It's too difficult to have layout specific information in the content if you want to display the content in more than one place. The content needs to be **presentation agnostic**. One of the greatest things about the Web is its universality. Web-enabled devices are everywhere. Your content should be accessible from any device. A Content Management System should focus on **managing content**. 

### Responsive Design

The web is responsive by nature. Responsive design gets really difficult to accomplish when there is display rules mixed in with the content. Often times layout breaks on certain devices or layouts. It's impossible to test for all the possibilities. Design for the flexibility and the unknown.

### Versatility

Desktop applications, web applications, mobile applications. All devices can by sources of content. Why limit yourself to creating content to a single place focused toward a single device.

### Don't Repeat Yourself or Reinvent the Wheel

Don't Repeat Yourself (DRY) is a principle of software development aimed at reducing repetition of information of all kinds. To reinvent the wheel is to duplicate a basic method that has already previously been created or optimized by others. We think that CAPE helps website users and managers avoid both of these pitfalls.

### Drupal is Slow and Complicated

You'll only be as good as the mean of those around you. The Drupal community is home to many semi-developer freelancers. Drupal enables a ton of functionality without being a programmer. Need some added functionality? There is a module for that. A module that could have been written for a specific job and the maintainer is no longer getting paid to work on it.


#### Drupal is good for two main groups

1. Small scale site builders who can leverage the power of Views, Fields, and the rich module ecosystem but aren't building sites complex enough to land them in "maintenance hell".

2. Large organizations with small development teams that need a complex content/user model. Drupal does a good job of content modeling, revisions, localization, and has a decent plugin system.

#### The simple things
Say you want to show a specific set of characters in a post. Not easy when there is html involved. You have to exclude the html from the count.