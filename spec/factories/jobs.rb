FactoryBot.define do
  factory :job do
    month
    published_at { Time.zone.now }
    username { 'joe' }
    api_id { '12345' }
  end
end
