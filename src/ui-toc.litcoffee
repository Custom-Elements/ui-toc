#ui-markdown-layout
Layout with converted markdown

    Polymer 'ui-toc',

##Events

##Attributes and Change Handlers

##Methods

      getHostDocument: (element) ->
        if element is null
          return null
        else if element.nodeName is "#document"
          return element
        else if element.nodeName is "#document-fragment"
          return element.host
        else
          return @getHostDocument element.parentNode


      bindEvent: (element, type, handler) ->
        if element.addEventListener
          element.addEventListener type, handler, false
        else
          element.attachEvent 'on'+type, handler

##Event Handlers

##Polymer Lifecycle

      ready: () ->

        prefix = 'ui-toc'
        selectors = ['h1', 'h2', 'h3']
        container = 'body'

        hostDocument = @getHostDocument @
        if container
          container = hostDocument.querySelector container
          tocLinks = container.querySelectorAll selectors
        else
          tocLinks = hostDocument.querySelectorAll selectors

        # Generate the TOC Link
        toc = '<ul id="toc">'
        for link, i in tocLinks

          # Check if An ID is Already Defined
          #if !link.getAttribute 'id'
          anchorName = prefix + "-" + link.nodeName + "-" + i
          #  link.setAttribute 'id', anchorName

          # Build the TOC Item
          toc += '<li>'
          toc += '<a href="#'+anchorName+'">'
          toc += link.textContent
          toc += '</a>'
          toc += '</li>'

        toc += '</ul>'

        # Append the TOC
        @$.el.innerHTML += toc

        # Bind Events
        tocLinks = @$.el.querySelectorAll 'li'
        for link in tocLinks
          @bindEvent link,'click', () ->
            boundingRect = link.getBoundingClientRect()
            window.scrollTo 0, boundingRect.top
