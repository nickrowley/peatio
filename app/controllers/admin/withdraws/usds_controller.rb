module Admin
  module Withdraws
    class UsdsController < ::Admin::Withdraws::BaseController
      load_and_authorize_resource :class => '::Withdraws::Usd'

      def index
        start_at = DateTime.now.ago(60 * 60 * 24)
        @one_usds = @usds.with_aasm_state(:accepted, :processing).order("id DESC")
        @all_usds = @usds.without_aasm_state(:accepted, :processing).where('created_at > ?', start_at).order("id DESC")
      end

      def show
      end

      def update
        if @usd.may_process?
          @usd.process!
        elsif @usd.may_succeed?
          @usd.succeed!
        end

        redirect_to :back, notice: t('.notice')
      end

      def destroy
        @usd.reject!
        redirect_to :back, notice: t('.notice')
      end
    end
  end
end
