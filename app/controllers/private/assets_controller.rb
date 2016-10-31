module Private
  class AssetsController < BaseController
    skip_before_action :auth_member!, only: [:index]

    def index
      @cny_assets  = Currency.assets('cny')
      @usd_assets  = Currency.assets('usd')
      @eur_assets  = Currency.assets('eur')
      @gbp_assets  = Currency.assets('gbp')
      @zar_assets  = Currency.assets('zar')
      @btc_proof   = Proof.current :btc
      @bcr_proof   = Proof.current :bcr
      @ltc_proof   = Proof.current :ltc
      @spr_proof   = Proof.current :spr
      @cny_proof   = Proof.current :cny
      @usd_proof   = Proof.current :usd
      @eur_proof   = Proof.current :eur      
      @gbp_proof   = Proof.current :gbp
      @zar_proof   = Proof.current :zar
      @dash_proof   = Proof.current :dash

      if current_user
        @btc_account = current_user.accounts.with_currency(:btc).first
        @cny_account = current_user.accounts.with_currency(:cny).first
        @bcr_account = current_user.accounts.with_currency(:bcr).first
        @spr_account = current_user.accounts.with_currency(:spr).first
        @ltc_account = current_user.accounts.with_currency(:ltc).first
        @dash_account = current_user.accounts.with_currency(:dash).first
        @usd_account = current_user.accounts.with_currency(:usd).first
        @gbp_account = current_user.accounts.with_currency(:gbp).first
        @zar_account = current_user.accounts.with_currency(:zar).first
        @eur_account = current_user.accounts.with_currency(:eur).first                        
      end
    end

    def partial_tree
      account    = current_user.accounts.with_currency(params[:id]).first
      @timestamp = Proof.with_currency(params[:id]).last.timestamp
      @json      = account.partial_tree.to_json.html_safe
      respond_to do |format|
        format.js
      end
    end

  end
end
