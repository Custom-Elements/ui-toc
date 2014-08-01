#ui-markdown-layout
Layout with converted markdown

    Polymer 'ui-toc',

##Events

##Attributes and Change Handlers

##Methods

      updateTocLinks: (querySelectorRoot) ->
        @tocLinks = []
        elements = querySelectorRoot.querySelectorAll @selectors
        for element in elements
          boundingRect = element.getBoundingClientRect()
          @tocLinks.push {'textContent':element.textContent, 'scrollToY':boundingRect.top}

      linkClick: (event) ->
        window.scrollTo 0, event.target.getAttribute('scroll-to-y')

##Event Handlers

##Polymer Lifecycle

      # Object type hints
      created: () ->
        @tocLinks = []
        @selectors = ['h1', 'h2', 'h3']
        @container = 'body'

      ready: () ->

        if @container
          querySelectorRoot = document.querySelector @container
        else
          querySelectorRoot = document

        @updateTocLinks querySelectorRoot

        # Add Mutation Observer for Page Updates
        observer = new MutationObserver (mutations) =>
          @updateTocLinks querySelectorRoot
        target = document
        config = { subtree: true, childList: true, characterData: true }
        observer.observe(target, config)
