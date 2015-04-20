class ContributionPolicy < ApplicationPolicy

  self::UserScope = Struct.new(:current_user, :user, :scope) do
    def resolve
      if current_user.try(:admin?)
        scope.available_to_display
      elsif current_user == user
        scope.with_state('confirmed')
      else
        scope.not_anonymous.with_state('confirmed')
      end
    end
  end

  def confirm?
    done_by_owner_or_admin_for_record?(record.project) && record.waiting_confirmation?
  end
  
  def refund?
    done_by_owner_or_admin_for_record?(record.project) && record.confirmed?
  end

  def hide?
    done_by_owner_or_admin_for_record?(record.project) && (record.canceled? || record.refunded?)
  end
  
  def push_to_trash?
    done_by_owner_or_admin_for_record?(record.project) && (record.waiting_confirmation? || record.pending?)
  end

  def cancel?
    done_by_owner_or_admin_for_record?(record.project) && (record.waiting_confirmation? || record.pending?)
  end
  
  def create?
    done_by_owner_or_admin? && record.project.online?
  end

  def update?
    done_by_owner_or_admin? && record.pending?
  end

  def show?
    done_by_owner_or_admin?
  end

  def credits_checkout?
    done_by_owner_or_admin?
  end

  def request_refund?
    done_by_owner_or_admin?
  end

  def permitted_attributes
    {contribution: record.attribute_names.map(&:to_sym) - %i[user_attributes user_id user payment_service_fee payment_id]}
  end
end

