module Admin
  module Withdraws
    class BitcreditsController < ::Admin::Withdraws::BaseController
      load_and_authorize_resource :class => '::Withdraws::Bitcredit'

      def index
        start_at = DateTime.now.ago(60 * 60 * 24)
        @one_bitcredits = @bitcredits.with_aasm_state(:accepted).order("id DESC")
        @all_bitcredits = @bitcredits.without_aasm_state(:accepted).where('created_at > ?', start_at).order("id DESC")
      end

      def show
      end

      def update
        @bitcredit.process!
        redirect_to :back, notice: t('.notice')
      end

      def destroy
        @bitcredit.reject!
        redirect_to :back, notice: t('.notice')
      end
    end
  end
end
