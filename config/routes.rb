Rails.application.routes.draw do
  devise_for  %s(users)
  root        %q(groups#index)
  resources   %s(groups), only: %i(new create show edit update)
  resources   %s(messages), only: %i(create)
end
