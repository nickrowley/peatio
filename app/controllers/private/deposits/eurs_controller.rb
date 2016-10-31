module Private
  module Deposits
    class EursController < ::Private::Deposits::BaseController
      include ::Deposits::CtrlBankable
    end
  end
end
