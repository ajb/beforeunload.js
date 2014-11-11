class BeforeUnload
  @footerText: "Are you sure you want to leave this page?"

  @enable: (enableIf, msg) ->
    if !msg
      msg = enableIf
      enableIf = (-> true)

    $(window).bind 'beforeunload', ->
      if enableIf() then msg else undefined

    $(document).on 'page:before-change.beforeunload', =>
      return unless enableIf()

      if confirm("#{msg}\n\n#{@footerText}")
        @disable()
      else
        return false # prevent Turbolinks page change

  @disable: ->
    $(window).unbind 'beforeunload'
    $(document).off 'page:before-change.beforeunload'

window.BeforeUnload = BeforeUnload
