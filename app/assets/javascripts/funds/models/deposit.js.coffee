class Deposit extends PeatioModel.Model
  @configure 'Deposit', 'account_id', 'member_id', 'currency', 'amount', 'fee', 'fund_uid', 'fund_extra',
    'txid', 'state', 'aasm_state', 'created_at', 'updated_at', 'done_at', 'type', 'confirmations', 'is_submitting', 'blockchain_url', 'txid_desc'

  constructor: ->
    super
    @is_submitting = @aasm_state == "submitting"

  @initData: (records) ->
    PeatioModel.Ajax.disable ->
      $.each records, (idx, record) ->
        Deposit.create(record)

  afterScope: ->
    "#{@pathName()}"

  pathName: ->
    switch @currency
      when 'usd' then 'banks'
      when 'btc' then 'satoshis'
      when 'ltc' then 'litecoins'
      when 'dash' then 'dashs'

window.Deposit = Deposit



