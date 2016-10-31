module Withdraws
  class Eur < ::Withdraw
    include ::AasmAbsolutely
    include ::Withdraws::Bankable
    include ::FundSourceable
  end
end
