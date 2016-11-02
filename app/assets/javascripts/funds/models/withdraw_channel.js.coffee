class WithdrawChannel extends ZimbitxModel.Model
  @configure 'WithdrawChannel', 'key', 'currency', 'resource_name'

  @initData: (records) ->
    ZimbitxModel.Ajax.disable ->
      $.each records, (idx, record) ->
        WithdrawChannel.create(record)

  account: ->
    Account.findBy('currency', @currency)

window.WithdrawChannel = WithdrawChannel
