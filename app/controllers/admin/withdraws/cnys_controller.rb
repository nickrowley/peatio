module Admin
  module Withdraws
    class CnysController < ::Admin::Withdraws::BaseController
      load_and_authorize_resource :class => '::Withdraws::Cny'

      def index
        start_at = DateTime.now.ago(60 * 60 * 24)
        @one_cnys = @cnys.with_aasm_state(:accepted, :processing).order("id DESC")
        @all_cnys = @cnys.without_aasm_state(:accepted, :processing).where('created_at > ?', start_at).order("id DESC")
      end

      def show
      end

      def update
        if @cny.may_process?
          @cny.process!
        elsif @cny.may_succeed?
          @cny.succeed!
        end

        redirect_to :back, notice: t('.notice')
      end

      def destroy
        @cny.reject!
        redirect_to :back, notice: t('.notice')
      end
    end
  end
end
