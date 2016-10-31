module Private
  module Deposits
    class GbpsController < ::Private::Deposits::BaseController
      include ::Deposits::CtrlBankable
    end
  end
end
