class DomainNamingRegistriesController < ApplicationController
  def create
    @todo = DomainNamingRegistry.create!(domain_naming_registry_params)
    json_response(@todo, :created)
  end

  def find_domain_by
    page = params[:page]
    included = params[:included] || []
    excluded = params[:excluded] || []

    domain_naming_regitries = if included.empty? && excluded.empty?
        DomainNamingRegistry.find_domain_by(page)
      elsif excluded.empty?
        DomainNamingRegistry.find_domain_by_included(included, page)
      elsif included.empty?
        DomainNamingRegistry.find_domain_by_excluded(excluded, page)
      else
        DomainNamingRegistry.find_domain_by_included_and_excluded(included, excluded, page)
      end

    hostnames_attributes = domain_naming_regitries.map { |domain_naming_regitry| domain_naming_regitry.hostnames_attributes }.flatten

    hostnames_attributes_counts = Hash.new(0)
    hostnames_attributes.each { |hostname| hostnames_attributes_counts[hostname] += 1 }

    raise ActiveRecord::RecordNotFound.new(message = "Couldn't find Domain") if domain_naming_regitries.empty?

    result = {
      total_records: domain_naming_regitries.size,
      records: domain_naming_regitries.map { |domain_naming_regitry| { id: domain_naming_regitry.id, ip_address: domain_naming_regitry.ip } },
      related_hostnames: hostnames_attributes_counts.keys.map { |key| { hostname: key, count: hostnames_attributes_counts[key] } },
    }

    json_response(result, :ok)
  end

  private

  def domain_naming_registry_params
    params.permit(:ip, :hostnames_attributes => [])
  end
end
