module Admin
  module Deposits
    class GbpsController < ::Admin::Deposits::BaseController
      load_and_authorize_resource :class => '::Deposits::Gbp'

      def index
        start_at = DateTime.now.ago(60 * 60 * 24)
        @oneday_gbps = @gbps.includes(:member).
          where('created_at > ?', start_at).
          order('id DESC')

        @available_gbps = @gbps.includes(:member).
          with_aasm_state(:submitting, :warning, :submitted).
          order('id DESC')

        @available_gbps -= @oneday_gbps
      end

      def show
        flash.now[:notice] = t('.notice') if @gbp.aasm_state.accepted?
      end

      def update
        if target_params[:txid].blank?
          flash[:alert] = t('.blank_txid')
          redirect_to :back and return
        end

        @gbp.charge!(target_params[:txid])

        redirect_to :back
      end

      private
      def target_params
        params.require(:deposits_gbp).permit(:sn, :holder, :amount, :created_at, :txid)
      end
    end
  end
end

