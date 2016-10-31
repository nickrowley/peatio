module Private
  module Deposits
    class CnysController < ::Private::Deposits::BaseController
      include ::Deposits::CtrlBankable
    end
  end
end
