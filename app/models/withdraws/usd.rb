module Withdraws
  class Usd < ::Withdraw
    include ::AasmAbsolutely
    include ::Withdraws::Bankable
    include ::FundSourceable
  end
end
