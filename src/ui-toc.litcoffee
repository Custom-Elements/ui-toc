#ui-toc-layout
Creates a header

    Polymer 'ui-toc',

##Events
Scroll to the referenced section

      linkClickInitializer: (element) ->
        linkClick: (event) ->
          boundingRect = element.getBoundingClientRect()
          window.scrollTo 0, boundingRect.top

##Attributes and Change Handlers

##Methods

      updateTocLinks: () ->
        @tocLinks = []
        elements = @querySelectorRoot.querySelectorAll @selectors
        for element in elements

          for selector, i in @selectors
            selectorIndex = if selector is element.nodeName then i

          linkClick = @linkClickInitializer(element)

          tocLink =
            sourceNodeName: element.nodeName
            selectorIndex: selectorIndex
            textContent: element.textContent
            linkClick: linkClick

          @tocLinks.push tocLink



##Event Handlers

##Polymer Lifecycle

      created: () ->
        @tocLinks = []
        @selectors = ['h1', 'h2', 'h3']
        @container = 'body'

      ready: () ->

        @querySelectorRoot = if @container then document.querySelector @container else document

        @updateTocLinks @querySelectorRoot

        # Add Mutation Observer for Page Updates
        observer = new MutationObserver (mutations) =>
          @updateTocLinks @querySelectorRoot
        target = @querySelectorRoot
        config = { subtree: true, childList: true, characterData: true }
        observer.observe(target, config)
