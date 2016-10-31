module Private::Withdraws
  class SpreadcoinsController < ::Private::Withdraws::BaseController
    include ::Withdraws::Withdrawable
  end
end
