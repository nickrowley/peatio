module Private::Withdraws
  class CnysController < ::Private::Withdraws::BaseController
    include ::Withdraws::Withdrawable
  end
end
