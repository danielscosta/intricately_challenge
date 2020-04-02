class CreateDomainNamingRegistries < ActiveRecord::Migration[6.0]
  def change
    create_table :domain_naming_registries do |t|
      t.string :ip
      t.text :hostnames, array: true, default: []

      t.timestamps
    end
  end
end
