class DomainNamingRegistry < ApplicationRecord
  validates :ip, format: { with: /((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(\.|$)){4}/, message: "Bad Format" }
  validates :hostnames, length: { minimum: 1 }
end
