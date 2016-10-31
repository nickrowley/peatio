module Admin
  module Deposits
    class EursController < ::Admin::Deposits::BaseController
      load_and_authorize_resource :class => '::Deposits::Eur'

      def index
        start_at = DateTime.now.ago(60 * 60 * 24)
        @oneday_eurs = @eurs.includes(:member).
          where('created_at > ?', start_at).
          order('id DESC')

        @available_eurs = @eurs.includes(:member).
          with_aasm_state(:submitting, :warning, :submitted).
          order('id DESC')

        @available_eurs -= @oneday_eurs
      end

      def show
        flash.now[:notice] = t('.notice') if @eur.aasm_state.accepted?
      end

      def update
        if target_params[:txid].blank?
          flash[:alert] = t('.blank_txid')
          redirect_to :back and return
        end

        @eur.charge!(target_params[:txid])

        redirect_to :back
      end

      private
      def target_params
        params.require(:deposits_eur).permit(:sn, :holder, :amount, :created_at, :txid)
      end
    end
  end
end

