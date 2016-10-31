module Admin
  module Withdraws
    class EursController < ::Admin::Withdraws::BaseController
      load_and_authorize_resource :class => '::Withdraws::Eur'

      def index
        start_at = DateTime.now.ago(60 * 60 * 24)
        @one_eurs = @eurs.with_aasm_state(:accepted, :processing).order("id DESC")
        @all_eurs = @eurs.without_aasm_state(:accepted, :processing).where('created_at > ?', start_at).order("id DESC")
      end

      def show
      end

      def update
        if @eur.may_process?
          @eur.process!
        elsif @eur.may_succeed?
          @eur.succeed!
        end

        redirect_to :back, notice: t('.notice')
      end

      def destroy
        @eur.reject!
        redirect_to :back, notice: t('.notice')
      end
    end
  end
end
