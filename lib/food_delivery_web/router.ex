defmodule FoodDeliveryWeb.Router do
  use FoodDeliveryWeb, :router

  import FoodDeliveryWeb.UserAuth

  pipeline :browser do
    plug :accepts, ~w[html]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {FoodDeliveryWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ~w[json]
  end

  scope "/", FoodDeliveryWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  # Other scopes may use custom stacks.
  # scope "/api", FoodDeliveryWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:food_delivery, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: FoodDeliveryWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/", FoodDeliveryWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    live_session :redirect_if_user_is_authenticated,
      on_mount: [{FoodDeliveryWeb.UserAuth, :redirect_if_user_is_authenticated}] do
      live "/users/register", UserRegistrationLive, :new
      live "/users/log_in", UserLoginLive, :new
      live "/users/reset_password", UserForgotPasswordLive, :new
      live "/users/reset_password/:token", UserResetPasswordLive, :edit
    end

    post "/users/log_in", UserSessionController, :create
  end

  scope "/", FoodDeliveryWeb do
    pipe_through [:browser, :require_authenticated_user]

    live_session :require_authenticated_user,
      on_mount: [{FoodDeliveryWeb.UserAuth, :ensure_authenticated}] do
      live "/users/settings", UserSettingsLive, :edit
      live "/users/settings/confirm_email/:token", UserSettingsLive, :confirm_email
    end
  end

  scope "/", FoodDeliveryWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete

    live_session :current_user,
      on_mount: [{FoodDeliveryWeb.UserAuth, :mount_current_user}] do
      live "/users/confirm/:token", UserConfirmationLive, :edit
      live "/users/confirm", UserConfirmationInstructionsLive, :new
    end
  end

  scope "/api/v1", FoodDeliveryWeb do
    pipe_through [:api]

    post "/users/register", UserController, :create
    post "/users/log_in", UserSessionController, :create
    post "/drivers", DriverController, :create

    resources "/restaurants", RestaurantController, only: [:index, :show]
    resources "/products", ProductController, only: [:index, :show]
  end

  scope "/api/v1/", FoodDeliveryWeb do
    pipe_through [:api, :fetch_api_user]

    get "/users/:id", UserController, :show
    put "/users/:id", UserController, :update

    resources "/addresses", AddressController
    resources "/drivers", DriverController, except: [:create]
    resources "/restaurants", RestaurantController, except: [:index, :show]
    resources "/products", ProductController, except: [:index, :show]
  end
end
