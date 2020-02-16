class Api::V1::UserPolicy < Api::V1::BasePolicy
  def show?
    user.present?
  end

  def update?
    user.present? && user.id == record.id
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
