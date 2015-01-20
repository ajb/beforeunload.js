class BeforeUnload
  @footerText: 'Are you sure you want to leave this page?'

  @defaults:
    if: -> true
    message: 'You have unsaved changes.'

  @enable: (opts) ->
    opts = $.extend {}, @defaults, opts

    $(window).bind 'beforeunload', ->
      if opts.if() then opts.message else undefined

    $(document).on 'page:before-change.beforeunload', (e) =>
      return @disable() unless opts.if()

      # If we're given a callback, just call it. We want to avoid showing this
      # ugly error message, right?
      if opts.cb
        opts.cb(e.originalEvent.data.url)
        return false

      # No callback -- use confirm() like the browser does
      else if confirm("#{opts.message}\n\n#{@footerText}")
        @disable()

      # Not confirmed? Prevent the Turbolinks page change
      else
        return false

  @disable: ->
    $(window).unbind 'beforeunload'
    $(document).off 'page:before-change.beforeunload'

window.BeforeUnload = BeforeUnload
