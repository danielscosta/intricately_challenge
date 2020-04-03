FactoryBot.define do
  factory :domain_naming_registry do
    ip { Faker::Internet.ip_v4_address }
    hostnames_attributes { [Faker::Internet.domain_name, Faker::Internet.domain_name] }
  end
end
