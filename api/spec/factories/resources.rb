FactoryBot.define do
  factory(:resource) do
    name { Faker::Name.name }
    url { Faker::Internet.url }
  end
end
