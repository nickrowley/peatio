module Private::Withdraws
  class BitcreditsController < ::Private::Withdraws::BaseController
    include ::Withdraws::Withdrawable
  end
end
