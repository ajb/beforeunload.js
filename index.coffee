class BeforeUnload
  @footerText: 'Are you sure you want to leave this page?'

  @defaults:
    if: -> true
    message: 'You have unsaved changes.'

  @enable: (opts) ->
    @opts =
      if: opts.if || @defaults.if
      message: opts.message || @defaults.message
      cb: opts.cb

    @_onTurbolinksUnload = (e) =>
      return @disable() unless @_willPrevent()

      # If we're given a callback, just call it. We want to avoid showing this
      # ugly error message, right? However, returning `false` from the callback
      # will allow the script to continue and still show the confirmation.
      if @opts.cb
        unless @opts.cb(e.data.url) == false
          return e.preventDefault()

      if confirm("#{@opts.message}\n\n#{@footerText}")
        @disable()
      else # Not confirmed? Prevent the Turbolinks page change
        e.preventDefault()

    # Turbolinks replaces the body when restoring a page (via the back button),
    # so we need to know whether the current page was the one that .enable
    # was originally called on
    document.body.beforeunload = @

    window.onbeforeunload = =>
      if @_willPrevent() then @opts.message else undefined

    document.addEventListener 'page:before-change', @_onTurbolinksUnload, false

  @disable: ->
    window.onbeforeunload = null
    document.removeEventListener 'page:before-change', @_onTurbolinksUnload

  @_willPrevent: ->
    document.body.beforeunload == @ && @opts.if()

window.BeforeUnload = BeforeUnload
