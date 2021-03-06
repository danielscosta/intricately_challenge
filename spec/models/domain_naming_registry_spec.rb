require "rails_helper"

RSpec.describe DomainNamingRegistry, type: :model do
  it { should validate_presence_of(:ip) }
  it { should validate_presence_of(:hostnames_attributes) }
  it { should allow_value("127.0.0.1").for(:ip) }
  it { should_not allow_value("x").for(:ip).with_message("Bad Format") }
  it { should allow_value(["intracately.com"]).for(:hostnames_attributes) }
  it { should_not allow_value([]).for(:hostnames_attributes).with_message("Should have a least one hostname") }
end
