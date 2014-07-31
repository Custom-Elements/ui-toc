#ui-markdown-layout
Layout with converted markdown

    Polymer 'ui-toc',

##Events

##Attributes and Change Handlers

##Methods

      linkClick: (event) ->
        window.scrollTo 0, event.target.getAttribute('scroll-to-y')

      bindEvent: (element, type, handler) ->
        if element.addEventListener
          element.addEventListener type, handler, false
        else
          element.attachEvent 'on'+type, handler

##Event Handlers

##Polymer Lifecycle

      created: () ->
        @tocLinks = [] # hint that tocLinks is an array

      ready: () ->

        @selectors = ['h1', 'h2', 'h3']
        @container = 'body'

        if @container
          querySelectorRoot = document.querySelector @container
        else
          querySelectorRoot = document

        elements = querySelectorRoot.querySelectorAll @selectors
        for element in elements
          boundingRect = element.getBoundingClientRect()
          @tocLinks.push {'textContent':element.textContent, 'scrollToY':boundingRect.top}
