class ApplicationQuery
  attr_reader :relation, :params

  def initialize(relation = default_relation, params = {})
    @relation = relation
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

  def apply_scope(scope, condition)
    condition ? scope : relation
  end
end
