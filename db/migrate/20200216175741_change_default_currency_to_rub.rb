class ChangeDefaultCurrencyToRub < ActiveRecord::Migration[6.0]
  def change
    change_column_default :payments, :total_price_currency, nil
    change_column_default :prices, :price_currency, nil
  end
end
