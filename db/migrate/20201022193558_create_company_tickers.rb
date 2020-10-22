class CreateCompanyTickers < ActiveRecord::Migration[6.0]
  def change
    create_table :company_tickers do |t|
      t.string :symbol
      t.string :name

      t.timestamps
    end
  end
end
