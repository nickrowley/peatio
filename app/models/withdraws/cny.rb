module Withdraws
  class Cny < ::Withdraw
    include ::AasmAbsolutely
    include ::Withdraws::Bankable
    include ::FundSourceable
  end
end
