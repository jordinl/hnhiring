FactoryBot.define do
  factory :job do
    post
    published_at { Time.zone.now }
    username { 'joe' }
    api_id { '12345' }
  end
end
