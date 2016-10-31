class Withdraw extends PeatioModel.Model
  @configure 'Withdraw', 'sn', 'account_id', 'member_id', 'currency', 'amount', 'fee', 'fund_uid', 'fund_extra',
    'created_at', 'updated_at', 'done_at', 'txid', 'blockchain_url', 'aasm_state', 'sum', 'type', 'is_submitting'

  constructor: ->
    super
    @is_submitting = @aasm_state == "submitting"

  @initData: (records) ->
    PeatioModel.Ajax.disable ->
      $.each records, (idx, record) ->
        Withdraw.create(record)

  afterScope: ->
    "#{@pathName()}"

  pathName: ->
    switch @currency
      when 'cny' then 'banks'
      when 'btc' then 'satoshis'
      when 'eur' then 'eurs'
      when 'ltc' then 'litecoins'
      when 'spr' then 'spreadcoins'
      when 'usd' then 'usds'
      when 'bcr' then 'bitcredits'
      when 'gbp' then 'gbps'
      when 'dash' then 'dashs'
      when 'zar' then 'zars'

window.Withdraw = Withdraw
