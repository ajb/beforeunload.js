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
      # ugly error message, right? However, returning `false` from the callback
      # will allow the script to continue and still show the confirmation.
      if opts.cb
        unless opts.cb(e.originalEvent.data.url) == false
          return false

      if confirm("#{opts.message}\n\n#{@footerText}")
        @disable()
      else # Not confirmed? Prevent the Turbolinks page change
        return false

  @disable: ->
    $(window).unbind 'beforeunload'
    $(document).off 'page:before-change.beforeunload'

window.BeforeUnload = BeforeUnload
