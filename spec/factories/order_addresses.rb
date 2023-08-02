FactoryBot.define do
  factory :order_address do
    postal_code { '123-4567' }
    prefecture_id { 1 }
    city { '東京都' }
    house_number { '1-1' }
    phone_number { "09012345679" }
    building_name { '柳ビル103' }
    token {"tok_abcdefghijk00000000000000000"}
  end
end