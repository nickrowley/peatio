module Admin
  module Deposits
    class CnysController < ::Admin::Deposits::BaseController
      load_and_authorize_resource :class => '::Deposits::Cny'

      def index
        start_at = DateTime.now.ago(60 * 60 * 24)
        @oneday_cnys = @cnys.includes(:member).
          where('created_at > ?', start_at).
          order('id DESC')

        @available_cnys = @cnys.includes(:member).
          with_aasm_state(:submitting, :warning, :submitted).
          order('id DESC')

        @available_cnys -= @oneday_cnys
      end

      def show
        flash.now[:notice] = t('.notice') if @cny.aasm_state.accepted?
      end

      def update
        if target_params[:txid].blank?
          flash[:alert] = t('.blank_txid')
          redirect_to :back and return
        end

        @cny.charge!(target_params[:txid])

        redirect_to :back
      end

      private
      def target_params
        params.require(:deposits_cny).permit(:sn, :holder, :amount, :created_at, :txid)
      end
    end
  end
end

