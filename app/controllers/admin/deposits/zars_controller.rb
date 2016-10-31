module Admin
  module Deposits
    class ZarsController < ::Admin::Deposits::BaseController
      load_and_authorize_resource :class => '::Deposits::Zar'

      def index
        start_at = DateTime.now.ago(60 * 60 * 24)
        @oneday_zars = @zars.includes(:member).
          where('created_at > ?', start_at).
          order('id DESC')

        @available_zars = @zars.includes(:member).
          with_aasm_state(:submitting, :warning, :submitted).
          order('id DESC')

        @available_zars -= @oneday_zars
      end

      def show
        flash.now[:notice] = t('.notice') if @zar.aasm_state.accepted?
      end

      def update
        if target_params[:txid].blank?
          flash[:alert] = t('.blank_txid')
          redirect_to :back and return
        end

        @zar.charge!(target_params[:txid])

        redirect_to :back
      end

      private
      def target_params
        params.require(:deposits_zar).permit(:sn, :holder, :amount, :created_at, :txid)
      end
    end
  end
end

