module Private
  module Deposits
    class ZarsController < ::Private::Deposits::BaseController
      include ::Deposits::CtrlBankable
    end
  end
end
