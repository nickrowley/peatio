module Private
  module Deposits
    class BitcreditsController < ::Private::Deposits::BaseController
      include ::Deposits::CtrlCoinable
    end
  end
end
