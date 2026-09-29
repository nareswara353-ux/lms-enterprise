class ApplicationQuery
  attr_reader :relation, :params

  def initialize(relation = nil, params = {})
    @relation = relation || default_relation
    @params = params.symbolize_keys
  end

  def self.call(relation = nil, params = {})
    new(relation, params).call
  end

  def call
    raise NotImplementedError, "#{self.class} must implement #call"
  end

  private

  def default_relation
    raise NotImplementedError, "#{self.class} must define #default_relation"
  end
end
