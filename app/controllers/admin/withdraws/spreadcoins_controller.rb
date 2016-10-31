
module Admin
  module Withdraws
    class SpreadcoinsController < ::Admin::Withdraws::BaseController
      load_and_authorize_resource :class => '::Withdraws::Spreadcoin'

      def index
        start_at = DateTime.now.ago(60 * 60 * 24)
        @one_spreadcoins = @spreadcoins.with_aasm_state(:accepted).order("id DESC")
        @all_spreadcoins = @spreadcoins.without_aasm_state(:accepted).where('created_at > ?', start_at).order("id DESC")
      end

      def show
      end

      def update
        @spreadcoin.process!
        redirect_to :back, notice: t('.notice')
      end

      def destroy
        @spreadcoin.reject!
        redirect_to :back, notice: t('.notice')
      end
    end
  end
end
