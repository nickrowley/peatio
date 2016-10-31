module Admin
  module Withdraws
    class ZarsController < ::Admin::Withdraws::BaseController
      load_and_authorize_resource :class => '::Withdraws::Zar'

      def index
        start_at = DateTime.now.ago(60 * 60 * 24)
        @one_zars = @zars.with_aasm_state(:accepted, :processing).order("id DESC")
        @all_zars = @zars.without_aasm_state(:accepted, :processing).where('created_at > ?', start_at).order("id DESC")
      end

      def show
      end

      def update
        if @zar.may_process?
          @zar.process!
        elsif @zar.may_succeed?
          @zar.succeed!
        end

        redirect_to :back, notice: t('.notice')
      end

      def destroy
        @zar.reject!
        redirect_to :back, notice: t('.notice')
      end
    end
  end
end
