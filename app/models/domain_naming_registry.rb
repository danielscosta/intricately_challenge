class DomainNamingRegistry < ApplicationRecord
  validates :ip, presence: true, format: { with: /(?:[0-9]{1,3}\.){3}[0-9]{1,3}/, message: "Bad Format" }
  validates :hostnames_attributes, presence: true, length: { minimum: 1, message: "Should have a least one hostname" }

  scope :find_domain_by_included_and_excluded, ->(included = [], excluded = [], page = 1) { where("hostnames_attributes && ARRAY[?]", included).where.not("hostnames_attributes && ARRAY[?]", excluded).page(page).per(100) }
  scope :find_domain_by_excluded, ->(excluded = [], page = 1) { where.not("hostnames_attributes && ARRAY[?]", excluded).page(page).per(100) }
  scope :find_domain_by_included, ->(included = [], page = 1) { where("hostnames_attributes && ARRAY[?]", included).page(page).per(100) }
  scope :find_domain_by, ->(page = 1) { page(page).per(100) }
end
