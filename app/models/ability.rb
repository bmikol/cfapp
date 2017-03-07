class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user (not logged in)
    can :manage, User, id: user.id # :manage matches any action on User, provided the user has the same ID as her/his user record
  end
end
