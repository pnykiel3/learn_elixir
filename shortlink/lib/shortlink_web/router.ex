defmodule ShortlinkWeb.Router do
  use ShortlinkWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ShortlinkWeb do
    pipe_through :api
    get "/links/:hash/stats", LinkController, :stats
    resources "/links", LinkController, except: [:new, :edit]
  end

  scope "/", ShortlinkWeb do
    get "/:hash", RedirectController, :redirect_hash
  end
end
