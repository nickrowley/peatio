module Admin
  module Deposits
    class UsdsController < ::Admin::Deposits::BaseController
      load_and_authorize_resource :class => '::Deposits::Usd'

      def index
        start_at = DateTime.now.ago(60 * 60 * 24)
        @oneday_usds = @usds.includes(:member).
          where('created_at > ?', start_at).
          order('id DESC')

        @available_usds = @usds.includes(:member).
          with_aasm_state(:submitting, :warning, :submitted).
          order('id DESC')

        @available_usds -= @oneday_usds
      end

      def show
        flash.now[:notice] = t('.notice') if @usd.aasm_state.accepted?
      end

      def update
        if target_params[:txid].blank?
          flash[:alert] = t('.blank_txid')
          redirect_to :back and return
        end

        @usd.charge!(target_params[:txid])

        redirect_to :back
      end

      private
      def target_params
        params.require(:deposits_usd).permit(:sn, :holder, :amount, :created_at, :txid)
      end
    end
  end
end

