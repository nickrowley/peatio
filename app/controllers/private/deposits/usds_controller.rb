module Private
  module Deposits
    class UsdsController < ::Private::Deposits::BaseController
      include ::Deposits::CtrlBankable
    end
  end
end
