class Ability
  include CanCan::Ability

  def initialize(user)
    user.permissions.each do |permission|
      can permission.action.to_sym, permission.permissible_type.constantize do |object|
        object.nil? ||
        permission.permissible_id.nil? ||
        permission.permissible_id == object.id
      end
    end
  end
end
