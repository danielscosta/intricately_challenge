require "rails_helper"

RSpec.describe DomainNamingRegistry, type: :model do
  it { should allow_value("127.0.0.1").for(:ip) }
  it { should validate_length_of(:hostnames).is_at_least(1) }
end
