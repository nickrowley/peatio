module Admin
  module Withdraws
    class GbpsController < ::Admin::Withdraws::BaseController
      load_and_authorize_resource :class => '::Withdraws::Gbp'

      def index
        start_at = DateTime.now.ago(60 * 60 * 24)
        @one_gbps = @gbps.with_aasm_state(:accepted, :processing).order("id DESC")
        @all_gbps = @gbps.without_aasm_state(:accepted, :processing).where('created_at > ?', start_at).order("id DESC")
      end

      def show
      end

      def update
        if @gbp.may_process?
          @gbp.process!
        elsif @gbp.may_succeed?
          @gbp.succeed!
        end

        redirect_to :back, notice: t('.notice')
      end

      def destroy
        @gbp.reject!
        redirect_to :back, notice: t('.notice')
      end
    end
  end
end
