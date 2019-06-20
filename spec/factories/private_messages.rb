FactoryBot.define do
  factory :private_message, class: 'Private::Message' do
    body {'Hello there! This is a test message'}
    association :conversation, factory: :private_conversation
    user
  end
end
