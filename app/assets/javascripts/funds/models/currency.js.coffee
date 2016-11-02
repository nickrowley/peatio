class Currency extends ZimbitxModel.Model
  @configure 'Currency', 'key', 'code', 'coin', 'blockchain'

  @initData: (records) ->
    ZimbitxModel.Ajax.disable ->
      $.each records, (idx, record) ->
        currency = Currency.create(record.attributes)

window.Currency = Currency
