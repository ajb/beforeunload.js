class BeforeUnload
  @footerText: "Are you sure you want to leave this page?"

  @enable: (enableIf, msg, cb) ->
    if !msg
      msg = enableIf
      enableIf = (-> true)

    $(window).bind 'beforeunload', ->
      if enableIf() then msg else undefined

    $(document).on 'page:before-change.beforeunload', (e) =>
      return unless enableIf()

      # If we're given a callback, just call it. We want to avoid showing this
      # ugly error message, right?
      if cb?
        cb(e.originalEvent.data.url)

      # No callback -- use confirm() like the browser does
      else if confirm("#{msg}\n\n#{@footerText}")
        @disable()

      # Not confirmed? Prevent the Turbolinks page change
      else
        return false

  @disable: ->
    $(window).unbind 'beforeunload'
    $(document).off 'page:before-change.beforeunload'

window.BeforeUnload = BeforeUnload
