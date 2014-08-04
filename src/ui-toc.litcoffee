#ui-toc-layout
Create a table of contents outline for the containing document.

Out of the box, this will outline headers, under the assumption that you will
be using headers h1-h4 to create your document structure.

You can include `title=` attributes on your outline elements to provide a
bit more content/subtitle in the TOC.

    _ = require 'lodash'

    Polymer 'ui-toc',

##Events
###tocjump
Fired when a link is clicked, this makes it easier to respond differently
when a link is clicked.

##Attributes and Change Handlers
###selector
Finds the elements, starting from document, to outline in the table of contents.

      selectorChanged: ->
        @updateTocLinks()

##Methods

      updateTocLinks: () ->
        elements = document.querySelectorAll @selector
        @tocLinks = _.map elements, (element, i) ->
          index: i
          caption: element.textContent
          notes: element.title
          style: element.tagName.toLowerCase()
          element: element

##Event Handlers
Scroll to the referenced section on a click.

      linkClick: (event) ->
        target = @tocLinks?[event.target.getAttribute('link')]?.element
        target.scrollIntoView(true)
        @fire 'tocjump', target

##Polymer Lifecycle

      created: () ->
        @tocLinks = []
        @selector = "h1, h2, h3, h4"

When the document is updated, the TOC is rebuild automatically.

      attached: () ->
        observer = new MutationObserver (mutations) =>
          @updateTocLinks()
        target = document
        config = { subtree: true, childList: true, characterData: true }
        observer.observe(target, config)
        @updateTocLinks()
