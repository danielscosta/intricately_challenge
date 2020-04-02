class DomainNamingRegistry < ApplicationRecord
  validates :ip, presence: true, format: { with: /(?:[0-9]{1,3}\.){3}[0-9]{1,3}/, message: "Bad Format" }
  validates :hostnames, presence: true, length: { minimum: 1, message: "Should have a least one hostname" }
end
