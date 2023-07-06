class RegistrationsController < Devise::RegistrationsController
  def create
    super do |resource|
      resource.posts_counter = 0
      resource.save
    end
  end
end
